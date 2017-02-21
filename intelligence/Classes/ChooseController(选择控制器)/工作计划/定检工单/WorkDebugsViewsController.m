//
//  WorkDebugsViewsController.m
//  intelligence
//
//  Created by 光耀 on 16/9/10.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "WorkDebugsViewsController.h"
#import "StockViewCell.h"
#import "AddWorkDeViewController.h"
#import "PlanViewController.h"
#import "DebugsViewsController.h"
@interface WorkDebugsViewsController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSString *_searchStr;
    NSInteger _arrayCount;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *addArray;
@property (nonatomic,assign)NSInteger isModify;

@end

@implementation WorkDebugsViewsController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)addArray{
    if (!_addArray) {
        _addArray = [NSMutableArray array];
    }
    return _addArray;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight - 5) style:UITableViewStyleGrouped];
    }
    _tableview.dataSource = self;
    _tableview.delegate =self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调试工单子表";
    [self.view addSubview:self.tableview];
    _number = 1;
    _isModify = _dele;
    [self addNa];
    if (_parent.length >0) {
        if (_isModify) {
            [self initRefresh];
            [self.dataArray addObjectsFromArray:_array];
            [self.tableview reloadData];
        }else{
            SVHUD_NO_Stop(@"正在加载");
            [self requestData:1 isUpdata:YES];
            [self initRefresh];
        }
    }else{
        [self.dataArray addObjectsFromArray:_array];
        [self.tableview reloadData];
    }
}
-(void)addNa{
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(addimgClick) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(30, 5, 30, 30);
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = leftItem;
    
    //按钮的创建和设置
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"nav_back_pub"] forState:UIControlStateNormal
     ];
    rightButton.frame = CGRectMake(0, 0, 50, 40);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = rightItem;
}


-(void)back{
    NSLog(@"返回了");
        for (WorksPlanModel *mater in self.dataArray) {
            if (mater.isnumber ==1) {
                [self.addArray addObject:mater];
            }
        }
        if (self.updataCellClick) {
            self.updataCellClick(self.addArray,_isModify);
        }
        if (self.executeCellClick) {
            self.executeCellClick(self.dataArray);
        }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addimgClick{
    WEAKSELF
    AddWorkDeViewController *add = [[AddWorkDeViewController alloc]init];
    add.backModel = ^(WorkDebugsModel *model){
        [weakSelf.dataArray addObject:model];
        [weakSelf.tableview reloadData];
        weakSelf.isModify = YES;
    };
    add.number = _identifier;
    [self.navigationController pushViewController:add animated:YES];
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
    if (_isModify) {
        // 结束刷新
        [self.tableview.mj_header endRefreshing];
        return;
    }
    NSDictionary *dic = @{
                          @"DEBUGWORKORDERNUM" : _parent.length?_parent:@"",
                          };
    NSDictionary *requestDic = @{@"appid":@"UDDEBUGWORKORDERLINE",
                                 @"objectname":@"UDDEBUGWORKORDERLINE",
                                 @"curpage":@(page),
                                 @"showcount":@(20),
                                 @"option":@"read",
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
        NSArray *array = [WorkDebugsModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
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
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [StockViewCell stockViewCell];
    }
    cell.workDebug = [self modelTypeWithIndex:indexPath.section];
    return cell;
}

- (WorkDebugsModel *)modelTypeWithIndex:(NSInteger)index{
    WorkDebugsModel *model;
    model = self.dataArray[index];
    return model;
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
    DebugsViewsController *debuge = [[DebugsViewsController alloc]init];
    WorkDebugsModel *debuges = self.dataArray[indexPath.section];
    debuge.backModels = ^(WorkDebugsModel *model){
        debuges.WINDDRIVENGENERATORNUM = model.WINDDRIVENGENERATORNUM;
        debuges.DISPOSE = model.DISPOSE;
        debuges.QUESTION = model.QUESTION;
        debuges.SYNCHRONIZATIONDEBUGDATE = model.SYNCHRONIZATIONDEBUGDATE;
        debuges.CREW3 = model.CREW3;
        debuges.VESION = model.VESION;
        debuges.DYNAMICDEBUGDATE = model.DYNAMICDEBUGDATE;
        debuges.DEBUGLEADER = model.DEBUGLEADER;
        debuges.FJLOCATION = model.FJLOCATION;
        debuges.RESPONSIBLEPERSON = model.RESPONSIBLEPERSON;
        debuges.CREW2 = model.CREW2;
        debuges.TIME1 = model.TIME1;
        debuges.TIME2 = model.TIME2;
        debuges.CREW = model.CREW;
        debuges.isnumber = 1;
        [weakSelf.tableview reloadData];
        weakSelf.isModify = YES;
    };
    
    debuge.model = debuges;
    [self.navigationController pushViewController:debuge animated:YES];
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
