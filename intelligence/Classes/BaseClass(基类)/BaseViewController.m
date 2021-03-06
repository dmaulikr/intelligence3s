//
//  BaseViewController.m
//  Recreation
//
//  Created by chris on 16/3/14.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "QRCodeViewController.h"
#import "JANALYTICSService.h"
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPCOLOR;
    //[self setupLeftMenuButton];
}
//-(void)setupLeftMenuButton{
//    
//    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addImg setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
//    [addImg addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    addImg.frame = CGRectMake(0, 5, 30, 30);
//    
//    // leftItem设置
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
//    //导航栏上添加按钮
//    self.navigationItem.leftBarButtonItem = leftItem;
//}

#pragma mark - Button Handlers
//-(void)leftDrawerButtonPress:(id)sender{
//    NSLog(@"分享二维码");
//    QRCodeViewController* qrvc = [[QRCodeViewController alloc] init];
//    [self presentViewController:qrvc animated:YES completion:nil];
//}
- (void)dealloc
{
    [self.task cancel];
}
-(void)viewDidAppear:(BOOL)animated
{
    [JANALYTICSService startLogPageView:NSStringFromClass([self class])];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [JANALYTICSService stopLogPageView:NSStringFromClass([self class])];
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
