//
//  WTLLD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "WTLLD_ViewController.h"

@interface WTLLD_ViewController ()

@end

@implementation WTLLD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"需求提出人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.LEADER FieldName:@"支持部门领导姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.SOLVEDBY FieldName:@"问题处理人姓名"];
        
    }else{
        AccountModel *model = [AccountManager account];
        [self modifyField:@"需求提出人" newValue:model.userName];
        [self modifyField:@"状态" newValue:@"新建"];
        [self modifyField:@"需求提出人姓名" newValue:model.displayName];
         [self queryDisplayNameByUserName:model.userName FieldName:@"需求提出人姓名"];
        [self modifyField:@"提出时间" newValue:[self.dateAndTimeFormtter stringFromDate:[NSDate date]]];
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"FEEDBACKNUM" newType:@"隐藏"];
    }
    [self addRightNavBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"发送工作流"  callBack:^(NSUInteger index, id info) {
        //[weakSelf checkRequiredFieldcompeletion:^(BOOL isOk) {
        //if (isOk) {
        //[weakSelf sendData];
        //}
        //}];
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        [self saveData];
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"放弃更改"  callBack:^(NSUInteger index, id info) {
        [self.navigationController popoverPresentationController];
    }];
    
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2,item3];
    }
    else
    {
        items =@[item2,item3];
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
    //PROBLEMTYPE
    if([fieldName isEqualToString:@"PROBLEMTYPE"])
    {
        ChoiceWorkView * work;
        work = [[ChoiceWorkView alloc] initWithFrame:self.view.frame dataArray:@[@"车辆问题",@"村民阻工",@"技术支持",@"车培训",@"其它问题",@"人员",@"资料"]];
        [work ShowInView:self.view];
        work.WorkBlock = ^(NSString *str) {
            [self modifyField:@"问题类型" newValue:str];
        };
    }
    //EMERGENCY
    if([fieldName isEqualToString:@"EMERGENCY"])
    {
        ChoiceWorkView * work;
        work = [[ChoiceWorkView alloc] initWithFrame:self.view.frame dataArray:@[@"非常紧急",@"紧急",@"一般"]];
        [work ShowInView:self.view];
        work.WorkBlock = ^(NSString *str) {
            [self modifyField:@"紧急程度" newValue:str];
        };
    }
    //PRONUM
    NSLog(@"选择值%@",fieldName);
    if ([fieldName isEqualToString:@"PRONUM"]) {
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"项目编号" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目描述" newValue:model.DESCRIPTION];
            [self modifyField:@"所属中心" newValue:model.BRANCHDESC];
            [self modifyField:@"项目负责人" newValue:model.RESPONSNAME];
            [self modifyField:@"负责人电话" newValue:model.RESPONSPHONE];
            [self modifyField:@"项目阶段" newValue:model.PROSTAGE];
            
        };
        [self.navigationController pushViewController:choose animated:YES];
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
}
//发送工作流
-(void)sendData{
    if ([self.Kmodel.STATUS isEqualToString:@"已取消"]||[self.Kmodel.STATUS isEqualToString:@"已关闭"]||[self.Kmodel.STATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",self.Kmodel.STATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([self.Kmodel.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDFEEDBACK";
    popupView.mbo = @"UDFEEDBACK";
    popupView.keyValue = self.Kmodel.FEEDBACKNUM;
    popupView.key = @"FEEDBACKNUM";
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
        NSString * PRIMARYPHONE = info[@"PRIMARYPHONE"];
        NSString * DEPARTDESC = info[@"DEPARTDESC"];
        
        [self modifyField:fieldName newValue:displayName];
        
        if([fieldName isEqualToString:@"需求提出人姓名"])
        {
             [self modifyField:@"提出人电话" newValue:PRIMARYPHONE];
             [self modifyField:@"提出人部门" newValue:DEPARTDESC];
        }
        if ([fieldName isEqualToString:@"问题处理人姓名"])
        {
            [self modifyField:@"处理人联系电话" newValue:PRIMARYPHONE];
            [self modifyField:@"解决人所属部门" newValue:DEPARTDESC];
        }
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
                         @{@"mboObjectName":@"UDFEEDBACK"},
                         @{@"mboKey":@"FEEDBACKNUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDFEEDBACK"},
                         @{@"mboKey":@"FEEDBACKNUM"},
                         @{@"mboKeyValue":self.Kmodel.FEEDBACKNUM},
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
