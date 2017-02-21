//
//  BaseNavigationViewController.m
//  Recreation
//
//  Created by 光耀 on 16/3/12.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation BaseNavigationViewController

/** 视图已经加载*/
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建字典
   self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]};
    //设置导航栏颜色
    self.navigationBar.barTintColor = RGBCOLOR(7, 62, 139);
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //当栈里的控制器数量大于0的时候
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
//        viewController.hidesBottomBarWhenPushed = YES;
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
        [[NSNotificationCenter defaultCenter]postNotificationName:@"closeMMD" object:nil];
    }
    //父类push
    [super pushViewController:viewController animated:animated];
}
/** pop退出*/
- (void)back
{
    SVHUD_Stop
    NSLog(@"--%ld",self.viewControllers.count);
    if (self.viewControllers.count == 2) {
        NSLog(@"打开");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"openMMD" object:nil];
    }
#pragma mark - 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}
/** 内存警告*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
