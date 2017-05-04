//
//  MyselfViewController.m
//  intelligence
//
//  Created by chris on 2017/2/27.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "MyselfViewController.h"
#import "LoginViewController.h"
@interface MyselfViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * table;
@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人设置";
    self.table = [[UITableView alloc] initWithFrame:self.view.frame];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table setBackgroundColor:[UIColor clearColor]];
    [self.table setTableFooterView:[[UIView alloc] init]];
    [self.view addSubview:self.table];
    [self.view setBackgroundColor:RGBCOLOR(230, 230, 230)];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.table reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountModel *account = [AccountManager account];
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            cell.textLabel.text=@"姓名:";
            cell.detailTextLabel.text=account.displayName;
            
        }
        else
        {
            cell.textLabel.text=@"工号:";
            cell.detailTextLabel.text=account.userName;
        }
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            
            cell.textLabel.text=@"当前环境:";
            
            if ([BASE_URL isEqualToString:@"http://eamapp.mywind.com.cn:9080"]){
                
                cell.detailTextLabel.text=@"正式系统";
                
            }else if ([BASE_URL isEqualToString:@"http://deveamapp.mywind.com.cn:9080"]){
                
                cell.detailTextLabel.text=@"开发系统";
                
            }
            
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text=@"地址:";
            [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
            cell.detailTextLabel.text=BASE_URL;
        }
        else if (indexPath.row==2)
        {
            cell.textLabel.text=@"当前版本:";
            // app版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@（点击检查新版本)",app_Version];
        }
        else
        {
            cell.textLabel.text=@"二维码";
            cell.detailTextLabel.text=@"点击以分享本app";
        }
    }
    else
    {
        cell.textLabel.text=@"注销当前用户";
        [cell.textLabel setCenterX:self.view.centerX];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==2) {
        [self update];
    };
    
    if (indexPath.section==2&&indexPath.row==0) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"注销" message:@"注销当前用户" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self logout];
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil];
        [alert addAction:logoutAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    };
    if (indexPath.section==1&&indexPath.row==3) {
        QRCodeViewController* qrvc = [[QRCodeViewController alloc] init];
        [self presentViewController:qrvc animated:YES completion:nil];
        
    };
    
}

-(void)logout
{
    [AccountManager logOffAccount];
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:login completion:^{
        
    }];
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
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本检查" message:@"当前已是新版本" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * Cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:Cancel];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}
@end
