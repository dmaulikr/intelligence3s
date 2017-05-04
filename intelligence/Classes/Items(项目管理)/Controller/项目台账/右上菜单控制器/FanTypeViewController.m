//
//  FanTypeViewController.m
//  intelligence
//
//  Created by  on 16/7/26.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "FanTypeViewController.h"
#import "FanTypeModel.h"
#import "StockViewCell.h"
#import "FanTypeDetailsController.h"

@interface FanTypeViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _arrayCount;
    BOOL isShowEmpty;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FanTypeViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选项列表";
    SVHUD_NO_Stop(@"正在加载");
    if(self.requestCode.length == 0){
        self.requestCode = @"";
    }
    _number = 1;
    [self requestData:1 isUpdata:YES];
    [self initTableView];
    [self addRefresh];
}

//创建tableview
- (void)initTableView{
    isShowEmpty = NO;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, ScreenWidth, ScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.emptyDataSetDelegate = self;
    _tableview.emptyDataSetSource = self;
    [self.view addSubview:_tableview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}


//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *requestDic;
    if (_isShow) {
        NSDictionary *dic = @{@"siteid":@"=MWSITE",
                              @"PRONUM":self.requestCode};
        requestDic = @{
                       @"appid"     :@"UDFANDETAILS",
                       @"objectname":@"UDFANDETAILS",
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"condition" :dic
                       };
    }else{
        NSDictionary *dic = @{@"siteid":@"=MWSITE",
                              @"PRONUM":self.requestCode};
        requestDic = @{
                                     @"appid"     :@"UDFANDETAILS",
                                     @"objectname":@"UDFANDETAILS",
                                     @"curpage"   :@(page),
                                     @"showcount" :@(20),
                                     @"option"    :@"read",
                                     @"condition" :dic
                                     };
    }
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
        NSLog(@"array %@",array);
        for (NSDictionary *dic in array) {
            FanTypeModel *fanType = [FanTypeModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:fanType];
        }
        [self descending];
        if (data) {
            // 结束刷新
            NSString *str = [NSString stringWithFormat:@"%@",response[@"result"][@"totalpage"]];
            NSString *str2 = [NSString stringWithFormat:@"%ld",page];
            if (_arrayCount == _dataArray.count ||
                [str isEqualToString:str2]) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }

        }else{
            NSString *str = [NSString stringWithFormat:@"%@",response[@"result"][@"totalpage"]];
            NSString *str2 = [NSString stringWithFormat:@"%ld",page];
            if (_arrayCount == _dataArray.count ||
                [str isEqualToString:str2]) {
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

- (void)descending{
        NSArray *array = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSComparisonResult result = [obj1 compareParkInfo:obj2];
            return result;
        }];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
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
    cell.fanType = [self modelTypeWithIndex:indexPath.section];
    return cell;
}

- (FanTypeModel *)modelTypeWithIndex:(NSInteger)index{
    FanTypeModel *model;
    model = self.dataArray[index];
    return model;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isribao) {
        FanTypeModel *fan = self.dataArray[indexPath.section];
        if (self.backModel) {
            self.backModel(fan);
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }else{
        FanTypeModel *fan = self.dataArray[indexPath.section];
        if (_backModel) {
            self.backModel(fan);
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        FanTypeDetailsController *vc = [[FanTypeDetailsController alloc] init];
        vc.model = fan;
        [self.navigationController pushViewController:vc animated:YES];
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
