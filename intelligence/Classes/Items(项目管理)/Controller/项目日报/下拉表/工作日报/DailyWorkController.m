//
//  DailyWorkController.m
//  intelligence
//
//  Created by  on 16/8/13.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DailyWorkController.h"
#import "DailyWorkAddController.h"

#import "ShareConstruction.h"
#import "DailyWorkModel.h"

#import "StockViewCell.h"

#import "DailyWorkDetailsController.h"

@interface DailyWorkController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _arrayCount;
    BOOL isShowEmpty;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) DailyWorkModel *dailyWork;


@end

@implementation DailyWorkController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    self.dailyWork = shareConstruction.dailyWork;
    [self.tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作日报列表";
    isShowEmpty = YES;
//    SVHUD_NO_Stop(@"正在加载");
//    _number = 1;
    [self setupRightMenuButton];
    [self requestData:1 isUpdata:YES];
    [self initTableView];
//    [self addRefresh];
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
    DailyWorkAddController *vc = [[DailyWorkAddController alloc]init];
    vc.PRORUNLOGNUM = self.PRORUNLOGNUM;
    [self.navigationController pushViewController:vc animated:YES];
}

//创建tableview
- (void)initTableView{

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, ScreenWidth, ScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate =self;
    _tableview.emptyDataSetDelegate = self;
    _tableview.emptyDataSetSource = self;
    [self.view addSubview:_tableview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}


//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    
    NSDictionary *dic = @{
                          @"PRORUNLOGNUM":self.PRORUNLOGNUM,
                          };
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDPRORUNLOGLINE",
                                 @"objectname":@"UDPRORUNLOGLINE",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"RUNLOGDATE DESC",
                                 @"condition" :dic,
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        isShowEmpty = YES;
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = _dataArray.count;
        NSArray *array = response[@"result"][@"resultlist"];
        for (NSDictionary *dic in array) {
            
            NSLog(@"dic %@",dic);
              DailyWorkModel *stock = [DailyWorkModel mj_objectWithKeyValues:dic];
              [self.dataArray addObject:stock];
            }
        
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
        }else{
            if (_arrayCount == _dataArray.count) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        
        [self.tableview reloadData];
        //        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_Stop
        isShowEmpty = YES;
        HUDNormal(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
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
-(void)addRefresh{
    WEAKSELF
    // 下拉刷新
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _number = 1;
        
        [weakSelf requestData:_number isUpdata:YES];
    }];
    //    // 上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
        
        [weakSelf requestData:_number isUpdata:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.dailyWork) {
        return self.dataArray.count;
    }else{
        return self.dataArray.count;
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
    cell.dailyWork = [self.dataArray objectAtIndex:indexPath.section];
    return cell;
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
    
    DailyWorkDetailsController *vc = [[DailyWorkDetailsController alloc] init];
    vc.dailyWork = [self.dataArray objectAtIndex:indexPath.section];
    vc.PRORUNLOGNUM = self.PRORUNLOGNUM;
    [self.navigationController pushViewController:vc animated:YES];
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
    NSString *text;
    if (isShowEmpty) {
        text = @"暂无相关数据\n";
    }else{
        text = @"";
    }
    
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
    
}


@end
