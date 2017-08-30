//
//  ZLNavigationController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15/11/25.
//  Copyright © 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLNavigationController.h"

@interface ZLNavigationController ()

@end

@implementation ZLNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = kNavigationBarBGColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]};
//    //创建字典
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
