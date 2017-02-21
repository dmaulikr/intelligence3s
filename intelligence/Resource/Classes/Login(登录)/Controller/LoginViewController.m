//
//  LoginViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userName;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passWord;
//记住密码
@property (weak, nonatomic) IBOutlet UIButton *remember;
//服务器
@property (weak, nonatomic) IBOutlet UIButton *server;
//登录
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
-(void)createUI{
    //用户名
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    UIImageView *leftuser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 25, 29)];
    leftuser.image = [UIImage imageNamed:@"image_username"];
    leftuser.contentMode = UIViewContentModeScaleAspectFit;
    [leftview addSubview:leftuser];
    self.userName.leftView = leftview;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    //密码
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    UIImageView *leftpass = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 25, 29)];
    leftpass.image = [UIImage imageNamed:@"image_password"];
    leftpass.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:leftpass];
    self.passWord.leftView = leftView;
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.secureTextEntry = YES;
    //登录
    self.login.layer.masksToBounds = YES;
    self.login.layer.cornerRadius = 5;
}

//记住密码
- (IBAction)rememberClick:(id)sender {
    self.remember.selected = !self.remember.selected;
}
//服务器
- (IBAction)serverClick:(id)sender {
}
//登录
- (IBAction)loginClick:(id)sender {
    if (self.userName.text.length == 0 ||self.passWord.text.length == 0) {
        SVHUD_HINT(@"账号密码不能为空");
        return;
    }
    NSDictionary *dic = @{
                          @"loginid":self.userName.text,
                          @"password":self.passWord.text
                          };
    
    self.task = [HTTPSessionManager postWithUrl:@"maximo/mobile/system/login" params:dic success:^(id response) {
        NSLog(@"--%@",response);
        
    } fail:^(NSError *error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
