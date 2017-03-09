//
//  CheckWorksViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "CheckWorksViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"
#import "ChooseItemNoController.h"
#import "FlightNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "CheckNumViewController.h"
#import "ChoiceWorkView.h"
#import "ApprovalsView.h"
#import "WorkPlanViewController.h"
#import "FanNumViewController.h"
#import "FanTypeViewController.h"
#import "FlightNumberViewController.h"
#import "RegularViewController.h"
@interface CheckWorksViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 工单号*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 描述*/
@property (nonatomic,strong)PersonalSettingItem *LT2;
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI4;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem *LL5;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI6;
/** 定检组长*/
@property (nonatomic,strong)PersonalSettingItem *LLI7;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL8;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL9;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL10;
/** ------第二部分----*/
/** 定检标准编号*/
@property (nonatomic,strong)PersonalSettingItem *LL11;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI12;
/** 计划完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI13;
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI14;
/** 实际完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI15;
/** ------第三部分----*/
/** 定检人员1*/
@property (nonatomic,strong)PersonalSettingItem *LLI16;
/** 定检人员2*/
@property (nonatomic,strong)PersonalSettingItem *LLI17;
/** 定检人员3*/
@property (nonatomic,strong)PersonalSettingItem *LLI18;
/** 定检计划编号*/
@property (nonatomic,strong)PersonalSettingItem *LL19;
/** 定检类型*/
@property (nonatomic,strong)PersonalSettingItem *LLI20;
/** 计划定检风机台数*/
@property (nonatomic,strong)PersonalSettingItem *LT21;
/** ------第四部分----*/
/** 风机型号*/
@property (nonatomic,strong)PersonalSettingItem *LLI22;
/** 定检结果*/
@property (nonatomic,strong)PersonalSettingItem *LC23;
/** 备注*/
@property (nonatomic,strong)PersonalSettingItem *LT24;
/** 大部件发送*/
@property (nonatomic,strong)PersonalSettingItem *LC25;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong)ChooseItemNoModel *choose1;
@property (nonatomic,strong)ChoosePersonModel *choose2;
@property (nonatomic,strong)ChoosePersonModel *choose3;
@property (nonatomic,strong)ChoosePersonModel *choose4;
@property (nonatomic,strong)ChoosePersonModel *choose5;

@property (nonatomic,strong)TXTimeChoose *timeYear1;
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)TXTimeChoose *timeYear3;
@property (nonatomic,strong)TXTimeChoose *timeYear4;
@property (nonatomic,assign)BOOL isEditor;
@property (nonatomic,assign)BOOL isEditors;
@property (nonatomic,strong)NSMutableArray *workArray;
@property (nonatomic,assign) BOOL isworkDele;
@property (nonatomic,strong) NSMutableArray *updataworkArray;
@end

@implementation CheckWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定检工单详情";
    if ([_stock.UDSTATUS isEqualToString:@"新建"]) {
        _isEditor = YES;
    }else{
        _isEditor = NO;
    }
    if ([_stock.UDSTATUS isEqualToString:@"进行中"]) {
        _isEditors = YES;
    }else{
        _isEditors = NO;
    }
    self.updataworkArray = [NSMutableArray array];
    _workArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
    [self addFour];
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDDJWO" objectName:@"WORKORDER" status:self.stock.UDSTATUS compeletion:^(NSArray *fields) {
        NSLog(@"定检工单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
}

- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工单详情" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
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
            work.parent = SettingContent(_LL1);
            work.executeCellClick = ^(NSArray *array){
                [weakSelf.workArray removeAllObjects];
                [weakSelf.workArray addObjectsFromArray:array];
            };
            work.updataCellClick = ^(NSArray *array,BOOL dele){
                [weakSelf.updataworkArray removeAllObjects];
                [weakSelf.updataworkArray addObjectsFromArray:array];
                weakSelf.isworkDele = dele;
            };
            work.dele = _isworkDele;
            work.array = self.workArray;
            work.deleArray = self.updataworkArray;
            [weakSelf.navigationController pushViewController:work animated:YES];
        }break;
        case 1:{
            //发送工作流
            [self checkRequiredFieldcompeletion:^(BOOL isOK) {
                if(isOK)
                {
                    [self sendData];
                }
            }];
        }break;
        case 2:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = _objectname;
            vc.ownerid = _stock.WORKORDERID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

//发送工作流
-(void)sendData{
    if ([_stock.UDSTATUS isEqualToString:@"已取消"]||[_stock.UDSTATUS isEqualToString:@"已关闭"]||[_stock.UDSTATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_stock.STATUS];
        HUDJuHua(str);
        return;
    }

    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_stock.UDSTATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDDJWO";
    popupView.mbo = @"WORKORDER";
    popupView.keyValue = _stock.WONUM;
    popupView.key = @"WONUM";
    popupView.CloseBlick = ^(NSDictionary *dic){
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDJuHua(dic[@"errorMsg"]);
        }
    };
    [popupView show];
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定修改工单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self saveClick];
    }
}
//保存
-(void)saveClick{
    
    if ([SettingContent(_LLI4) isEqualToString:@""]) {
        HUDNormal(@"请选择项目编号");
        return;
    }else if ([SettingContent(_LLI6) isEqualToString:@""]){
        HUDNormal(@"请选择机位号");
        return;
    }else if ([SettingContent(_LLI7) isEqualToString:@""]){
        HUDNormal(@"请选择定检组长");
        return;
    }else if ([SettingContent(_LLI22) isEqualToString:@""]){
        HUDNormal(@"请选择风机型号");
        return;
    }else if ([SettingContent(_LLI20) isEqualToString:@""]){
        HUDNormal(@"请选择定检类型");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    AccountModel *model = [AccountManager account];
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.blackBlock) {
                self.blackBlock(@"修改定检工单成功");
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSMutableArray *arrayst = [NSMutableArray array];
    for (NSDictionary *dic in self.updataworkArray) {
        WorksPlanModel *work = [WorksPlanModel mj_objectWithKeyValues:dic];
        if ([work.TYPE isEqualToString:@"add"]) {
            NSDictionary *dic = @{
                                  @"DESCRIPTION"  :work.DESCRIPTION,
                                  @"ESTDUR"       :work.ESTDUR,
                                  @"OWNER"        :work.OWNER,
                                  @"OWNERNAME"    :work.OWNERNAME,
                                  @"TASKID"       :work.TASKID,
                                  @"TYPE"         :@"add",
                                  };
            [arrayst addObject:dic];
        }else if ([work.TYPE isEqualToString:@"update"]){
            NSDictionary *dic = @{
                                  @"DESCRIPTION"  :work.DESCRIPTION,
                                  @"ESTDUR"       :work.ESTDUR,
                                  @"OWNER"        :work.OWNER,
                                  @"OWNERNAME"    :work.OWNERNAME,
                                  @"TASKID"       :work.TASKID,
                                  @"WORKORDERID"  :work.WORKORDERID,
                                  @"TYPE"         :@"update",
                                  };
            [arrayst addObject:dic];
        }else if ([work.TYPE isEqualToString:@"delete"]){
            NSDictionary *dic = @{
                                  @"DESCRIPTION"  :work.DESCRIPTION,
                                  @"ESTDUR"       :work.ESTDUR,
                                  @"OWNER"        :work.OWNER,
                                  @"OWNERNAME"    :work.OWNERNAME,
                                  @"TASKID"       :work.TASKID,
                                  @"WORKORDERID"  :work.WORKORDERID,
                                  @"TYPE"         :@"delete",
                                  };
            [arrayst addObject:dic];
        }
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
                           @"ASSETTYPE":@"",
                           @"BRANCH":SettingContent(_LL3),
                           @"CREATEBY":model.personId,
                           @"CREATEDATE":SettingContent(_LL10),
                           @"CREATENAME":SettingContent(_LL9),
                           @"DESCRIPTION":SettingContent(_LT2),
                           @"DJPLANNUM":@"",
                           @"DJTYPE":SettingContent(_LLI20),
                           @"JGPLANNUM":@"",
                           @"LEAD":_choose2.PERSONID.length?_choose2.PERSONID:@"",
                           @"LEADNAME":SettingContent(_LLI7),
                           @"LOCDESC":@"",
                           @"NAME1":SettingContent(_LLI16),
                           @"NAME2":SettingContent(_LLI17),
                           @"NAME3":SettingContent(_LLI18),
//                           @"PCCOMPNUM":SettingContent(_LT21),
                           @"PCRESON":@"",
                           @"PCTYPE":@"",
                           @"PLANNUM":@"",
                           @"PRONAME":SettingContent(_LL5),
                           @"SCHEDFINISH":@"",
                           @"SCHEDSTART":@"",
                           @"UDFJAPPNUM":@"",
                           @"UDFJFOL":@"",
                           @"UDINSPOBY":_choose3.PERSONID.length?_choose3.PERSONID:_stock.UDINSPOBY,
                           @"UDINSPOBY2":SettingContent(_LLI17),
                           @"UDINSPOBY3":_choose5.PERSONID.length?_choose5.PERSONID:_stock.UDINSPOBY3,
                           @"UDJGRESULT":@"",
                           @"UDJGTYPE":@"",
                           @"UDJPNUM":SettingContent(_LL11),
                           @"UDLOCATION":@"",
                           @"UDLOCNUM":SettingContent(_LLI6),
                           @"UDPLANNUM":@"",
                           @"UDPLSTARTDATE":SettingContent(_LLI12),
                           @"UDPLSTOPDATE":SettingContent(_LLI13),
                           @"UDPROBDESC":@"",
                           @"UDPROJECTNUM":SettingContent(_LLI4),
                           @"UDREMARK":SettingContent(_LT24),
                           @"UDREPORTNUM":@"",
                           @"UDRESTARTTIME":@"",
                           @"UDRLSTARTDATE":@"",
                           @"UDRLSTOPDATE":@"",
                           @"UDSTATUS":SettingContent(_LL8),
                           @"UDSTOPTIME":@"",
                           @"UDZGLIMIT":@"",
                           @"UDZGMEASURE":@"",
                           @"WONUM":SettingContent(_LL1),
                           @"WORKTYPE":@"WS",
                           @"WTCODE":SettingContent(_LLI22),
//                           @"ISBIGPAR":SettingContent(_LC25),
                           @"ISSTOPED":@"0",
//                           @"PERINSPR":SettingContent(_LC23),
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
                     @{@"mboObjectName":@"WORKORDER"},
                     @{@"mboKey":@"WONUM"},
                     @{@"mboKeyValue":SettingContent(_LL1)},
                     ];
    [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
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

-(void)setStock:(FauWorkModel *)stock{
    _stock = stock;
}
//第一部分
-(void)addOne{
    WEAKSELF
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.WONUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"工单号:" type:PersonalSettingItemTypeLabels];
    self.LL1.FieldName=@"WONUM";
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    self.LT2.FieldName=@"DESCRIPTION";
    
    self.LL19 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DJPLANNUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检计划编号:" type:PersonalSettingItemTypeArrow];
    self.LL19.FieldName=@"DJPLANNUM";
    
    _LL19.operation =^{
        RegularViewController *regular = [[RegularViewController alloc]init];
        regular.executeCellClick = ^(RegularModel *model){
            weakSelf.LL19.content = model.PLANNO;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:regular animated:YES];
    };

    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRANCH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    self.LL3.FieldName=@"BRANCH";
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPROJECTNUM withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    self.LLI4.FieldName=@"UDPROJECTNUM";
    
    _LLI4.operation = ^{
        if(weakSelf.isEditor){
            ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
            choose.executeClickCell = ^(ChooseItemNoModel *model){
                weakSelf.choose1 = model;
                weakSelf.LL3.content = model.BRANCH;
                weakSelf.LLI4.content = model.PRONUM;
                weakSelf.LL5.content = model.DESCRIPTION;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:choose animated:YES];
        }
    };
    
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRONAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    self.LL5.FieldName=@"PRONAME";
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDLOCNUM withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    self.LLI6.FieldName=@"UDLOCNUM";
    
    
    _LLI6.operation = ^{
        if(weakSelf.isEditor){
            FlightNoController *choose = [[FlightNoController alloc]init];
            choose.executeCellClick = ^(FlightNoModel *model){
                weakSelf.LLI4.content = model.LOCNUM;
                [weakSelf.tableView reloadData];
            };
            choose.requestCoding = weakSelf.LLI4.content;
            [weakSelf.navigationController pushViewController:choose animated:YES];
        }
    };

    
    self.LLI7 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.LEADNAME withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"定检组长:" type:PersonalSettingItemTypeArrow];
    self.LLI7.FieldName=@"LEADNAME";
    
    _LLI7.operation = ^{
        if(weakSelf.isEditor){
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose2 = model;
                weakSelf.LLI7.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        }
    };
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDSTATUS withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    self.LL8.FieldName=@"UDSTATUS";
    
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    self.LL9.FieldName=@"CREATENAME";
    
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    self.LL10.FieldName=@"CREATEDATE";
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LL19,_LL3,_LLI4,_LL5,_LLI6,_LLI7,_LL8,_LL9,_LL10,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDJPNUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检标准编号:" type:PersonalSettingItemTypeArrow];
    self.LL11.FieldName=@"UDJPNUM";
    
    _LL11.operation = ^{
        if(weakSelf.isEditor){
            CheckNumViewController *check = [[CheckNumViewController alloc]init];
            check.executeCellClick = ^(CheackNumModel *model){
                weakSelf.LL11.content = model.JPNUM;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:check animated:YES];
        }
    };
    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDPLSTARTDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI12.FieldName=@"UDPLSTARTDATE";
    
    _LLI12.operation = ^{
        if(weakSelf.isEditor){
            [weakSelf.view addSubview:weakSelf.timeYear1];
        }
    };
    
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDPLSTOPDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI13.FieldName=@"UDPLSTOPDATE";
    
    _LLI13.operation = ^{
        {
            [weakSelf.view addSubview:weakSelf.timeYear2];
        }
    };
    
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI14.FieldName=@"";
    
    _LLI14.operation = ^{
        if (weakSelf.isEditors) {
            [weakSelf.view addSubview:weakSelf.timeYear3];
        }
    };
    
    self.LLI15 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI15.FieldName=@"";
    
    _LLI15.operation = ^{
        if (weakSelf.isEditors) {
            [weakSelf.view addSubview:weakSelf.timeYear4];
        }
    };

    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL11,_LLI12,_LLI13,_LLI14,_LLI15,];
    [_allGroups addObject:group];
}

//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI16 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.NAME1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员1:" type:PersonalSettingItemTypeArrow];
    self.LLI16.FieldName=@"NAME1";
    
    _LLI16.operation = ^{
        if(weakSelf.isEditor){
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose3 = model;
                weakSelf.LLI16.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        }
    };
    
    self.LLI17 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.NAME2 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员2:" type:PersonalSettingItemTypeArrow];
    self.LLI17.FieldName=@"NAME2";
    
    
    _LLI17.operation = ^{
        if(weakSelf.isEditor){
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose4 = model;
                weakSelf.LLI17.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        }
    };
    
    self.LLI18 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.NAME3 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检人员3:" type:PersonalSettingItemTypeArrow];
    self.LLI18.FieldName=@"NAME3";
    
    
    _LLI18.operation = ^{
        if(weakSelf.isEditor){
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose5 = model;
                weakSelf.LLI18.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        }
    };
    
    
    self.LLI20 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.DJTYPE withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"定检类型:" type:PersonalSettingItemTypeArrow];
    self.LLI20.FieldName=@"DJTYPE";
    
    _LLI20.operation = ^{
        if(weakSelf.isEditor){
            ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeDiJian];
            work.WorkBlock = ^(NSString *str){
                weakSelf.LLI20.content = str;
                [weakSelf.tableView reloadData];
            };
            [work ShowInView:weakSelf.view];
        }
    };
    
    self.LT21 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PCCOMPNUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划定检风机台数:" type:PersonalSettingItemTypeText];
    self.LT21.FieldName=@"PCCOMPNUM";
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI16,_LLI17,_LLI18,_LLI20,];
    [_allGroups addObject:group];
}
//第四部分
-(void)addFour{
    WEAKSELF
    self.LLI22 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.WTCODE withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"风机型号:" type:PersonalSettingItemTypeArrow];
    self.LLI22.FieldName=@"WTCODE";
    
    _LLI22.operation = ^{
        if(weakSelf.isEditor){
            if (_LLI4.content.length == 0 ) {
                WHUDNormal(@"请选择项目编号");
                return ;
            }
            FlightNumberViewController *fan = [[FlightNumberViewController alloc]init];
            fan.requestCoding = SettingContent(weakSelf.LLI4);
            fan.executeCellClick = ^(FlightNoModel *mode){
                weakSelf.LLI22.content = mode.MODELTYPE;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:fan animated:YES];
        }
    };

    self.LC23 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PERINSPR withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"定检结果:" type:PersonalSettingItemTypeChoice];
    
    self.LC23.FieldName=@"PERINSPR";
    
    self.LT24 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDREMARK withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"备注:" type:PersonalSettingItemTypeLabels];
    self.LT24.FieldName=@"UDREMARK";
    
    self.LC25 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ISBIGPAR withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"大部件发放:" type:PersonalSettingItemTypeChoice];
    self.LC25.FieldName=@"ISBIGPAR";
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI22,_LT24,];
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
            weakSelf.LLI12.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LLI13.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}

- (TXTimeChoose *)timeYear3{
    WEAKSELF
    if (!_timeYear3) {
        self.timeYear3 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear3.backString = ^(NSDate *data){
            weakSelf.LLI14.content = [weakSelf.timeYear3 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear3;
}
- (TXTimeChoose *)timeYear4{
    WEAKSELF
    if (!_timeYear4) {
        self.timeYear4 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear4.backString = ^(NSDate *data){
            weakSelf.LLI15.content = [weakSelf.timeYear4 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear4;
}
-(void)checkRequiredFieldcompeletion:(void (^)(BOOL isOK))compeletion
{
    
    NSMutableArray *nullFields=[NSMutableArray array];
    
    if (self.RequiredFields.count<=0) {
        compeletion(YES);
    }
    else
    {
        for (NSString * str in self.RequiredFields) {
            
            PersonalSettingItem *item = [self.SetingItems objectForKey:str];
            if (item) {
                
                if (item.content.length<=0) {
                    [nullFields addObject:item.title];
                    
                }
            }
            
        }
        if (nullFields.count>0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:[NSString stringWithFormat:@"以下内容未填写<%@>,请填写并保存后进行其它操作",nullFields] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * comfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert addAction:cancel];
                [alert addAction:comfirm];
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            compeletion(YES);
        }
    }
    
    
}

@end
