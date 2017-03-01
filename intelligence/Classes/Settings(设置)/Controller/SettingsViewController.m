//
//  SettingsViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginController.h"
#import "AppDelegate.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface SettingsViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentMemoryLabel;
@property (weak, nonatomic) IBOutlet UIView *clearMemoryView;

@property (weak, nonatomic) IBOutlet UIView *bottleView;

@property (nonatomic, copy) NSString *filePathStr;

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self settingViewsLayer];
    self.filePathStr = [kFilePath stringByAppendingPathComponent:@"default"];
    self.currentMemoryLabel.text  = [self getCacheSizeWithFilePath:self.filePathStr];
    [self addTapAction];
}

- (void)settingViewsLayer{
    [self.view layoutIfNeeded];
    self.bottleView.layer.masksToBounds = YES;
    self.bottleView.layer.cornerRadius = 6.0;
    self.bottleView.layer.borderWidth = 1.0;
    self.bottleView.layer.borderColor = UIColorFromRGB(0xE6E6E6).CGColor;
    
    self.logoutBtn.layer.masksToBounds = YES;
    self.logoutBtn.layer.cornerRadius = 6.0;
}

- (void)addTapAction{
    UITapGestureRecognizer *clearMemoryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearMemoryViewTap:)];
    [self.clearMemoryView addGestureRecognizer:clearMemoryTap];
    

}

- (void)clearMemoryViewTap:(UIGestureRecognizer *)tap{
    if ([_currentMemoryLabel.text isEqualToString:@"0.00B"]) {
        HUDNormal(@"已经很干净了");
        return;
    }
    //点击回调
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确认清除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

- (IBAction)logoutClick:(id)sender {
    [AccountManager logOffAccount];
    LoginController *vc = [[LoginController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)logOutViewTap:(UIGestureRecognizer *)tap{
    [AccountManager logOffAccount];
    LoginController *vc = [[LoginController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
//    AppDelegate *appDelegate =  (AppDelegate *) [UIApplication sharedApplication].delegate;
//    [appDelegate.window.rootViewController.view removeFromSuperview];
//    appDelegate.window.rootViewController = vc;
//
//    LoginViewController *login = [[LoginViewController alloc]init];
//    AppDelegate *appDelegate =  (AppDelegate *) [UIApplication sharedApplication].delegate;
//    appDelegate.window.rootViewController = login;
  
}

#pragma mark - alertView点击回调
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 点击第二个
    if (buttonIndex ==1) {
        BOOL isClearSuccess = [self clearCacheWithFilePath:self.filePathStr];
        if (isClearSuccess) {
            NSLog(@"清除成功");
            NSString *cacheSize = [self getCacheSizeWithFilePath:self.filePathStr];
            //设置当前缓
            self.currentMemoryLabel.text = cacheSize;
            HUDNormal(@"清除成功");
        }else{
            NSLog(@"清除失败");
            HUDNormal(@"清除失败");
        }
    }
}

#pragma mark - 获取path路径下文件夹大小
- (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return totleStr;
}


#pragma mark - 清除path文件夹下缓存大小
- (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"%@",error);
            return NO;
        }
    }
    return YES;
}

- (IBAction)versionUpdateTap:(id)sender {
    HUDNormal(@"版本已经是最新了")
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
