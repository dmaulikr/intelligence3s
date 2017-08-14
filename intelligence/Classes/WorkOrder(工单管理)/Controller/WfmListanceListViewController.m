//
//  WfmListanceListViewController.m
//  intelligence
//
//  Created by chris on 2017/5/26.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "WfmListanceListViewController.h"
#import "WfmListanceTableViewCell.h"
#import "ProcessModel.h"
@interface WfmListanceListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(atomic,strong)UITableView*table;
@end

@implementation WfmListanceListViewController
{
    NSMutableArray *datas;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.table=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.view addSubview:self.table];
    self.title=@"工作流任务分配";
    datas=[NSMutableArray array];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)requestData
{
    
    NSDictionary *dic = @{@"OWNERID":self.OWNERID,
                          @"ASSIGNSTATUS":@"=活动"};
    
    NSDictionary *requestDic = @{@"appid":@"WFDESIGN",
                                 @"objectname":@"WFASSIGNMENT",
                                 @"curpage":@(0),
                                 @"showcount":@(20),
                                 @"option":@"read",
                                 @"orderby":@"WFASSIGNMENTID DESC",
                                 @"condition":dic};
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
       
    
        NSArray *array = [ProcessModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"resultlist"]];
        
        for (ProcessModel * one in array) {
            NSLog(@"流程审批 %@",[one mj_keyValues]);
        }
        
        [datas addObjectsFromArray:array];
        
        [self.table reloadData];

    } fail:^(NSError *error) {

    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WfmListanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WfmListanceTableViewCellIdentifier"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WfmListanceTableViewCell" owner:tableView options:nil] firstObject];
    }
    ProcessModel * model = [datas objectAtIndex:indexPath.row];
    [cell.username setText:model.ASSIGNCODE];
    [cell.displayname setText:@""];
    [cell.descriptionLabel setText:model.DESCRIPTION];
    [cell.process setText:model.PROCESSNAME];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165.0;
}
@end
