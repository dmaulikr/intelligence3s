//
//  WebViewController.m
//  intelligence
//
//  Created by chris on 2016/12/30.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *wview=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"地址 %@",self.urlString);
    
    [wview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    wview.delegate=self;
    [self.view addSubview:wview];
    
    UIScrollView *tempView = (UIScrollView *)[wview.subviews objectAtIndex:0];
    tempView.scrollEnabled = YES;
    [wview setScalesPageToFit:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    [webView stringByEvaluatingJavaScriptFromString:@"var element = document.createElement('meta');  element.name = \"viewport\";  element.content = \"width=device-width,initial-scale=1.0,minimum-scale=0.5,maximum-scale=3,user-scalable=1\"; var head = document.getElementsByTagName('head')[0]; head.appendChild(element);"];
    
    [self setTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    
    NSString * urlString =webView.request.URL.absoluteString;
    
    if ([urlString containsString:@"login"]) {
        NSLog(@"登录页面");
        
        NSString * username = [USERDEFAULT objectForKey:@"userName"];
        NSString * password = [USERDEFAULT objectForKey:@"password"];
        
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById(\"username\").value=\"%@\"",username]];
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById(\"password\").value=\"%@\"",password]];
        //document.getElementById("loginbutton").click()
         [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"loginbutton\").click()"];
    }
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}
@end
