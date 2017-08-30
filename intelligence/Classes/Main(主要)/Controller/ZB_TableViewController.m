//
//  ZB_TableViewController.m
//  intelligence
//
//  Created by chris on 2017/8/22.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "ZB_TableViewController.h"
#import "WLXX_ViewController.h"
#import "DJGDRW_ViewController.h"
#import "PCGDRW_ViewController.h"
#import "JGGDRW_ViewController.h"
#import "ZYSGDRW_ViewController.h"
#import "FJZB_ViewController.h"
#import "XMRY_ViewController.h"
#import "XMCL_ViewController.h"
#import "TJJDRB_ViewController.h"
#import "DJTSRB_ViewController.h"
#import "GZRZHD_ViewController.h"
#import "YXRZXX_ViewController.h"
#import "PDMXH_ViewController.h"
#import "TSGDZB_ViewController.h"

@interface ZB_TableViewController ()

@end

@implementation ZB_TableViewController
{
    UIButton *choice;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:self.type];
    self.table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.view addSubview:self.table];
    [self initTable];
    self.page=1;
    [self requestData:self.page=1];
    self.array = [NSMutableArray array];
}
-(void)viewDidAppear:(BOOL)animated
{
    
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
    
    if ([self.type isEqualToString:@"定检工单任务"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GDRW_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"排查工单任务"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GDRW_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"技改工单任务"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GDRW2_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"终验收工单任务"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GDRW2_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"物料信息"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_WLXX_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"巡检项目"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"不合格项目"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"风机子表"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_FJZB_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"项目人员"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XMRY_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"项目车辆"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_XMCL_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"土建阶段日报"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TJJDRB_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"吊装调试日报"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_DJTSRB_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"工作日报"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GZRB_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"工装管理"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_GZGL_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"运行日志行信息"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGD_With:self.search page:page];
    }
    else if ([self.type isEqualToString:@"盘点明细行"])
    {
        dataDic = [RequestJsonFactry getRequestJsonfor_TSGD_With:self.search page:page];
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
            //工单任务
            if ([self.type isEqualToString:@"定检工单任务"]) {
                WorksPlanModel *work =[WorksPlanModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            if ([self.type isEqualToString:@"排查工单任务"]) {
                WorksPlanModel *work =[WorksPlanModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            if ([self.type isEqualToString:@"技改工单任务"]) {
                WorksPlanModel *work =[WorksPlanModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            if ([self.type isEqualToString:@"终验收工单任务"]) {
                WorksPlanModel *work =[WorksPlanModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //物料信息
            else if ([self.type isEqualToString:@"物料信息"])
            {
                MaterielsModel *work =[MaterielsModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //巡检项目
            else if ([self.type isEqualToString:@"巡检项目"])
            {
                InspectProjectModel *work =[InspectProjectModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //不合格项目
            else if ([self.type isEqualToString:@"不合格项目"])
            {
                InspectProjectModel *work =[InspectProjectModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //风机子表
            else if ([self.type isEqualToString:@"风机子表"])
            {
                FanTypeModel *work =[FanTypeModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //项目人员
            else if ([self.type isEqualToString:@"项目人员"])
            {
                ProjectPersonModel *work =[ProjectPersonModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //项目车辆
            else if ([self.type isEqualToString:@"项目车辆"])
            {
                ProjectCarsModel *work =[ProjectCarsModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //土建阶段日报
            else if ([self.type isEqualToString:@"土建阶段日报"])
            {
                ConstructionModel *work =[ConstructionModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //吊装调试日报
            else if ([self.type isEqualToString:@"吊装调试日报"])
            {
                HoistingModel *work =[HoistingModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //工作日报
            else if ([self.type isEqualToString:@"工作日报"])
            {
                DailyWorkModel *work =[DailyWorkModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //工装管理
            else if ([self.type isEqualToString:@"工装管理"])
            {
                ToolingManagementModel *work =[ToolingManagementModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //运行日志
            else if ([self.type isEqualToString:@"运行日志"])
            {
                Runliner *work =[Runliner mj_objectWithKeyValues:dic];
                [self.array addObject:work];
            }
            //盘点明细行
            else if ([self.type isEqualToString:@"盘点明细行"])
            {
                DetailStockModel *work =[DetailStockModel mj_objectWithKeyValues:dic];
                [self.array addObject:work];
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
    [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    
    if ([self.type isEqualToString:@"定检工单任务"])
    {
        WorksPlanModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.TASKID];
        [cell.bottom setText:object.DESCRIPTION];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
       
    }
    else if ([self.type isEqualToString:@"排查工单任务"])
    {
        WorksPlanModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.TASKID];
        [cell.bottom setText:[NSString stringWithFormat:@"%@ %@",object.WOJO1,object.WOJO2]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        
    }
    else if ([self.type isEqualToString:@"技改工单任务"])
    {
        WorksPlanModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.TASKID];
        [cell.bottom setText:[NSString stringWithFormat:@"%@ %@",object.JGUNITNAME,object.JGBJGYS]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        
    }
    else if ([self.type isEqualToString:@"终验收工单任务"])
    {
        WorksPlanModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.TASKID];
        [cell.bottom setText:[NSString stringWithFormat:@"%@ %@",object.UDZYSCORN]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        
    }
    else if ([self.type isEqualToString:@"物料信息"])
    {
        MaterielsModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.ITEMNUM];
        [cell.bottom setText:object.ITEMDESC];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"土建阶段日报"])
    {
        ConstructionModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.PERSONDESC];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@",object.CREATEDATE,object.PROPHASE]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"吊装调试日报"])
    {
        HoistingModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.NAME];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@",object.CREATEDATE,object.PROPHASE]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"工作日报"])
    {
        DailyWorkModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.RUNLOGDATE];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@",object.WEATHER,object.DESCRIPTION]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"工装管理"])
    {
        //ToolingManagementModel;
        ToolingManagementModel * object= [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.RUNLOGDATE];
        [cell.bottom setText:[NSString stringWithFormat:@"%@",object.TYPE2]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    //风机子表
    else if ([self.type isEqualToString:@"风机子表"])
    {
        FanTypeModel *object = [self.array objectAtIndex:indexPath.row];
        [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.LOCNUM];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@\n%@",object.EMPST,object.MODELTYPE,object.STATUS]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    //项目人员
    else if ([self.type isEqualToString:@"项目人员"])
    {
        ProjectPersonModel *object = [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.PERSONID];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@",object.BRANCH,object.PRONUM]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
       
    }
    //项目车辆
    else if ([self.type isEqualToString:@"项目车辆"])
    {
        ProjectCarsModel *object = [self.array objectAtIndex:indexPath.row];
        [cell.top setText:object.LICENSENUM];
        [cell.bottom setText:[NSString stringWithFormat:@"%@\n%@",object.DRIVER,object.VEHICLENAME]];
        [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    }
    else if ([self.type isEqualToString:@"调试工单子表"])
    {
        WorkDebugsModel * stock = [self.array objectAtIndex:indexPath.row];
        cell.top.text = @"";
        cell.bottom.text = [NSString stringWithFormat:@"\n调试区域负责人: %@ \n调试组长: %@",stock.RESPONSIBLEPERSON,stock.DEBUGLEADER];
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
    if ([self.type isEqualToString:@"定检工单任务"])
    {
        DJGDRW_ViewController * vc = [[DJGDRW_ViewController alloc] init];
        vc.key = @"定检工单任务";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"排查工单任务"])
    {
        PCGDRW_ViewController * vc = [[PCGDRW_ViewController alloc] init];
        vc.key = @"排查工单任务";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"技改工单任务"])
    {
        JGGDRW_ViewController * vc = [[JGGDRW_ViewController alloc] init];
        vc.key = @"技改工单任务";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"终验收工单任务"])
    {
        ZYSGDRW_ViewController * vc = [[ZYSGDRW_ViewController alloc] init];
        vc.key = @"终验收工单任务";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //物料信息
    else if ([self.type isEqualToString:@"物料信息"])
    {
        WLXX_ViewController * vc = [[WLXX_ViewController alloc] init];
        vc.Kmodel = [self.array objectAtIndex:indexPath.row];
        vc.key = @"物料信息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //巡检项目
    else if ([self.type isEqualToString:@"巡检项目"])
    {
        
    }
    //不合格项目
    else if ([self.type isEqualToString:@"不合格项目"])
    {

    }
    //风机子表
    else if ([self.type isEqualToString:@"风机子表"])
    {
        FJZB_ViewController * vc = [[FJZB_ViewController alloc] init];
        vc.key = @"风机子表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //项目人员
    else if ([self.type isEqualToString:@"项目人员"])
    {
        XMRY_ViewController * vc = [[XMRY_ViewController alloc] init];
        vc.key = @"项目人员";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //项目车辆
    else if ([self.type isEqualToString:@"项目车辆"])
    {
        XMCL_ViewController * vc = [[XMCL_ViewController alloc] init];
        vc.key = @"项目车辆";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //土建阶段日报
    else if ([self.type isEqualToString:@"土建阶段日报"])
    {
        TJJDRB_ViewController *vc =[[TJJDRB_ViewController alloc] init];
        vc.key = @"土建阶段日报";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //吊装调试日报
    else if ([self.type isEqualToString:@"吊装调试日报"])
    {
        DJTSRB_ViewController * vc = [[DJTSRB_ViewController alloc] init];
        vc.key = @"吊装调试日报";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //工作日报
    else if ([self.type isEqualToString:@"工作日报"])
    {
        YXRZXX_ViewController * vc = [[YXRZXX_ViewController alloc] init];
        vc.key = @"运行日报";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //工装管理
    else if ([self.type isEqualToString:@"工装管理"])
    {

    }
    //运行日志
    else if ([self.type isEqualToString:@"运行日志"])
    {
        YXRZXX_ViewController * vc = [[YXRZXX_ViewController alloc] init];
        vc.key = @"运行日志";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //盘点明细行
    else if ([self.type isEqualToString:@"盘点明细行"])
    {
        PDMXH_ViewController * vc = [[PDMXH_ViewController alloc] init];
        vc.key = @"盘点明细行";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"调试工单子表"])
    {
        
        TSGDZB_ViewController * vc = [[TSGDZB_ViewController alloc] init];
        vc.Kmodel = [self.array objectAtIndex:indexPath.row];
        vc.key = @"调试工单子表";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
