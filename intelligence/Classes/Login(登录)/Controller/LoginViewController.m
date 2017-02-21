//
//  LoginViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LoginViewController.h"
#import "ChoiceServerView.h"
#import "MainViewController.h"
#import "OpenUDID.h"
#import <PgyUpdate/PgyUpdateManager.h>
#import "JPUSHService.h"
@interface LoginViewController ()
{
    NSString *_serverStr;
    NSInteger _number;
}
//版本号
@property (strong, nonatomic) UILabel *verison;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textWidth1;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"5c896f805ad5482b3d290e6bcfca3c8f"];
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
        //检查更新

}
-(void)update
{
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本 %@",app_Version);
    //服务器的版本
    NSURL * url = [NSURL URLWithString:@"https://mykk.mywind.com.cn:8443/group1/M00/00/10/aaak5lcQe9mAGkAEAAACrY0gDzk311.txt"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSString * version=app_Version;
    
    if (data) {
        
        version = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"最新版本 %@",version);
    }
    
    if (app_Version.floatValue<version.floatValue) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新版本" message:@"发现新版本" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * UpdateAction = [UIAlertAction actionWithTitle:@"马上更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://mykk.mywind.com.cn:8443/group1/M00/00/10/aaak5lcQe9mAGkAEAAACrY0gDzk3.plist"]];
            
        }];
        UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:UpdateAction];
        [alert addAction:Cancel];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}
-(void)viewDidAppear:(BOOL)animated
{
        [self update];
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
    self.userName.clearButtonMode = UITextFieldViewModeAlways;
    //密码
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    UIImageView *leftpass = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 25, 29)];
    leftpass.image = [UIImage imageNamed:@"image_password"];
    leftpass.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:leftpass];
    self.passWord.leftView = leftView;
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.secureTextEntry = YES;
    self.passWord.clearsOnBeginEditing = YES;
    //登录
    self.login.layer.masksToBounds = YES;
    self.login.layer.cornerRadius = 5;
    //读取账号
    self.userName.text = [USERDEFAULT objectForKey:@"userName"];
    self.passWord.text = [USERDEFAULT objectForKey:@"password"];
    if (self.userName.text.length) {
        self.remember.selected = YES;
    }
    if (kIPhone4s) {
        self.textWidth.constant = 50;
        self.textWidth1.constant = 50;
    }else if(kIPhone5){
        self.textWidth.constant = 60;
        self.textWidth1.constant = 60;
    }
    NSString *patch = [USERDEFAULT objectForKey:@"server"];
    if ([patch isEqualToString:@"http://eamapp.mywind.com.cn:9080"]) {
        _number = 1;
        _serverStr = patch;
    }else if ([patch isEqualToString:@"http://deveamapp.mywind.com.cn:9080"]){
        _number = 2;
        _serverStr = patch;
    }else if ([patch isEqualToString:@"http://112.91.182.4:7001"]){
        _number = 3;
        _serverStr = patch;
    }else if ([patch isEqualToString:@"http://demoeamapp.mywind.com.cn"]){
        _number = 4;
        _serverStr = patch;
    }else{
        _number = 3;
        _serverStr = @"http://112.91.182.4:7001";
    }
    //存储帐号
    [USERDEFAULT setObject:_serverStr forKey:@"server"];
    self.verison.text = [NSString stringWithFormat:@"版本号%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    ;
}

-(UILabel *)verison{
    if (!_verison) {
        _verison = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 110, ScreenHeight - 45, 100, 15)];
        _verison.font = font(16);
        _verison.textColor = [UIColor whiteColor];
        _verison.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:_verison];
        [self.view bringSubviewToFront:_verison];
    }
    return _verison;
}

//记住密码
- (IBAction)rememberClick:(id)sender {
    self.remember.selected = !self.remember.selected;
}

//服务器
- (IBAction)serverClick:(id)sender {
    
    if ([BASE_URL isEqualToString:@"http://eamapp.mywind.com.cn:9080"]) {
        _number = 1;
    }else if ([BASE_URL isEqualToString:@"http://deveamapp.mywind.com.cn:9080"]){
        _number = 2;
    }else if ([BASE_URL isEqualToString:@"http://112.91.182.4:7001"]){
        _number = 3;
    }else if ([BASE_URL isEqualToString:@"http://demoeamapp.mywind.com.cn"]){
        _number = 4;
    }
    
    ChoiceServerView *choice = [[ChoiceServerView alloc]initWithFrame:self.view.bounds withNumber:_number];
    choice.serverBlock = ^(NSString *str){
        _serverStr = str;
        //存储帐号
        [USERDEFAULT setObject:_serverStr forKey:@"server"];
        
        if ([str isEqualToString:@"http://eamapp.mywind.com.cn:9080"]) {
            _number = 1;
        }else if ([str isEqualToString:@"http://deveamapp.mywind.com.cn:9080"]){
            _number = 2;
        }else if ([str isEqualToString:@"http://112.91.182.4:7001"]){
            _number = 3;
        }else if ([str isEqualToString:@"http://demoeamapp.mywind.com.cn"]){
            _number = 4;
        }
    };
    [choice ShowInView:self.view];
}
//登录
- (IBAction)loginClick:(id)sender {
    
    [JPUSHService setAlias:self.userName.text callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    
    if (self.userName.text.length == 0 ||self.passWord.text.length == 0) {
        SVHUD_HINT(@"账号密码不能为空");
        return;
    }
    NSString *openID = [OpenUDID value];
    NSDictionary *dic = @{
                          @"loginid":self.userName.text,
                          @"password":self.passWord.text,
                          @"imei":openID
                          };
    SVHUD_NO_Stop(@"正在登陆");
    self.task = [HTTPSessionManager postWithUrl:@"/maximo/mobile/system/login" params:dic success:^(id response) {
        if(KCode(@"USER-S-104")||KCode(@"USER-S-101")){
            SVHUD_Stop
            AccountModel *account = [AccountModel mj_objectWithKeyValues:response[@"result"][@"userLoginDetails"]];
            NSString *str;
            if (_number == 1) {
                str = @"正式环境";
            }else if (_number == 2){
                str = @"开发环境";
            }else if (_number == 3){
                str = @"开发环境";
            }
            account.name = str;
            [AccountManager saveAccount:account];
            if (self.remember.selected) {
                //存储帐号
                [USERDEFAULT setObject:self.userName.text forKey:@"userName"];
                [USERDEFAULT setObject:self.passWord.text forKey:@"password"];
            }else{
                [USERDEFAULT removeObjectForKey:@"userName"];
                [USERDEFAULT removeObjectForKey:@"password"];
            }

            
            MainViewController *main = [[MainViewController alloc]init];
            [self presentViewController:main animated:NO completion:nil];
        }else if (KCode(@"USER-E-100")){
            SVHUD_ERROR(@"账号密码错误");
        }else if(KCode(@"USER-E-103")){
            SVHUD_ERROR(@"不能重复登录");
        }
        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"极光推送设置标签 rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
