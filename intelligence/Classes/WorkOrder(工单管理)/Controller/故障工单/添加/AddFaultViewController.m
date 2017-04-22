//
//  AddFaultViewController.m
//  intelligence
//
//  Created by chris on 16/8/9.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddFaultViewController.h"
#import "DTKDropdownMenuView.h"
#import "ChooseItemNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "FooterView.h"
#import "SoapUtil.h"
#import "EquipmentLocationController.h"
#import "FaultClassController.h"
#import "FaultCodeController.h"
#import "FlightNoController.h"
#import "FinalNumViewController.h"
#import "WorkPlanViewController.h"
#import "MaterielsViewController.h"
#import "CauseProblemViewController.h"
@interface AddFaultViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL_1;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_2;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem *LL_3;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_4;
/** 设备位置*/
@property (nonatomic,strong)PersonalSettingItem *LLI_5;
/** 终验收计划号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_6;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL_7;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL_8;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL_9;
/** ------第二部分----*/
/** 维护/运行组长*/
@property (nonatomic,strong)PersonalSettingItem *LLI_10;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_11;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_12;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_13;
/** ------第二部分----*/
/** 故障类*/
@property (nonatomic,strong)PersonalSettingItem *LLI_14;
/** 故障问题*/
@property (nonatomic,strong)PersonalSettingItem *LLI_15;
/** 故障问题描述*/
@property (nonatomic,strong)PersonalSettingItem *LL_15_1;
/** 故障等级*/
@property (nonatomic,strong)PersonalSettingItem *LL_16;
/** 故障类型*/
@property (nonatomic,strong)PersonalSettingItem *LL_17;
/** 提报人*/
@property (nonatomic,strong)PersonalSettingItem *LLI_18;
/** 提报时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_19;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_20;
/** 计划完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_21;
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_22;
/** 实际结束时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_23;
/** 是否停机*/
@property (nonatomic,strong)PersonalSettingItem *LC_24;
/** 故障开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_25;
/** 故障恢复时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_26;
/** 累计停机时间*/
@property (nonatomic,strong)PersonalSettingItem *LL_27;
/** 故障隐患描述*/
@property (nonatomic,strong)PersonalSettingItem *LT_28;
/** 没有编码的物料*/
@property (nonatomic,strong)PersonalSettingItem *LT_27I;
/** 年月日*/
@property (nonatomic,strong)TXTimeChoose *timeYear1;
/** 年月日*/
@property (nonatomic,strong)TXTimeChoose *timeYear2;
/** 年月日*/
@property (nonatomic,strong)TXTimeChoose *timeYear3;
/** 年月日*/
@property (nonatomic,strong)TXTimeChoose *timeYear4;
@property (nonatomic,strong)ChooseItemNoModel *LL1Model;
@property (nonatomic,strong)FaultClassModel *faultmodel;
@property (nonatomic,strong)FaultCodeModel *faultmodel1;
@property (nonatomic,strong)ChoosePersonModel *choosemodel1;
@property (nonatomic,strong)ChoosePersonModel *choosemodel2;
@property (nonatomic,strong)ChoosePersonModel *choosemodel3;
@property (nonatomic,strong)ChoosePersonModel *choosemodel4;
@property (nonatomic,strong)ChoosePersonModel *choosemodel5;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong) NSMutableArray *workArray;
@property (nonatomic,strong) NSMutableArray *materielsArray;
@end

@implementation AddFaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建故障工单";
    self.workArray = [NSMutableArray array];
    self.materielsArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
}
-(void)setStock:(FauWorkModel *)stock
{
    _stock = stock;
}

- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作计划" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"物料信息" iconName:@"ic_realinfo" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];

    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"故障原因及措施" iconName:@"ic_failreport" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2,] icon:@"more"];
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
        case 1:{
            //物料信息
            MaterielsViewController *mater = [[MaterielsViewController alloc]init];
            mater.executeCellClick = ^(NSArray *array){
                [weakSelf.materielsArray removeAllObjects];
                [weakSelf.materielsArray addObjectsFromArray:array];
            };
            mater.array = self.materielsArray;
            [weakSelf.navigationController pushViewController:mater animated:YES];
            
        }break;
        case 2:{
            CauseProblemViewController *vc = [[CauseProblemViewController alloc] init];
            if ([SettingContent(_LLI_14) isEqualToString:@""]) {
                HUDNormal(@"请选择故障问题")
                return;
            }
            vc.requestCode = SettingContent(_LLI_15);
            [self.navigationController pushViewController:vc animated:YES];
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
    
    if ([SettingContent(_LLI_2) isEqualToString:@""]) {
        HUDNormal(@"请选择项目编号");
        return;
    }else if ([SettingContent(_LLI_4) isEqualToString:@""]){
        HUDNormal(@"请选择机位号");
        return;
    }else if ([SettingContent(_LLI_5) isEqualToString:@""]){
        HUDNormal(@"请选择设备位置");
        return;
    }else if ([SettingContent(_LLI_10) isEqualToString:@""]){
        HUDNormal(@"请选择维护/运行人员");
        return;
    }else if ([SettingContent(_LLI_11) isEqualToString:@""]){
        HUDNormal(@"请选择维护/运行人员");
        return;
    }else if ([SettingContent(_LLI_14) isEqualToString:@""]){
        HUDNormal(@"请选择故障类");
        return;
    }else if ([SettingContent(_LLI_15) isEqualToString:@""]){
        HUDNormal(@"请选择故障问题");
        return;
    }else if ([SettingContent(_LLI_18) isEqualToString:@""]){
        HUDNormal(@"请选择提报人");
        return;
    }else if ([SettingContent(_LLI_19) isEqualToString:@""]){
        HUDNormal(@"请选择提报时间");
        return;
    }else if ([SettingContent(_LLI_20) isEqualToString:@""]){
        HUDNormal(@"请选择计划开始时间");
        return;
    }else if ([SettingContent(_LLI_21) isEqualToString:@""]){
        HUDNormal(@"请选择计划完成时间");
        return;
    }else if ([SettingContent(_LLI_25) isEqualToString:@""]){
        HUDNormal(@"请选择故障开始时间");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            
             [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"WORKORDER_FR",@"ACTIONNAME":@"故障工单"}];
            
             WHUDNormal(@"新建工单成功");
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if(weakSelf.Open){
                [weakSelf.dics setValue:dic[@"WONUM"] forKey:@"WONUM"];
                [weakSelf.dics setValue:weakSelf.LL1Model.BRANCHDESC forKey:@"BRANCH"];
                weakSelf.Open(weakSelf.dics);
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

    NSMutableArray *materielArray = [NSMutableArray array];
    for (MaterielsModel *mater in self.materielsArray) {
            NSDictionary *dic = @{
                                  @"ITEMNUM"    :mater.ITEMNUM,
                                  @"ITEMQTY"    :mater.ITEMQTY,
                                  @"LOCATION"   :mater.LOCATION,
                                  @"TYPE"       :@"add",
                                  };
            [materielArray addObject:dic];
        }
    AccountModel *model = [AccountManager account];
    NSMutableDictionary *dicy = [NSMutableDictionary dictionary];
    if (arrayst.count) {
        [dicy setObject:arrayst forKey:@"WOACTIVITY"];
    }else if (materielArray.count){
        [dicy setObject:materielArray forKey:@"WPMATERIAL"];
    }
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
              @"ACTFINISH":@"",
              @"ACTSTART":@"",
              @"ASSETTYPE":@"",
              @"BRANCH":SettingContent(_LL_1),
              @"CREATEBY":model.personId,
              @"CREATEDATE":SettingContent(_LL_9),
              @"DESCRIPTION":[NSString stringWithFormat:@"%@%@%@%@号风机%@故障工单",SettingContent(_LL_9),SettingContent(_LLI_18),SettingContent(_LL_3),SettingContent(_LLI_4),SettingContent(_LLI_14)],
              @"DJPLANNUM":@"",
              @"DJTYPE":@"",
              @"FAILURECODE":_faultmodel.FAILURECODE,
              @"GZLDESC":SettingContent(_LLI_14),
              @"GZWTDESC":_faultmodel1.CODEDESC,
              @"LEAD":_choosemodel1.PERSONID.length?_choosemodel1.PERSONID:@"",////
              @"LEADNAME":SettingContent(_LLI_10),
              @"LOCDESC":SettingContent(_LLI_5),
              @"NAME1":SettingContent(_LLI_11),
              @"NAME2":SettingContent(_LLI_12),
              @"NAME3":SettingContent(_LLI_13),
              @"PCCOMPNUM":@"",
              @"PCRESON":@"",
              @"PCTYPE":@"",
              @"PLANNUM":@"",
              @"UDFAILURECODE":SettingContent(_LLI_15),
              @"PRONAME":SettingContent(_LL_3),
              @"SCHEDFINISH":SettingContent(_LLI_21),
              @"SCHEDSTART":SettingContent(_LLI_20),
              @"UDFJAPPNUM":@"",
              @"UDFJFOL":@"",
              @"UDINSPOBY":SettingContent(_LLI_11),
              @"UDINSPOBY2":SettingContent(_LLI_12),
              @"UDINSPOBY3":SettingContent(_LLI_13),
              @"UDJGRESULT":@"",
              @"UDJGTYPE":@"",
              @"UDJPNUM":@"",
              @"UDLOCATION":SettingContent(_LLI_5),
              @"UDLOCNUM":SettingContent(_LLI_4),
              @"UDPLANNUM":SettingContent(_LLI_6),
              @"UDPLSTARTDATE":@"",
              @"UDPLSTOPDATE":@"",
              @"UDPROBDESC":SettingContent(_LT_28),
              @"UDPROJECTNUM":SettingContent(_LLI_2),
              @"UDREMARK":SettingContent(_LT_27I),
              @"UDRESTARTTIME":@"",
              @"UDRLSTARTDATE":@"",
              @"UDRLSTOPDATE":@"",
              @"UDRPRRSB":_choosemodel5.PERSONID.length?_choosemodel5.PERSONID:@"",
              @"UDRPRRSBNAME":SettingContent(_LLI_18),
              @"UDSTATUS":@"新建",
              @"UDSTOPTIME":SettingContent(_LLI_25),
              @"UDZGLIMIT":SettingContent(_LLI_19),
              @"UDZGMEASURE":@"",
              @"WONUM":@"",
              @"WORKTYPE":@"FR",
              @"WTCODE":@"",
              @"ISBIGPAR":@"0",
              @"ISSTOPED":SettingContent(_LC_24),
              @"PERINSPR":@"0",
              @"relationShip":arrays,
              };
    NSMutableDictionary *dics1 = [NSMutableDictionary dictionary];
    [dics1 addEntriesFromDictionary:dic1];
    if (arrayst.count) {
        [dics1 setObject:arrayst forKey:@"WOACTIVITY"];
    }else if (materielArray.count){
        [dics1 setObject:materielArray forKey:@"WPMATERIAL"];
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
//拼接body字典
-(NSString *)getBodyWithDics:(NSDictionary *)dic
{
    NSString * bodyStr = @"";
    
    for (int i = 0 ; i<[dic count]; i++)
    {
        NSString * key = [dic.allKeys objectAtIndex:i];
        NSString * value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            if (i==0)
            {
                bodyStr = [NSString stringWithFormat:@"\"%@\":\"%@\"",key,value];
            }
            else
            {
                bodyStr = [NSString stringWithFormat:@"%@,\"%@\":\"%@\"",bodyStr,key,value];
            }
        }else if ([value isKindOfClass:[NSNumber class]]) {
            if (i==0)
            {
                bodyStr = [NSString stringWithFormat:@"\"%@\":%@",key,value];
            }
            else
            {
                bodyStr = [NSString stringWithFormat:@"%@,\"%@\":%@",bodyStr,key,value];
            }
            
        }else {
            if (i==0)
            {
                bodyStr = [NSString stringWithFormat:@"\"%@\":\"%@\"",key,value];
            }
            else
            {
                bodyStr = [NSString stringWithFormat:@"%@,\"%@\":\"%@\"",bodyStr,key,value];
            }
        }
    }
    bodyStr = [NSString stringWithFormat:@"{%@}",bodyStr];
    return bodyStr;
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
    AccountModel *model = [AccountManager account];
    WEAKSELF
    self.LL_1 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    
    self.LLI_2 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    _LLI_2.operation = ^{
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            weakSelf.LL1Model = model;
            weakSelf.LL_1.content = model.BRANCH;
            weakSelf.LLI_2.content = model.PRONUM;
            weakSelf.LL_3.content = model.DESCRIPTION;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    
    self.LL_3 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    
    self.LLI_4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    _LLI_4.operation = ^{
        if (weakSelf.LLI_2.content.length == 0) {
            WHUDNormal(@"请选择项目编号");
            return ;
        }
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
            weakSelf.LLI_4.content = model.LOCNUM;
            [weakSelf.tableView reloadData];
        };
        choose.requestCoding = weakSelf.LLI_2.content;
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    
    self.LLI_5 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"设备位置:" type:PersonalSettingItemTypeArrow];
    _LLI_5.operation = ^{
        
        if(weakSelf.LLI_2.content.length == 0){
            WHUDNormal(@"请选择项目编号");
            return ;
        }else if (weakSelf.LLI_4.content.length == 0){
            WHUDNormal(@"请选择机位号");
            return ;
        }
        EquipmentLocationController *equipment = [[EquipmentLocationController alloc]init];
        equipment.executeCellClick = ^(EquipmentLocationModel *model){
            weakSelf.LLI_5.content = model.LOCATION;
            [weakSelf.tableView reloadData];
        };
        equipment.requestCoding1 = weakSelf.LLI_2.content;
        equipment.requestCoding2 = weakSelf.LLI_4.content;
        [weakSelf.navigationController pushViewController:equipment animated:YES];
    };
    
    self.LLI_6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"终验收计划号:" type:PersonalSettingItemTypeArrow];
    _LLI_6.operation = ^{
        FinalNumViewController *choose = [[FinalNumViewController alloc]init];
        choose.executeCellClick = ^(FinalModels *model){
            weakSelf.LLI_6.content = model.PLANNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };

    self.LL_7 = [PersonalSettingItem itemWithIcon:nil withContent:@"新建" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    
    
    self.LL_8 = [PersonalSettingItem itemWithIcon:nil withContent:model.displayName withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    
    self.LL_9 = [PersonalSettingItem itemWithIcon:nil withContent:kGetCurrentTime(@"yyyy-MM-dd HH:mm:ss") withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL_1,_LLI_2,_LL_3,_LLI_4,_LLI_5,_LLI_6,_LL_7,_LL_8,_LL_9];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI_10 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"维护/运行组长:" type:PersonalSettingItemTypeArrow];
    _LLI_10.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choosemodel1 = model;
            weakSelf.LLI_10.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI_11 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    _LLI_11.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choosemodel2 = model;
            weakSelf.LLI_11.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI_12 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    _LLI_12.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choosemodel3 = model;
            weakSelf.LLI_12.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LLI_13 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    _LLI_13.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choosemodel4 = model;
            weakSelf.LLI_13.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI_10,_LLI_11,_LLI_12,_LLI_13];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI_14 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"故障类:" type:PersonalSettingItemTypeArrow];
    _LLI_14.operation = ^{
        FaultClassController *fault = [[FaultClassController alloc]init];
        fault.isShow = YES;
        fault.executeCellClick = ^(FaultClassModel *model){
            weakSelf.faultmodel = model;
            weakSelf.LLI_14.content = model.CODEDESC;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:fault animated:YES];
    };
    
    self.LLI_15 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"故障问题:" type:PersonalSettingItemTypeArrow];
    
    _LLI_15.operation = ^{
        if (weakSelf.LLI_14.content.length ==0) {
            WHUDNormal(@"请选择故障类");
            return ;
        }
        FaultCodeController *fault = [[FaultCodeController alloc]init];
        fault.executeCellClick = ^(FaultCodeModel *model){
            weakSelf.faultmodel1 = model;
            weakSelf.LLI_15.content = model.FAILURECODE;
            weakSelf.LL_15_1.content = model.CODEDESC;
            [weakSelf.tableView reloadData];
        };
        fault.requestCoding = weakSelf.faultmodel.FAILURELIST;
        [weakSelf.navigationController pushViewController:fault animated:YES];
    };
    self.LL_15_1 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障类型描述:" type:PersonalSettingItemTypeLabels];
    
    self.LL_16 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障等级:" type:PersonalSettingItemTypeLabels];
    
    self.LL_17 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障类型:" type:PersonalSettingItemTypeLabels];
    
    self.LLI_18 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"提报人:" type:PersonalSettingItemTypeArrow];
    _LLI_18.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choosemodel5 = model;
            weakSelf.LLI_18.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LLI_19 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"提报时间:" type:PersonalSettingItemTypeArrow];
    _LLI_19.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LLI_20 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"计划开始时间:" type:PersonalSettingItemTypeArrow];
    _LLI_20.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    self.LLI_21 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"计划完成时间:" type:PersonalSettingItemTypeArrow];
    _LLI_21.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear3];
    };
    
    self.LLI_22 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    
    self.LLI_23 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"实际结束时间:" type:PersonalSettingItemTypeArrow];
    
    self.LC_24 = [PersonalSettingItem itemWithIcon:nil withContent:@"0" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否停机:" type:PersonalSettingItemTypeChoice];
    
    self.LLI_25 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"故障开始时间:" type:PersonalSettingItemTypeArrow];
    _LLI_25.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear4];
    };
    
    self.LLI_26 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障恢复时间:" type:PersonalSettingItemTypeArrow];
    
    self.LL_27 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"累计停机时间:" type:PersonalSettingItemTypeLabels];
    
    self.LT_27I = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"没有编码的物料:" type:PersonalSettingItemTypeText];
    
    self.LT_28 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障隐患描述:" type:PersonalSettingItemTypeText];
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI_14,_LLI_15,_LL_15_1,_LL_16,_LL_17,_LLI_18,_LLI_19,_LLI_20,_LLI_21,_LLI_22,_LLI_23,_LC_24,_LLI_25,_LLI_26,_LL_27,_LT_27I,_LT_28,];
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
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.LLI_19.content = [weakSelf.timeYear1 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear1;
}

- (TXTimeChoose *)timeYear2{
    WEAKSELF
    if (!_timeYear2) {
        self.timeYear2 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear2.backString = ^(NSDate *data){
            weakSelf.LLI_20.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}

- (TXTimeChoose *)timeYear3{
    WEAKSELF
    if (!_timeYear3) {
        self.timeYear3 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear3.backString = ^(NSDate *data){
            weakSelf.LLI_21.content = [weakSelf.timeYear3 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear3;
}
- (TXTimeChoose *)timeYear4{
    WEAKSELF
    if (!_timeYear4) {
        self.timeYear4 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear4.backString = ^(NSDate *data){
            weakSelf.LLI_25.content = [weakSelf.timeYear4 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear4;
}


@end
