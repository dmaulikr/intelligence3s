//
//  TabBarController.m
//  intelligence
//
//  Created by chris on 2017/2/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "TabBarController.h"
#import "ProcessViewController.h"
#import "FunctionViewController.h"
#import "MyselfViewController.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "JANALYTICSService.h"
#import "SoapUtil.h"
#import "sys/utsname.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface TabBarController ()<CLLocationManagerDelegate>

@end

@implementation TabBarController
{
    NSArray *items;
    CLLocationManager *locationManager;
    
    NSString * longitude;
    NSString * latitude;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self deviceInfo];
    
    longitude=@"未知";
    latitude=@"未知";
    
    FunctionViewController * function = [[FunctionViewController alloc]init];
    
    BaseNavigationViewController * navigationController1 = [[BaseNavigationViewController alloc] initWithRootViewController:function];
    
    ProcessViewController * process = [[ProcessViewController alloc]init];
    
    BaseNavigationViewController * navigationController2 = [[BaseNavigationViewController alloc]initWithRootViewController:process];
    
    MyselfViewController * myself = [[MyselfViewController alloc] init];
    
     BaseNavigationViewController * navigationController3 = [[BaseNavigationViewController alloc]initWithRootViewController:myself];
    
    self.viewControllers=@[navigationController1,navigationController2,navigationController3];
    
    
    items = self.tabBar.items;
    self.tabBar.tintColor=[UIColor colorWithRed:43.0/255.0 green:90.0/255.0 blue:156.0/255.0 alpha:1];
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
    UITabBarItem *functionItem = items[0];
    functionItem.image = [[UIImage imageNamed:@"ic_function.png"]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    functionItem.title=@"功能";
    
    functionItem.selectedImage = [[UIImage imageNamed:@"ic_function_down.png"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *processItem = items[1];
    processItem.image = [[UIImage imageNamed:@"ic_float.png"]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    processItem.title=@"流程审批";
    processItem.selectedImage = [[UIImage imageNamed:@"ic_float_down.png"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //processItem.badgeColor=[UIColor colorWithRed:43.0/255.0 green:90.0/255.0 blue:156.0/255.0 alpha:1];
    processItem.badgeColor=[UIColor redColor];
    UITabBarItem *myselfItem = items[2];
    myselfItem.image = [[UIImage imageNamed:@"ic_me.png"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myselfItem.title=@"个人";
    myselfItem.selectedImage = [[UIImage imageNamed:@"ic_me_down.png"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        NSLog(@"定位可用");
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"定位" message:@"定位服务不可用，请在设置中允许EAM使用定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * comfrimAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:comfrimAction];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestNumberOfTask) name:@"MywindUpdateNumberOfTask" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAnalysisInfo:) name:@"MywindsendAnalysisInfo" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"ONLINE",@"ACTIONNAME":@"在线"}];
    });
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * location = [locations objectAtIndex:0];
   longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
   latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self requestNumberOfTask];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestNumberOfTask{
    
    AccountModel *account = [AccountManager account];
    if (account.personId.length<=0) {
        return;
    }
    
    NSDictionary *dic = @{@"ASSIGNCODE":account.personId,
                          @"ASSIGNSTATUS":@"=活动"};
    
    NSDictionary *requestDic = @{@"appid":@"WFDESIGN",
                                 @"objectname":@"WFASSIGNMENT",
                                 @"option":@"read",
                                 @"orderby":@"WFASSIGNMENTID DESC",
                                 @"condition":dic};
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    URLSessionTask *task=[HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        
        NSLog(@"response %@",response);
        
        if (response[@"result"]) {
            NSArray * array =response[@"result"];
            NSLog(@"%lu条未处理信息",(unsigned long)array.count );
            if (items.count>1) {
                UITabBarItem *processItem = items[1];
                processItem.badgeValue=[NSString stringWithFormat:@"%lu",array.count];
                if (array.count==0) {
                    processItem.badgeValue=nil;
                }
            }
            
        }
    }fail:^(NSError *error) {
        
        
    }];
    
    NSLog(@"%@",task);
}

-(void)sendAnalysisInfo:(NSNotification*)notification
{
    NSDictionary * info;
   
    NSString *actionCode =  [notification.userInfo valueForKey:@"ACTIONCODE"];
    NSString *actionName =  [notification.userInfo valueForKey:@"ACTIONNAME"];
    
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    NSString * phoneModel =  [self deviceVersion];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString * dateString = [df stringFromDate:[NSDate date]];
    AccountModel * accout = [AccountManager account];
    
    if (accout==nil) {
        return;
    }
    info = @{@"USERNAME":accout.userName,
             @"TIMESTAMP":dateString,
             
             @"LONGITUDE":longitude,
             @"LATITUDE":latitude,
             
             @"ACTIONCODE":actionCode,
             @"ACTIONNAME":actionName,
             
             @"PHPNENAME":phoneModel,
             @"OSVERSION":phoneVersion,
             @"APPVERSION":appCurVersion,
             @"REMARK":@"IOS",
             @"relationShip":relationShip};


    
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop

    };
    
    AccountModel *model = [AccountManager account];
    NSMutableDictionary* dics = [NSMutableDictionary dictionaryWithDictionary:info];
    
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:dics]},
                     @{@"flag":@"1"},
                     @{@"mboObjectName":@"ANALYSIS"},
                     @{@"mboKey":@"ANALYSISID"},
                     @{@"personId":model.personId},
                     ];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
       [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
        
    });
    
}

/**
 *  用于不同的请求 传的参数是json
 */
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
-(void)deviceInfo
{
    //设备唯一标识符
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"设备唯一标识符:%@",identifierStr);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString * phoneModel =  [self deviceVersion];
    NSLog(@"手机型号:%@",phoneModel);
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"物理尺寸:%.0f × %.0f",width,height);
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSLog(@"分辨率是:%.0f × %.0f",width*scale_screen ,height*scale_screen);
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSLog(@"运营商:%@", carrier.carrierName);
}
- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    return deviceString;
}

@end
