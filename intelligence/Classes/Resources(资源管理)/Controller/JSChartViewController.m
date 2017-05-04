//
//  JSChartViewController.m
//  intelligence
//
//  Created by chris on 2017/1/23.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "JSChartViewController.h"

@interface JSChartViewController ()

@end

@implementation JSChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view setBackgroundColor:[UIColor blackColor]];
    self.webView=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.117.37/chartsPage.html"]]];
    [self setReloadButton];
    self.title=@"库存余量";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setReloadButton{
    
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addImg setTitle:@"刷新" forState:UIControlStateNormal];
    
    [addImg addTarget:self action:@selector(ReloadWebView) forControlEvents:UIControlEventTouchUpInside];
    
    addImg.frame = CGRectMake(0, 5, 80, 30);
    
    // leftItem设置
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)ReloadWebView
{
    [self.webView reload];
}

@end
