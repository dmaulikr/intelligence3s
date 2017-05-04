//
//  AddCheckViewController.m
//  intelligence
//
//  Created by chris on 16/8/13.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddChecksViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "ChooseItemNoController.h"
#import "FlightNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "CheckNumViewController.h"
#import "SoapUtil.h"
#import "ChoiceWorkView.h"
#import "FanNumViewController.h"
#import "WorkPlanViewController.h"
#import "FanTypeViewController.h"
#import "FlightNumberViewController.h"
#import "FlightNumberViewController.h"
#import "RegularViewController.h"

@interface AddChecksViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI2;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI4;
/** 定检组长*/
@property (nonatomic,strong)PersonalSettingItem *LLI5;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL6;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL7;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL8;
/** ------第二部分----*/
/** 定检标准号*/
@property (nonatomic,strong)PersonalSettingItem *LL9;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI10;
/** 计划完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI11;
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI12;
/** 实际完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI13;
/** ------第三部分----*/
/** 定检人员1*/
@property (nonatomic,strong)PersonalSettingItem *LLI14;
/** 定检人员2*/
@property (nonatomic,strong)PersonalSettingItem *LLI15;
/** 定检人员3*/
@property (nonatomic,strong)PersonalSettingItem *LLI16;
/** 定检计划编号*/
@property (nonatomic,strong)PersonalSettingItem *LL17;
/** 定检类型*/
@property (nonatomic,strong)PersonalSettingItem *LLI18;
/** 计划定检风机台数*/
@property (nonatomic,strong)PersonalSettingItem *LT19;
/** ------第四部分----*/
/** 风机型号*/
@property (nonatomic,strong)PersonalSettingItem *LLI20;
/** 定检结果*/
@property (nonatomic,strong)PersonalSettingItem *LC21;
/** 备注*/
@property (nonatomic,strong)PersonalSettingItem *LT22;
/** 大部件发放*/
@property (nonatomic,strong)PersonalSettingItem *LC23;
@property (nonatomic,strong)ChooseItemNoModel *choose1;
@property (nonatomic,strong)ChoosePersonModel *choose2;
@property (nonatomic,strong)ChoosePersonModel *choose3;
@property (nonatomic,strong)ChoosePersonModel *choose4;
@property (nonatomic,strong)ChoosePersonModel *choose5;
@property (nonatomic,strong)NSMutableDictionary *dics;

@property (nonatomic,strong)TXTimeChoose *timeYear1;
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)NSMutableArray *workArray;
@end

@implementation AddChecksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建定检工单";
    _workArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
    [self addFour];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工单详情" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:0];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,] icon:@"more"];
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
        HUDNormal(@"请选择定检组长");
        return;
    }else if ([SettingContent(_LLI18) isEqualToString:@""]){
        HUDNormal(@"请选择定检类型");
        return;
    }else if ([SettingContent(_LLI20) isEqualToString:@""]){
        HUDNormal(@"请选择风机型号");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"WORKORDER_WS",@"ACTIONNAME":@"定检工单"}];
        }
        else
        {
            HUDNormal(@"新建工单失败");
        }
    };
    AccountModel *model = [AccountManager account];
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
                           @"ACTFINISH":@"",
                           @"ACTSTART":@"",
                           @"PRODESC":SettingContent(_LL3),
                           @"ASSETTYPE":@"",
                           @"BRANCH":SettingContent(_LL1),
                           @"CREATEBY":model.personId,
                           @"CREATEDATE":SettingContent(_LL8),
                           @"DESCRIPTION":[NSString stringWithFormat:@"%@%@%@%@定检类型",SettingContent(_LL8),SettingContent(_LL7),SettingContent(_LL3),SettingContent(_LLI18)],
                           @"DJPLANNUM":@"",
                           @"DJTYPE":SettingContent(_LLI18),
                           @"JGPLANNUM":@"",
                           @"LEAD":_choose2.PERSONID.length?_choose2.PERSONID:@"",
                           @"LEADNAME":SettingContent(_LLI5),
                           @"LOCDESC":@"",
                           @"NAME1":SettingContent(_LLI14),
                           @"NAME2":SettingContent(_LLI15),
                           @"NAME3":SettingContent(_LLI16),
                           @"PCCOMPNUM":SettingContent(_LT19),
                           @"PCRESON":@"",
                           @"PCTYPE":@"",
                           @"PLANNUM":@"",
                           @"PRONAME":SettingContent(_LL3),
                           @"SCHEDFINISH":@"",
                           @"SCHEDSTART":@"",
                           @"UDFJAPPNUM":@"",
                           @"UDFJFOL":@"",
                           @"UDINSPOBY":_choose4.PERSONID.length?_choose4.PERSONID:@"",
                           @"UDINSPOBY2":SettingContent(_LLI15),
                           @"UDINSPOBY3":_choose5.PERSONID.length?_choose5.PERSONID:@"",
                           @"UDJGRESULT":@"",
                           @"UDJGTYPE":@"",
                           @"UDJPNUM":SettingContent(_LL9),
                           @"UDLOCATION":@"",
                           @"UDLOCNUM":SettingContent(_LLI4),
                           @"UDPLANNUM":@"",
                           @"UDPLSTARTDATE":SettingContent(_LLI10),
                           @"UDPLSTOPDATE":SettingContent(_LLI11),
                           @"UDPROBDESC":@"",
                           @"UDPROJECTNUM":SettingContent(_LLI2),
                           @"UDREMARK":SettingContent(_LC21),
                           @"UDRESTARTTIME":@"",
                           @"UDRLSTARTDATE":@"",
                           @"UDRLSTOPDATE":@"",
                           @"UDSTATUS":SettingContent(_LL6),
                           @"UDSTOPTIME":@"",
                           @"UDZGLIMIT":@"",
                           @"UDZGMEASURE":@"",
                           @"WONUM":@"",
                           @"WORKTYPE":@"WS",
                           @"WTCODE":SettingContent(_LLI20),
                           @"ISBIGPAR":SettingContent(_LC23),
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
    AccountModel *model = [AccountManager account];
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    
    self.LLI2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    _LLI2.operation = ^{
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            weakSelf.choose1 = model;
            weakSelf.LL1.content = model.BRANCH;
            weakSelf.LLI2.content = model.PRONUM;
            weakSelf.LL3.content = model.DESCRIPTION;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };

    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        if (weakSelf.LLI2.content.length == 0) {
            WHUDNormal(@"请选择项目编号");
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

    
    self.LLI5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"定检组长:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose2 = model;
            weakSelf.LLI5.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    self.LL6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"新建" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:model.displayName withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:kGetCurrentTime(@"yyyy-MM-dd HH:mm:ss") withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LLI2,_LL3,_LLI4,_LLI5,_LL6,_LL7,_LL8,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检标准编号:" type:PersonalSettingItemTypeArrow];
    _LL9.operation =^{
        CheckNumViewController *check = [[CheckNumViewController alloc]init];
        check.executeCellClick = ^(CheackNumModel *model){
            weakSelf.LL9.content = model.JPNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:check animated:YES];
    };
    
    self.LLI10 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划开始时间:" type:PersonalSettingItemTypeArrow];
    _LLI10.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };

    
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划完成时间:" type:PersonalSettingItemTypeArrow];
    _LLI11.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际成时间:" type:PersonalSettingItemTypeArrow];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL9,_LLI10,_LLI11,_LLI12,_LLI13];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员1:" type:PersonalSettingItemTypeArrow];
    _LLI14.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose3 = model;
            weakSelf.LLI14.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI15 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员2:" type:PersonalSettingItemTypeArrow];
    _LLI15.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose4 = model;
            weakSelf.LLI15.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI16 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员3:" type:PersonalSettingItemTypeArrow];
    _LLI16.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose5 = model;
            weakSelf.LLI16.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LL17 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"定检计划编号:" type:PersonalSettingItemTypeArrow];
    _LL17.operation =^{
        RegularViewController *regular = [[RegularViewController alloc]init];
        regular.executeCellClick = ^(RegularModel *model){
            weakSelf.LL17.content = model.PLANNO;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:regular animated:YES];
    };
    self.LLI18 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"定检类型:" type:PersonalSettingItemTypeArrow];
    _LLI18.operation = ^{
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeDiJian];
        work.WorkBlock = ^(NSString *str){
            weakSelf.LLI18.content = str;
            [weakSelf.tableView reloadData];
        };
        [work ShowInView:weakSelf.view];
    };

    
    self.LT19 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"计划定检风机台数:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI14,_LLI15,_LLI16,_LL17,_LLI18,_LT19];
    [_allGroups addObject:group];

}
//第四部分
-(void)addFour{
    WEAKSELF
    self.LLI20 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"风机型号:" type:PersonalSettingItemTypeArrow];
    _LLI20.operation = ^{
        if (_LLI2.content.length == 0 ) {
            WHUDNormal(@"请选择项目编号");
            return ;
        }
        FlightNumberViewController *fan = [[FlightNumberViewController alloc]init];
        fan.requestCoding = SettingContent(weakSelf.LLI2);
        fan.executeCellClick = ^(FlightNoModel *mode){
            weakSelf.LLI20.content = mode.MODELTYPE;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:fan animated:YES];
    };
    
    self.LC21 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检结果" type:PersonalSettingItemTypeChoice];
    
    self.LT22 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"备注:" type:PersonalSettingItemTypeLabels];
    
    self.LC23 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"大部件发放:" type:PersonalSettingItemTypeChoice];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI20,_LC21,_LT22,_LC23];
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
            weakSelf.LLI10.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LLI11.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}

@end
