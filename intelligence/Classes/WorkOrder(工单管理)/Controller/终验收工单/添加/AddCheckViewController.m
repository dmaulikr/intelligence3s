//
//  AddCheckViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AddCheckViewController.h"
#import "DTKDropdownMenuView.h"
#import "ChooseItemNoController.h"
#import "FlightNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "SoapUtil.h"
#import "FooterView.h"
#import "FinalNumViewController.h"
#import "WorkPlanViewController.h"
@interface AddCheckViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI2;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI4;
/** 终验收负责人*/
@property (nonatomic,strong)PersonalSettingItem *LLI5;
/** 终验收计划号*/
@property (nonatomic,strong)PersonalSettingItem *LLI6;
/** 项目负责人*/
@property (nonatomic,strong)PersonalSettingItem *LLI7;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL8;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL9;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL10;
/** ------第二部分----*/
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI11;
/** 实际完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI12;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong)ChoosePersonModel *choose1;
@property (nonatomic,strong)ChoosePersonModel *choose2;
@property (nonatomic,strong)ChoosePersonModel *choose3;
@property (nonatomic,strong)ChoosePersonModel *choose4;
@property (nonatomic,strong)ChoosePersonModel *choose5;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear1;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)NSMutableArray *workArray;
@end

@implementation AddCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建终验收工单";
    _workArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作计划" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0] icon:@"more"];
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 130.f;
    //    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    //    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)pushWithIndex:(NSInteger)index
{
    WEAKSELF
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            //工作计划
            WorkPlanViewController *work = [[WorkPlanViewController alloc]init];
            work.executeCellClick = ^(NSArray *array){
                [weakSelf.workArray removeAllObjects];
                [weakSelf.workArray addObjectsFromArray:array];
            };
            work.numbers = 1;
            work.array = self.workArray;
            [weakSelf.navigationController pushViewController:work animated:YES];
        }break;
            
        default:
            break;
    }
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClicks) forControlEvents:UIControlEventTouchUpInside];
    
    footer.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:footer];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-55);
    }];
}
//取消
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)saveClicks{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定新增工单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self saveClick];
    }
}

//保存
-(void)saveClick{
    
    if ([SettingContent(_LLI2) isEqualToString:@""]) {
        HUDNormal(@"请选择项目编号");
        return;
    }else if ([SettingContent(_LLI4) isEqualToString:@""]){
        HUDNormal(@"请选择机位号");
        return;
    }else if ([SettingContent(_LLI5) isEqualToString:@""]){
        HUDNormal(@"请选择终验收负责人");
        return;
    }else if ([SettingContent(_LLI7) isEqualToString:@""]){
        HUDNormal(@"请选择项目负责人");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    AccountModel *model = [AccountManager account];
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            [weakSelf.navigationController popViewControllerAnimated:NO];
            if(weakSelf.OpenCheck){
                [weakSelf.dics setValue:dic[@"WONUM"] forKey:@"WONUM"];
                [weakSelf.dics setValue:model.displayName forKey:@"CREATENAME"];
                weakSelf.OpenCheck(weakSelf.dics);
            }
        }
    };
    
    NSMutableArray *arrayst = [NSMutableArray array];
    for (NSDictionary *dic in self.workArray) {
        WorksPlanModel *work = [WorksPlanModel mj_objectWithKeyValues:dic];
        NSDictionary *dic = @{
                              @"DESCRIPTION"  :work.DESCRIPTION,
                              @"ESTDUR"       :work.ESTDUR,
                              @"OWNER"        :work.OWNER,
                              @"OWNERNAME"    :work.OWNERNAME,
                              @"TASKID"       :work.TASKID,
                              @"TYPE"         :@"add",
                              };
        [arrayst addObject:dic];
    }
    NSMutableDictionary *dicy = [NSMutableDictionary dictionary];
    if (arrayst.count) {
        [dicy setObject:arrayst forKey:@"WOACTIVITY"];
    }
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
                           @"ACTFINISH":SettingContent(_LLI12),
                           @"ACTSTART":SettingContent(_LLI11),
                           @"ASSETTYPE":@"",
                           @"BRANCH":SettingContent(_LL1),
                           @"CREATEBY":model.personId,
                           @"CREATEDATE":SettingContent(_LL10),
                           @"DESCRIPTION":[NSString stringWithFormat:@"%@%@%@%@号风机验收工单",SettingContent(_LL10),SettingContent(_LL9),SettingContent(_LL3),SettingContent(_LLI4)],
                           @"DJPLANNUM":@"",
                           @"DJTYPE":@"",
                           @"JGPLANNUM":@"",
                           @"LEAD":_choose1.PERSONID.length?_choose1.PERSONID:@"",
                           @"LEADNAME":SettingContent(_LLI5),
                           @"LOCDESC":@"",
                           @"PCCOMPNUM":@"",
                           @"PCRESON":@"",
                           @"PCTYPE":@"",
                           @"PLANNUM":@"",
                           @"PRONAME":SettingContent(_LL3),
                           @"SCHEDFINISH":@"",
                           @"SCHEDSTART":@"",
                           @"UDFJAPPNUM":@"",
                           @"UDFJFOL":@"",
                           @"UDJGRESULT":@"",
                           @"UDJGTYPE":@"",
                           @"UDJPNUM":@"",
                           @"UDLOCATION":@"",
                           @"UDLOCNUM":SettingContent(_LLI4),
                           @"UDPLANNUM":SettingContent(_LLI6),
                           @"UDPLSTARTDATE":@"",
                           @"UDPLSTOPDATE":@"",
                           @"UDPROBDESC":@"",
                           @"UDPROJECTNUM":SettingContent(_LLI2),
                           @"UDPRORES":_choose2.PERSONID.length?_choose2.PERSONID:@"",
                           @"UDPRORESNAME":SettingContent(_LLI7),
                           @"UDREMARK":@"",
                           @"UDRESTARTTIME":@"",
                           @"UDRLSTARTDATE":@"",
                           @"UDRLSTOPDATE":@"",
                           @"UDSTATUS":SettingContent(_LL8),
                           @"UDSTOPTIME":@"",
                           @"UDZGLIMIT":@"",
                           @"UDZGMEASURE":@"",
                           @"WONUM":@"",
                           @"WORKTYPE":@"AA",
                           @"WTCODE":@"",
                           @"ISBIGPAR":@"0",
                           @"ISSTOPED":@"0",
                           @"PERINSPR":@"0",
                           @"relationShip":arrays,
                           };
    NSMutableDictionary *dics1 = [NSMutableDictionary dictionary];
    [dics1 addEntriesFromDictionary:dic1];
    if (arrayst.count) {
        [dics1 setObject:arrayst forKey:@"WOACTIVITY"];
    }
    _dics = [NSMutableDictionary dictionaryWithDictionary:dics1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"flag":@"1"},
                     @{@"mboObjectName":@"WORKORDER"},
                     @{@"mboKey":@"WONUM"},
                     @{@"personId":model.personId},
                     ];
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}
/**
 *  用于不同的请求 传的参数是json
 */
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//第一部分
-(void)addOne{
    WEAKSELF
    AccountModel  *model = [AccountManager account];
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    
    self.LLI2 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    _LLI2.operation = ^{
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            weakSelf.LL1.content = model.BRANCH;
            weakSelf.LLI2.content = model.PRONUM;
            weakSelf.LL3.content = model.DESCRIPTION;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };

    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        if (weakSelf.LLI2.content.length == 0) {
            HUDNormal(@"请选择项目编号");
            return ;
        }
        
        
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
            weakSelf.LLI4.content = model.LOCNUM;
            [weakSelf.tableView reloadData];
        };
        choose.requestCoding = weakSelf.LLI2.content;
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };

    
    self.LLI5 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"终验收负责人:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose1 = model;
            weakSelf.LLI5.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"终验收计划号:" type:PersonalSettingItemTypeArrow];
    _LLI6.operation = ^{
        FinalNumViewController *choose = [[FinalNumViewController alloc]init];
        choose.executeCellClick = ^(FinalModels *model){
            weakSelf.LLI6.content = model.PLANNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    
    self.LLI7 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"项目负责人:" type:PersonalSettingItemTypeArrow];
    _LLI7.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose2 = model;
            weakSelf.LLI7.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:@"新建" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:model.displayName withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:kGetCurrentTime(@"yyyy-MM-dd HH:mm:ss") withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LLI2,_LL3,_LLI4,_LLI5,_LLI6,_LLI7,_LL8,_LL9,_LL10];
    [_allGroups addObject:group];
}

//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
//    _LLI11.operation = ^{
//        [weakSelf.view addSubview:weakSelf.timeYear1];
//    };
    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"实际完成时间:" type:PersonalSettingItemTypeArrow];
//    _LLI12.operation = ^{
//        [weakSelf.view addSubview:weakSelf.timeYear2];
//    };
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI11,_LLI12];
    [_allGroups addObject:group];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.LLI11.content = [weakSelf.timeYear1 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear1;
}
- (TXTimeChoose *)timeYear2{
    WEAKSELF
    if (!_timeYear2) {
        self.timeYear2 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear2.backString = ^(NSDate *data){
            weakSelf.LLI12.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}


@end
