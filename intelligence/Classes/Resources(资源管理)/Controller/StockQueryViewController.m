//
//  StockQueryViewController.m
//  intelligence
//
//  Created by chris on 2016/12/2.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "StockQueryViewController.h"
#import "ConditionViewController.h"
#import "StockQueryTableViewCell.h"
#import "StockQuery.h"
#import "SoapUtil.h"
#import "ShareConstruction.h"

@interface StockQueryViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

{
    NSInteger _numberSearch;
    NSInteger _multiNumberSearch;
    NSInteger _number;
    NSString *_searchStr;
    NSInteger _arrayCount;
}
@property (nonatomic,assign) StockType stcokType;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *searchArray;
@property (nonatomic,strong) __block NSMutableArray *canQueryLocations;

@end

@implementation StockQueryViewController
/*
 BINNUM :
 CURBAL :
 ITEMNUM :
 LOCATIONDESC :
 LOTNUM : ;
 ITEMDESC :
 LOCATION :
 UNIT : 单位
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"库存查询";
    self.searchArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    [self setupRightFilterButton];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    SVHUD_NO_Stop(@"正在加载");
    _number = 1;
    _numberSearch =1;
    _multiNumberSearch=1;
    
    // Do any additional setup after loading the view from its nib.
    //[self soapTest];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self queryPermission];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupRightFilterButton{
    
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addImg setTitle:@"高级搜索" forState:UIControlStateNormal];
    
    [addImg addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    addImg.frame = CGRectMake(0, 5, 80, 30);
    
    // leftItem设置
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)rightButtonPress{
    
    ConditionViewController * condition =[[ConditionViewController alloc] init];
    
    condition.locations=self.canQueryLocations;
    
    [self.navigationController pushViewController:condition animated:YES];
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
        _numberSearch =1;
        _multiNumberSearch=1;
        
        if (weakSelf.stcokType == StockTypeNone) {
            
            [weakSelf requestData:_number isUpdata:YES];
            
        }else if(weakSelf.stcokType == StockTypeSearch){
            
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:YES];
        }
        else
        {
            ShareConstruction * share = [ShareConstruction sharedConstruction];
            

            [self multiSearchRequestData:share.stockQueryCondicitonDictionary page:_multiNumberSearch isUpdata:YES];
        }
        
    }];
    //上拉加载
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
        _numberSearch ++;
        _multiNumberSearch ++;
        
        if (weakSelf.stcokType == StockTypeNone) {
            
            [weakSelf requestData:_number isUpdata:NO];
            
        }else if(weakSelf.stcokType == StockTypeSearch){
            
            [weakSelf searchRequestData:_searchStr page:_numberSearch isUpdata:NO];
            
        }else{
            
            ShareConstruction * share = [ShareConstruction sharedConstruction];
            
            
            [self multiSearchRequestData:share.stockQueryCondicitonDictionary page:_multiNumberSearch isUpdata:NO];
        }
        
    }];
}
//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDINVBALANCES",
                                 @"objectname":@"UDINVBALANCES",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"ITEMNUM DESC",
                                 @"condition" :@{@"BINNUM":@"无限制"}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = _dataArray.count;
        NSArray *array = response[@"result"][@"resultlist"];
        
        for (NSDictionary *dic in array) {
            
            NSLog(@"库存 %@",dic);
            StockQuery * model=[StockQuery mj_objectWithKeyValues:dic];
            
            if ([self.canQueryLocations count]>0) {
                NSLog(@"局部仓库");
                
                if (model.LOCATION.length>0) {
                    
                    BOOL contains =NO;
                    
                    for (NSString *one in self.canQueryLocations) {
                        
                        if ([model.LOCATION isEqualToString:one]) {
                            contains =YES;
                        }
                    }
                    if (contains) {
                        
                        [self.dataArray addObject:model];
                        NSLog(@"%lu个",[self.dataArray count]);
                    }
                }
                else
                {
                    [self.dataArray addObject:model];
                }
            }
            else
            {
                NSLog(@"所有仓库");
                [self.dataArray addObject:model];
            }
            
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
        
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        
    }];
    
}
//搜索加载
- (void)searchRequestData:(NSString*)str page:(NSInteger)page isUpdata:(BOOL)data{
    // htt://service.wanwanyl.com/Search/conSearch
    NSDictionary *dic = @{
                          @"LOCATIONDESC":str,
                          @"ITEMNUM" :str,
                          @"ITEMDESC":str,
                          @"LOTNUM":str,
                          };
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDINVBALANCES",
                                 @"objectname":@"UDINVBALANCES",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"ITEMNUM DESC",
                                 @"sinorsearch":dic,
                                 @"condition" :@{@"BINNUM":@"无限制"}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        NSArray *array = response[@"result"][@"resultlist"];
        if (data) {
            [self.searchArray removeAllObjects];
        }
        _arrayCount = self.searchArray.count;
//        for (NSDictionary *dic in array) {
//            
//            StockQuery * model=[StockQuery mj_objectWithKeyValues:dic];
//            [self.searchArray addObject:model];
//            
//        }
        for (NSDictionary *dic in array) {
            
            //NSLog(@"库存 %@",dic);
            StockQuery * model=[StockQuery mj_objectWithKeyValues:dic];
            
            if ([self.canQueryLocations count]>0) {
                NSLog(@"局部仓库");
                
                if (model.LOCATION.length>0) {
                    
                    BOOL contains =NO;
                    
                    for (NSString *one in self.canQueryLocations) {
                        
                        if ([model.LOCATION isEqualToString:one]) {
                            contains =YES;
                        }
                    }
                    if (contains) {
                        
                        [self.searchArray addObject:model];
                        NSLog(@"有权限查看的物料%lu个",[self.dataArray count]);
                    }
                }
                else
                {
                    [self.searchArray addObject:model];
                }
            }
            else
            {
                NSLog(@"所有仓库");
                [self.searchArray addObject:model];
            }
            
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
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
    
}
- (void)multiSearchRequestData:(NSMutableDictionary *) dic page:(NSInteger)page isUpdata:(BOOL)data{
    
    NSDictionary *requestDic;
    NSMutableDictionary * dicCOPY =[NSMutableDictionary dictionaryWithDictionary:dic];
    
    if (dic&&[[dic allValues] count]>0&&dic[@"BINNUM"]&&[dic[@"BINNUM"] isEqualToString:@"所有"]) {
        
        [dicCOPY removeObjectForKey:@"BINNUM"];
        NSLog(@"所有BIN %@",dicCOPY);
        
    }
    
    if (dicCOPY&&[[dicCOPY allValues] count]>0) {
        
        requestDic = @{
                       @"appid"     :@"UDINVBALANCES",
                       @"objectname":@"UDINVBALANCES",
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :@"ITEMNUM DESC",
                       @"condition" :dicCOPY
                       };
    }
    else
    {
        requestDic = @{
                       @"appid"     :@"UDINVBALANCES",
                       @"objectname":@"UDINVBALANCES",
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :@"ITEMNUM DESC"
                       };
    }


    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        NSArray *array = response[@"result"][@"resultlist"];
        if (data) {
            [self.searchArray removeAllObjects];
        }
        _arrayCount = self.searchArray.count;
        
        for (NSDictionary *dic in array) {
            NSLog(@"multiSearchRequestData 库存 %@",dic);
            StockQuery * model=[StockQuery mj_objectWithKeyValues:dic];
            
            [self.searchArray addObject:model];
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
        self.stcokType = MultiStockTypeSearch;
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
        return self.dataArray.count;
    }else{
        return self.searchArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StockQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockQueryTableViewCell"];
        
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StockQueryTableViewCell" owner:tableView options:nil] firstObject];
    }
    
    cell.SN.text = [NSString stringWithFormat:@"%ld",indexPath.section+1];
    
    cell.stockQueryModel = [self chooseType:indexPath.section];
    
    return cell;
}

-(StockQuery *)chooseType:(NSInteger)type{
    
    StockQuery *stock;
    if (self.stcokType == StockTypeNone) {
        stock = self.dataArray[type];
    }else{
        stock = self.searchArray[type];
    }
    return stock;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
    
                    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
    
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StockQuery * stockQueryModel = [self chooseType:indexPath.section];
    SVHUD_HINT(stockQueryModel.ITEMDESC);
    
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
    
}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消搜索");
    searchBar.text = @"";
    if ([searchBar isKindOfClass:[UIButton class]]) {
        [searchBar removeFromSuperview];
    }
    self.searchBar.showsCancelButton = NO;//取消的字体颜色
    [self.searchBar resignFirstResponder];//失去第一响应
    self.stcokType = StockTypeNone;
    
    ShareConstruction * share = [ShareConstruction sharedConstruction];
    
    if (share.stockQueryCondicitonDictionary) {
        
        self.stcokType = MultiStockTypeSearch;
        
        NSLog(@"取消了搜索栏搜索，变成条件搜索");
        
    }
    
    [self.tableview reloadData];
}

/**
 *  键盘上搜索事件的响应
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"搜索");
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
//查询权限
-(void)queryPermission
{
    self.canQueryLocations=[NSMutableArray array];
    
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic)
    {
        if (dic==nil) {
            SVHUD_Normal(@"请求权限失败");
            return ;
        }
        
        NSString * str =dic[@"sqlMsg"];
        
        if ([str isEqualToString:@"ALL"]) {
            
            NSLog(@"所有权限");
            self.canQueryLocations=nil;
            
        }
        else
        {
            for (NSString* location in [str componentsSeparatedByString:@","]) {
                
                NSLog(@"有权限的仓库 %@",location);
                [self.canQueryLocations addObject:location];
            }
        }
        //有没有查询条件
        
        ShareConstruction * share = [ShareConstruction sharedConstruction];
        
        if ([[share.stockQueryCondicitonDictionary allValues] count]>0) {
            
            NSLog(@"设置了查询条件");
            
            [self multiSearchRequestData:share.stockQueryCondicitonDictionary page:1 isUpdata:YES];
            
        }
        else
        {
            NSLog(@"没有设置查询条件");
            
            [self requestData:1 isUpdata:YES];
        }
        
        [self request];
    };
    
    NSString * userName=[AccountManager account].userName;
    
    [soap requestMethods:@"mobileservicegetLocaPermission" withDate:@[@{@"user":userName}]];
    
}
//-(void)soapTest
//{
//    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"" andEndpoint:@"http://rdmms.infinitus.com.cn/ws/CommonService?wsdl"];
//    
//    soap.DicBlock = ^(NSDictionary *dic)
//    {
//        NSLog(@"haha %@",dic);
//    };
//    
//    [soap requestMethods:@"wsin:login" withDate:@[@{@"username":@"admin"},@{@"password":@"admin"}]];
//}
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
