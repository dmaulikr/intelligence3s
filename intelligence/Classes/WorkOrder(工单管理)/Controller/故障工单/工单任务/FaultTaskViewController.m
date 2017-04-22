//
//  FaultTaskViewController.m
//  intelligence
//
//  Created by chris on 16/8/16.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "FaultTaskViewController.h"
#import "StockViewCell.h"
#import "AddFaultViewController.h"
@interface FaultTaskViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation FaultTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工单任务";
    [self addNa];
    [self initTableView];
}
//na
-(void)addNa{
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(addimgClick) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 5, 30, 30);
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = leftItem;
}
//添加
-(void)addimgClick{
    AddFaultViewController *add = [[AddFaultViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}

//创建tableview
- (void)initTableView{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SEARCHWIDTH, ScreenWidth, ScreenHeight - SEARCHWIDTH) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate =self;
    [self.view addSubview:_tableview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stockcell"];
    if (!cell) {
        cell = [StockViewCell stockViewCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end
