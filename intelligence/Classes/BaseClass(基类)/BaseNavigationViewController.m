//
//  BaseNavigationViewController.m
//  Recreation
//
//  Created by chris on 16/3/12.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

/** 视图已经加载*/
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]};
    //设置导航栏颜色
    self.navigationBar.barTintColor = RGBCOLOR(7, 62, 139);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)

        //按钮的创建和设置
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:[UIImage imageNamed:@"nav_back_pub"] forState:UIControlStateNormal
         ];
        rightButton.frame = CGRectMake(0, 0, 50, 40);
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = rightItem;
        
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back
{  
    [self popViewControllerAnimated:YES];
   // SVHUD_Stop
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
@end
