//
//  LedgerDetailsController.m
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LedgerDetailsController.h"
#import "DTKDropdownMenuView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "ProcessDetailsCell.h"

#import "FanTypeViewController.h"
#import "ProjectPersonViewController.h"
#import "ProjectCarsViewController.h"
#import "ChoiceWorkView.h"


@interface LedgerDetailsController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LedgerDetailsController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"台账详情";
    [self.view addSubview:self.tableView];
    [self addRightNavBarItem];
}

- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"风机型号" iconName:@"ic_udfandetails" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"项目人员" iconName:@"ic_person" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"项目车辆" iconName:@"ic_udvehicle" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];

    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)pushWithIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            FanTypeViewController *vc = [[FanTypeViewController alloc] init];
            vc.requestCode = self.ledger.PRONUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            ProjectPersonViewController *vc = [[ProjectPersonViewController alloc] init];
            vc.requestCode = self.ledger.PRONUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{
            ProjectCarsViewController *vc = [[ProjectCarsViewController alloc] init];
            vc.requestCode = self.ledger.PRONUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProcessDetailsCell *cell = [ProcessDetailsCell cellWithTableView:tableView];
    _ledger.leftLabelWight = 120;
    _ledger.index = indexPath.section;
    cell.ledger = _ledger;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    _ledger.index = indexPath.section;
    CGFloat cellHeight = [self.tableView cellHeightForIndexPath:indexPath model:_ledger keyPath:@"ledger" cellClass:[ProcessDetailsCell class] contentViewWidth:[self cellContentViewWith]];
    return cellHeight;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
