//
//  ZYSGD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "ZYSGD_ViewController.h"

@interface ZYSGD_ViewController ()

@end

@implementation ZYSGD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryProjectNameByProjectNum:self.Kmodel.UDPROJECTNUM];
        [self queryDisplayNameByUserName:self.Kmodel.LEAD FieldName:@"终验收负责人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.LEAD FieldName:@"项目负责人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人姓名"];
    }
    else
    {
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"WONUM" newType:@"隐藏"];
        AccountModel *model = [AccountManager account];
        [self modifyField:@"状态" newValue:@"新建"];
        [self modifyField:@"创建时间" newValue:[self.dateAndTimeFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"创建人" newValue:model.userName];
        [self modifyField:@"创建人姓名" newValue:model.displayName];
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
        vc.type = @"终验收工单任务";
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
    //UDPROJECTNUM
    if([fieldName isEqualToString:@"UDPROJECTNUM"]){
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"项目编号" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];
            [self modifyField:@"中心" newValue:model.BRANCHDESC];
            [self modifyField:@"机位号" newValue:@""];
            [self modifyField:@"项目负责人" newValue:model.RESPONS];
            [self modifyField:@"项目负责人姓名" newValue:model.RESPONSNAME];
            [self modifyField:@"终验收负责人" newValue:model.RESPONS];
            [self modifyField:@"终验收负责人姓名" newValue:model.RESPONSNAME];
        };
        [self.navigationController pushViewController:choose animated:YES];
    }
    //UDLOCNUM
    if([fieldName isEqualToString:@"UDLOCNUM"]){
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.executeCellClick = ^(FlightNoModel *model){
    
            [self modifyField:@"机位号" newValue:model.LOCNUM];
        };
        choose.requestCoding = [self valueByname:@"项目编号"];
        [self.navigationController pushViewController:choose animated:YES];
    }
    //LEAD
    if([fieldName isEqualToString:@"LEAD"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"项目负责人" newValue:model.PERSONID];
            [self modifyField:@"项目负责人姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    //UDPRORES
    if([fieldName isEqualToString:@"UDPRORES"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"终验收负责人" newValue:model.PERSONID];
            [self modifyField:@"终验收负责人姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    if([fieldName isEqualToString:@"UDWPTYPE"])
    {
        ChoiceWorkView * work;
        work = [[ChoiceWorkView alloc] initWithFrame:self.view.frame dataArray:@[@"工程内部",@"内包",@"外包"]];
        [work ShowInView:self.view];
        work.WorkBlock = ^(NSString *str) {
            [self modifyField:@"人员类型" newValue:str];
        };
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
    //UDRLSTARTDATE
    if([name isEqualToString:@"UDRLSTARTDATE"])
    {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"实际开始时间" newValue:dateString];
        };
        [dateView ShowInView:self.view];
    }
    //UDRLSTOPDATE
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDPLANSTND",@"ACTIONNAME":@"新建或修改终验收工单"}];
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
    
    [md setValue:@"AA" forKey:@"WORKTYPE"];
    
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
