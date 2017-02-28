//
//  MyselfViewController.m
//  intelligence
//
//  Created by chris on 2017/2/27.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "MyselfViewController.h"

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
            return 3;
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
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            cell.textLabel.text=@"姓名:";
            cell.detailTextLabel.text=@"陈志北";
            
        }
        else
        {
            cell.textLabel.text=@"工号:";
            cell.detailTextLabel.text=@"chenzb";
        }
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"当前环境:";
            cell.detailTextLabel.text=@"开发系统";
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text=@"地址:";
            cell.detailTextLabel.text=@"http://deveam.mywind.com.cn:9080";
        }
        else
        {
            cell.textLabel.text=@"当前版本:";
            cell.detailTextLabel.text=@"2.5（点击检查新版本)";
        }
    }
    else
    {
        cell.textLabel.text=@"注销当前用户";
    }
    
    return cell;
}

@end
