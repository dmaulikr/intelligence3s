//
//  CheckWorkViewController.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "CheckWorkViewController.h"
#import "DTKDropdownMenuView.h"
#import "ChooseItemNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "SoapUtil.h"
#import "FooterView.h"
#import "FlightNoController.h"
#import "ApprovalsView.h"
#import "WorkPlanViewController.h"
#import "UploadPicturesViewController.h"
#import "FinalNumViewController.h"
@interface CheckWorkViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 工单号*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 描述*/
@property (nonatomic,strong)PersonalSettingItem *LL2;
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI4;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem *LL5;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI6;
/** 终验收负责人*/
@property (nonatomic,strong)PersonalSettingItem *LLI7;
/** 终验收计划号*/
@property (nonatomic,strong)PersonalSettingItem *LLI8;
/** 项目负责人*/
@property (nonatomic,strong)PersonalSettingItem *LLI9;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL10;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL11;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL12;
/** ------第二部分----*/
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI13;
/** 实际完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI14;
/** 编辑*/
@property (nonatomic, assign)BOOL isEdit;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear1;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong)ChoosePersonModel*choose1;
@property (nonatomic,strong)ChoosePersonModel*choose2;
@property (nonatomic,strong)NSMutableArray *workArray;
@property (nonatomic,assign) BOOL isworkDele;
@property (nonatomic,strong) NSMutableArray *updataworkArray;
@end

@implementation CheckWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"终验收工单详情";
    self.SetingItems = [NSMutableDictionary dictionary];
    if ([_stock.UDSTATUS isEqualToString:@"新建"]) {
        _isEdit = YES;
    }else{
        _isEdit = NO;
    }
    self.updataworkArray = [NSMutableArray array];
    _workArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
    
    
    [self checkWFPRequiredWithAppId:@"UDZYSWO" objectName:@"WORKORDER" status:self.stock.UDSTATUS compeletion:^(NSArray *fields) {
        NSLog(@"终验收工单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"WORKORDER",@"ACTIONNAME":@"查看终验收工单"}];
}
-(void)viewDidAppear:(BOOL)animated
{
     NSLog(@"%f",self.tableView.frame.origin.x);
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
        HUDNormal(@"请选择终验收负责人");
        return;
    }else if ([SettingContent(_LLI9) isEqualToString:@""]){
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
            if (self.blackBlock) {
                self.blackBlock(@"终验收工单修改成功");
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            HUDJuHua(dic[@"errorMsg"]);
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
                           @"ACTFINISH":SettingContent(_LLI14),
                           @"ACTSTART":SettingContent(_LLI13),
                           @"ASSETTYPE":@"",
                           @"BRANCH":SettingContent(_LL1),
                           @"CREATEBY":model.personId,
                           @"CREATEDATE":SettingContent(_LL12),
                           @"CREATENAME":SettingContent(_LL11),
                           @"DESCRIPTION":[NSString stringWithFormat:@"%@%@%@%@号风机验收工单",SettingContent(_LL12),SettingContent(_LL11),SettingContent(_LL5),SettingContent(_LLI6)],
                           @"DJPLANNUM":@"",
                           @"DJTYPE":@"",
                           @"JGPLANNUM":@"",
                           @"LEAD":_choose1.PERSONID.length?_choose1.PERSONID:@"",
                           @"LEADNAME":SettingContent(_LLI7),
                           @"LOCDESC":@"",
                           @"PCCOMPNUM":@"",
                           @"PCRESON":@"",
                           @"PCTYPE":@"",
                           @"PLANNUM":@"",
                           @"PRONAME":@"",
                           @"SCHEDFINISH":@"",
                           @"SCHEDSTART":@"",
                           @"UDFJAPPNUM":@"",
                           @"UDFJFOL":@"",
                           @"UDJGRESULT":@"",
                           @"UDJGTYPE":@"",
                           @"UDJPNUM":@"",
                           @"UDLOCATION":@"",
                           @"UDLOCNUM":SettingContent(_LLI6),
                           @"UDPLANNUM":SettingContent(_LLI8),
                           @"UDPLSTARTDATE":@"",
                           @"UDPLSTOPDATE":@"",
                           @"UDPROBDESC":@"",
                           @"UDPROJECTNUM":SettingContent(_LLI4),
                           @"UDPRORES":SettingContent(_LLI9),
                           @"UDPRORESNAME":SettingContent(_LLI9),
                           @"UDREMARK":@"",
                           @"UDREPORTNUM":@"",
                           @"UDRESTARTTIME":@"",
                           @"UDRLSTARTDATE":@"",
                           @"UDRLSTOPDATE":@"",
                           @"UDSTATUS":SettingContent(_LL10),
                           @"UDSTOPTIME":@"",
                           @"UDZGLIMIT":@"",
                           @"UDZGMEASURE":@"",
                           @"WONUM":SettingContent(_LL1),
//                           @"UDSTARTTIM":SettingContent(_LL1),
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

- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作详情" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_gzgl" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工作流任务分配" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=_stock.WORKORDERID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2,item3] icon:@"more"];
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
    popupView.processname = @"UDZYSWO";
    popupView.mbo = @"WORKORDER";
    popupView.keyValue = _stock.WONUM;
    popupView.key = @"WONUM";
    popupView.CloseBlick = ^(NSDictionary *dic){
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDNormal(str1);
        }
    };
    [popupView show];
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
            work.types = WorkTypeCheck;
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
           
            [self checkRequiredFieldcompeletion:^(BOOL isOk) {
                if (isOk) {
                    [weakSelf sendData];
                }
            }];
            
        }break;
        case 2:{
            //图片上传
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = _objectname;
            vc.ownerid = _stock.WORKORDERID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

-(void)setStock:(FauWorkModel *)stock{
    _stock = stock;
}
//第一部分
-(void)addOne{
    WEAKSELF
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.WONUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"工单号:" type:PersonalSettingItemTypeLabels];
    self.LL1.FieldName=@"WONUM";
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    self.LL2.FieldName=@"DESCRIPTION";
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRANCH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    self.LL3.FieldName=@"BRANCH";
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPROJECTNUM withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    self.LLI4.FieldName=@"UDPROJECTNUM";
    
    
    if (_isEdit) {
        _LLI4.operation = ^{
            ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
            choose.executeClickCell = ^(ChooseItemNoModel *model){
                weakSelf.LLI4.content = model.PRONUM;
                weakSelf.LL5.content = model.DESCRIPTION;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:choose animated:YES];
        };
    }
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRONAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    self.LL5.FieldName=@"PRONAME";
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDLOCNUM withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    self.LLI6.FieldName=@"UDLOCNUM";
    
    
    if (_isEdit) {
        _LLI6.operation = ^{
            FlightNoController *choose = [[FlightNoController alloc]init];
            choose.executeCellClick = ^(FlightNoModel *model){
                weakSelf.LLI6.content = model.LOCNUM;
                [weakSelf.tableView reloadData];
            };
            choose.requestCoding = weakSelf.LLI4.content;
            [weakSelf.navigationController pushViewController:choose animated:YES];        };
    }
    
    self.LLI7 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.LEADNAME withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"终验收负责人:" type:PersonalSettingItemTypeArrow];
    self.LLI7.FieldName=@"LEADNAME";
    
    if(_isEdit){
        _LLI7.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose1 = model;
                weakSelf.LLI7.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LLI8 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPLANNUM withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"终验收计划号:" type:PersonalSettingItemTypeArrow];
    self.LLI8.FieldName=@"UDPLANNUM";
    
    
    _LLI8.operation = ^{
        FinalNumViewController *final = [[FinalNumViewController alloc]init];
        final.executeCellClick = ^(FinalModels *model){
            weakSelf.LLI8.content = model.PLANNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:final animated:YES];
    };

    self.LLI9 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.LEADNAME withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"项目负责人:" type:PersonalSettingItemTypeArrow];
    self.LLI9.FieldName=@"LEADNAME";
    
    
    if(_isEdit){
        _LLI9.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose2 = model;
                weakSelf.LLI9.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDSTATUS withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    self.LL10.FieldName=@"UDSTATUS";
    
    
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    self.LL11.FieldName=@"CREATENAME";
    
    self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    self.LL12.FieldName=@"CREATEDATE";
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LL2,_LL3,_LLI4,_LL5,_LLI6,_LLI7,_LLI8,_LLI9,_LL10,_LL11,_LL12];
    [_allGroups addObject:group];
}

//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.ACTSTART withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI13.FieldName=@"ACTSTART";
    
    if (_isEdit) {
        _LLI13.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear1];
        };
    }
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.ACTFINISH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI14.FieldName=@"ACTFINISH";
    
    if (_isEdit) {
        _LLI14.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear2];
        };
    }
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI13,_LLI14];
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
            weakSelf.LLI13.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LLI14.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
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
                
            }];
            [alert addAction:cancel];
            [alert addAction:comfirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            compeletion(YES);
        }
    }
    
    
}

@end
