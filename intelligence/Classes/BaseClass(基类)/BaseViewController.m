//
//  BaseViewController.m
//  Recreation
//
//  Created by 光耀 on 16/3/14.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "QRCodeViewController.h"
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPCOLOR;
    [self setupLeftMenuButton];
    // Do any additional setup after loading the view.
}
-(void)setupLeftMenuButton{
    
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 5, 30, 30);
    
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    NSLog(@"分享二维码");
    QRCodeViewController* qrvc = [[QRCodeViewController alloc] init];
    [self presentViewController:qrvc animated:YES completion:nil];
    //SVHUD_Stop
    //[self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


/** 控制器取消的时候调用*/
- (void)dealloc
{
    [self.task cancel];
}
/** 视图将要消失*/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //结束编辑
    [self.view endEditing:YES];
    SVHUD_Stop
}


@end
