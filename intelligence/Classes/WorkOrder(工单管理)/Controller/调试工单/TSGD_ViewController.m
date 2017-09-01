//
//  TSGD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/12.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "TSGD_ViewController.h"
#import "TableViewController.h"
@interface TSGD_ViewController ()

@end

@implementation TSGD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel)
    {
        [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人姓名"];
        [self addRightNavBarItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作流任务分配"  callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=self.Kmodel.DEBUGWORKORDERID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"调试工单子表"  callBack:^(NSUInteger index, id info) {
        ZB_TableViewController * table  = [[ZB_TableViewController alloc] init];
        table.type=@"调试工单子表";
        table.search = self.Kmodel.DEBUGWORKORDERNUM;
        [self.navigationController pushViewController:table animated:YES];
        
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"发送工作流"  callBack:^(NSUInteger index, id info) {
        
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
    }];

    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"保存修改"  callBack:^(NSUInteger index, id info) {

    }];
    DTKDropdownItem *item5 = [DTKDropdownItem itemWithTitle:@"放弃修改"  callBack:^(NSUInteger index, id info) {

        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2,item3,item4,item5] icon:@"more"];
    
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
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        NSString * RESPONS =  info[@"RESPONS"];
        NSString * RESPONSNAME = info[@"RESPONSNAME"];
        NSString * OWNER = info[@"OWNER"];
        NSString * CAPACITY = info[@"CAPACITY"];
        NSString *PROSTAGE = info[@"PROSTAGE"];
        
        [self modifyField:@"项目名称" newValue:DESCRIPTION];
        [self modifyField:@"项目责任人" newValue:RESPONS];
        [self modifyField:@"项目责任人姓名" newValue:RESPONSNAME];
        [self modifyField:@"业主单位" newValue:OWNER];
        [self modifyField:@"项目阶段" newValue:PROSTAGE];
        [self modifyField:@"总容量（MW）" newValue:CAPACITY];
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
    
    [md setValue:@"FR" forKey:@"WORKTYPE"];
    
    if (!self.Kmodel) {
        
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"DEBUGWORKORDER"},
                         @{@"mboKey":@"DEBUGWORKORDERNUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"DEBUGWORKORDER"},
                         @{@"mboKey":@"DEBUGWORKORDERNUM"},
                         @{@"mboKeyValue":self.Kmodel.DEBUGWORKORDERNUM},
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
