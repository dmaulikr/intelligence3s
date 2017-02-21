//
//  AddFaultViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AddFaultsViewController.h"
#import "DailyDetailChoosePersonController.h"
#import "FooterView.h"
#import "SoapUtil.h"
@interface AddFaultsViewController ()
//任务号
@property (nonatomic,strong)PersonalSettingItem *LL1;
//描述
@property (nonatomic,strong)PersonalSettingItem *LT2;
//负责人
@property (nonatomic,strong)PersonalSettingItem *LLI3;
//实际开始时间
@property (nonatomic,strong)PersonalSettingItem *LLI4;
//实际完成时间
@property (nonatomic,strong)PersonalSettingItem *LLI5;
@end

@implementation AddFaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增任务详情";
    [self addFooter];
    [self addOne];
}

-(void)addOne{
    WEAKSELF
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"任务号:" type:PersonalSettingItemTypeLabels];
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeText];
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"负责人:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.LLI3.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    self.LLI4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际完成时间:" type:PersonalSettingItemTypeArrow];
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LLI3,_LLI4,_LLI5];
    [_allGroups addObject:group];
}

-(void)addFooter{
    CGRect frame = self.tableView.frame;
    frame.size.height -= 55;
    self.tableView.frame = frame;
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
    footer.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:footer];
}
//取消
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)saveClick{
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:@"http://deveam.mywind.com.cn:7001/meaweb/services/WFSERVICE"];
    soap.DicBlock = ^(NSDictionary *dic){
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
    //
    //    self.LL1
    //    self.LLI2
    
    
}


@end
