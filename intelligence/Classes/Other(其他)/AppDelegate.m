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
    self.window.rootViewController = [[TabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    // Required
    // notice: 3.0.0及以后版本注册可以这样写，也可以继续 旧的注册 式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册 法，改成可上报IDFA，如果没有使 IDFA直接传nil
    // 如需继续使 pushConfig.plist 件声明appKey等配置内容，请依旧使 [JPUSHService setupWithOption:launchOptions] 式初始化。
    
    [JPUSHService setupWithOption:launchOptions appKey:@"53c93662bb6246e7f9f79b9a"
                          channel:@"mywind"
                 apsForProduction:NO
            advertisingIdentifier:@"123"];
    
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    
    config.appKey = @"53c93662bb6246e7f9f79b9a";
    
    config.channel = @"mywind";
    
    [JANALYTICSService setupWithConfig:config];

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
