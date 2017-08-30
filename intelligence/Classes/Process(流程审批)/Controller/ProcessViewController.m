//
//  ProcessViewController.m
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProcessViewController.h"
#import "StockViewCell.h"
#import "ProcessModel.h"
#import "ProcessCellDetailsController.h"

@interface ProcessViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _numberSearch;
    BOOL isSearch;
    NSInteger _number;
    NSString *_searchStr;
    NSInteger _arrayCount;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *searchArray;
@property BOOL needReRefresh;
@end

@implementation ProcessViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SEARCHWIDTH, ScreenWidth, ScreenHeight - SEARCHWIDTH) style:UITableViewStyleGrouped];
    }
    _tableview.dataSource = self;
    _tableview.delegate =self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"流程审批";
    SVHUD_NO_Stop(@"正在加载");
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    _number = 1;
    _numberSearch = 1;
    [self requestData:1 isUpdata:YES];
    [self initRefresh];
    self.needReRefresh=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.needReRefresh=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.needReRefresh) {
        if (_number==1) {
            [self requestData:1 isUpdata:YES];
        }
    }
}
-(void)settingDegate{
    WEAKSELF
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.tableview.emptyDataSetDelegate = self;
        weakSelf.tableview.emptyDataSetSource = self;
    });
    
}

//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    AccountModel *account = [AccountManager account];
    
    NSDictionary *dic = @{@"ASSIGNCODE":account.personId,
                          @"ASSIGNSTATUS":@"=活动"};
    
    NSDictionary *requestDic = @{@"appid":@"WFDESIGN",
                                 @"objectname":@"WFASSIGNMENT",
                                 @"curpage":@(page),
                                 @"showcount":@(20),
                                 @"option":@"read",
                                 @"orderby":@"WFASSIGNMENTID DESC",
                                 @"condition":dic};
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = self.dataArray.count;
        NSArray *array = [ProcessModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
        
        for (ProcessModel * one in array) {
            NSLog(@"流程审批 %@",[one mj_keyValues]);
        }
        
        [self.dataArray addObjectsFromArray:array];
        
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
            if(_dataArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(_dataArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}

//上下拉刷新
- (void)initRefresh{
    WEAKSELF
    // 下拉刷新
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _number = 1;
        _numberSearch = 1;
        if (!isSearch) {
            [weakSelf requestData:_number isUpdata:YES];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:YES];
        }
    }];
    //    // 上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
        _numberSearch ++;
        if (!isSearch) {
            [weakSelf requestData:_number isUpdata:NO];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:NO];
        }
    }];
}

//搜索加载
- (void)searchRequestData:(NSString*)str page:(NSInteger)page isUpdata:(BOOL)data{
    // htt://service.wanwanyl.com/Search/conSearch
    NSDictionary *dic = @{
                          @"STOCKNUM":str,
                          @"DESCRIPTION":str
                          };
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDSTOCK",
                                 @"objectname":@"UDSTOCK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"STOCKNUM DESC",
                                 @"sinorsearch":dic
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        if (data) {
            [self.searchArray removeAllObjects];
        }
        _arrayCount = self.searchArray.count;
        NSArray *array = [ProcessModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
        [self.searchArray addObjectsFromArray:array];
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
            if(_searchArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(_searchArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        isSearch = YES;
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!isSearch) {
        return self.dataArray.count;
    }else{
        return self.searchArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [StockViewCell stockViewCell];
    }
    cell.process = [self modelTypeWithIndex:indexPath.section];
    [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.section+1]];

    return cell;
}

- (ProcessModel *)modelTypeWithIndex:(NSInteger)index{
    ProcessModel *model;
    if (!isSearch) {
        model = self.dataArray[index];
    }else{
        model = self.searchArray[index];
    }
    return model;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    ProcessCellDetailsController *vc = [[ProcessCellDetailsController alloc] init];
    vc.UpdataBlock = ^(NSString *str){
        HUDNormal(str);
        if (!isSearch) {
            [weakSelf requestData:1 isUpdata:YES];
        }else{
            [weakSelf searchRequestData:_searchStr page:_number isUpdata:YES];
        }
    };
    if (!isSearch) {
        vc.process = self.dataArray[indexPath.section];
    }else{
        vc.process = self.searchArray[indexPath.section];
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    HUDStop
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel = (UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }
    }
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self searchBarResignAndChangeUI];
    //    [self requestData];
}
/**
 *  搜框中输入关键字的事件响应
 *
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
    //    [self.tableview reloadData];
    
}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消了");
    searchBar.text = @"";
    if ([searchBar isKindOfClass:[UIButton class]]) {
        [searchBar removeFromSuperview];
    }
    self.searchBar.showsCancelButton = NO;//取消的字体颜色
    [self.searchBar resignFirstResponder];//失去第一响应
    isSearch = NO;
    [self.tableview reloadData];
}

/**
 *  键盘上搜索事件的响应
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取");
    _searchStr = searchBar.text;
    SVHUD_NO_Stop(@"正在加载");
    _numberSearch =1;
    [self searchRequestData:searchBar.text page:_numberSearch isUpdata:YES];
    //    [searchBar setShowsCancelButton:NO animated:YES];
    [self searchBarResignAndChangeUI];
}

- (void)searchBarResignAndChangeUI{
    [self.searchBar resignFirstResponder];//失去第一响应
    [self changeSearchBarCancelBtnTitleColor:self.searchBar];//改变布局
}

- (void)changeSearchBarCancelBtnTitleColor:(UIView *)view{
    
    if (view) {
        //        [self.searchBar setShowsCancelButton:YES];
        if ([view isKindOfClass:[UIButton class]]) {
            //             self.searchBar.showsCancelButton = NO;//取消的字体颜色，
            //            [view removeFromSuperview];
            UIButton *getBtn = (UIButton *)view;
            [getBtn setEnabled:YES];//设置可用
            [getBtn setUserInteractionEnabled:YES];
            //设置取消按钮字体的颜色“#0374f2”
            
            //            [getBtn setTitleColor:[UIColor colorWithHexString:@"#0374f2"] forState:UIControlStateReserved];
            //
            //            [getBtn setTitleColor:[UIColor colorWithHexString:@"#0374f2"] forState:UIControlStateDisabled];
            return;
        }else{
            self.searchBar.showsCancelButton = NO;//取消的字体颜色
            for (UIView *subView in view.subviews) {
                [self changeSearchBarCancelBtnTitleColor:subView];
            }
        }
    }else{
        return;
    }
}

#pragma mark - DZN占位图代理
/** 选择占位图图片*/
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_wanxiaoniu"];
}

/** 填写占位文字*/
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"无数据\n";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: UIColorFromRGB(0x878787)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
/** 占位图位置*/
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -self.tableview.frame.size.height/10.0f;
}
/** 文字距离图片距离*/
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 5.0f;
}

/** 是否显示*/
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
/** 允许交互*/
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
/** 可以滚动*/
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

/** 展示视图后 通知 轻拍View*/
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // Do something
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
