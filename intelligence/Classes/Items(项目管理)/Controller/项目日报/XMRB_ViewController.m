//
//  XMRB_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "XMRB_ViewController.h"

@interface XMRB_ViewController ()

@end

@implementation XMRB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
        [self queryDisplayNameByUserName:self.Kmodel.CONTRACTS FieldName:@"现场联系人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.CHANGEBY FieldName:@"修改人"];
    }else{
        AccountModel *model = [AccountManager account];
        [self modifyField:@"修改日期" newValue:[self.dateAndTimeFormtter stringFromDate:[NSDate date]]];
        [self modifyField:@"修改人" newValue:model.displayName];
        
        [self modifyTypeByFieldName:@"DESCRIPTION" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"PRORUNLOGNUM" newType:@"隐藏"];
    }
    [self addRightNavBarItem];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"土建阶段日报"  callBack:^(NSUInteger index, id info) {
        ZB_TableViewController* vc = [[ZB_TableViewController alloc] init];
        vc.type = @"土建阶段日报";
        vc.search = self.Kmodel.PRORUNLOGNUM;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"吊装调试日报"  callBack:^(NSUInteger index, id info) {
        ZB_TableViewController* vc = [[ZB_TableViewController alloc] init];
        vc.type = @"吊装调试日报";
        vc.search = self.Kmodel.PRORUNLOGNUM;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"工作日报"  callBack:^(NSUInteger index, id info) {
        ZB_TableViewController* vc = [[ZB_TableViewController alloc] init];
        vc.type = @"工作日报";
        vc.search = self.Kmodel.PRORUNLOGNUM;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工装管理"  callBack:^(NSUInteger index, id info) {
        ZB_TableViewController* vc = [[ZB_TableViewController alloc] init];
        vc.type = @"工装管理";
        vc.search = self.Kmodel.PRORUNLOGNUM;
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
    if ([fieldName isEqualToString:@"PRONUM"]) {
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            //项目编号
            NSLog(@"%@",model.PRONUM);
            [self modifyField:@"项目编号" newValue:model.PRONUM];
            //项目描述
            NSLog(@"%@",model.DESCRIPTION);
            [self modifyField:@"项目名称" newValue:model.DESCRIPTION];
            [self modifyField:@"所属中心" newValue:model.BRANCHDESC];
            [self modifyField:@"现场负责人" newValue:model.RESPONS];
            [self modifyField:@"现场负责人姓名" newValue:model.RESPONSNAME];
            [self modifyField:@"现场联系人" newValue:model.RESPONS];
            [self modifyField:@"现场联系人姓名" newValue:model.RESPONSNAME];
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
    if ([name isEqualToString:@"YEAR"]||[name isEqualToString:@"MONTH"]) {
        ChoicDateView * dateView = [[ChoicDateView alloc] initWithFrame:self.view.frame datePickerMode:UIDatePickerModeDate];
        dateView.dateBlock = ^(NSDate *date) {
            
            NSDateFormatter * yF = [[NSDateFormatter alloc] init];
            [yF setDateFormat:@"YYYY"];
            NSDateFormatter * mF = [[NSDateFormatter alloc] init];
            [mF setDateFormat:@"MM"];
            
            [self  modifyField:@"年" newValue:[yF stringFromDate:date]];
            [self  modifyField:@"月" newValue:[mF stringFromDate:date]];
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
                         @{@"mboObjectName":@"UDPRORUNLOG"},
                         @{@"mboKey":@"PRORUNLOGNUM"},
                         @{@"personId":model.personId},
                         ];
        
        [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    }
    else
    {
        NSArray *arr = @[
                         @{@"json":[self dictionaryToJson:md]},
                         @{@"flag":@"1"},
                         @{@"mboObjectName":@"UDPRORUNLOG"},
                         @{@"mboKey":@"PRORUNLOGNUM"},
                         @{@"mboKeyValue":self.Kmodel.PRORUNLOGNUM},
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
