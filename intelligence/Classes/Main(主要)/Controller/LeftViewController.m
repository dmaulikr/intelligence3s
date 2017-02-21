//
//  LeftViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftHeaderView.h"
#import "LeftViewCell.h"
#import "MMDrawerController.h"
#import "AppOpsViewController.h"
#import "ItemsViewController.h"
#import "ProcessViewController.h"
#import "ResourcesViewController.h"
#import "SettingsViewController.h"
#import "StockViewControllers.h"
#import "WorkOrderViewController.h"
#define HeaderHeight 185
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic, strong) LeftHeaderView *header;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeader];
    [self createUItableView];
    // Do any additional setup after loading the view from its nib.
}
//创建header
-(void)addHeader{
    self.header = [LeftHeaderView leftHeaderView];
    self.header.frame = CGRectMake(0, 0, LEFTWIDTH, HeaderHeight);
    [self.view addSubview:self.header];
//    [header mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.left.equalTo(self.view.mas_left);
//        make.width.mas_equalTo(LEFTWIDTH);
//    }];
    AccountModel *account = [AccountManager account];
    self.header.name.text = account.displayName; 
    self.header.huan.text = account.name;
}
/** 创表*/
- (void)createUItableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HeaderHeight, LEFTWIDTH, ScreenHeight- HeaderHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.header.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.width.mas_equalTo(LEFTWIDTH);
        }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataArray = @[
                   @{@"title":@"流程审批",@"icon":@"ic_approval"},
                   @{@"title":@"工单管理",@"icon":@"ic_work"},
                   @{@"title":@"库存盘点",@"icon":@"ic_udstock"},
                   @{@"title":@"项目管理",@"icon":@"ic_project"},
                   @{@"title":@"运维管理",@"icon":@"ic_operations"},
                   @{@"title":@"资源管理",@"icon":@"ic_resources"},
                   @{@"title":@"设置",@"icon":@"ic_setting"},
                   ];
}
/** tableView系统方法*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
/** 有多少个分区*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/** tableView系统方法*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [LeftViewCell leftViewCell];
    }
    cell.data = _dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *view;
    if (indexPath.row == 0) {
        ProcessViewController *process = [[ProcessViewController alloc]init];
        view = process;
    }else if (indexPath.row == 1){
        WorkOrderViewController *work = [[WorkOrderViewController alloc]init];
        view = work;
    }else if (indexPath.row == 2){
        StockViewControllers *stock = [[StockViewControllers alloc]init];
        view = stock;
    }else if (indexPath.row == 3){
        ItemsViewController * items = [[ItemsViewController alloc]init];
        view = items;
    }else if (indexPath.row == 4){
        AppOpsViewController * appops = [[AppOpsViewController alloc]init];
        view = appops;
    }else if (indexPath.row == 5){
        ResourcesViewController * resources = [[ResourcesViewController alloc]init];
        view = resources;
    }else if (indexPath.row == 6){
        SettingsViewController * settings = [[SettingsViewController alloc]init];
        view = settings;
    }
    BaseNavigationViewController * nav = [[BaseNavigationViewController alloc] initWithRootViewController:view];
    [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
