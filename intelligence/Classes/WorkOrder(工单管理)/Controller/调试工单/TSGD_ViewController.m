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
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"调试工单子表" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        TableViewController * table  = [[TableViewController alloc] init];
        table.type=@"调试工单子表";
        table.search = self.Kmodel.DEBUGWORKORDERNUM;
        
        [self.navigationController pushViewController:table animated:YES];
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工作流任务分配" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=self.Kmodel.DEBUGWORKORDERID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2,item3] icon:@"more"];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
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
        
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        [self modifyField:fieldName newValue:displayName];
        
    } fail:^(NSError *error) {
        
    }];
}
@end
