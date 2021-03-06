//
//  XMTJ_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/15.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "XMTJ_ViewController.h"

@interface XMTJ_ViewController ()

@end

@implementation XMTJ_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryUDDEPTByBRANCH:self.Kmodel.BRANCH];
        [self queryDisplayNameByUserName:self.Kmodel.RESPONS FieldName:@"责任人姓名"];
    }
    [self addRightNavBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"风机子表"  callBack:^(NSUInteger index, id info) {
        
        ZB_TableViewController *vc = [[ZB_TableViewController alloc] init];
        vc.type = @"风机子表";
        vc.search =self.Kmodel.PRONUM;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"项目人员"  callBack:^(NSUInteger index, id info) {
        
        ZB_TableViewController *vc = [[ZB_TableViewController alloc] init];
        vc.type = @"项目人员";
        vc.search =self.Kmodel.PRONUM;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"项目车辆"  callBack:^(NSUInteger index, id info) {
        
        ZB_TableViewController *vc = [[ZB_TableViewController alloc] init];
        vc.type = @"项目车辆";
        vc.search =self.Kmodel.PRONUM;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        
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
        NSString * PRIMARYPHONE = info[@"PRIMARYPHONE"];
        NSString * DEPARTDESC = info[@"DEPARTDESC"];
        
        [self modifyField:fieldName newValue:displayName];
        [self modifyField:@"责任人电话" newValue:PRIMARYPHONE];
        [self modifyField:@"责任人部门" newValue:DEPARTDESC];
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
        [self modifyField:@"所属中心名称" newValue:DESCRIPTION];
         }
    } fail:^(NSError *error) {
        
    }];
}
@end
