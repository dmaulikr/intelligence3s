//
//  MainViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "MainViewController.h"
#import "ProcessViewController.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import <PgyUpdate/PgyUpdateManager.h>

@interface MainViewController ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMMD) name:@"closeMMD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openMMD) name:@"openMMD" object:nil];
    //流程审批
    ProcessViewController *process = [[ProcessViewController alloc]init];
    BaseNavigationViewController * navigationController = [[BaseNavigationViewController alloc]initWithRootViewController:process];
    //侧拉菜单
    LeftViewController *left = [[LeftViewController alloc]init];
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:left];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:LEFTWIDTH];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];

    [self.view addSubview: self.drawerController.view];
    //[[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"5c896f805ad5482b3d290e6bcfca3c8f"];
    //[[PgyUpdateManager sharedPgyManager] checkUpdate];
    //检查更新
    [self update];
}
-(void)update
{
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本 %@",app_Version);
    //服务器的版本
    NSURL * url = [NSURL URLWithString:@"https://mykk.mywind.com.cn:8443/group1/M00/00/10/aaak5lcQe9mAGkAEAAACrY0gDzk311.txt"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSString * version=app_Version;
    
    if (data) {
        
        version = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"最新版本 %@",version);
    }
    
    if (app_Version.floatValue<version.floatValue) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新版本" message:@"发现新版本" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * UpdateAction = [UIAlertAction actionWithTitle:@"马上更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://mykk.mywind.com.cn:8443/group1/M00/00/10/aaak5lcQe9mAGkAEAAACrY0gDzk3.plist"]];
            
        }];
        UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:UpdateAction];
        [alert addAction:Cancel];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}
-(void)closeMMD{
    SVHUD_Stop
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
-(void)openMMD{
    SVHUD_Stop
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
