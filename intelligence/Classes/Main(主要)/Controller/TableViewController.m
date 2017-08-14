//
//  TableViewController.m
//  intelligence
//
//  Created by chris on 2017/6/26.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "TableViewController.h"
#import "StockViewCell.h"
#import "UDWARNINGWO.h"
#import "ChoiceWorkView.h"
#import "YJPC_ViewController.h"
#import "FaultWorkViewController.h"
#import "DebugWorkViewController.h"
#import "PollingDetailsController.h"
#import "CheckWorksViewController.h"
#import "CheckingWorkController.h"
#import "TechnologyViewController.h"
#import "CheckWorkViewController.h"
#import "RunLogDetailsViewController.h"
#import "FaultAppDetailsViewController.h"
#import "DailyDetailController.h"
#import "LedgerDetailsController.h"
#import "ProblemDetailsController.h"
#import "TripReportDetailsViewController.h"
#import "DetailsTravelViewController.h"
#import "DetailsOilViewController.h"
#import "DetailsMaintainViewController.h"
#import "DetailsStockViewController.h"
#import "AddFaultViewController.h"
#import "AddCheckViewController.h"
#import "AddChecksViewController.h"
#import "AddTaskXViewController.h"
#import "RunLogAddViewController.h"
#import "FaultAppAddController.h"
#import "DailyAddController.h"
#import "ProblemAddController.h"
#import "TripReportAddViewController.h"
#import "TracelViewController.h"
#import "OilRAddViewController.h"
#import "AddMaintain.h"
#import "TSGD_ViewController.h"
#import "WorkDebugsModel.h"
#import "TSGDZB_ViewController.h"
#import "GZGD_ViewController.h"
@interface TableViewController ()

@end

@implementation TableViewController
{
    UIButton *choice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.type];
    self.table.dataSource=self;
    self.table.delegate=self;
    
    [self initTable];
    self.page=1;
    [self requestData:self.page=1];
    self.array = [NSMutableArray array];
    [self setupRightMenuButton];
    {
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64,ScreenWidth, 44)];
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        _searchBar.barTintColor = RGBCOLOR(46, 93, 154);
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.barStyle = UIBarStyleDefault;
        //改变searchBar颜色
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        view.backgroundColor = RGBCOLOR(189, 189, 195);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithUIView:view]];
        [_searchBar insertSubview:imageView atIndex:1];
    }
    if ([self.type isEqualToString:@"调试工单子表"])
    {
        [_searchbar setHidden:YES];
        [_searchBar setHidden:YES];
    }
   // self.search = @"";
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [self.searchBar setDelegate:self];
    [self.searchBar setPrompt:@"输入关键字以搜索"];

    _searchBar.barTintColor = RGBCOLOR(0, 0, 0);
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    //改变searchBar颜色
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    view.backgroundColor = RGBCOLOR(189, 189, 195);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithUIView:view]];
    [_searchBar insertSubview:imageView atIndex:1];
}
//改变颜色
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
-(void)setupRightMenuButton{
    
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 0, 30, 30);
    
    choice = [UIButton buttonWithType:UIButtonTypeCustom];
    [choice setTitle:@"全部" forState:UIControlStateNormal];
    [choice.titleLabel setTextAlignment:NSTextAlignmentRight];
    [choice addTarget:self action:@selector(choiceButtonPress) forControlEvents:UIControlEventTouchUpInside];
    choice.frame = CGRectMake(0, 0, 80, 30);

    // leftItem设置
    UIBarButtonItem * rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    UIBarButtonItem * rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:choice];
    //导航栏上添加按钮
    if ([self.type isEqualToString:@"故障工单"]||[self.type isEqualToString:@"定检工单"]||[self.type isEqualToString:@"终验收工单"]||[self.type isEqualToString:@"出差报告"]) {
        self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem2];
    }
    if ([self.type isEqualToString:@"调试工单"]||[self.type isEqualToString:@"巡检工单"]||[self.type isEqualToString:@"排查工单"]||[self.type isEqualToString:@"技改工单"]) {
        self.navigationItem.rightBarButtonItems = @[rightItem2];
    }
    if ([self.type isEqualToString:@"项目日报"]||[self.type isEqualToString:@"问题联络单"]||[self.type isEqualToString:@"运行记录"]||[self.type isEqualToString:@"故障提报单"]||[self.type isEqualToString:@"行驶记录"]||[self.type isEqualToString:@"加油记录"]||[self.type isEqualToString:@"车辆维修"]||[self.type isEqualToString:@"预警排查工单"]) {
        
        self.navigationItem.rightBarButtonItems = @[rightItem1];
    }
}

-(void)rightButtonPress{
    
    if ([self.type isEqualToString:@"故障工单"]) {
        AddFaultViewController * vc = [[AddFaultViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"调试工单"])
    {
        //
    }
    else if ([self.type isEqualToString:@"巡检工单"])
    {
        //
    }
    else if ([self.type isEqualToString:@"定检工单"])
    {
        AddChecksViewController * vc = [[AddChecksViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if ([self.type isEqualToString:@"排查工单"])
    {
        //
    }
    else if ([self.type isEqualToString:@"技改工单"])
    {
        //
    }
    else if ([self.type isEqualToString:@"终验收工单"])
    {
        AddCheckViewController * vc = [[AddCheckViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"预警排查工单"])
    {
        YJPC_ViewController *yjpc = [[YJPC_ViewController alloc] init];
        yjpc.key = @"预警排查工单";
        [self.navigationController pushViewController:yjpc animated:YES];
        
    }
    else if ([self.type isEqualToString:@"项目台账"])
    {
        //
    }
    else if ([self.type isEqualToString:@"项目日报"])
    {
        DailyAddController * vc = [[DailyAddController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if ([self.type isEqualToString:@"问题联络单"])
    {
        ProblemAddController * vc = [[ProblemAddController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"出差报告"])
    {
        TripReportAddViewController * vc = [[TripReportAddViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"运行记录"])
    {
        RunLogAddViewController * vc = [[RunLogAddViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"故障提报单"])
    {
        FaultAppAddController * vc = [[FaultAppAddController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"行驶记录"])
    {
        TracelViewController * vc = [[TracelViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"加油记录"])
    {
        OilRAddViewController * vc = [[OilRAddViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"车辆维修"])
    {
        AddMaintain * vc = [[AddMaintain alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"库存盘点"])
    {
        
    }
}
-(void)choiceButtonPress
{
    NSLog(@"at");
    ChoiceWorkView *work;

    
    if ([self.type isEqualToString:@"故障工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeFR];
    }
    else if([self.type isEqualToString:@"定检工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeTP];
    }
    else if([self.type isEqualToString:@"终验收工单"])
    {
         work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeAA];
    }
    else if([self.type isEqualToString:@"出差报告"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeTP];
    }
    else if([self.type isEqualToString:@"调试工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeDC];
    }
    else if([self.type isEqualToString:@"巡检工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeXJ];
    }
    else if([self.type isEqualToString:@"排查工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeSP];
    }
    else if([self.type isEqualToString:@"技改工单"])
    {
        work =[[ChoiceWorkView alloc] initWithFrame:self.view.frame choice:ChoiceTypeTPS];
    }
    [work ShowInView:self.view];
    work.WorkBlock = ^(NSString *str) {
        [choice setTitle:str forState:UIControlStateNormal];
        if ([str isEqualToString:@"全部"]) {
            self.search = @"";
        }else{
            self.search = str;
        }
        [self.array removeAllObjects];
        [self requestData:1];
    };

}
-(void)initTable{
    WEAKSELF
    // 下拉加载
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.array=[NSMutableArray array];
        weakSelf.page=1;
        [weakSelf requestData:self.page];
    }];
    // 上拉刷新
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page+=1;
        [weakSelf requestData:self.page];
    }];
}
- (void)requestData:(NSInteger)page{
    

    NSDictionary *dataDic;
    
    if ([self.type isEqualToString:@"故障工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GZGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"调试工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"巡检工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XJGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"定检工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_DJGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"排查工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_PCGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"技改工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_JGGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"终验收工单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_ZYSGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"预警排查工单"])
    {
       dataDic = [RequestJsonFactry getRequestJsonfor_YJPCGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"项目台账"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XMTJ_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"项目日报"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XMRB_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"问题联络单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_WTLLD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"出差报告"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_CCBG_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"运行记录"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_YXJL_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"故障提报单"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GZTBD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"行驶记录"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XSJL_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"加油记录"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_JYJL_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"车辆维修"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_CLWX_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"库存盘点"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_KCPD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"调试工单子表"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGDZB_With:self.search page:page];
    }
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        
        NSArray *dataArray = response[@"result"][@"resultlist"];
        
        for (NSDictionary *dic in dataArray) {
            
            if ([self.type isEqualToString:@"故障工单"]) {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"调试工单"])
            {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"巡检工单"])
            {
                PollingModel *stock = [PollingModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"定检工单"])
            {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"排查工单"])
            {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"技改工单"])
            {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"终验收工单"])
            {
                FauWorkModel *work =[FauWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            else if ([self.type isEqualToString:@"预警排查工单"])
            {
                UDWARNINGWO *object = [UDWARNINGWO mj_objectWithKeyValues:dic];
                [self.array addObject:object];
                
            }
            else if ([self.type isEqualToString:@"项目台账"])
            {
                LedgerModel *stock = [LedgerModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"项目日报"])
            {
                DailyModel *stock = [DailyModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"问题联络单"])
            {
                ProblemModel *stock = [ProblemModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"出差报告"])
            {
                TripReportModel *stock = [TripReportModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"运行记录"])
            {
                RunlogModel *stock = [RunlogModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"故障提报单"])
            {
                PaultAppModel *stock = [PaultAppModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"行驶记录"])
            {
                TravelRModel *stock = [TravelRModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"加油记录"])
            {
                OilRModel *stock = [OilRModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"车辆维修"])
            {
                MaintainModel *stock = [MaintainModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"库存盘点"])
            {
                StockModel *stock = [StockModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
            else if ([self.type isEqualToString:@"调试工单子表"])
            {
                WorkDebugsModel * stock = [WorkDebugsModel mj_objectWithKeyValues:dic];
                [self.array addObject:stock];
            }
        }
        
        [self.table reloadData];
            // 结束刷新
            [self.table.mj_header endRefreshing];
        
            if([dataArray count]<20){
                [self.table.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.table.mj_footer endRefreshing];
            }
        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UDWARNINGWO"];
    if (!cell) {
        cell =  [[[NSBundle mainBundle]loadNibNamed:@"StockViewCell" owner:nil options:nil] lastObject];;
    }
    

    if ([self.type isEqualToString:@"故障工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"调试工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.DEBUGWORKORDERNUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"巡检工单"])
    {
        cell.polling = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"定检工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"排查工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"技改工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"终验收工单"])
    {
        FauWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"预警排查工单"])
    {
        UDWARNINGWO * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.WONUM];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        
    }
    else if ([self.type isEqualToString:@"项目台账"])
    {
        cell.ledger = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"项目日报"])
    {
        cell.daily = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"问题联络单"])
    {
        cell.problem = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"出差报告"])
    {
        cell.tripReport = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"运行记录"])
    {
        cell.runlog = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"故障提报单"])
    {
        cell.pault = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"行驶记录"])
    {
        cell.travel = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"加油记录"])
    {
        cell.oil = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"车辆维修"])
    {
        cell.maintain =[self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"库存盘点"])
    {
        cell.stock = [self.array objectAtIndex:indexPath.row];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];

    }
    else if ([self.type isEqualToString:@"调试工单子表"])
    {
        WorkDebugsModel * stock = [self.array objectAtIndex:indexPath.row];
        cell.top.text = @"";
        cell.bottom.text = [NSString stringWithFormat:@"调试区域负责人: %@ 调试组长: %@",stock.RESPONSIBLEPERSON,stock.DEBUGLEADER];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"故障工单"])
    {
//        FaultWorkViewController*vc = [[FaultWorkViewController alloc] init];
//        vc.stock = [self.array objectAtIndex:indexPath.row];
//        vc.objectname = @"WORKORDER";
        GZGD_ViewController * vc = [[GZGD_ViewController alloc] init];
        vc.Kmodel = [self.array objectAtIndex:indexPath.row];;
        vc.key = @"故障工单";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"调试工单"])
    {
        TSGD_ViewController * vc = [[TSGD_ViewController alloc] init];
        FauWorkModel *object= [self.array objectAtIndex:indexPath.row];
        vc.Kmodel = object;
        vc.key = @"调试工单";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"巡检工单"])
    {
        PollingDetailsController * vc = [[PollingDetailsController alloc] init];
        vc.polling = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"定检工单"])
    {
        FaultWorkViewController*vc = [[FaultWorkViewController alloc] init];
        vc.stock = [self.array objectAtIndex:indexPath.row];
        vc.objectname = @"WORKORDER";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"排查工单"])
    {
        FaultWorkViewController*vc = [[FaultWorkViewController alloc] init];
        vc.stock = [self.array objectAtIndex:indexPath.row];
        vc.objectname = @"WORKORDER";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"技改工单"])
    {
        FaultWorkViewController*vc = [[FaultWorkViewController alloc] init];
        vc.stock = [self.array objectAtIndex:indexPath.row];
        vc.objectname = @"WORKORDER";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"终验收工单"])
    {
        FaultWorkViewController*vc = [[FaultWorkViewController alloc] init];
        vc.stock = [self.array objectAtIndex:indexPath.row];
        vc.objectname = @"WORKORDER";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"预警排查工单"])
    {
        
        YJPC_ViewController *yjpc = [[YJPC_ViewController alloc] init];
        UDWARNINGWO * object= [self.array objectAtIndex:indexPath.row];
        yjpc.Kmodel = object;
        yjpc.key = @"预警排查工单";
        [self.navigationController pushViewController:yjpc animated:YES];
        
    }
    else if ([self.type isEqualToString:@"项目台账"])
    {
        LedgerDetailsController *vc = [[LedgerDetailsController alloc] init];
        vc.ledger = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"项目日报"])
    {
        DailyDetailController * vc = [[DailyDetailController alloc] init];
        vc.daily = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"问题联络单"])
    {
        ProblemDetailsController * vc = [[ProblemDetailsController alloc] init];
        vc.problem = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"出差报告"])
    {
        TripReportDetailsViewController * vc = [[TripReportDetailsViewController alloc] init];
        vc.model = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"运行记录"])
    {
        RunLogDetailsViewController * vc = [[RunLogDetailsViewController alloc] init];
        vc.runlogModel = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"故障提报单"])
    {
        FaultAppDetailsViewController * vc =[[FaultAppDetailsViewController alloc] init];
        vc.pault = [self.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"行驶记录"])
    {
        DetailsTravelViewController * vc = [[DetailsTravelViewController alloc] init];
        vc.stock =[self.array objectAtIndex:indexPath.row];
        vc.objectname = @"UDCARDRIVELOG";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"加油记录"])
    {
        DetailsOilViewController * vc = [[DetailsOilViewController alloc] init];
        vc.stock =[self.array objectAtIndex:indexPath.row];
        vc.objectname = @"UDCARFUELCHARGE";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"车辆维修"])
    {
        DetailsMaintainViewController * vc = [[DetailsMaintainViewController alloc] init];
        vc.maintain =[self.array objectAtIndex:indexPath.row];
        vc.objectname = @"UDCARMAINLOG";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"库存盘点"])
    {
        DetailsStockViewController * vc = [[DetailsStockViewController alloc] init];
        vc.stock = [self.array objectAtIndex:indexPath.row];
        vc.objectname = @"UDSTOCK";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"调试工单子表"])
    {
        
        TSGDZB_ViewController * vc = [[TSGDZB_ViewController alloc] init];
        vc.Kmodel = [self.array objectAtIndex:indexPath.row];
        vc.key = @"调试工单子表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //
}
#pragma mark
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [searchBar setShowsCancelButton:YES];
    return [searchBar showsCancelButton];
}// return NO to not become first responder

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text starts editing

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [searchBar setShowsCancelButton:YES];
    return YES;
}// return NO to not resign first responder

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text ends editing

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text changes (including clear)

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
} // called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",searchBar.text);
    self.search = searchBar.text;
    [searchBar resignFirstResponder];
    self.array=[NSMutableArray array];
    self.page=1;
    [self requestData:self.page];
    
}// called when keyboard search button pressed

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
} // called when bookmark button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    self.search=@"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}   // called when cancel button pressed

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
} // called when search results button pressed

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
