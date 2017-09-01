//
//  GZTBD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "GZTBD_ViewController.h"

@interface GZTBD_ViewController ()

@end

@implementation GZTBD_ViewController
{
    NSString * FAILURELIST;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initData];
    if (self.Kmodel) {
        [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
        [self queryUDDEPTByBRANCH:self.Kmodel.BRANCH];
        [self queryLOCATIONSByLOCNUM:self.Kmodel.LOCATION_CODE LOCATION:self.Kmodel.LOCATION UDPRONUM:self.Kmodel.PRONUM];
        [self queryFAILURECODEByFAILURECODE:self.Kmodel.FAULT_CODE FieldTitle:@"故障类描述"];
        [self queryFAILURECODEByFAILURECODE:self.Kmodel.FAULT_CODE1 FieldTitle:@"故障问题描述"];
    }else{
        AccountModel *model = [AccountManager account];
        [self modifyField:@"提报时间" newValue:[self.dateAndTimeFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"提报人" newValue:model.displayName];
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"REPORTNUM" newType:@"隐藏"];
    }
    [self addRightNavBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightNavBarItem{
    WEAKSELF

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"生成故障工单"  callBack:^(NSUInteger index, id info) {
        
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流"  callBack:^(NSUInteger index, id info) {
        //[weakSelf checkRequiredFieldcompeletion:^(BOOL isOk) {
        //if (isOk) {
        //[weakSelf sendData];
        //}
        //}];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];
        
    }];

    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        [self saveData];
    }];
    
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"放弃更改"  callBack:^(NSUInteger index, id info) {
        [self.navigationController popoverPresentationController];
    }];
    
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2,item3,item4];
    }
    else
    {
        items =@[item3,item4];
    }
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0,40.f, 40.f) dropdownItems:items icon:@"more"];
    
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 180.f;
    menuView.textColor = RGBCOLOR(255, 255, 255);
    menuView.cellColor = RGBCOLOR(46,92,154);
    menuView.textFont = [UIFont systemFontOfSize:16.f];
    menuView.cellSeparatorColor = RGBCOLOR(255, 255, 255);
    menuView.animationDuration = 0.4f;
    menuView.cellHeight = 50.0f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
//选择值
-(void)selectValue:(NSString *)fieldName
{
    if([fieldName isEqualToString:@"PRONUM"])
    {
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"项目编号" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];
            [self modifyField:@"中心" newValue:model.BRANCH];
            [self modifyField:@"中心名称" newValue:model.BRANCHDESC];
            [self modifyField:@"机位号" newValue:@""];
            [self modifyField:@"设备位置" newValue:@""];
            [self modifyField:@"设备位置描述" newValue:@""];
        };
        [self.navigationController pushViewController:choose animated:YES];
    }
    if([fieldName isEqualToString:@"LOCATION_CODE"]){
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
            
            [self modifyField:@"机位号" newValue:model.LOCNUM];
            [self modifyField:@"设备位置" newValue:@""];
            [self modifyField:@"设备位置描述" newValue:@""];
        };
        choose.requestCoding = [self valueByname:@"项目编号"];
        [self.navigationController pushViewController:choose animated:YES];
    }
    if([fieldName isEqualToString:@"LOCATION"]){
        EquipmentLocationController *equipment = [[EquipmentLocationController alloc]init];
        equipment.executeCellClick = ^(EquipmentLocationModel *model){
            
            [self modifyField:@"设备位置" newValue:model.LOCATION];
            [self modifyField:@"设备位置描述" newValue:model.DESCRIPTION];
        };
        equipment.requestCoding1 = [self valueByname:@"项目编号"];//项目编号
        equipment.requestCoding2 = [self valueByname:@"机位号"];//机位号
        
        [self.navigationController pushViewController:equipment animated:YES];
    }
    if([fieldName isEqualToString:@"FAULT_CODE"])
    {
        FaultClassController *fault = [[FaultClassController alloc]init];
        fault.isShow = YES;
        fault.executeCellClick = ^(FaultClassModel *model){
            
            [self modifyField:@"故障类" newValue:model.FAILURECODE];
            [self modifyField:@"故障类描述" newValue:model.CODEDESC];
            FAILURELIST = model.FAILURELIST;
        };
        [self.navigationController pushViewController:fault animated:YES];
        
    }
    if([fieldName isEqualToString:@"FAULT_CODE1"])
    {
        FaultCodeController *fault = [[FaultCodeController alloc]init];
        fault.executeCellClick = ^(FaultCodeModel *model){
            [self modifyField:@"故障问题" newValue:model.FAILURECODE];
            [self modifyField:@"故障问题描述" newValue:model.CODEDESC];
        };
        fault.requestCoding = FAILURELIST?FAILURELIST:@"";
        [self.navigationController pushViewController:fault animated:YES];
    }
    if([fieldName isEqualToString:@"CREATEBY"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"提报人" newValue:model.PERSONID];
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
}
//跳转到子表
-(void)jumpToDetial:(NSString *)name
{
    
}
//设置日期
-(void)setDate:(NSString *)name
{
    if ([name isEqualToString:@"HAPPEN_TIME"]) {
        
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDateAndTime];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateAndTimeFormtter stringFromDate:date];
            [self  modifyField:@"故障发生时间" newValue:dateString];
        };
        [dateView ShowInView:self.view];
    }
}
//发送工作流
-(void)sendData{
    if ([self.Kmodel.STATUSTYPE isEqualToString:@"已取消"]||[self.Kmodel.STATUSTYPE isEqualToString:@"已关闭"]||[self.Kmodel.STATUSTYPE isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",self.Kmodel.STATUSTYPE];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([self.Kmodel.STATUSTYPE isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDREPORT";
    popupView.mbo = @"UDREPORT";
    popupView.keyValue = self.Kmodel.UDREPORTID;
    popupView.key = @"UDREPORTID";
    popupView.CloseBlick = ^(NSDictionary *dic){
        
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDNormal(str1);
        }
        
    };
    [popupView show];
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
-(void)queryUDDEPTByBRANCH:(NSString*) BRANCH
{
    if(BRANCH.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDDEPT",
                           @"objectname":@"UDDEPT",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"DEPTNUM":BRANCH}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        [self modifyField:@"中心名称" newValue:DESCRIPTION];
         }
    } fail:^(NSError *error) {
        
    }];
}
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
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        [self modifyField:@"项目名称" newValue:DESCRIPTION];
         }
    } fail:^(NSError *error) {
        
    }];
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
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        [self modifyField:fieldName newValue:displayName];
         }
    } fail:^(NSError *error) {;
        
    }];
}
-(void)queryLOCATIONSByLOCNUM:(NSString*) LOCNUM LOCATION:(NSString*)LOCATION UDPRONUM:(NSString*)UDPRONUM
{
    if(LOCNUM.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"LOCATION",
                           @"objectname":@"LOCATIONS",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"UDLOCNUM":LOCNUM,@"LOCATION":LOCATION,@"UDPRONUM":UDPRONUM}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        [self modifyField:@"设备位置描述" newValue:DESCRIPTION];
         }
    } fail:^(NSError *error) {
        
    }];
}
-(void)queryFAILURECODEByFAILURECODE:(NSString*)FAILURECODE FieldTitle:(NSString* )title
{
    if(FAILURECODE.length<=0||FAILURECODE.length<=0)
    {
        return;
    }
    
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"FAILURELIST",
                           @"objectname":@"FAILURELIST",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"FAILURECODE":FAILURECODE}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * CODEDESC = info[@"CODEDESC"];
        [self modifyField:title newValue:CODEDESC];
         }
    } fail:^(NSError *error) {
        
    }];
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDPLANSTND",@"ACTIONNAME":@"新建或修改故障工单"}];
        }
        else
        {
            HUDNormal(@"保存失败")
        }
    };
    
    AccountModel *model = [AccountManager account];
    
    NSDictionary *dicy = @{};
    
    NSMutableDictionary * md = [self dictionaryData];
    
    NSArray *arrays = @[dicy];
    
    [md setObject:arrays forKey:@"relationShip"];
    
    
    
    if (!self.Kmodel) {
        
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDREPORT"},
                         @{@"mboKey":@"REPORTNUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDREPORT"},
                         @{@"mboKey":@"REPORTNUM"},
                         @{@"mboKeyValue":self.Kmodel.REPORTNUM},
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
-(BOOL)checkField
{return YES;}
@end
