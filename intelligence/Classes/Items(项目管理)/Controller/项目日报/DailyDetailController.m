//
//  DailyDetailController.m
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DailyDetailController.h"
#import "DTKDropdownMenuView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "ProcessDetailsCell.h"
#import "DailyDetailsFooterView.h"
#import "DailyDetailsCell.h"
#import "ChoiceWorkView.h"
#import "DailyDetailChoosePersonController.h"
#import "ChooseItemNoController.h"

#import "ConstructionPhaseDailyListController.h"
#import "HoistingDebugDailyController.h"
#import "DailyWorkController.h"
#import "ToolingManagementAddController.h"

#import "ChooseItemNoModel.h"
#import "ChoosePersonModel.h"
#import "SoapUtil.h"
#import "ShareConstruction.h"
#import "ToolingManagementController.h"

@interface DailyDetailController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;

@end

@implementation DailyDetailController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日报详情";
    [self.view addSubview:self.tableView];
    [self addTableFooterView];
    [self addRightNavBarItem];
    
    NSLog(@"项目日报详情 %@",[self.daily mj_JSONString]);
}

- (void)addTableFooterView{
    WEAKSELF
    self.footerView = [DailyDetailsFooterView showXibView];
    self.footerView.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    self.footerView.executeBtnCancelClick = ^(){
        NSLog(@"取消");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.footerView.executeBtnSaveClick = ^(){
        NSLog(@"保存");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要进行修改？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    };
    [self.view addSubview:self.footerView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self updata];
            break;
            
        default:
            break;
    }
}

- (void)updata{
    SVHUD_NO_Stop(@"保存日报中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"0"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            HUDNormal(@"保存成功");
            ShareConstruction *share = [ShareConstruction sharedConstruction];
            share = nil;
        }else{
            HUDNormal(dic[@"errorMsg"])
        }
    };
   
    
/*    {
 "relationShip":[{"UDPRORUNLOGLINE1":""}],
 "PRORUNLOGNUM":"1078",
 "DESCRIPTION":"水电云南巨龙山2016年11月项目日报",
 "PRONUM":"S1-20130001",
 "PRODESC":"水电云南巨龙山",
 "UDPRORESC":"陆犇",
 "CONTDESC":"陆犇",
 "YEAR":"2016",
 "MONTH":"11",
 "PROSTAGE":"质保期",
 "STATUS":"新建",
 
 "CONTRACTS":"F00433",
 "RESPONSID":"F00433",
 "CHANGEBY":"MAXADMIN",
 "CHANGEDATE":"2016-11-03 16:59:30",
 "UDPRORUNLOGLINE1":[
     {
      "BASEAOG":"2016-11-03",
      "OUTSIDEROAD":"djfjj",
      "FUNNUM":"004#",
      "PERSONDESC":"林诣",
      "REMARK":"fj",
      "INSIDEROAD":"rff",
      "VEHICLERECORDS":"djdj",
      "PERSONID":"A01864",
      "CREATEDATE":"2016-11-03",
      "BASESTART":"2016-11-03",
      "VILLAGERINVOLVED":"0",
      "TAMERAOG":"2016-11-03",
      "PROPHASE":"质保期",
      "LAND":"ffkfj",
      "KEYPOINT":"",
      "BASEPLACING":"2016-11-03",
      "TYPE":"add"
     }
   ],
 }
 */
    /*
     {json={
     "PRORUNLOGNUM":"1086",
     "DESCRIPTION":"三峡新能源云南施甸四大山2016年3月项目日报",
     "PRONUM":"S1-20150017",
     "PRODESC":"三峡新能源云南施甸四大山",
     "UDPRORESC":"殷应和",
     "CONTDESC":"殷应和",
     "YEAR":"2016",
     "MONTH":"3",
     "PROSTAGE":"调试期",
     "STATUS":"新建",
     "CHANGEBY":"MAXADMIN",
     "CHANGEDATE":"2016-11-07 10:01:46",
     "CONTRACTS":"F00227",
     "RESPONSID":"F00227",
     "UDPRORUNLOGLINE2":[
      {"BASECOMP":"基础浇筑完成累计数",
       "BPQPRODUCTION":"吊装完成累计数",
       "CLXPRODUCTION":"主机累计到货数",
       "COMPCHECKING":"轮毂累计到货数",
       "COMPRUNNING":"叶片累计到货数",
       "CREATEDATE":"2016-11-08",
       "DATE1":"2016-11-01",
       "DATE2":"2016-11-02",
       "DATE3":"2016-11-03",
       "DEBUGGING":"电气安装完成累计数",
       "DEBUGGING2":"安装验收完成累计数",
       "DEBUGGINGCHECK":"试运行台数",
       "DZCOMP":"试运行完成台数",
       "DZNUM":"001#",
       "DZSTART":"预验收完成台数",
       "NAME":"闵红卫",
       "PERSONID":"A10078",
       "PROPHASE":"调试期",
       "PRORUNLOGNUM":"1086",
       "REMARK1":"备注",
       "TYPE":"add",
       "WORKJOB":"当日工作内容"}],
       "relationShip":[{"UDPRORUNLOGLINE2":""}]
      };
     mboObjectName=UDPRORUNLOG;
     mboKey=PRORUNLOGNUM;
     mboKeyValue=1086;
     }
     */
    
    /*
     {json={"CHANGEBY":"MAXADMIN","CHANGEDATE":"2016-11-07 10:01:46","CONTDESC":"殷应和","CONTRACTS":"F00227","DESCRIPTION":"三峡新能源云南施甸四大山2016年3月项目日报","MONTH":"3","PRODESC":"三峡新能源云南施甸四大山","PRONUM":"S1-20150017","PRORUNLOGNUM":"1086","PROSTAGE":"调试期","RESPONSID":"F00227","STATUS":"新建","UDPRORESC":"殷应和","YEAR":"2016","UDPRORUNLOGLINE1":[{"BASEAOG":"","BASEPLACING":"","BASESTART":"","CREATEDATE":"2016-11-09","FUNNUM":"001#","INSIDEROAD":"","KEYPOINT":"","LAND":"土建日报子表","OUTSIDEROAD":"","PERSONDESC":"闵红卫","PERSONID":"A10078","PROPHASE":"调试期","REMARK":"","TAMERAOG":"","TYPE":"add","VEHICLERECORDS":"","VILLAGERINVOLVED":"0"}],"UDPRORUNLOGLINE2":[{"BASECOMP":"","BPQPRODUCTION":"","CLXPRODUCTION":"","COMPCHECKING":"","COMPRUNNING":"","CREATEDATE":"2016-11-09","DATE1":"","DATE2":"","DATE3":"","DEBUGGING":"","DEBUGGING2":"","DEBUGGINGCHECK":"","DZCOMP":"","DZNUM":"","DZSTART":"","NAME":"殷应和","PERSONID":"F00227","PROPHASE":"调试期","PRORUNLOGNUM":"1086","REMARK1":"","TYPE":"add","WORKJOB":"吊装子表"}],
     
     "UDPRORUNLOGC":[
                     {"COMPSTA":"未完成",
                      "DESCRIPTION":"描述",
                      "PRORUNLOGNUM":"1086",
                      "REMARK":"备注",
                      "RUNLOGDATE":"2016-11-01",
                      "SITUATION":"异常情况说明",
                      "TEM":"1.0",
                      "TYPE":"add",
                      "WEATHER":"暴雪",
                      "WINDSPEED":"2.0",
                      "WORKCRON":"工作任务",
                      "WORKPG":"工作班成员",
                      "WORKTYPE":"程序刷新"
                     }
                    ],
     "UDPRORUNLOGLINE4":[
                         {
                          "NUMBER1":"1",
                          "NUMBER2":"2",
                          "NUMBER3":"3",
                          "NUMBER4":"4",
                          "RUNLOGDATE":"2016-11-02",
                          "TYPE":"add",
                          "TYPE2":"1.5MW轮毂工装"
                          }
                         ],
     "relationShip":[{"UDPRORUNLOGLINE1":"","UDPRORUNLOGLINE2":"","UDPRORUNLOGC":"","UDPRORUNLOGLINE4":""}]}; mboObjectName=UDPRORUNLOG; mboKey=PRORUNLOGNUM; mboKeyValue=1086; }     */
    
    
    NSMutableArray *relationShip = [NSMutableArray array];
    NSMutableDictionary *relationShipDict = [NSMutableDictionary dictionary];
   // "relationShip":[{"UDPRORUNLOGLINE1":""}],
    
    NSDictionary *dic = @{
                          @"PRORUNLOGNUM":self.daily.PRORUNLOGNUM,
                          @"DESCRIPTION":self.daily.DESCRIPTION,
                          @"PRONUM":self.daily.PRONUM,
                          @"PRODESC":self.daily.BRANCH,
                          @"UDPRORESC":self.daily.UDPRORESC,
                          @"CONTDESC":self.daily.CONTDESC,
                          @"YEAR":self.daily.YEAR,
                          @"MONTH":self.daily.MONTH,
                          @"PROSTAGE":self.daily.PROSTAGE,
                          @"STATUS":self.daily.STATUS,
                          @"CHANGEBY":self.daily.CHANGEBY,
                          @"CHANGEDATE":self.daily.CHANGEDATE,
                          @"CONTRACTS":self.daily.CONTRACTS,
                          @"RESPONSID":self.daily.RESPONSID,
                          };
    
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    ShareConstruction *share = [ShareConstruction sharedConstruction];
    if (share.construction.dic.allKeys.count > 0) {
        NSArray *array = @[share.construction.dic];
        [dictionary setObject:array forKey:@"UDPRORUNLOGLINE1"];
        [relationShipDict setObject:@"" forKey:@"UDPRORUNLOGLINE1"];
//        [relationShip addObject:@{@"UDPRORUNLOGLINE1" : @""}];
//        [dictionary addEntriesFromDictionary:share.construction.dic];
//        NSDictionary *dict = @{share.construction.mboObjectName:@""};
//        [relationShip addObject:dict];
    }
    
    
    if (share.hoisting.dic.allKeys.count > 0) {
        NSArray *array = @[share.hoisting.dic];
        [dictionary setObject:array forKey:@"UDPRORUNLOGLINE2"];
        [relationShipDict setObject:@"" forKey:@"UDPRORUNLOGLINE2"];
//        [relationShip addObject:@{@"UDPRORUNLOGLINE2" : @""}];
//        NSDictionary *dict = @{share.hoisting.mboObjectName:@""};
//        [relationShip addObject:dict];
    }
    
    if (share.dailyWork.dic.allKeys.count > 0) {
        NSArray *array = @[share.dailyWork.dic];
        [dictionary setObject:array forKey:@"UDPRORUNLOGC"];
        [relationShipDict setObject:@"" forKey:@"UDPRORUNLOGC"];
//        [relationShip addObject:@{@"UDPRORUNLOGC" : @""}];
//        [dictionary addEntriesFromDictionary:share.dailyWork.dic];
//        NSDictionary *dict = @{share.dailyWork.mboObjectName:@""};
//        [relationShip addObject:dict];
    }
    
    if (share.toolingManagement.dic.allKeys.count > 0) {
        NSArray *array = @[share.toolingManagement.dic];
        [dictionary setObject:array forKey:@"UDPRORUNLOGLINE4"];
        [relationShipDict setObject:@"" forKey:@"UDPRORUNLOGLINE4"];
        
//        [relationShip addObject:@{@"UDPRORUNLOGLINE4" : @""}];
//        [dictionary addEntriesFromDictionary:share.toolingManagement.dic];
//        NSDictionary *dict = @{share.toolingManagement.mboObjectName:@""};
//        [relationShip addObject:dict];
    }
    
//    [dictionary setObject:relationShip forKey:@"relationShip"];
    
    if ([dictionary allKeys].count == 0) {
        [relationShip addObject:@{@"" : @""}];
    }else{
        [relationShip addObject:relationShipDict];
    }
    [dictionary setObject:relationShip forKey:@"relationShip"];
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dictionary]},
                     @{@"mboObjectName" : @"UDPRORUNLOG"},
                     @{@"mboKey" : @"PRORUNLOGNUM"},
                     @{@"mboKeyValue" : self.daily.PRORUNLOGNUM}
                     ];
    
    
    [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
}

/**
 *  用于不同的请求 传的参数是json
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"土建阶段日报" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"吊装调试日报" iconName:@"ic_diaozhuang" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"工作日报" iconName:@"ic_realinfo" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工装管理" iconName:@"ic_gzgl" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];

    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2,item3] icon:@"more"];
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)pushWithIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            if (self.daily.PRONUM.length < 2) {
                HUDNormal(@"缺少项目编号");
                return;
            }
            ConstructionPhaseDailyListController *vc = [[ConstructionPhaseDailyListController alloc] init];
            vc.requestStr = self.daily.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            if (self.daily.PRONUM.length < 2) {
                HUDNormal(@"缺少项目编号");
                return;
            }
            HoistingDebugDailyController *vc = [[HoistingDebugDailyController alloc] init];
            vc.requestStr = self.daily.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{
            DailyWorkController *vc = [[DailyWorkController alloc] init];
            vc.requestStr = self.daily.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 3:{
            ToolingManagementController *vc = [[ToolingManagementController alloc] init];
            vc.requestStr = self.daily.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 2:
        case 5:
        case 6:
        case 7:{
            DailyDetailsCell *cell = [DailyDetailsCell cellWithTableView:tableView];
            _daily.leftLabelWight = 110;
            _daily.index = indexPath.section;
            cell.daily = _daily;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            return cell;
        }   break;
        case 0:
        case 1:
        case 3:
        case 4:
        case 8:
        case 9:{
            ProcessDetailsCell *cell = [ProcessDetailsCell cellWithTableView:tableView];
            _daily.leftLabelWight = 110;
            _daily.index = indexPath.section;
            cell.daily = _daily;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            return cell;
        }   break;
        default: return nil; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    _daily.index = indexPath.section;
    switch (indexPath.section) {
        case 2:
        case 5:
        case 6:
        case 7:{
            CGFloat cellHeight = [self.tableView cellHeightForIndexPath:indexPath model:_daily keyPath:@"daily" cellClass:[DailyDetailsCell class] contentViewWidth:[self cellContentViewWith]];
            return cellHeight;
        }   break;
        case 0:
        case 1:
        case 3:
        case 4:
        case 8:
        case 9:{
            CGFloat cellHeight = [self.tableView cellHeightForIndexPath:indexPath model:_daily keyPath:@"daily" cellClass:[ProcessDetailsCell class] contentViewWidth:[self cellContentViewWith]];
            return cellHeight;
        }
            
        default: return 0; break;
    }
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
    WEAKSELF
    switch (indexPath.section) {
        case 2:{
            ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
            vc.title = @"项目编号";
            vc.executeClickCell = ^(ChooseItemNoModel *model){
                weakSelf.daily.PRONUM = model.PRONUM;
                weakSelf.daily.PRORUNLOGNUM = model.DESCRIPTION;
                weakSelf.daily.BRANCH = model.BRANCHDESC;
                weakSelf.daily.UDPRORESC = model.RESPONSNAME;
                weakSelf.daily.CONTDNAME = model.RESPONSNAME;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 5:{
            DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
            vc.title = @"选择联系人";
            vc.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.daily.CONTDESC = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 6:{
            ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailYear];
            popup.WorkBlock = ^(NSString *str){
                weakSelf.daily.YEAR = str;
                [weakSelf.tableView reloadData];
            };
            [popup ShowInView:self.view];
        }break;
        case 7:{
            ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailMonth];
            popup.WorkBlock = ^(NSString *str){
                weakSelf.daily.MONTH = str;
                [weakSelf.tableView reloadData];
            };
            [popup ShowInView:self.view];
        }break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
