//
//  RemediaMeasuresController.m
//  intelligence
//
//  Created by  on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "RemediaMeasuresController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CauseProblemModel.h"
#import "RemedialMeasuresCell.h"

@interface RemediaMeasuresController ()<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _arrayCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation RemediaMeasuresController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavBarHeight - 80) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补救措施";
    SVHUD_NO_Stop(@"正在加载");
    [self.view addSubview:self.tableView];
    _number = 1;
    [self requestData:1 isUpdata:YES];
    [self initRefresh];
}

-(void)settingDegate{
    WEAKSELF
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.tableView.emptyDataSetDelegate = self;
        weakSelf.tableView.emptyDataSetSource = self;
    });
    
}


//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *dic = @{@"PARENT":self.requestCode};
    NSDictionary *requestDic = @{@"appid":@"FAILURELIST",
                                 @"objectname":@"FAILURELIST",
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
        NSArray *array = [CauseProblemModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
            [self.dataArray addObjectsFromArray:array];
        
        if (data) {
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }else{
            if (_arrayCount == _dataArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableView.mj_footer endRefreshing];
            }
        }
        
        [self.tableView reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

//上下拉刷新
- (void)initRefresh{
    WEAKSELF
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _number = 1;
        [weakSelf requestData:_number isUpdata:YES];
        
    }];
    //    // 上拉刷新
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _number ++;
//        [weakSelf requestData:_number isUpdata:NO];
//    }];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemedialMeasuresCell *cell = [RemedialMeasuresCell cellWithTableView:tableView];
    cell.causeProblemModel = self.dataArray[indexPath.section];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CauseProblemModel *model = self.dataArray[indexPath.section];
    CGFloat cellHeight = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"causeProblemModel" cellClass:[RemedialMeasuresCell class] contentViewWidth:[self cellContentViewWith]];
    return cellHeight;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
