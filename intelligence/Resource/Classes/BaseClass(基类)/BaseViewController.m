//
//  BaseViewController.m
//  Recreation
//
//  Created by 光耀 on 16/3/14.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/** 控制器取消的时候调用*/
- (void)dealloc
{
    [self.task cancel];
    NSLog(@"%@->控制器释放了",[self class]);
}
/** 视图将要消失*/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //结束编辑
    [self.view endEditing:YES];
}


@end
