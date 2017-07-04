//
//  AppDelegate.m
//  intelligence
//
//  Created by chris on 16/7/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TabBarController.h"
#import "IQKeyboardManager.h"
// 引 JPush功能所需头 件
#import "JPUSHService.h"
#import "JANALYTICSService.h"
// iOS10注册APNs所需头 件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//白色
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.6
    //BaseNavigationViewController * navigationController = [[BaseNavigationViewController alloc] initWithRootViewController:[[TabBarController alloc] init]];
    
    //self.window.rootViewController = navigationController;
    self.window.rootViewController = [[TabBarController alloc] init];
    [self.window makeKeyAndVisible];
    

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {

    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    

    [JPUSHService setupWithOption:launchOptions appKey:@"53c93662bb6246e7f9f79b9a"
                          channel:@"mywind"
                 apsForProduction:NO
            advertisingIdentifier:@"123"];
    
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    
    config.appKey = @"53c93662bb6246e7f9f79b9a";
    
    config.channel = @"mywind";
    
    [JANALYTICSService setupWithConfig:config];
    
    _createDataObject = [NSMutableArray array];
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return YES;
}
@end
