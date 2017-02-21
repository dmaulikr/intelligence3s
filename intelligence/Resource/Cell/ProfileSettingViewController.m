//
//  ProfileSettingViewController.m
//  WeiGou
//
//  Created by noarter02 on 15-3-12.
//  Copyright (c) 2015年 yike. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "PersonalSettingCell.h"
#import "HeaderAllCell.h"
#import "SoapUtil.h"
@interface ProfileSettingViewController ()
@end

@implementation ProfileSettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = APPCOLOR;
     UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];

    _allGroups = [NSMutableArray array];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PersonalSettingGroup *group = _allGroups[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    // 1.创建一个ILSettingCell
    PersonalSettingCell *cell = [PersonalSettingCell settingCellWithTableView:tableView];
    cell.updata = ^(NSString *str){
        PersonalSettingGroup *group = _allGroups[indexPath.section];
        PersonalSettingItem *item = group.items[indexPath.row];
        item.content = str;
        [weakSelf.tableView reloadData];
    };
    cell.updataSelect = ^(NSString *str){
        PersonalSettingGroup *group = _allGroups[indexPath.section];
        PersonalSettingItem *item = group.items[indexPath.row];
        item.content = str;
        [weakSelf.tableView reloadData];
    };
    // 2.取出这行对应的模型（ILSettingItem）
    PersonalSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}
#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    PersonalSettingGroup *group = _allGroups[indexPath.section];
    PersonalSettingItem *item = group.items[indexPath.row];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalSettingGroup *group = _allGroups[indexPath.section];
    PersonalSettingItem *item = group.items[indexPath.row];
    return item.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PersonalSettingGroup *group = _allGroups[section];
    HeaderAllCell *header =[HeaderAllCell headerAllCell];
    header.name.text = group.header;
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CELLHEIGHT - 5;
}
-(void)checkWFPRequiredWithAppId:(NSString*)appId objectName:(NSString*)objectName status:(NSString*)status compeletion:(void(^)(NSArray *fields))compeletion
{
    if(appId.length<=0||objectName.length<=0||status.length<=0)
    {
        compeletion(nil);
        return;
    }
    NSLog(@"查询必填字段");
    
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    
    soap.DicBlock = ^(NSDictionary *dic)
    {
        if (dic==nil) {
            SVHUD_Normal(@"查询必填字段失败");
            return ;
        }
        else
        {
            NSLog(@"dic :%@",dic);
            NSString * fieldsString = dic[@"checkMsg"];
            NSArray * array=[fieldsString componentsSeparatedByString:@","];
            
            if (compeletion) {
                
                compeletion(array);
            }
            
        }
        
    };
    
    [soap requestMethods:@"mobileservicecheckWFPRequired" withDate:@[@{@"appId":appId},@{@"objectName":objectName},@{@"wfpStatus":status}]];
    
}
@end

