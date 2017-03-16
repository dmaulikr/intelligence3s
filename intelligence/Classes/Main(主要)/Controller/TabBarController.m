//
//  TabBarController.m
//  intelligence
//
//  Created by chris on 2017/2/27.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "TabBarController.h"
#import "ProcessViewController.h"
#import "FunctionViewController.h"
#import "MyselfViewController.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "JANALYTICSService.h"
@interface TabBarController ()<CLLocationManagerDelegate>

@end

@implementation TabBarController
{
    NSArray *items;
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * location = [locations objectAtIndex:0];
    
    JANALYTICSLoginEvent * event = [[JANALYTICSLoginEvent alloc] init];
    
    event.success = YES;
    
    event.method = @"登陆";
    
    event.extra = @{@"经度":[NSString stringWithFormat:@"%f",location.coordinate.longitude], @"纬度":[NSString stringWithFormat:@"%f",location.coordinate.latitude]};
    
    [JANALYTICSService eventRecord:event];
    
    NSLog(@"经度 %@",[NSString stringWithFormat:@"%f",location.coordinate.longitude]);
    NSLog(@"纬度 %@",[NSString stringWithFormat:@"%f",location.coordinate.latitude]);
    
    [locationManager stopUpdatingHeading];
    
    locationManager.delegate=nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self requestNumberOfTask];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondsToSelector:) name:@"MywindUpdateNumberOfTask" object:nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
