//
//  AddTaskXViewController.m
//  intelligence
//
//  Created by chris on 16/8/17.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddTaskXViewController.h"
#import "SoapUtil.h"
#import "FooterView.h"
@interface AddTaskXViewController ()
//任务号
@property (nonatomic,strong)PersonalSettingItem *LL1;
//工作任务
@property (nonatomic,strong)PersonalSettingItem *LT2;
//负责人
@property (nonatomic,strong)PersonalSettingItem *LLI3;
//开始时间
@property (nonatomic,strong)PersonalSettingItem *LLI4;
//结束时间
@property (nonatomic,strong)PersonalSettingItem *LLI5;

//执行标准
@property (nonatomic,strong)PersonalSettingItem *LT6;
//已完成
@property (nonatomic,strong)PersonalSettingItem *LC7;
//问题描述
@property (nonatomic,strong)PersonalSettingItem *LL8;
//整改期限
@property (nonatomic,strong)PersonalSettingItem *LLI9;
//整改责任人
@property (nonatomic,strong)PersonalSettingItem *LLI10;
//整改方案
@property (nonatomic,strong)PersonalSettingItem *LT11;
//整改完成情况
@property (nonatomic,strong)PersonalSettingItem *LL12;
//备注
@property (nonatomic,strong)PersonalSettingItem *LL13;


@end

@implementation AddTaskXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建任务详情";
    [self addUIOne];
    [self addFooter];
    
}
-(void)addUIOne{
    WEAKSELF
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"任务号:" type:PersonalSettingItemTypeLabels];
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"工作任务:" type:PersonalSettingItemTypeLabel];
    self.LT2.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LT2.content title:weakSelf.LT2.title compeletion:^(NSString *value) {
            weakSelf.LT2.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"负责人:" type:PersonalSettingItemTypeArrow];
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"开始时间:" type:PersonalSettingItemTypeArrow];
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"结束时间:" type:PersonalSettingItemTypeArrow];
    
     self.LT6 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"执行标准:" type:PersonalSettingItemTypeLabel];
    
     self.LC7 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"已完成:" type:PersonalSettingItemTypeChoice];
    
     self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"问题描述:" type:PersonalSettingItemTypeLabels];
    self.LL8.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LL8.content title:weakSelf.LL8.title compeletion:^(NSString *value) {
            weakSelf.LL8.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
     self.LLI9 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"整改期限:" type:PersonalSettingItemTypeArrow];
    
     self.LLI10 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"整改责任人:" type:PersonalSettingItemTypeArrow];
    
     self.LT11 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"整改方案:" type:PersonalSettingItemTypeLabel];
    
    self.LT11.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LT11.content title:weakSelf.LT11.title compeletion:^(NSString *value) {
            weakSelf.LT11.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    
    
     self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"整改完成情况:" type:PersonalSettingItemTypeLabel];
    
     self.LL13 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"备注:" type:PersonalSettingItemTypeLabel];
    
    self.LL13.operation  = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.LL13.content title:weakSelf.LL13.title compeletion:^(NSString *value) {
            weakSelf.LL13.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    
         PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LLI3,_LLI4,_LLI5,_LT6,_LC7,_LL8,_LLI9,_LLI10,_LT11,_LL12,_LL13];
    [_allGroups addObject:group];
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
    footer.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:footer];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-55);
    }];
}
//取消
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)saveClick{
    SVHUD_NO_Stop(@"提交中");
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/WFSERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        HUDStop
        if ([dic[@"status"] isEqualToString:@"已完成"]) {
            SVHUD_Stop;
            
        }else{
            SVHUD_Stop;
            SVHUD_Normal(@"审批失败稍后再试");
        }
    };
    AccountModel *model = [AccountManager account];
    
    //    NSArray *arr = @[
    //                     @{@"json":@""},
    //                     @{@"flag":@"1"},
    //                     @{@"mboObjectName":_stock.PROCESSNAME},
    //                     @{@"mboKey":_stock.OWNERTABLE},
    //                     @{@"personId":model.personId},
    //                     ];
    //    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
    //

    
    
}




@end
