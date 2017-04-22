//
//  BasePushViewController.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BasePushViewController.h"
#import "SoapUtil.h"
#import "JANALYTICSService.h"
@interface BasePushViewController ()

@end

@implementation BasePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 控制器取消的时候调用*/
- (void)dealloc
{
    [self.task cancel];
}
/** 视图将要消失*/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //结束编辑
    [self.view endEditing:YES];
    SVHUD_Stop
}

-(void)checkWFPRequiredWithAppId:(NSString*)appId objectName:(NSString*)objectName status:(NSString*)status compeletion:(void(^)(NSArray *fields))compeletion
{
    if(appId.length<=0||objectName.length<=0||status.length<=0)
    {
        return;
    }
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic)
    {
        if (dic==nil) {
            SVHUD_Normal(@"查询必填字段失败");
            return ;
        }
        else
        {
            NSLog(@"dic :%@",dic);
            NSString * fieldsString = dic[@"checkMsg"];
            NSArray * array=[fieldsString componentsSeparatedByString:@","];
            
            if (compeletion) {
                
                compeletion(array);
            }
        }
        
    };
    
    [soap requestMethods:@"mobileservicecheckWFPRequired" withDate:@[@{@"appId":appId},@{@"objectName":objectName},@{@"wfpStatus":status}]];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [JANALYTICSService startLogPageView:NSStringFromClass([self class])];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [JANALYTICSService stopLogPageView:NSStringFromClass([self class])];
}
@end
