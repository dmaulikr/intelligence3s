//
//  DJGD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/14.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "DJGD_ViewController.h"
#import "RegularViewController.h"

@interface DJGD_ViewController ()

@end

@implementation DJGD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryProjectNameByProjectNum:self.Kmodel.UDPROJECTNUM];
        [self queryDisplayNameByUserName:self.Kmodel.LEAD FieldName:@"定检组长姓名"];
        [self queryJOBPLANByJOBPLANID:self.Kmodel.UDJPNUM];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY FieldName:@"定检人员1姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY2 FieldName:@"定检人员2姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY3 FieldName:@"定检人员3姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY4 FieldName:@"定检人员4姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY5 FieldName:@"定检人员5姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.UDINSPOBY6 FieldName:@"定检人员6姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人"];
    }
    else
    {
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"WONUM" newType:@"隐藏"];
    }
    [self addRightNavBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作流任务分配"  callBack:^(NSUInteger index, id info) {
        
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"工单任务"  callBack:^(NSUInteger index, id info) {
                ZB_TableViewController * vc = [[ZB_TableViewController alloc] init];
                vc.type = @"定检工单任务";
                vc.search = self.Kmodel.WONUM;
                [self.navigationController pushViewController:vc animated:YES];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"发送工作流"  callBack:^(NSUInteger index, id info) {
        //[weakSelf checkRequiredFieldcompeletion:^(BOOL isOk) {
        //if (isOk) {
        //[weakSelf sendData];
        //}
        //}];
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];
        
    }];

    
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        [self saveData];
    }];
    
    DTKDropdownItem *item5 = [DTKDropdownItem itemWithTitle:@"放弃更改"  callBack:^(NSUInteger index, id info) {
        [self.navigationController popoverPresentationController];
    }];
    
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2,item3,item4,item5];
    }
    else
    {
        items =@[item4,item5];
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
    NSLog(@"选择值%@",fieldName);
    
    if([fieldName isEqualToString:@"UDWPTYPE"]){
        ChoiceWorkView * work;
        work = [[ChoiceWorkView alloc] initWithFrame:self.view.frame dataArray:@[@"工程内部",@"内包",@"外包"]];
        [work ShowInView:self.view];
        work.WorkBlock = ^(NSString *str) {
            [self modifyField:@"人员类型" newValue:str];
        };
    }
    if([fieldName isEqualToString:@"UDPROJECTNUM"]){
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){

            [self modifyField:@"项目编号" newValue:model.PRONUM];
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];
            [self modifyField:@"中心" newValue:model.BRANCHDESC];
            
            [self modifyField:@"机位号" newValue:@""];
            [self modifyField:@"风机型号" newValue:@""];
        };
        [self.navigationController pushViewController:choose animated:YES];
    }
    if([fieldName isEqualToString:@"UDLOCNUM"]){
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
            
            [self modifyField:@"机位号" newValue:model.LOCNUM];
        };
        choose.requestCoding = [self valueByname:@"项目编号"];
        [self.navigationController pushViewController:choose animated:YES];
    }
    if([fieldName isEqualToString:@"DJPLANNUM"]){
        RegularViewController *regular = [[RegularViewController alloc]init];
        regular.executeCellClick = ^(RegularModel *model){
            
            
             [self modifyField:@"定检计划编号" newValue:model.PLANNO];
             [self modifyField:@"定检组长" newValue:model.HEAD];
             [self modifyField:@"定检组长姓名" newValue:model.HEADNAME];
            
             [self modifyField:@"项目编号" newValue:model.PRONUM];
             [self modifyField:@"项目名称" newValue:model.PRODESC];
            
             [self modifyField:@"风机型号" newValue:model.FJNO];
             [self modifyField:@"定检计划编号" newValue:model.PLANNO];
             [self modifyField:@"定检计划编号" newValue:model.PLANNO];
             [self modifyField:@"定检计划编号" newValue:model.PLANNO];
            
             [self modifyField:@"中心" newValue:model.BRANCH];
             [self modifyField:@"中心名称" newValue:model.BRANCHDESC];
            [self modifyField:@"定检类型" newValue:model.REGULARINSPECTIONTYPE];
            [self modifyField:@"定检标准编号" newValue:model.STANDARDNUM];
            [self modifyField:@"定检标准描述" newValue:model.JPDESC];
            
            [self modifyField:@"计划开始时间" newValue:model.PLANSTARTTIME];
            
            [self modifyField:@"计划完成时间" newValue:model.PLANENDTIME];
            /**
             STANDARDNUM = WS0003;
             
           
             PLANENDTIME = 2016-02-29;
             
             PLANSTARTTIME = 2016-02-01;
           
            
             JPDESC = 1.5MW风力发电机组定检维护(年检);
             */
        };
        [self.navigationController pushViewController:regular animated:YES];
    }
    if([fieldName isEqualToString:@"LEAD"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检组长" newValue:model.PERSONID];
            [self modifyField:@"定检组长姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员1" newValue:model.PERSONID];
            [self modifyField:@"定检人员1姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY2"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员2" newValue:model.PERSONID];
            [self modifyField:@"定检人员2姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY3"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员3" newValue:model.PERSONID];
            [self modifyField:@"定检人员3姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY4"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员4" newValue:model.PERSONID];
            [self modifyField:@"定检人员4姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY5"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员5" newValue:model.PERSONID];
            [self modifyField:@"定检人员5姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDINSPOBY6"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"定检人员6" newValue:model.PERSONID];
            [self modifyField:@"定检人员6姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
}
//跳转到子表
-(void)jumpToDetial:(NSString *)name
{
    NSLog(@"跳转到子表%@",name);
}
//设置日期
-(void)setDate:(NSString *)name
{
    NSLog(@"设置日期%@",name);
    if([name isEqualToString:@"UDRLSTARTDATE"])
    {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"实际开始时间" newValue:dateString];
        };
        [dateView ShowInView:self.view];
    }
    if([name isEqualToString:@"UDRLSTOPDATE"])
    {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"实际完成时间" newValue:dateString];
        };
        [dateView ShowInView:self.view];
    }
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
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
             
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        [self modifyField:fieldName newValue:displayName];
         }
    } fail:^(NSError *error) {
        
    }];
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
        [self modifyField:@"中心描述" newValue:DESCRIPTION];
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
-(void)queryJOBPLANByJOBPLANID:(NSString*) JPNUM
{
    if(JPNUM.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDPLANSTND",
                           @"objectname":@"JOBPLAN",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"JPNUM":JPNUM}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
             
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        [self modifyField:@"定检标准描述" newValue:DESCRIPTION];
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDPLANSTND",@"ACTIONNAME":@"新建或修改定检工单"}];
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
    
    [md setValue:@"WS" forKey:@"WORKTYPE"];
    
    if (!self.Kmodel) {
        
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"WORKORDER"},
                         @{@"mboKey":@"WONUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"WORKORDER"},
                         @{@"mboKey":@"WONUM"},
                         @{@"mboKeyValue":self.Kmodel.WONUM},
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
