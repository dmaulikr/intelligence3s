//
//  DailyItemsController.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DailyItemsController.h"
#import "StockViewCell.h"
#import "DailyModel.h"
#import "DailyDetailController.h"
#import "DailyAddController.h"
#import "SoapUtil.h"
@interface DailyItemsController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _numberSearch;
    NSString *_searchStr;
    NSInteger _arrayCount;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataDArray;
@property (nonatomic,strong) NSMutableArray *searchDArray;

@end

@implementation DailyItemsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"项目日报";
    self.searchDArray = [NSMutableArray array];
    self.dataDArray = [NSMutableArray array];
    SVHUD_NO_Stop(@"正在加载");
    _number = 1;
    _numberSearch = 1;
    [self requestData:1 isUpdata:YES];
    [self initTableView];
    [self request];
    
    [self setupRightMenuButton];
    // Do any additional setup after loading the view from its nib.
}
//创建tableview
- (void)initTableView{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SEARCHWIDTH, ScreenWidth, ScreenHeight - SEARCHWIDTH) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate =self;
    [self.view addSubview:_tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setupRightMenuButton{
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 5, 30, 30);
    // leftItem设置
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightButtonPress{
    DailyAddController *tracel = [[DailyAddController alloc]init];
    [self.navigationController pushViewController:tracel animated:YES];
}

-(void)settingDegate{
    WEAKSELF
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.tableview.emptyDataSetDelegate = self;
        weakSelf.tableview.emptyDataSetSource = self;
    });
    
}
//上下拉刷新
-(void)request{
    WEAKSELF
    // 下拉刷新
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _number = 1;
        _numberSearch = 1;
        if (weakSelf.stcokType == StockTypeNone) {
            [weakSelf requestData:_number isUpdata:YES];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:YES];
        }
    }];
    //    // 上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
        _numberSearch ++;
        if (weakSelf.stcokType == StockTypeNone) {
            [weakSelf requestData:_number isUpdata:NO];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:NO];
        }
    }];
}
//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDPRORUN",
                                 @"objectname":@"UDPRORUNLOG",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"PRORUNLOGNUM desc"
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        SVHUD_Stop
        if (data) {
            [self.dataDArray removeAllObjects];
        }
        _arrayCount = _dataDArray.count;
        NSArray *array = response[@"result"][@"resultlist"];
        for (NSDictionary *dic in array) {
            
            NSLog(@"dic %@",dic);
            
            DailyModel *stock = [DailyModel mj_objectWithKeyValues:dic];
            NSString *str = [NSString stringWithFormat:@"%@",stock.PRORUNLOGNUM];
            if (str.length > 0) {
                [self.dataDArray addObject:stock];
            }
            
        }
        
        NSString *str1 = [NSString stringWithFormat:@"%@",response[@"result"][@"totalpage"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",response[@"result"][@"curpage"]];
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
            if([str1 isEqualToString:str2]){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if([str1 isEqualToString:str2]){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        
        self.stcokType = StockTypeNone;
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}
//搜索加载
- (void)searchRequestData:(NSString*)str page:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *dic = @{
                          @"PRORUNLOGNUM":str,
                          @"DESCRIPTION":str
                          };
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDPRORUN",
                                 @"objectname":@"UDPRORUNLOG",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"PRORUNLOGNUM desc",
                                 @"sinorsearch":dic
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        SVHUD_Stop
        NSArray *array = response[@"result"][@"resultlist"];
        if (data) {
            [self.searchDArray removeAllObjects];
        }
        _arrayCount = self.searchDArray.count;
        for (NSDictionary *dic in array) {
            
            NSLog(@"dic %@",dic);
            
            DailyModel *stock = [DailyModel mj_objectWithKeyValues:dic];
            [self.searchDArray addObject:stock];
        }
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
        }else{
            if (_arrayCount == _searchDArray.count) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        self.stcokType = StockTypeSearch;
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
    if (self.stcokType == StockTypeNone) {
        return self.dataDArray.count;
    }else{
        return self.searchDArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Dailycell"];
    if (!cell) {
        cell = [StockViewCell stockViewCell];
    }
    cell.daily = [self chooseType:indexPath.section];
    return cell;
}

-(DailyModel *)chooseType:(NSInteger)type{
    DailyModel *stock;
    if (self.stcokType == StockTypeNone) {
        stock = self.dataDArray[type];
    }else{
        stock = self.searchDArray[type];
    }
    NSLog(@"----%@",stock.PRORUNLOGNUM);
    return stock;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DailyDetailController *vc = [[DailyDetailController alloc] init];
    vc.daily = [[DailyModel alloc] init];
    vc.daily = [self chooseType:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}



-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
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
    NSLog(@"我的");
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
    self.stcokType = StockTypeNone;
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
    _numberSearch = 1;
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

@end
