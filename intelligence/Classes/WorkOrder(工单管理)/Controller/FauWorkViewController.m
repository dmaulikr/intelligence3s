//
//  FauWorkViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FauWorkViewController.h"
#import "StockViewCell.h"
#import "FauWorkModel.h"
#import "FaultWorkViewController.h"
#import "ChoiceWorkView.h"
#import "CheckWorkViewController.h"
#import "DebugWorkViewController.h"
#import "AddFaultViewController.h"
#import "FaultWorkViewController.h"
#import "CheckWorkViewController.h"
#import "CheckWorksViewController.h"
#import "TechnologyViewController.h"
#import "CheckingWorkController.h"
#import "AddChecksViewController.h"
#import "AddCheckViewController.h"
#import "SoapUtil.h"
@interface FauWorkViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _numberSearch;
    NSInteger _number;
    NSString *_searchStr;
    NSInteger _arrayCount;
    UIButton *_right;
    NSString *_choose;
    UIView *_narView;
}
@property (nonatomic,assign)StockType stcokType;
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *searchArray;

@end

@implementation FauWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.name;
    _choose = @"";
    self.searchArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    SVHUD_NO_Stop(@"正在加载");
    _number = 1;
    _numberSearch = 1;
    [self requestData:1 choose:_choose isUpdata:YES];
    if ([self.name isEqualToString:@"故障工单"]||[self.name isEqualToString:@"终验收工单"]||[self.name isEqualToString:@"定检工单"]||[self.name isEqualToString:@"调试工单"]||[self.name isEqualToString:@"技改工单"]||[self.name isEqualToString:@"排查工单"]) {
        [self addNav];
    }
    [self request];
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

-(void)addNav{
    //设置视图的矩形宽度
    _narView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-100, 0,100, 45)];
    _right = [UIButton buttonWithType:UIButtonTypeCustom];
    _right.backgroundColor = RGBCOLOR(16, 133, 233);
    _right.layer.masksToBounds = YES;
    _right.layer.cornerRadius = 4;
    //设置标题
    [_right setTitle:@"全部" forState:UIControlStateNormal];
    //设置颜色
    [_right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _right.titleLabel.font = font(13);
    CGFloat width = LabelWidth(_right.titleLabel);
    //设置frame
    _right.frame = CGRectMake(_narView.width_W-width-13 - 33, 5, width+13, 30);
    //添加监听事件
    [_right addTarget:self action:@selector(navClick) forControlEvents:UIControlEventTouchUpInside];
//    if(self.Choice != ChoiceTypeClose){
        // 视图上添加按钮
        [_narView addSubview:_right];
//    }
    
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(addimgClick) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(_narView.width_W - 30, 5, 30, 30);
    if (![self.name isEqualToString:@"调试工单"]&&![self.name isEqualToString:@"排查工单"]&&![self.name isEqualToString:@"技改工单"]) {
        [_narView addSubview:addImg];
    }
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:_narView];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = leftItem;
}
-(void)navClick{
    WEAKSELF
    ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:self.view.bounds choice:self.Choice];
    work.WorkBlock = ^(NSString *str){
        if ([str isEqualToString:@"全部"]) {
            _choose = @"";
        }else{
           _choose = str;
        }
       [_right setTitle:str forState:UIControlStateNormal];
        CGFloat width = LabelWidth(_right.titleLabel);
        //设置frame
        _right.frame = CGRectMake(_narView.width_W-width-13 - 33, 5, width+13, 30);
        SVHUD_NO_Stop(@"正在加载");
        [weakSelf requestData:1 choose:_choose isUpdata:YES];
    };
    [work ShowInView:self.view];
}
-(void)updataRequest{
    if(_searchStr.length){
        [self searchRequestData:_searchStr page:1 isUpdata:YES];
    }else{
        [self requestData:1 choose:_choose isUpdata:YES];
    }
}


-(void)addimgClick{
    WEAKSELF
    if ([self.name isEqualToString:@"故障工单"]) {
        AddFaultViewController *add = [[AddFaultViewController alloc]init];
        add.Open = ^(NSDictionary *dic){
            FaultWorkViewController *details = [[FaultWorkViewController alloc]init];
            details.stock = [FauWorkModel mj_objectWithKeyValues:dic];
            [weakSelf.navigationController pushViewController:details animated:NO];
        };
        add.objectname = _objectname;
        add.orderby = _orderby;
        add.appid = _appid;
        add.worktype = _worktype;
        [self.navigationController pushViewController:add animated:YES];
    }else if ([self.name isEqualToString:@"终验收工单"]){
        AddCheckViewController *check = [[AddCheckViewController alloc]init];
        check.OpenCheck = ^(NSDictionary *dic){
            CheckWorkViewController *check = [[CheckWorkViewController alloc]init];
            check.stock = [FauWorkModel mj_objectWithKeyValues:dic];
            [weakSelf.navigationController pushViewController:check animated:NO];
        };
        [self.navigationController pushViewController:check animated:YES];
    }else if ([self.name isEqualToString:@"定检工单"]){
        AddChecksViewController *check = [[AddChecksViewController alloc]init];
        [self.navigationController pushViewController:check animated:YES];
    }
}
//创建tableview
- (void)initTableView{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SEARCHWIDTH, ScreenWidth, ScreenHeight - SEARCHWIDTH) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate =self;
    [self.view addSubview:_tableview];
//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.searchBar.mas_bottom);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.left.mas_equalTo(self.view.mas_left);
//    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
            [weakSelf requestData:_number choose:_choose isUpdata:YES];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:YES];
        }
    }];
    //    // 上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
        _numberSearch ++;
        if (weakSelf.stcokType == StockTypeNone) {
            [weakSelf requestData:_number choose:_choose isUpdata:NO];
        }else{
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:NO];
        }
    }];
}
//全部加载
- (void)requestData:(NSInteger)page choose:(NSString *)choose isUpdata:(BOOL)data{
    NSDictionary *requestDic;
    NSDictionary *dic = @{
                          @"WORKTYPE":self.worktype,
                          @"UDSTATUS":choose
                          };
    if ([self.name isEqualToString:@"调试工单"]){
        NSDictionary *dics = @{
                               @"STATUS":choose
                               };
        if ([choose isEqualToString:@""]) {
            requestDic = @{
                           @"appid"     :_appid,
                           @"objectname":_objectname,
                           @"curpage"   :@(page),
                           @"showcount" :@(20),
                           @"option"    :@"read",
                           @"orderby"   :_orderby,
                           };
        }else{
            requestDic = @{
                           @"appid"     :_appid,
                           @"objectname":_objectname,
                           @"curpage"   :@(page),
                           @"showcount" :@(20),
                           @"option"    :@"read",
                           @"orderby"   :_orderby,
                           @"condition" :dics,
                           };
        }
    }else{
        requestDic = @{
                       @"appid"     :_appid,
                       @"objectname":_objectname,
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :_orderby,
                       @"condition" :dic,
                       };
    }
   
        NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = _dataArray.count;
        NSArray *array = response[@"result"][@"resultlist"];
        for (NSDictionary *dic in array) {
            NSLog(@"dic %@",dic);
            FauWorkModel *stock = [FauWorkModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:stock];
        }
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
        self.stcokType = StockTypeNone;
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_Stop
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}
//搜索加载
- (void)searchRequestData:(NSString*)str page:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *requestDic;
    if ([self.name isEqualToString:@"调试工单"]){
        NSDictionary *serach = @{
                                 @"DEBUGWORKORDERNUM":str,
                                 @"DESCRIPTION":str
                                 };
        requestDic = @{
                       @"appid"     :_appid,
                       @"objectname":_objectname,
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :_orderby,
                       @"sinorsearch":serach,
                       };
    }else{
        NSDictionary *serach = @{
                                 @"WONUM":str,
                                 @"DESCRIPTION":str
                                 };
        NSDictionary *dic = @{
                              @"WORKTYPE":self.worktype,
                              @"UDSTATUS":_choose
                              };
        requestDic = @{
                       @"appid"     :_appid,
                       @"objectname":_objectname,
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :_orderby,
                       @"condition" :dic,
                       @"sinorsearch":serach
                       };
    }
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        SVHUD_Stop
        NSArray *array = response[@"result"][@"resultlist"];
        if (data) {
            [self.searchArray removeAllObjects];
        }
        _arrayCount = self.searchArray.count;
        for (NSDictionary *dic in array) {
            NSLog(@"dic %@",dic);
            FauWorkModel *stock = [FauWorkModel mj_objectWithKeyValues:dic];
            [self.searchArray addObject:stock];
        }
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
        self.stcokType = StockTypeSearch;
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_Stop
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.stcokType == StockTypeNone) {
        return self.dataArray.count;
    }else{
        return self.searchArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Faucell"];
    if (!cell) {
        cell = [StockViewCell stockViewCell];
    }
    if ([self.name isEqualToString:@"调试工单"]){
        cell.debug = [self chooseType:indexPath.section];
    }else{
        cell.fauWork = [self chooseType:indexPath.section];
    }
    return cell;
}
-(FauWorkModel *)chooseType:(NSInteger)type{
    FauWorkModel *fau;
    if (self.stcokType == StockTypeNone) {
        fau = self.dataArray[type];
    }else{
        fau = self.searchArray[type];
    }
    return fau;
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
    WEAKSELF
    FauWorkModel *fau;
    if (self.stcokType == StockTypeNone) {
        fau = self.dataArray[indexPath.section];
    }else{
        fau = self.searchArray[indexPath.section];
    }
    if ([self.name isEqualToString:@"故障工单"]) {
        
        FaultWorkViewController *details = [[FaultWorkViewController alloc]init];
        details.updataModel = ^{
            HUDNormal(@"故障工单修改成功");
            [weakSelf updataRequest];
//            [weakSelf.tableview reloadData];
        };
        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];
    }else if ([self.name isEqualToString:@"终验收工单"]){
        CheckWorkViewController *details = [[CheckWorkViewController alloc]init];
        details.blackBlock = ^(NSString *str){
            HUDNormal(str);
            [weakSelf updataRequest];
        };
        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];

    }else if ([self.name isEqualToString:@"调试工单"]){
        DebugWorkViewController *details = [[DebugWorkViewController alloc]init];
        details.blackBlock = ^(NSString *str){
            HUDNormal(str);
            [weakSelf updataRequest];
        };

        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];
    }else if ([self.name isEqualToString:@"定检工单"]){
        CheckWorksViewController *details = [[CheckWorksViewController alloc]init];
        details.blackBlock = ^(NSString *str){
            HUDNormal(str);
            [weakSelf updataRequest];
        };
        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];
    }else if ([self.name isEqualToString:@"技改工单"]){
        TechnologyViewController *details = [[TechnologyViewController alloc]init];
        details.blackBlock = ^(NSString *str){
            HUDNormal(str);
            [weakSelf updataRequest];
        };

        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];
    }else if ([self.name isEqualToString:@"排查工单"]){
        CheckingWorkController *details = [[CheckingWorkController alloc]init];
        details.blackBlock = ^(NSString *str){
            HUDNormal(str);
            [weakSelf updataRequest];
        };

        details.stock = fau;
        details.objectname = _objectname;
        [self.navigationController pushViewController:details animated:YES];
    }
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
            
            for (UIView *subView in view.subviews) {
                self.searchBar.showsCancelButton = NO;//取消的字体颜色
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

