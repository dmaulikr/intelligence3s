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

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FunctionViewController * function = [[FunctionViewController alloc]init];
    BaseNavigationViewController * navigationController1 = [[BaseNavigationViewController alloc] initWithRootViewController:function];
    
    ProcessViewController * process = [[ProcessViewController alloc]init];
    BaseNavigationViewController * navigationController2 = [[BaseNavigationViewController alloc]initWithRootViewController:process];
    
    MyselfViewController * myself = [[MyselfViewController alloc] init];
     BaseNavigationViewController * navigationController3 = [[BaseNavigationViewController alloc]initWithRootViewController:myself];
    
    self.viewControllers=@[navigationController1,navigationController2,navigationController3];
    
    NSArray *items = self.tabBar.items;
    UITabBarItem *functionItem = items[0];
    functionItem.image = [[UIImage imageNamed:@"ic_function.png"]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    functionItem.title=@"功能";
    functionItem.selectedImage = [[UIImage imageNamed:@"ic_function_down.png"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *processItem = items[1];
    processItem.image = [[UIImage imageNamed:@"ic_float.png"]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    processItem.title=@"待办事项";
    processItem.selectedImage = [[UIImage imageNamed:@"ic_float_down.png"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *myselfItem = items[2];
    myselfItem.image = [[UIImage imageNamed:@"ic_me.png"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myselfItem.title=@"个人";
    myselfItem.selectedImage = [[UIImage imageNamed:@"ic_me_down.png"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
