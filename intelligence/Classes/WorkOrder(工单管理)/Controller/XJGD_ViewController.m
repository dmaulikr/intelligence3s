//
//  XJGD_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/14.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "XJGD_ViewController.h"
#import "InspectProjectController.h"

@interface XJGD_ViewController ()

@end

@implementation XJGD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    if (self.Kmodel) {
        [self queryUDINSPPLANByINSPPLANNUM:self.Kmodel.INSPPLANNUM];
        [self queryJOBPLANByJPNUM:self.Kmodel.JPNUM];
        [self queryUDDEPTByBRANCH:self.Kmodel.BRANCH];
        [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
        [self queryDisplayNameByUserName:self.Kmodel.RESBY FieldName:@"巡检负责人姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY FieldName:@"巡检人员1姓名"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY2 FieldName:@"巡检人员姓名2"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY3 FieldName:@"巡检人员姓名3"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY4 FieldName:@"巡检人员姓名4"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY5 FieldName:@"巡检人员姓名5"];
        [self queryDisplayNameByUserName:self.Kmodel.INSPOBY6 FieldName:@"巡检人员姓名6"];
    }
    [self addRightNavBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)addRightNavBarItem{
    WEAKSELF

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作流任务分配"  callBack:^(NSUInteger index, id info) {
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"巡检项目"  callBack:^(NSUInteger index, id info) {
        InspectProjectController *vc = [[InspectProjectController alloc] init];
        vc.requestCode = self.Kmodel.INSPONUM;
        vc.OK = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"不合格项目"  callBack:^(NSUInteger index, id info) {
        
            InspectProjectController *vc = [[InspectProjectController alloc] init];
            vc.requestCode = self.Kmodel.INSPONUM;
            vc.OK = @"0";
            [self.navigationController pushViewController:vc animated:YES];
      
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"发送工作流"  callBack:^(NSUInteger index, id info) {
        //[weakSelf checkRequiredFieldcompeletion:^(BOOL isOk) {
        //if (isOk) {
        //[weakSelf sendData];
        //}
        //}];
    }];
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"图片上传"  callBack:^(NSUInteger index, id info) {
        
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"";
        vc.ownerid =@"";
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    DTKDropdownItem *item5 = [DTKDropdownItem itemWithTitle:@"保存更改"  callBack:^(NSUInteger index, id info) {
        
    }];
    
    DTKDropdownItem *item6 = [DTKDropdownItem itemWithTitle:@"放弃更改"  callBack:^(NSUInteger index, id info) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    NSArray * items;
    if (self.Kmodel) {
        items =@[item0,item1,item2,item3,item4,item5,item6];
    }
    else
    {
        items =@[item5,item6];
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
-(void)queryUDINSPPLANByINSPPLANNUM:(NSString*) INSPPLANNUM
{
    if(INSPPLANNUM.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDINSPLANR",
                           @"objectname":@"UDINSPPLAN",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"INSPPLANNUM":INSPPLANNUM}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
         if ((response[@"result"])&&(response[@"result"][@"resultlist"])&&([response[@"result"][@"resultlist"] count]>0)){
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        [self modifyField:@"巡检计划描述" newValue:DESCRIPTION];
         }
    } fail:^(NSError *error) {
        
    }];
}
-(void)queryJOBPLANByJPNUM:(NSString*) JPNUM
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
        [self modifyField:@"巡检标准描述" newValue:DESCRIPTION];
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
@end
