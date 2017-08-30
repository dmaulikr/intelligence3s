//
//  CLWX_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "CLWX_ViewController.h"
#import "OptionsMaintainModel.h"
@interface CLWX_ViewController ()

@end

@implementation CLWX_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addRightNavBarItem];
    if(self.Kmodel)
    {
        
    }else{
        AccountModel *model = [AccountManager account];
        [self modifyField:@"录入日期" newValue:[self.dateFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"录入人" newValue:model.userName];
        [self modifyField:@"录入人姓名" newValue:model.displayName];
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"MAINLOGNUM" newType:@"隐藏"];
    }
}
- (void)addRightNavBarItem{
    WEAKSELF
    
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        [self saveData];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"放弃更改"  callBack:^(NSUInteger index, id info) {
        [self.navigationController popoverPresentationController];
    }];
    
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2];
    }
    else
    {
        items =@[item1,item2];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择值
-(void)selectValue:(NSString *)fieldName
{
    NSLog(@"选择值%@",fieldName);
    if ([fieldName isEqualToString:@"LICENSENUM"])
    {
        DetailsSearchController *details = [[DetailsSearchController alloc]init];
        details.BackBlock = ^(id model){
            
            OptionsMaintainModel *options = (OptionsMaintainModel *)model;
            /*
             NUMBER3 = ;
             BRANCH = 856;
             PERSON = A01135;
             PRODESC = 大唐广西龙胜南山一期;
             BRANCHDESC = 华南工程运维中心;
             NUMBER2 = ;
             DRIVER = A02903;
             TOTALMILEAGE = 0;
             VEHICLENAME = 猎豹;
             PRONUM = S1-20110013;
             LICENSENUM = 粤TMY917;
             NUMBER1 = ;
             */
            [self modifyField:@"车牌号" newValue:options.LICENSENUM];
            [self modifyField:@"型号" newValue:options.VEHICLENAME];
            [self modifyField:@"司机" newValue:options.DRIVER];
            [self modifyField:@"责任人" newValue:options.PERSON];
            [self queryDisplayNameByUserName:options.DRIVER FieldName:@"司机姓名"];
            [self queryDisplayNameByUserName:options.PERSON FieldName:@"责任人姓名"];
            [self modifyField:@"所属项目" newValue:options.PRODESC];
            [self modifyField:@"所属中心" newValue:options.BRANCHDESC];
        };
        
        [self.navigationController pushViewController:details animated:YES];
    }
    //SERVICETYPE 事故维修、保养、正常维修
    if ([fieldName isEqualToString:@"SERVICETYPE"])
    {

            ChoiceWorkView * work;
            work = [[ChoiceWorkView alloc] initWithFrame:self.view.frame dataArray:@[@"事故维修",@"保养",@"正常维修"]];
            [work ShowInView:self.view];
            work.WorkBlock = ^(NSString *str) {
                [self modifyField:@"维修类型" newValue:str];
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
    //STARTDATE
    //ENDDATE
    if ([name isEqualToString:@"STARTDATE"]) {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"维修开始日期" newValue:dateString];
        };
        [dateView ShowInView:self.view];
    }
    if ([name isEqualToString:@"ENDDATE"]) {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            NSString * dateString = [self.dateFormtter stringFromDate:date];
            [self  modifyField:@"维修结束日期" newValue:dateString];
        };
        [dateView ShowInView:self.view];
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
        [self modifyField:fieldName newValue:displayName];
         }
    } fail:^(NSError *error) {
        
    }];
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
                         @{@"mboObjectName":@"UDCARMAINLOG"},
                         @{@"mboKey":@"MAINLOGNUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDCARMAINLOG"},
                         @{@"mboKey":@"MAINLOGNUM"},
                         @{@"mboKeyValue":self.Kmodel.MAINLOGNUM},
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
