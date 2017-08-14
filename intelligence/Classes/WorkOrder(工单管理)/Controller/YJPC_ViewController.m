//
//  YJPC_ViewController.m
//  intelligence
//
//  Created by chris on 2017/6/29.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "YJPC_ViewController.h"
#import "NSArray+Extension.h"
#import "ZZZC_ViewController.h"
#import "FDJZC_ViewController.h"
#import "CLXGSZZC_ViewController.h"
#import "PCXXXX_ViewController.h"
#import "ChooseItemNoController.h"
#import "FlightNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
#import "ApprovalsView.h"
#import "SoapUtil.h"
#import "WfmListanceListViewController.h"

@interface YJPC_ViewController ()<ZZZC_ViewControllerDelegate,FDJZC_ViewControllerDelegate,CLXGSZZC_ViewControllerDelegate,PCXXXX_ViewControllerDelegate>

@end

@implementation YJPC_ViewController
{
    NSMutableArray * UDWARNINGNORMs;
    NSMutableArray * PCXXXXs;
    NSMutableDictionary *ZZZC_DATAs;
    NSMutableDictionary *FDJZC_DATAs;
    NSMutableDictionary *CLXGSZZC_DATAs;
    NSMutableArray *PCXXXX_DATAs;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.SCREENINGUSER FieldName:@"排查人1姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.SCREENINGUSER2 FieldName:@"排查人2姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.SCREENINGUSER3 FieldName:@"排查人3姓名"];
        [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
        [self queryMODELTYPEByProjectNum:self.Kmodel.PRONUM Locnum:self.Kmodel.LOCNUM];
        
    }
    else
    {
        AccountModel *model = [AccountManager account];
        [self modifyField:@"状态" newValue:@"新建"];
        [self modifyField:@"创建时间" newValue:[self.dateFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"创建人" newValue:model.userName];
        [self modifyField:@"创建人姓名" newValue:model.displayName];
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"WONUM" newType:@"隐藏"];
    }
    [self queryUDWARNINGNORM];

    
    CGRect pickerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    self.typePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.typePicker.delegate = self;
    self.typePicker.dataSource = self;
    [self.typePicker setBackgroundColor:[UIColor grayColor]];
    
    self.UDLEVELPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.UDLEVELPicker.delegate = self;
    self.UDLEVELPicker.dataSource = self;
    [self.UDLEVELPicker setBackgroundColor:[UIColor grayColor]];
    
    self.PROBASEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.PROBASEPicker.delegate = self;
    self.PROBASEPicker.dataSource = self;
    [self.PROBASEPicker setBackgroundColor:[UIColor grayColor]];
    
    self.MASTERCONTROLPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.MASTERCONTROLPicker.delegate = self;
    self.MASTERCONTROLPicker.dataSource = self;
    [self.MASTERCONTROLPicker setBackgroundColor:[UIColor grayColor]];
    
    self.VARIABLEPITCHPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.VARIABLEPITCHPicker.delegate = self;
    self.VARIABLEPITCHPicker.dataSource = self;
    [self.VARIABLEPITCHPicker setBackgroundColor:[UIColor grayColor]];
    
    self.FREQUENCYCONVERSIONPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.FREQUENCYCONVERSIONPicker.delegate = self;
    self.FREQUENCYCONVERSIONPicker.dataSource = self;
    [self.FREQUENCYCONVERSIONPicker setBackgroundColor:[UIColor grayColor]];
    
    
    self.LIFTINGDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.LIFTINGDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.LIFTINGDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.INTERCONNECTIONDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.INTERCONNECTIONDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.INTERCONNECTIONDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.SCREENINGDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.SCREENINGDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.SCREENINGDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"发电机轴承" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"排查详细信息" newType:@"隐藏"];
    
    NSLog(@"排查类型 %@",[self valueByname:@"排查类型"]);
    if (self.Kmodel) {
    if ([[self valueByname:@"排查类型"] isEqualToString:@"主轴轴承故障"]) {
        
        [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"跳转"];
        
    }else if([[self valueByname:@"排查类型"] isEqualToString:@"发电机轴承温度异常"]){
        
        [self modifyTypeByFieldName:@"发电机轴承" newType:@"跳转"];
    
    }else if([[self valueByname:@"排查类型"] isEqualToString:@"齿轮箱高速轴轴承温度异常"]){
        
        [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"跳转"];
    
    }else{
        [self modifyTypeByFieldName:@"排查详细信息" newType:@"跳转"];
        [self queryNORMNUMByWARNTYPE:[self valueByname:@"排查类型"]];
    }
    }
    [self addRightNavBarItem];

}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        //[weakSelf checkRequiredFieldcompeletion:^(BOOL isOk) {
            //if (isOk) {
                [weakSelf sendData];
            //}
        //}];
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_gzgl" callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"保存更改" iconName:@"" callBack:^(NSUInteger index, id info) {
        [self saveData];
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"放弃更改" iconName:@"" callBack:^(NSUInteger index, id info) {
        [self.navigationController popoverPresentationController];
    }];
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"工作流任务分配" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=self.Kmodel.UDWARNINGWOID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2,item3,item4];
    }
    else
    {
        items =@[item2,item3];
    }
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0,40.f, 40.f) dropdownItems:items icon:@"more"];
    
    
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

//发送工作流
-(void)sendData{
    if ([self.Kmodel.UDSTATUS isEqualToString:@"已取消"]||[self.Kmodel.UDSTATUS isEqualToString:@"已关闭"]||[self.Kmodel.UDSTATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",self.Kmodel.UDSTATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([self.Kmodel.UDSTATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDWARNWO";
    popupView.mbo = @"UDWARNINGWO";
    popupView.keyValue = self.Kmodel.WONUM;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)selectValue:(NSString *)fieldName
{
    NSLog(@"子类重写 %@",fieldName);
    
    if ([fieldName isEqualToString:@"TYPE"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"UDLEVEL"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"PROBASE"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"MASTERCONTROL"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"VARIABLEPITCH"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"FREQUENCYCONVERSION"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if([fieldName isEqualToString:@"PRONUM"]){
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"项目编号" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];
            [self queryProjectNameByProjectNum:model.PRONUM];
            [self modifyField:@"机位号" newValue:@""];
            [self modifyField:@"机组型号" newValue:@""];
            [self modifyField:@"程序版本号" newValue:@""];

        };
        [self.navigationController pushViewController:choose animated:YES];
    }
    if ([fieldName isEqualToString:@"LOCNUM"]) {
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
            
            [self modifyField:@"机位号" newValue:model.LOCNUM];
            [self queryMODELTYPEByProjectNum:[self valueByname:@"项目编号"] Locnum:model.LOCNUM];
        };
        choose.requestCoding = [self valueByname:@"项目编号"];
        [self.navigationController pushViewController:choose animated:YES];
    }
    if ([fieldName isEqualToString:@"SCREENINGUSER"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"排查人1" newValue:model.PERSONID];
            [self modifyField:@"排查人1姓名" newValue:model.DISPLAYNAME];

        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if ([fieldName isEqualToString:@"SCREENINGUSER2"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"排查人2" newValue:model.PERSONID];
            [self modifyField:@"排查人2姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if ([fieldName isEqualToString:@"SCREENINGUSER3"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"排查人3" newValue:model.PERSONID];
            [self modifyField:@"排查人3姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    
}
-(void)jumpToDetial:(NSString *)name
{
    NSLog(@"子类重写 %@",name);
    if ([name isEqualToString:@"主轴轴承故障"]) {
        
        ZZZC_ViewController * vc = [[ZZZC_ViewController alloc] init];
        vc.delegate = self;
        vc.key = name;
        vc.Kmodel = self.Kmodel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([name isEqualToString:@"发电机轴承"]) {
        
        FDJZC_ViewController * vc = [[FDJZC_ViewController alloc] init];
        vc.delegate = self;
        vc.key = name;
        vc.Kmodel = self.Kmodel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([name isEqualToString:@"齿轮箱高速轴轴承"]) {
        
        CLXGSZZC_ViewController * vc = [[CLXGSZZC_ViewController alloc] init];
        vc.delegate = self;
        vc.key = name;
        vc.Kmodel = self.Kmodel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        if ([PCXXXXs count]==0) {
            return;
        }
        PCXXXX_ViewController * vc = [[PCXXXX_ViewController alloc] init];
        vc.WONUM = self.Kmodel.WONUM;
        vc.delegate = self;
        vc.key = name;
        if (PCXXXXs.count>=1) {
            vc.array = PCXXXXs;
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)setDate:(NSString *)name
{
    NSLog(@"子类设置日期 %@",name);
    if ([name isEqualToString:@"LIFTINGDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
    if ([name isEqualToString:@"INTERCONNECTIONDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
    if ([name isEqualToString:@"SCREENINGDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
}
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    if ([name isEqualToString:@"排查类型"]) {
        [cell addSubview:self.typePicker];
    }
    if ([name isEqualToString:@"预警等级"]) {
        [cell addSubview:self.UDLEVELPicker];
    }
    if ([name isEqualToString:@"装配基地"]) {
        [cell addSubview:self.PROBASEPicker];
    }
    if ([name isEqualToString:@"主控配置"]) {
        [cell addSubview:self.MASTERCONTROLPicker];
    }
    if ([name isEqualToString:@"变浆配置"]) {
        [cell addSubview:self.VARIABLEPITCHPicker];
    }
    if ([name isEqualToString:@"变频配置"]) {
        [cell addSubview:self.FREQUENCYCONVERSIONPicker];
    }
    if ([name isEqualToString:@"吊装时间"]) {
        [cell addSubview:self.LIFTINGDATEDatePicker];
        [self.LIFTINGDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if ([name isEqualToString:@"并网时间"]) {
        [cell addSubview:self.INTERCONNECTIONDATEDatePicker];
         [self.INTERCONNECTIONDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if ([name isEqualToString:@"排查时间"]) {
        [cell addSubview:self.SCREENINGDATEDatePicker];
         [self.SCREENINGDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

}
-(void)initData
{
    if (self.Kmodel) {
       NSArray *names = [NSArray getProperties:[self.Kmodel class]];
        
        for (NSString *name in names) {
            
            if ([self.Kmodel valueForKey:name]) {
                NSString * value = [self.Kmodel valueForKey:name];
                if (value.length>0) {
                    NSLog(@"反射值 %@   反射键 %@",value,name);
                }
                [self modifyFieldByFieldName:name newValue:value];
            }
        }
    }
}
//根据工号查人名
-(void)queryDisplayNameByUserName:(NSString*)username FieldName:(NSString*)fieldName
{
    if(username.length<=0||fieldName.length<=0)
    {
        return;
    }
    
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDPERSON",
                           @"objectname":@"PERSON",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"STATUS":@"=活动",
                                          @"PERSONID":username}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};

    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {

        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        [self modifyField:fieldName newValue:displayName];
        
    } fail:^(NSError *error) {
        
    }];
}
//根据项目编号查项目名
-(void)queryProjectNameByProjectNum:(NSString*) projectNum
{
    if(projectNum.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDPROJECT",
                           @"objectname":@"UDPRO",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"TESTPRO":@"Y",
                                          @"PRONUM":projectNum}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        NSString * RESPONS =  info[@"RESPONS"];
        NSString * RESPONSNAME = info[@"RESPONSNAME"];
        
        [self modifyField:@"项目名称" newValue:DESCRIPTION];
        [self modifyField:@"项目负责人" newValue:RESPONS];
        [self modifyField:@"姓名" newValue:RESPONSNAME];
        
    } fail:^(NSError *error) {
        
    }];
    
}
//根据机位号查机组型号和程序版本号
-(void)queryMODELTYPEByProjectNum:(NSString*) projectNum Locnum:(NSString*) LOCNUM
{
    if(projectNum.length<=0||LOCNUM.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDFANDETAILS",
                           @"objectname":@"UDFANDETAILS",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"orderby":@"LOCNUM",
                           @"condition":@{@"LOCNUM":LOCNUM,
                                          @"PRONUM":projectNum}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        
        NSString * MODELTYPE = info[@"MODELTYPE"];
        NSString * UDFJAPPNUM =  info[@"UDFJAPPNUM"];
        
        [self modifyField:@"机组型号" newValue:MODELTYPE];
        [self modifyField:@"程序版本号" newValue:UDFJAPPNUM];
       
    } fail:^(NSError *error) {
        
    }];
}
-(void)queryUDWARNINGNORM
{
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNNORM",
                           @"objectname":@"UDWARNINGNORM",
                           @"curpage":@(1),
                           @"showcount":@(100),
                           @"option":@"read",
                           @"orderby":@"NORMNUM"};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSArray * array = response[@"result"][@"resultlist"];
        UDWARNINGNORMs=[NSMutableArray array];
        [UDWARNINGNORMs addObjectsFromArray:array];
        
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"1",@"WARNTYPE":@"主轴轴承故障"}];
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"2",@"WARNTYPE":@"发电机轴承温度异常"}];
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"3",@"WARNTYPE":@"齿轮箱高速轴轴承温度异常"}];
        NSLog(@"预警排查类型 %@",UDWARNINGNORMs);
    } fail:^(NSError *error) {
        
    }];

}
-(void)queryUDWARNINGNORMLINE:(NSString*)NORMNUM;
{
    if (self.Kmodel) {
        NORMNUM = self.Kmodel.WONUM;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNINGWOLINE",
                           @"objectname":@"UDWARNINGWOLINE",
                           @"curpage":@(1),
                           @"showcount":@(100),
                           @"option":@"read",
                           @"orderby":@"SERNUM",
                           @"condition":@{@"WONUM":NORMNUM}};
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {

        NSArray * array =  response[@"result"][@"resultlist"];
        
        if (array.count>0) {
            PCXXXXs = [NSMutableArray array];
            NSInteger index = 1;
            for (NSDictionary * dic in array) {
                
                NSString *CHECKITEM = dic[@"CHECKITEM"]?dic[@"CHECKITEM"]:@"";
                NSString *CHECKCONTENT = dic[@"CHECKCONTENT"]?dic[@"CHECKCONTENT"]:@"";
                NSString *CHECKRESULT = dic[@"CHECKRESULT"]?dic[@"CHECKRESULT"]:@"";
                NSString *PROBLEMDESC = dic[@"PROBLEMDESC"]?dic[@"PROBLEMDESC"]:@"";
                NSString *UDWARNINGWOLINEID = [NSString stringWithFormat:@"%@",dic[@"UDWARNINGWOLINEID"]?dic[@"UDWARNINGWOLINEID"]:@""];
                
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":CHECKITEM,@"值":@"" ,@"类型":@"标题",@"必填":@"否",@"字段名":@"NONAME3"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":CHECKCONTENT,@"值":@"" ,@"类型":@"标题",@"必填":@"否",@"字段名":@"NONAME3"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":[NSString stringWithFormat:@"%ld、%@",(long)index,@"排查结果(是否合格)"],@"值":CHECKRESULT,@"类型":@"是否",@"必填":@"否",@"字段名":@"CHECKRESULT"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":[NSString stringWithFormat:@"%ld、%@",(long)index,@"问题描述"],@"值":PROBLEMDESC ,@"类型":@"文本",@"必填":@"否",@"字段名": @"PROBLEMDESC"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":UDWARNINGWOLINEID,@"值":@"" ,@"类型":@"隐藏",@"必填":@"否",@"字段名": @"-"}]];
                
                index++;
            }
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)queryNORMNUMByWARNTYPE:(NSString*)WARNTYPE
{
    
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNNORM",
                           @"objectname":@"UDWARNINGNORM",
                           @"curpage":@(1),
                           @"showcount":@(1),
                           @"option":@"read",
                           @"orderby":@"NORMNUM",
                           @"condition":@{@"WARNTYPE":WARNTYPE}};
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSString * NORMNUM = response[@"result"][@"resultlist"][0][@"NORMNUM"];
        if (NORMNUM.length>0) {
            [self queryUDWARNINGNORMLINE:NORMNUM];
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

        if ([pickerView isEqual:self.typePicker]) {
        
            return [UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"];
        
        }else if ([pickerView isEqual:self.UDLEVELPicker]) {
        
            return @[@"高",@"中",@"低"][row];
        }else if ([pickerView isEqual:self.PROBASEPicker]) {
            
            return @[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row];
        }else if ([pickerView isEqual:self.MASTERCONTROLPicker]) {
            
            return @[@"倍福主控",@"丹控主控",@"其它主控"][row];
        }else if ([pickerView isEqual:self.VARIABLEPITCHPicker]) {
            
            return @[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row];
        }else if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]) {
            
            return @[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row];
        }
        else{
            return nil;
        }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

        if ([pickerView isEqual:self.typePicker]){
        
            return [UDWARNINGNORMs count];
        
        }else if ([pickerView isEqual:self.UDLEVELPicker]){
        
            return 3;
        }else if ([pickerView isEqual:self.PROBASEPicker]){
            
            return 7;
        }else if ([pickerView isEqual:self.MASTERCONTROLPicker]){
            
            return 3;
        }else if ([pickerView isEqual:self.VARIABLEPITCHPicker]){
            
            return 6;
        }else if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]){
            
            return 9;
        }
        else{
            return 0;
        }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.typePicker]) {
        
        [self modifyTypeByFieldName:@"排查详细信息" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"发电机轴承" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"隐藏"];
        
        NSLog(@"你选择了 %@",[UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"]);
        [self.typePicker removeFromSuperview];
        [self modifyField:@"排查类型" newValue:[UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"]];
        NSString * NORMNUM = [UDWARNINGNORMs objectAtIndex:row][@"NORMNUM"];
        
        if ([NORMNUM isEqualToString:@"1"]) {
            
            
                [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"跳转"];
            
            
            
        }else if([NORMNUM isEqualToString:@"2"]){
            
                [self modifyTypeByFieldName:@"发电机轴承" newType:@"跳转"];
            
        }else if([NORMNUM isEqualToString:@"3"]){
            
                [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"跳转"];
             
        }else{
            
            if (self.Kmodel) {
                [self modifyTypeByFieldName:@"排查详细信息" newType:@"跳转"];
                
                [self queryUDWARNINGNORMLINE:NORMNUM];
            }

        }
        [self modifyTypeByFieldName:@"TYPE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.UDLEVELPicker]) {
        
        NSLog(@"你选择了 %@",@[@"高",@"中",@"低"][row]);
        [self.UDLEVELPicker removeFromSuperview];
        [self modifyField:@"预警等级" newValue:@[@"高",@"中",@"低"][row]];
        [self modifyTypeByFieldName:@"UDLEVEL" newType:@"选择"];
    }
    if ([pickerView isEqual:self.PROBASEPicker]) {
        
        NSLog(@"你选择了 %@",@[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row]);
        [self.PROBASEPicker removeFromSuperview];
        [self modifyField:@"装配基地" newValue:@[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row]];
        [self modifyTypeByFieldName:@"PROBASE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.MASTERCONTROLPicker]) {
        
        NSLog(@"你选择了 %@",@[@"倍福主控",@"丹控主控",@"其它主控"][row]);
        [self.MASTERCONTROLPicker removeFromSuperview];
        [self modifyField:@"主控配置" newValue:@[@"倍福主控",@"丹控主控",@"其它主控"][row]];
        [self modifyTypeByFieldName:@"MASTERCONTROL" newType:@"选择"];
    }
    if ([pickerView isEqual:self.VARIABLEPITCHPicker]) {
        
        NSLog(@"你选择了 %@",@[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row]);
        [self.VARIABLEPITCHPicker removeFromSuperview];
        [self modifyField:@"变浆配置" newValue:@[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row]];
        [self modifyTypeByFieldName:@"VARIABLEPITCH" newType:@"选择"];
    }
    if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]) {
        
        NSLog(@"你选择了 %@",@[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row]);
        [self.FREQUENCYCONVERSIONPicker removeFromSuperview];
        [self modifyField:@"变频配置" newValue:@[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row]];
        [self modifyTypeByFieldName:@"FREQUENCYCONVERSION" newType:@"选择"];
    }
    
}
-(void)datePickerValueChanged:(id)sender
{
    NSDate * date;
    
    NSLog(@"日期改变");
    if ([sender isEqual:self.LIFTINGDATEDatePicker]) {
        [self.LIFTINGDATEDatePicker removeFromSuperview];
        date = self.LIFTINGDATEDatePicker.date;
        NSString *dateString = [self.dateAndTimeFormtter stringFromDate:date];
        [self modifyField:@"吊装时间" newValue:dateString];
        [self modifyTypeByFieldName:@"LIFTINGDATE" newType:@"日期"];
    }
    if ([sender isEqual:self.INTERCONNECTIONDATEDatePicker]) {
        [self.INTERCONNECTIONDATEDatePicker removeFromSuperview];
        date = self.INTERCONNECTIONDATEDatePicker.date;
        NSString *dateString = [self.dateAndTimeFormtter stringFromDate:date];
        [self modifyField:@"并网时间" newValue:dateString];
        [self modifyTypeByFieldName:@"INTERCONNECTIONDATE" newType:@"日期"];
    }
    if ([sender isEqual:self.SCREENINGDATEDatePicker]) {
        [self.SCREENINGDATEDatePicker removeFromSuperview];
        date = self.SCREENINGDATEDatePicker.date;
        NSString *dateString = [self.dateAndTimeFormtter stringFromDate:date];
        [self modifyField:@"排查时间" newValue:dateString];
        [self modifyTypeByFieldName:@"SCREENINGDATE" newType:@"日期"];
    }
}
-(void)saveData
{
    
   //[self testLine];return;
    
    if (![self checkField]) {
        return;
    }
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        NSLog(@"保存结果 %@",dic);
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            HUDNormal(@"保存成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDCARMAINLOG",@"ACTIONNAME":@"新建或修改预警排查工单"}];
        }else
        {
            HUDNormal(@"保存失败")
        }
    };

    AccountModel *model = [AccountManager account];
    
    NSDictionary *dicy = @{};
    
    NSMutableDictionary * md = [self dictionaryData];
    
    if (ZZZC_DATAs) {
        [md addEntriesFromDictionary:ZZZC_DATAs];
    }
    if (FDJZC_DATAs) {
        [md addEntriesFromDictionary:FDJZC_DATAs];
    }
    if (CLXGSZZC_DATAs) {
        [md addEntriesFromDictionary:CLXGSZZC_DATAs];
    }
    NSArray *arrays = @[dicy];
    [md setObject:arrays forKey:@"relationShip"];
    
    if (!self.Kmodel) {
        
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDWARNINGWO"},
                         @{@"mboKey":@"UDWARNINGWOID"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDWARNINGWO"},
                         @{@"mboKey":@"UDWARNINGWOID"},
                         @{@"mboKeyValue":self.Kmodel.UDWARNINGWOID},
                         ];
        
        [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
    }

}
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
-(void)ZZZC_DATA:(NSMutableDictionary *)data
{
    NSLog(@"代理返回数据 %@",data);
    ZZZC_DATAs = data;
}
-(void)FDJZC_DATA:(NSMutableDictionary *)data
{
    NSLog(@"代理返回数据 %@",data);
    FDJZC_DATAs = data;
}
-(void)CLXGSZZC_DATA:(NSMutableDictionary *)data
{
    NSLog(@"代理返回数据 %@",data);
    CLXGSZZC_DATAs = data;
}
-(void)PCXXXX_DATA:(NSMutableArray *)data
{
    NSLog(@"代理返回数据 %@",data);
    PCXXXX_DATAs = data;
    if ([PCXXXX_DATAs count]>0) {
        for (NSMutableDictionary *dic in PCXXXX_DATAs) {
            [self updateUDWARNINGWOLINEID:dic];
        }
    }
}
-(BOOL)checkField
{
    NSString* string =[self valueByname:@"项目编号"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"项目编号未填写")
        return NO;
    }
    string =[self valueByname:@"机位号"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"机位号未填写")
        return NO;
    }
    string =[self valueByname:@"排查类型"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"排查类型未填写")
        return NO;
    }
    string =[self valueByname:@"预警等级"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"预警等级未填写")
        return NO;
    }
    string =[self valueByname:@"问题描述"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"问题描述未填写")
        return NO;
    }
    string =[self valueByname:@"吊装时间"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"吊装时间未填写")
        return NO;
    }
    string =[self valueByname:@"并网时间"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"并网时间未填写")
        return NO;
    }
    string =[self valueByname:@"排查时间"];
    if (string.length==0||[string isEqualToString:@"请补充"]) {
        HUDNormal(@"排查时间未填写")
        return NO;
    }
    return YES;
}
-(void)updateUDWARNINGWOLINEID:(NSDictionary*)dic
{
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        
        NSLog(@"保存结果 %@",dic);
        
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            HUDNormal(@"排查详细信息 保存成功");
        }else{
            HUDNormal(@"排查详细信息 保存失败")
        }
        
    };

    NSDictionary *dicy = @{};
    NSArray *arrays = @[dicy];
    NSDictionary * md = @{@"PROBLEMDESC":dic[@"PROBLEMDESC"],
                          @"CHECKRESULT":dic[@"CHECKRESULT"],
                          @"relationShip":arrays};
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDWARNINGWOLINE"},
                         @{@"mboKey":@"UDWARNINGWOLINEID"},
                         @{@"mboKeyValue":dic[@"UDWARNINGWOLINEID"]},
                         ];
        [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
}
@end
