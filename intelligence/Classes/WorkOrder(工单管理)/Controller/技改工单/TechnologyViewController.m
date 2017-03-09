//
//  TechnologyViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "TechnologyViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"
#import "DailyDetailChoosePersonController.h"
#import "ApprovalsView.h"
#import "WorkPlanViewController.h"
#import "FlightNumberViewController.h"
#import "ChooseItemNoController.h"
#import "ChoiceWorkView.h"
@interface TechnologyViewController ()<UIAlertViewDelegate>
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
/** 技改负责人*/
@property (nonatomic,strong)PersonalSettingItem *LLI6;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL7;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL8;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL9;
/** ------第二部分----*/
/** 排查标准*/
@property (nonatomic,strong)PersonalSettingItem *LL10;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI11;
/** 计划完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI12;
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI13;
/** 实际完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI14;
/** ------第三部分----*/
/** 风机型号*/
@property (nonatomic,strong)PersonalSettingItem *LLI15;
/** 设备类型*/
@property (nonatomic,strong)PersonalSettingItem *LLI16;
/** 技改结果*/
@property (nonatomic,strong)PersonalSettingItem *LC17;
/** 风机台数*/
@property (nonatomic,strong)PersonalSettingItem *LT18;
/** 实际完成台数*/
@property (nonatomic,strong)PersonalSettingItem *LT19;
/** 风机跟踪*/
@property (nonatomic,strong)PersonalSettingItem *LT20;
/** 技改原因*/
@property (nonatomic,strong)PersonalSettingItem *LT21;
/** 技改计划编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI22;
/** 技改类型*/
@property (nonatomic,strong)PersonalSettingItem *LLI23;
/** 主控程序版本号*/
@property (nonatomic,strong)PersonalSettingItem *LT24;
/** 字典*/
@property (nonatomic,strong)NSMutableDictionary *dics;
/** 技改负责人*/
@property (nonatomic,strong)ChoosePersonModel *choose1;
@property (nonatomic,strong)NSMutableArray *workArray;
@property (nonatomic,strong) NSMutableArray *updataworkArray;
@property (nonatomic,assign) BOOL isworkDele;
@property (nonatomic,assign)BOOL isEditor;
@property (nonatomic,assign)BOOL isEditors;
//时间
@property (nonatomic,strong)TXTimeChoose *timeYear1;
//时间
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@end

@implementation TechnologyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"技改工单详情";
    if ([_stock.UDSTATUS isEqualToString:@"新建"]||[_stock.UDSTATUS isEqualToString:@"进行中"]) {
        _isEditor = YES;
        _isEditors= YES;
    }else{
        _isEditor = NO;
        _isEditors= NO;
    }
    self.updataworkArray = [NSMutableArray array];
    _workArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDJGWO" objectName:@"WORKORDER" status:self.stock.UDSTATUS compeletion:^(NSArray *fields) {
        NSLog(@"技改工单必填字段 %@",fields);
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
                if (isOK) {
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
    popupView.processname = @"UDJGWO";
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
        HUDNormal(@"请选择终验收负责人");
        return;
    }else if ([SettingContent(_LLI15) isEqualToString:@""]){
        HUDNormal(@"请选择风机型号");
        return;
    }
//    else if ([SettingContent(_LLI16) isEqualToString:@""]){
//        HUDNormal(@"请选择设备类型");
//        return;
//    }
    else if ([SettingContent(_LT18) isEqualToString:@""]){
        HUDNormal(@"请选择风机台数");
        return;
    }else if ([SettingContent(_LT21) isEqualToString:@""]){
        HUDNormal(@"请选择技改原因");
        return;
    }else if ([SettingContent(_LLI23) isEqualToString:@""]){
        HUDNormal(@"请选择技改类型");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.blackBlock) {
                self.blackBlock(@"修改工单成功");
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            HUDNormal(@"errorMsg");
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
    AccountModel *model = [AccountManager account];
    NSMutableDictionary *dicy = [NSMutableDictionary dictionary];
    if (arrayst.count) {
        [dicy setObject:@"" forKey:@"WOACTIVITY"];
    }
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
                            @"ACTFINISH":@"",
                            @"ACTSTART":@"",
                            @"ASSETTYPE":@"",
                            @"BRANCH":SettingContent(_LL3),
                            @"CREATEBY":_stock.CREATEBY,
                            @"CREATEDATE":SettingContent(_LL9),
                            @"CREATENAME":SettingContent(_LL8),
                            @"DESCRIPTION":SettingContent(_LT2),
                            @"DJPLANNUM":@"",
                            @"DJTYPE":@"",
                            @"JGPLANNUM":@"",
                            @"LEAD":_stock.LEAD,
                            @"LEADNAME":SettingContent(_LLI6),
                            @"LOCDESC":@"",
                            @"PCCOMPNUM":_stock.PCCOMPNUM,
                            @"PCRESON":SettingContent(_LT21),
                            @"PCTYPE":@"",
                            @"PLANNUM":@"",
                            @"PRONAME":@"",
                            @"SCHEDFINISH":@"",
                            @"SCHEDSTART":@"",
                            @"UDFJAPPNUM":SettingContent(_LT24),
//                            @"UDFJFOL":SettingContent(_LT20),
                            @"UDJGRESULT":@"",
                            @"UDJGTYPE":SettingContent(_LLI23),
                            @"UDJPNUM":SettingContent(_LL10),
                            @"UDLOCATION":@"",
                            @"UDLOCNUM":@"",
                            @"UDPLANNUM":@"",
                            @"UDPLSTARTDATE":SettingContent(_LLI11),
                            @"UDPLSTOPDATE":SettingContent(_LLI12),
                            @"UDPROBDESC":@"",
                            @"UDPROJECTNUM":SettingContent(_LLI4),
                            @"UDREMARK":@"",
                            @"UDREPORTNUM":@"",
                            @"UDRESTARTTIME":@"",
                            @"UDRLSTARTDATE":@"",
                            @"UDRLSTOPDATE":@"",
                            @"UDRPRRSB":@"",
                            @"UDSTATUS":SettingContent(_LL7),
                            @"UDSTOPTIME":@"",
                            @"UDZGLIMIT":@"",
                            @"UDZGMEASURE":@"",
                            @"WONUM":SettingContent(_LL1),
                            @"WORKTYPE":@"TP",
                            @"WTCODE":SettingContent(_LLI15),
                            @"ISBIGPAR":@"0",
                            @"ISSTOPED":@"0",
                            @"PERINSPR":SettingContent(_LC17),
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
    self.LL1.FieldName=@"";
    
    CGSize textMaxSize = CGSizeMake(ScreenWidth-130, MAXFLOAT);
    CGSize textSize = [_stock.DESCRIPTION sizeWithFont:font(16) maxSize:textMaxSize];
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:textSize.height > CELLHEIGHT?textSize.height+6:CELLHEIGHT withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    self.LT2.FieldName=@"";
    
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRANCH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    self.LL3.FieldName=@"";
    
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPROJECTNUM withHeight:CELLHEIGHT  withClick:_isEditor withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    self.LLI4.FieldName=@"";
    
    
    if (_isEditors) {
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
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];
    self.LL5.FieldName=@"";
    
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.LEADNAME withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"技改执行人:" type:PersonalSettingItemTypeArrow];
    self.LLI6.FieldName=@"";
    
    if (_isEditors) {
        _LLI6.operation = ^{
            if(weakSelf.isEditor){
                DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
                daily.exetuceClickCell = ^(ChoosePersonModel *model){
                    weakSelf.choose1 = model;
                    weakSelf.LLI6.content = model.DISPLAYNAME;
                    [weakSelf.tableView reloadData];
                };
                [weakSelf.navigationController pushViewController:daily animated:YES];
            }
        };
    }
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDSTATUS withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    self.LL7.FieldName=@"";
    
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    self.LL8.FieldName=@"";
    
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    self.LL9.FieldName=@"";
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LL3,_LLI4,_LL5,_LLI6,_LL7,_LL8,_LL9,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDJPNUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"技改标准:" type:PersonalSettingItemTypeLabels];
    self.LL10.FieldName=@"";
    
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDPLSTARTDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI11.FieldName=@"";
    
    if (_isEditors) {
        _LLI11.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear1];
        };
    }
    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDPLSTOPDATE withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"计划完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI12.FieldName=@"";
    
    
    if (_isEditors) {
        _LLI12.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear2];
        };
    }
    
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI13.FieldName=@"";
    
    
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI14.FieldName=@"";
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL10,_LLI11,_LLI12,_LLI13,_LLI14,];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI15 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.WTCODE withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"风机型号:" type:PersonalSettingItemTypeArrow];
    self.LLI15.FieldName=@"";
    
    _LLI15.operation = ^{
        if(weakSelf.isEditors){
            if (_LLI4.content.length == 0 ) {
                WHUDNormal(@"请选择项目编号");
                return ;
            }
            FlightNumberViewController *fan = [[FlightNumberViewController alloc]init];
            fan.requestCoding = SettingContent(weakSelf.LLI4);
            fan.executeCellClick = ^(FlightNoModel *mode){
                weakSelf.LLI15.content = mode.MODELTYPE;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:fan animated:YES];
        }
    };

    
    self.LLI16 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:_isEditor withStar:YES title:@"设备类别:" type:PersonalSettingItemTypeArrow];
    self.LLI16.FieldName=@"";
    
    
    self.LC17 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PERINSPR withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"已完成:" type:PersonalSettingItemTypeChoice];
    self.LC17.FieldName=@"";
    
    
    self.LT18 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PCCOMPNUM withHeight:CELLHEIGHT  withClick:_isEditor withStar:YES title:@"机台号:" type:PersonalSettingItemTypeText];
    self.LT18.FieldName=@"";
    
    
    self.LT19 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"实际完成台数:" type:PersonalSettingItemTypeText];
    self.LT19.FieldName=@"";
    
    
    self.LT20 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDFJFOL withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"风机跟踪:" type:PersonalSettingItemTypeText];
    self.LT20.FieldName=@"";
    
    self.LT21 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PCRESON withHeight:CELLHEIGHT  withClick:_isEditor withStar:YES title:@"技改原因:" type:PersonalSettingItemTypeText];
    self.LT21.FieldName=@"";
    
    
    self.LLI22 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.JGPLANNUM withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"技改计划编号:" type:PersonalSettingItemTypeArrow];
    self.LLI22.FieldName=@"";
    
    self.LLI23 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDJGTYPE withHeight:CELLHEIGHT  withClick:_isEditor withStar:YES title:@"技改类型:" type:PersonalSettingItemTypeArrow];
    self.LLI23.FieldName=@"";
    
    _LLI23.operation = ^{
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeJiGai];
        work.WorkBlock = ^(NSString *str){
            weakSelf.LLI22.content = str;
            [weakSelf.tableView reloadData];
        };
        [work ShowInView:weakSelf.view];
    };
    
    self.LT24 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDFJAPPNUM withHeight:CELLHEIGHT  withClick:_isEditor withStar:NO title:@"主控程序版本:" type:PersonalSettingItemTypeText];
    self.LT24.FieldName=@"";
    
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI15,_LC17,_LT18,_LT19,_LT21,_LLI22,_LLI23,_LT24,];

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
