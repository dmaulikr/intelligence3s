//
//  CustomSearchViewController.m
//  剧能玩2.1
//
//  Created by 大兵布莱恩特  on 15/11/11.
//  Copyright © 2015年 大兵布莱恩特 . All rights reserved.
//

#import "CustomSearchViewController.h"

@interface CustomSearchViewController ()
@property (nonatomic,strong) UIView *navBar;

@end

@implementation CustomSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    
}
-  (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIView*)navBar
{
    if (!_navBar) {
        _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navBar.backgroundColor = RGBCOLOR(7, 62, 139);
        // 标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, ScreenWidth-160, 25)];
        label.textColor = [UIColor whiteColor];
        label.font      = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.text      = _titleStr;
        [_navBar addSubview:label];
        // 返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn setFrame:CGRectMake(20, 25, 40, 30)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_navBar addSubview:backBtn];
    }
    
    return _navBar;
}
- (void)back
{
    __weak typeof(self)weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:nil];
        self.searchBar.text = @"";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([weakSelf.delegateCustom respondsToSelector:@selector(searchControllerBackButtonClick:)]) {
                [weakSelf.delegateCustom searchControllerBackButtonClick:weakSelf];
            }
        });
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


@end
