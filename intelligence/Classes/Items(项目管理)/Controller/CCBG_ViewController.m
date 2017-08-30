//
//  CCBG_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "CCBG_ViewController.h"

@interface CCBG_ViewController ()

@end

@implementation CCBG_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryDisplayNameByUserName:self.Kmodel.ACOUNT FieldName:@"出差人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.DEPTLEADER FieldName:@"部门领导姓名"];
        [self queryProjectNameByProjectNum:self.Kmodel.PROJECT];
    }else{
        AccountModel *model = [AccountManager account];
        [self modifyField:@"状态" newValue:@"新建"];
        [self modifyField:@"创建日期" newValue:[self.dateFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"创建人" newValue:model.userName];
        [self modifyField:@"创建人姓名" newValue:model.displayName];
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"SERIALNUMBER" newType:@"隐藏"];
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
    //ACOUNT
    if([fieldName isEqualToString:@"ACOUNT"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"出差人" newValue:model.PERSONID];
            [self modifyField:@"出差人姓名" newValue:model.DISPLAYNAME];
             [self modifyField:@"所属部门" newValue:model.DEPARTMENT];
             [self modifyField:@"所属部门名称" newValue:model.DEPARTDESC];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    //DEPTLEADER
    if([fieldName isEqualToString:@"DEPTLEADER"])
    {
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            
            [self modifyField:@"部门领导" newValue:model.PERSONID];
            [self modifyField:@"部门领导姓名" newValue:model.DISPLAYNAME];
            
        };
        [self.navigationController pushViewController:daily animated:YES];
    }
    //PROJECT
    if([fieldName isEqualToString:@"PROJECT"]){
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"出差项目" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];

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
    //TRIPDATE
    if([name isEqualToString:@"TRIPDATE"])
    {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"出差日期" newValue:dateString];
        };
        [dateView ShowInView:self.view];
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
        
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        NSString * DEPARTMENT = info[@"DEPARTMENT"];
        [self modifyField:fieldName newValue:displayName];
        [self modifyField:@"所属部门" newValue:DEPARTMENT];
        [self queryUDDEPTByBRANCH:DEPARTMENT];
         }
    } fail:^(NSError *error) {;
        
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
        [self modifyField:@"所属部门名称" newValue:DESCRIPTION];
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
//UDDEPT
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
                         @{@"mboObjectName":@"UDTRIPREPORT"},
                         @{@"mboKey":@"SERIALNUMBER"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDTRIPREPORT"},
                         @{@"mboKey":@"SERIALNUMBER"},
                         @{@"mboKeyValue":self.Kmodel.SERIALNUMBER},
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
