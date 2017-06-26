//
//  FaultWorkViewController.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "FaultWorkViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "SoapUtil.h"
#import "ChooseItemNoController.h"
#import "EquipmentLocationController.h"
#import "DailyDetailChoosePersonController.h"
#import "FaultClassController.h"
#import "FaultCodeController.h"
#import "FlightNoController.h"
#import "WorkPlanViewController.h"
#import "MaterielsViewController.h"
#import "ApprovalsView.h"
#import "UploadPicturesViewController.h"
#import "CauseProblemViewController.h"
#import "FinalNumViewController.h"
#import "ApprovalsView.h"
#import "TextInputViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "WfmListanceListViewController.h"

@interface FaultWorkViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 工单号*/
@property (nonatomic,strong)PersonalSettingItem *LL_1;
/** 描述*/
@property (nonatomic,strong)PersonalSettingItem *LL_2;
/** 中心*/
@property (nonatomic,strong)PersonalSettingItem *LL_3;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_4;
//项目描述
@property (nonatomic,strong)PersonalSettingItem *LL_4I;
/** 机位号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_5;
/** 设备位置*/
@property (nonatomic,strong)PersonalSettingItem *LLI_6;
/** 位置描述*/
@property (nonatomic,strong)PersonalSettingItem *LLI_6I;
/** 终验收计划号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_7;
/** 故障提报单号*/
@property (nonatomic,strong)PersonalSettingItem *LLI_7I;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL_8;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL_9;
/** 创建时间*/
@property (nonatomic,strong)PersonalSettingItem *LL_10;
/** ------第二部分----*/
/** 维护/运行组长*/
@property (nonatomic,strong)PersonalSettingItem *LLI_11;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_12;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_13;
/** 维护/运行人员*/
@property (nonatomic,strong)PersonalSettingItem *LLI_14;
/** ------第二部分----*/
/** 故障类*/
@property (nonatomic,strong)PersonalSettingItem *LLI_15;
/** 故障问题*/
@property (nonatomic,strong)PersonalSettingItem *LLI_16;
/** 故障问题描述*/
@property (nonatomic,strong)PersonalSettingItem *LLI_16I;
/** 故障等级*/
@property (nonatomic,strong)PersonalSettingItem *LL_17;
/** 故障类型*/
@property (nonatomic,strong)PersonalSettingItem *LL_18;
/** 提报人*/
@property (nonatomic,strong)PersonalSettingItem *LLI_19;
/** 提报时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_20;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_21;
/** 计划完成时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_22;
/** 实际开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_23;
/** 实际结束时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_24;
/** 是否停机*/
@property (nonatomic,strong)PersonalSettingItem *LC_25;
/** 故障开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_26;
/** 故障恢复时间*/
@property (nonatomic,strong)PersonalSettingItem *LLI_27;
/** 累计停机时间*/
@property (nonatomic,strong)PersonalSettingItem *LL_28;
/** 没有编码的物料*/
@property (nonatomic,strong)PersonalSettingItem *LT_28I;
/** 故障隐患描述*/
@property (nonatomic,strong)PersonalSettingItem *LT_29;
/** 编辑*/
@property (nonatomic, assign)BOOL isEdit;
@property (nonatomic, assign)BOOL isEdits;
@property (nonatomic, assign)BOOL isShows;

@property (nonatomic,strong)FaultClassModel *faultmodel;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear1;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear2;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear3;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear4;
@property (nonatomic,strong)TXTimeChoose *timeYear5;
@property (nonatomic,strong)TXTimeChoose *timeYear6;
@property (nonatomic,strong)TXTimeChoose *timeYear7;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong) NSMutableArray *workArray;
@property (nonatomic,strong) NSMutableArray *materielsArray;
@property (nonatomic,strong) NSMutableArray *updataArray;
@property (nonatomic,strong) NSMutableArray *updataworkArray;

@property (nonatomic,assign) BOOL isdele;
@property (nonatomic,assign) BOOL isworkDele;
@property (nonatomic,strong) ChoosePersonModel *choose1;
@property (nonatomic,strong) ChoosePersonModel *choose2;
@property (nonatomic,strong) ChoosePersonModel *choose3;
@property (nonatomic,strong) ChoosePersonModel *choose4;
@end

@implementation FaultWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"故障工单详情";
    NSLog(@"%@",[self.stock mj_keyValues]);
    self.workArray = [NSMutableArray array];
    self.materielsArray = [NSMutableArray array];
    self.updataArray = [NSMutableArray array];
    self.updataworkArray = [NSMutableArray array];
    
    
    [self addRightNavBarItem];
    if ([_stock.UDSTATUS isEqualToString:@"新建"]) {
        _isEdit = YES;
        _isShows = NO;
    }else if ([_stock.UDSTATUS isEqualToString:@"待审批"]){
        _isShows = YES;
        _isEdit = NO;
    }else{
        _isEdit = NO;
        _isShows = NO;
    }
    
    if ([_stock.UDSTATUS isEqualToString:@"进行中"]) {
        _isEdits = YES;
    }else{
        _isEdits = NO;
    }
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
    
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDREPORTWO" objectName:@"WORKORDER" status:self.stock.UDSTATUS compeletion:^(NSArray *fields) {
        NSLog(@"故障工单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
        
    }];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"WORKORDER",@"ACTIONNAME":@"查看故障工单"}];
}
-(void)viewDidAppear:(BOOL)animated
{

}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClicks) forControlEvents:UIControlEventTouchUpInside];
    
    footer.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:footer];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(55);
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
    
    if ([SettingContent(_LLI_4) isEqualToString:@""]) {
        HUDNormal(@"请选择项目编号");
        return;
    }else if ([SettingContent(_LLI_5) isEqualToString:@""]){
        HUDNormal(@"请选择机位号");
        return;
    }else if ([SettingContent(_LLI_6) isEqualToString:@""]){
        HUDNormal(@"请选择设备位置");
        return;
    }else if ([SettingContent(_LLI_11) isEqualToString:@""]){
        HUDNormal(@"请选择维护/运行人员");
        return;
    }else if ([SettingContent(_LLI_12) isEqualToString:@""]){
        HUDNormal(@"请选择维护/运行人员");
        return;
    }else if ([SettingContent(_LLI_15) isEqualToString:@""]){
        HUDNormal(@"请选择故障类");
        return;
    }else if ([SettingContent(_LLI_16) isEqualToString:@""]){
        HUDNormal(@"请选择故障问题");
        return;
    }else if ([SettingContent(_LLI_19) isEqualToString:@""]){
        HUDNormal(@"请选择提报人");
        return;
    }else if ([SettingContent(_LLI_20) isEqualToString:@""]){
        HUDNormal(@"请选择提报时间");
        return;
    }else if ([SettingContent(_LLI_21) isEqualToString:@""]){
        HUDNormal(@"请选择计划开始时间");
        return;
    }else if ([SettingContent(_LLI_22) isEqualToString:@""]){
        HUDNormal(@"请选择计划完成时间");
        return;
    }else if ([SettingContent(_LLI_26) isEqualToString:@""]){
        HUDNormal(@"请选择故障开始时间");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (weakSelf.updataModel) {
                weakSelf.updataModel();
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
    
    NSMutableArray *materielArray = [NSMutableArray array];
    for (MaterielsModel *mater in self.updataArray) {
        if ([mater.TYPE isEqualToString:@"add"]) {
            NSDictionary *dic = @{
                                  @"ITEMNUM"    :mater.ITEMNUM,
                                  @"ITEMQTY"    :mater.ITEMQTY,
                                  @"LOCATION"   :mater.LOCATION,
                                  @"TYPE"       :@"add",
                                  };
            [materielArray addObject:dic];
        }else if ([mater.TYPE isEqualToString:@"update"]){
            NSDictionary *dic = @{
                                  @"ITEMNUM"    :mater.ITEMNUM,
                                  @"ITEMQTY"    :mater.ITEMQTY,
                                  @"LOCATION"   :mater.LOCATION,
                                  @"WPITEMID"   :mater.WPITEMID,
                                  @"TYPE"       :@"update",
                                  };
            [materielArray addObject:dic];
        }else if ([mater.TYPE isEqualToString:@"delete"]){
            NSDictionary *dic = @{
                                  @"ITEMNUM"    :mater.ITEMNUM,
                                  @"ITEMQTY"    :mater.ITEMQTY,
                                  @"LOCATION"   :mater.LOCATION,
                                  @"WPITEMID"   :mater.WPITEMID,
                                  @"TYPE"       :@"delete",
                                  };
            [materielArray addObject:dic];
        }
    }
    AccountModel *model = [AccountManager account];
    NSMutableDictionary *dicy = [NSMutableDictionary dictionary];
    if (arrayst.count) {
        [dicy setObject:@"" forKey:@"WOACTIVITY"];
    }else if (materielArray.count){
        [dicy setObject:@"" forKey:@"WPMATERIAL"];
    }
    NSArray *arrays = @[
                        dicy,
                        ];

    NSDictionary *dic1 = @{
                           @"ACTFINISH":@"",
                           @"ACTSTART":@"",
                           @"ASSETTYPE":@"",
                           @"BRANCH":SettingContent(_LL_3),
                           @"CREATEBY":model.personId,
                           @"CREATEDATE":SettingContent(_LL_10),
                           @"CREATENAME":SettingContent(_LL_8),
                           @"CULEVEL":@"",
                           @"DESCRIPTION":SettingContent(_LL_2),
                           @"DJPLANNUM":@"",
                           @"DJTYPE":@"",
                           @"FAILURECODE":_stock.FAILURECODE,
                           @"GZLDESC":SettingContent(_LLI_15),
                           @"GZWTDESC":SettingContent(_LLI_16),
                           @"JGPLANNUM":@"",
//                           @"LEAD":self.choose1.PERSONID.length?self.choose1.PERSONID:@"",
                           @"LEADNAME":SettingContent(_LLI_11),
                           @"LOCDESC":SettingContent(_LLI_6I),
                           @"NAME1":SettingContent(_LLI_12),
                           @"NAME2":SettingContent(_LLI_13),
                           @"NAME3":SettingContent(_LLI_14),
                           @"PCCOMPNUM":@"",
                           @"PCRESON":@"",
                           @"PCTYPE":@"",
                           @"PLANNUM":@"",
                           @"PROBLEMCODE":SettingContent(_LLI_16),
                           @"PRONAME":SettingContent(_LL_4I),
                           @"SCHEDFINISH":SettingContent(_LLI_22),
                           @"SCHEDSTART":SettingContent(_LLI_21),
                           @"UDDESCRIP":@"",
                           @"UDFJAPPNUM":@"",
                           @"UDFJFOL":@"",
                           @"UDGZDJ":SettingContent(_LL_17),
                           @"UDGZTYPE":SettingContent(_LL_18),
                           @"UDINSPOBY":SettingContent(_LLI_12),
                           @"UDINSPOBY2":SettingContent(_LLI_13),
                           @"UDINSPOBY3":SettingContent(_LLI_14),
                           @"UDJGRESULT":@"",
                           @"UDJGTYPE":@"",
                           @"UDJPNUM":@"",
                           @"UDLOCATION":SettingContent(_LLI_6),
                           @"UDLOCNUM":SettingContent(_LLI_5),
                           @"UDPLANNUM":SettingContent(_LLI_7),
                           @"UDPLSTARTDATE":@"",
                           @"UDPLSTOPDATE":@"",
                           @"UDPROBDESC":SettingContent(_LT_29),
                           @"UDPROJECTNUM":SettingContent(_LLI_4),
                           @"UDREMARK":SettingContent(_LT_28I),
                           @"UDREPORTNUM":@"",
                           @"UDRESTARTTIME":@"",
                           @"UDRLSTARTDATE":@"",
                           @"UDRLSTOPDATE":@"",
                           @"UDRPRRSB":_stock.UDRPRRSB,
                           @"UDRPRRSBNAME":SettingContent(_LLI_19),
                           @"UDSTATUS":_stock.UDSTATUS,
                           @"UDSTOPTIME":SettingContent(_LLI_26),
                           @"UDZGLIMIT":SettingContent(_LLI_20),
                           @"UDZGMEASURE":@"",
                           @"WONUM":_stock.WONUM,
                           @"WORKTYPE":@"FR",
                           @"WTCODE":@"",
                           @"ISBIGPAR":@"0",
                           @"ISSTOPED":SettingContent(_LC_25),
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
                     @{@"mboObjectName":@"WORKORDER"},
                     @{@"mboKey":@"WONUM"},
                     @{@"mboKeyValue":_stock.WONUM},
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
    

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作计划" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"物料信息" iconName:@"ic_realinfo" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_gzgl" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"故障原因及措施" iconName:@"ic_failreport" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item5 = [DTKDropdownItem itemWithTitle:@"工作流任务分配" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=_stock.WORKORDERID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0,40.f, 40.f) dropdownItems:@[item0,item1,item2,item3,item4,item5] icon:@"more"];
    
    
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 150.f;
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
            work.parent = SettingContent(_LL_1);
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
            //物料信息
            MaterielsViewController *mater = [[MaterielsViewController alloc]init];
            mater.parent = SettingContent(_LL_1);
            mater.executeCellClick = ^(NSArray *array){
                [weakSelf.materielsArray removeAllObjects];
                [weakSelf.materielsArray addObjectsFromArray:array];
            };
            mater.updataCellClick = ^(NSArray *array,BOOL dele){
                [weakSelf.updataArray removeAllObjects];
                [weakSelf.updataArray addObjectsFromArray:array];
                weakSelf.isdele = dele;
            };
            mater.dele = _isdele;
            mater.array = self.materielsArray;
            mater.deleArray = self.updataArray;
            [weakSelf.navigationController pushViewController:mater animated:YES];
        }break;
        case 2:{
            //发送工作流
            [self checkRequiredFieldcompeletion:^(BOOL isOk) {
                if (isOk) {
                    [weakSelf sendData];
                }
            }];
            
        }break;
        case 3:{
            //图片上传
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = _objectname;
            vc.ownerid = _stock.WORKORDERID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }break;
        case 4:{
            //故障原因
            CauseProblemViewController *vc = [[CauseProblemViewController alloc] init];
            if ([SettingContent(_LLI_15) isEqualToString:@""]) {
                HUDNormal(@"请选择故障问题")
                return;
            }
            vc.requestCode = SettingContent(_LLI_16);
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
    popupView.processname = @"UDGZWO";
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

-(void)setStock:(FauWorkModel *)stock{
    _stock = stock;
}
//第一部分
-(void)addOne{
    WEAKSELF
    self.LL_1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.WONUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"工单号:" type:PersonalSettingItemTypeLabels];
    self.LL_1.FieldName=@"WONUM";
    
    
    self.LL_2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    
    self.LL_2.FieldName=@"DESCRIPTION";
    
    self.LL_3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRANCH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"中心:" type:PersonalSettingItemTypeLabels];
    
    self.LL_3.FieldName=@"BRANCH";
    
    
    self.LLI_4 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPROJECTNUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    self.LLI_4.FieldName=@"UDPROJECTNUM";
    
    if (_isEdit) {
        _LLI_4.operation = ^{
            ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
            choose.executeClickCell = ^(ChooseItemNoModel *model){
                weakSelf.LLI_4.content = model.PRONUM;
                weakSelf.LL_4I.content = model.DESCRIPTION;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:choose animated:YES];
        };
    }
    
     self.LL_4I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRONAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabels];

    self.LL_4I.FieldName=@"PRONAME";
    
    self.LLI_5 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDLOCNUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"机位号:" type:PersonalSettingItemTypeArrow];
    self.LLI_5.FieldName=@"UDLOCNUM";
    
    if (_isEdit) {
        _LLI_5.operation = ^{
            if (weakSelf.LLI_4.content.length == 0) {
                WHUDNormal(@"请选择项目编号");
                return ;
            }
            FlightNoController *choose = [[FlightNoController alloc]init];
            choose.executeCellClick = ^(FlightNoModel *model){
                weakSelf.LLI_5.content = model.LOCNUM;
                [weakSelf.tableView reloadData];
            };
            choose.requestCoding = weakSelf.LLI_4.content;
            [weakSelf.navigationController pushViewController:choose animated:YES];
        };
    }
    
     self.LLI_6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDLOCATION withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"设备位置:" type:PersonalSettingItemTypeArrow];
    self.LLI_6.FieldName=@"UDLOCATION";
    
    
    _LLI_6.operation = ^{
        if(weakSelf.LLI_4.content.length == 0){
            WHUDNormal(@"请选择项目编号");
            return ;
        }else if (weakSelf.LLI_5.content.length == 0){
            WHUDNormal(@"请选择机位号");
            return ;
        }
        EquipmentLocationController *equipment = [[EquipmentLocationController alloc]init];
        equipment.executeCellClick = ^(EquipmentLocationModel *model){
            weakSelf.LLI_6.content = model.LOCATION;
            weakSelf.LLI_6I.content = model.DESCRIPTION;
            [weakSelf.tableView reloadData];
        };
        equipment.requestCoding1 = weakSelf.LLI_4.content;
        equipment.requestCoding2 = weakSelf.LLI_5.content;
        [weakSelf.navigationController pushViewController:equipment animated:YES];
    };
    
    self.LLI_6I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.LOCDESC withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"位置描述:" type:PersonalSettingItemTypeLabels];
    self.LLI_6I.FieldName=@"LOCDESC";
    
     self.LLI_7 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDPLANNUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"终验收计划号:" type:PersonalSettingItemTypeArrow];
    self.LLI_7.FieldName=@"UDPLANNUM";
    
    _LLI_7.operation = ^{
        FinalNumViewController *final = [[FinalNumViewController alloc]init];
        final.executeCellClick = ^(FinalModels *model){
            weakSelf.LLI_7.content = model.PLANNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:final animated:YES];
    };
    
    self.LLI_7I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDREPORTNUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"故障提报单号:" type:PersonalSettingItemTypeLabels];
    self.LLI_7I.FieldName = @"UDREPORTNUM";
    
     self.LL_8 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDSTATUS withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    self.LL_8.FieldName=@"UDSTATUS";
    
    self.LL_9 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    self.LL_9.FieldName=@"CREATENAME";
    
    self.LL_10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabels];
    self.LL_10.FieldName=@"CREATEDATE";
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL_1,_LL_2,_LL_3,_LLI_4,_LL_4I,_LLI_5,_LLI_6,_LLI_6I,_LLI_7,_LLI_7I,_LL_8,_LL_9,_LL_10];
    
    for (PersonalSettingItem * one in group.items) {
        
        if (one.FieldName.length>0) {
            [self.SetingItems setObject:one forKey:one.FieldName];
        }
    }
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI_11 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.LEADNAME withHeight:CELLHEIGHT  withClick:_isEdit||_isShows withStar:YES title:@"维护/运行组长:" type:PersonalSettingItemTypeArrow];
    self.LLI_11.FieldName=@"LEADNAME";
    
    if (_isEdit||_isShows) {
        _LLI_11.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose1 = model;
                weakSelf.LLI_11.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LLI_12 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDINSPOBY withHeight:CELLHEIGHT  withClick:_isEdit||_isShows withStar:YES title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    self.LLI_12.FieldName =@"UDINSPOBY";
    
    if (_isEdit||_isShows) {
        _LLI_12.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose2 = model;
                weakSelf.LLI_12.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LLI_13 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDINSPOBY2 withHeight:CELLHEIGHT  withClick:_isEdit||_isShows withStar:NO title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    self.LLI_13.FieldName=@"UDINSPOBY2";
    
    if (_isEdit||_isShows) {
        _LLI_13.operation = ^{
            
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose3 = model;
                weakSelf.LLI_13.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LLI_14 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDINSPOBY3 withHeight:CELLHEIGHT  withClick:_isEdit||_isShows withStar:NO title:@"维护/运行人员:" type:PersonalSettingItemTypeArrow];
    self.LLI_14.FieldName=@"UDINSPOBY3";
    
    if (_isEdit||_isShows) {
        
        _LLI_14.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.choose4 = model;
                weakSelf.LLI_14.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    
    group.items = @[_LLI_11,_LLI_12,_LLI_13,_LLI_14];
    
    [_allGroups addObject:group];
    
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI_15 = [PersonalSettingItem itemWithIcon:@"moreext_icon" withContent:_stock.GZLDESC withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"故障类:" type:PersonalSettingItemTypeArrow];
    self.LLI_15.FieldName=@"GZLDESC";
    
    
    if (_isEdit) {
        _LLI_15.operation = ^{
            FaultClassController *fault = [[FaultClassController alloc]init];
            fault.isShow = YES;
            fault.executeCellClick = ^(FaultClassModel *model){
                weakSelf.faultmodel = model;
                weakSelf.LLI_15.content = model.CODEDESC;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:fault animated:YES];
        };
    }
    
    self.LLI_16 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDFAILURECODE withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"故障问题:" type:PersonalSettingItemTypeArrow];
    self.LLI_16.FieldName=@"UDFAILURECODE";
    
    _LLI_16.operation = ^{
        if (weakSelf.LLI_15.content.length ==0) {
            WHUDNormal(@"请选择故障类");
            return ;
        }
        FaultCodeController *fault = [[FaultCodeController alloc]init];
        fault.executeCellClick = ^(FaultCodeModel *model){
            weakSelf.LLI_16.content = model.FAILURECODE;
            weakSelf.LLI_16I.content = model.CODEDESC;
            [weakSelf.tableView reloadData];
        };
        fault.requestCoding = weakSelf.faultmodel.FAILURELIST.length?weakSelf.faultmodel.FAILURELIST:weakSelf.stock.GZWTDESC;
        [weakSelf.navigationController pushViewController:fault animated:YES];
    };

    self.LLI_16I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.GZWTDESC withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"故障问题描述:" type:PersonalSettingItemTypeLabels];
    self.LLI_16I.FieldName=@"GZWTDESC";
    
    
    self.LL_17 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDGZDJ withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"故障等级:" type:PersonalSettingItemTypeLabel];
    self.LL_17.FieldName=@"UDGZDJ";
    
    
    self.LL_18 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDGZTYPE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"故障类型:" type:PersonalSettingItemTypeLabel];
    self.LL_18.FieldName=@"UDGZTYPE";
    
    
    self.LLI_19 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:_stock.UDRPRRSBNAME withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"提报人:" type:PersonalSettingItemTypeArrow];
    self.LLI_19.FieldName=@"UDRPRRSBNAME";
    
    
    if (_isEdit) {
        
        _LLI_19.operation = ^{
            DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
            daily.exetuceClickCell = ^(ChoosePersonModel *model){
                weakSelf.LLI_19.content = model.DISPLAYNAME;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:daily animated:YES];
        };
    }
    
    self.LLI_20 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDZGLIMIT withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"提报时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_20.FieldName=@"UDZGLIMIT";
    
    if(_isEdit){
        _LLI_20.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear1];
        };
    }
    
    self.LLI_21 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.SCHEDSTART withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"计划开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_21.FieldName=@"SCHEDSTART";
    
    if(_isEdit){
        _LLI_21.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear2];
        };
    }
    
    self.LLI_22 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.SCHEDFINISH withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"计划完成时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_22.FieldName=@"SCHEDFINISH";
    
    if(_isEdit){
        _LLI_22.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear3];
        };
    }
    
    
    self.LLI_23 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.ACTSTART withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_23.FieldName=@"ACTSTART";
    
    _LLI_23.operation = ^{
        if (weakSelf.isEdits) {
            [weakSelf.view addSubview:weakSelf.timeYear5];
        }
    };
    
    self.LLI_24 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.ACTFINISH withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际结束时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_24.FieldName =@"ACTFINISH";
    
    _LLI_24.operation = ^{
        if (weakSelf.isEdits) {
            [weakSelf.view addSubview:weakSelf.timeYear6];
        }
    };
    
    self.LC_25 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ISSTOPED withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否停机:" type:PersonalSettingItemTypeChoice];
    self.LC_25.FieldName=@"ISSTOPED";
    
    
    self.LLI_26 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDSTOPTIME withHeight:CELLHEIGHT  withClick:_isEdit withStar:YES title:@"故障开始时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_26.FieldName=@"UDSTOPTIME";
    
    if(_isEdit){
        _LLI_26.operation = ^{
            [weakSelf.view addSubview:weakSelf.timeYear4];
        };
    }
    
    self.LLI_27 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.UDRESTARTTIME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"故障恢复时间:" type:PersonalSettingItemTypeArrow];
    self.LLI_27.FieldName=@"UDRESTARTTIME";
    
    _LLI_27.operation = ^{
        if (weakSelf.isEdits) {
            [weakSelf.view addSubview:weakSelf.timeYear7];
        }
    };

    
    self.LL_28 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDJGRESULT withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"累计停机时间:" type:PersonalSettingItemTypeLabel];
    self.LL_28.FieldName=@"UDJGRESULT";
    
    
    self.LT_28I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDREMARK withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"没有编码的物料:" type:PersonalSettingItemTypeLabel];
    self.LT_28I.FieldName=@"UDREMARK";
    
    self.LT_28I.operation=^{
        
        [weakSelf popInputTextViewContent:weakSelf.LT_28I.content title:weakSelf.LT_28I.title compeletion:^(NSString *value) {
            weakSelf.LT_28I.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    self.LT_29 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.UDPROBDESC withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"故障隐患描述:" type:PersonalSettingItemTypeLabel];
    
    self.LT_29.FieldName=@"UDPROBDESC";
    
    
    self.LT_29.operation=^{
        
        [weakSelf popInputTextViewContent:weakSelf.LT_29.content title:weakSelf.LT_29.title compeletion:^(NSString *value) {
            weakSelf.LT_29.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    
    group.items = @[_LLI_15,_LLI_16,_LLI_16I,_LL_17,_LL_18,_LLI_19,_LLI_20,_LLI_21,_LLI_22,_LLI_23,_LLI_24,_LC_25,_LLI_26,_LLI_27,_LL_28,_LT_28I,_LT_29,];
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
            weakSelf.LLI_20.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LLI_21.content = [weakSelf.timeYear2 stringFromDate:data];
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
            weakSelf.LLI_22.content = [weakSelf.timeYear3 stringFromDate:data];
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
            weakSelf.LLI_26.content = [weakSelf.timeYear4 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear4;
}

-(TXTimeChoose *)timeYear5{
    WEAKSELF
    if (!_timeYear5) {
        self.timeYear5 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear5.backString = ^(NSDate *data){
            weakSelf.LLI_23.content = [weakSelf.timeYear5 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear5;
}

- (TXTimeChoose *)timeYear6{
    WEAKSELF
    if (!_timeYear6) {
        self.timeYear6 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear6.backString = ^(NSDate *data){
            weakSelf.LLI_24.content = [weakSelf.timeYear6 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear5;
}

- (TXTimeChoose *)timeYear7{
    WEAKSELF
    if (!_timeYear7) {
        self.timeYear7 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear7.backString = ^(NSDate *data){
            weakSelf.LLI_27.content = [weakSelf.timeYear7 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear7;
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
-(void)popInputTextViewContent:(NSString*)content title:(NSString*)title  compeletion:(void(^)(NSString * value))compeletion
{
    TextInputViewController *popTextView = [[TextInputViewController alloc] initWithNibName:@"TextInputViewController" bundle:[NSBundle mainBundle]];
    [self presentPopupViewController:popTextView animationType:MJPopupViewAnimationFade];
    
    popTextView.titleLabel.text=title;
    popTextView.content.text=content;
    [popTextView.content becomeFirstResponder];

    popTextView.save=^(NSString *content)
    {
        compeletion(content);
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    popTextView.cancel = ^{
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
}
@end
