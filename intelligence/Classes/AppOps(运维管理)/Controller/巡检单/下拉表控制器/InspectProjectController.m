//
//  InspectProjectController.m
//  intelligence
//
//  Created by  on 16/8/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "InspectProjectController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "InspectProjectModel.h"
#import "InspectProjectCell.h"
#import "ShareConstruction.h"

#import "InspectProjectDetailsController.h"


@interface InspectProjectController ()<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _arrayCount;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation InspectProjectController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
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
    self.title = @"巡检项目";
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
    /*{'appid':'UDINSPROJECT','objectname':'UDINSPROJECT','curpage':1,'showcount':20,'option':'read','orderby':'JPTASK','condition':{'INSPONUM':'1942'}}
     */
    NSDictionary *dic = @{@"INSPONUM":self.requestCode};
    NSDictionary *requestDic = @{@"appid":@"UDINSPROJECT",
                                 @"objectname":@"UDINSPROJECT",
                                 @"curpage":@(page),
                                 @"showcount":@(20),
                                 @"option":@"read",
                                 @"orderby":@"JPTASK DESC",
                                 @"condition":dic};
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        
        NSLog(@"巡检项目response %@",response);
        
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = self.dataArray.count;
        NSArray *array = [InspectProjectModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
       
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
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _number ++;
            [weakSelf requestData:_number isUpdata:NO];
        }];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InspectProjectCell *cell = [InspectProjectCell cellWithTableView:tableView];
//    cell.inspectProject = [self getModelWithIndex:indexPath.section];
    cell.inspectProject = self.dataArray[indexPath.section];
    return cell;
}

- (InspectProjectModel *)getModelWithIndex:(NSInteger)index{
    
    NSInteger count = self.dataArray.count - 1;
    
    InspectProjectModel *model = self.dataArray[count - index];
    
    return model;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
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
    
    InspectProjectModel *model = self.dataArray[indexPath.section];
    
    InspectProjectDetailsController *vc = [[InspectProjectDetailsController alloc] init];
    
    vc.inspectProject = model;
    vc.index = indexPath.section;
    vc.executeupdata = ^(NSInteger index){
        ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
        InspectProjectModel *model = shareConstruction.inspectProject;
        
        [self changeModelWithIndex:index withModel:model];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeModelWithIndex:(NSInteger)index withModel:(InspectProjectModel *)model{
    NSInteger count = self.dataArray.count - index -1;
    [self.dataArray replaceObjectAtIndex:count withObject:model];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
