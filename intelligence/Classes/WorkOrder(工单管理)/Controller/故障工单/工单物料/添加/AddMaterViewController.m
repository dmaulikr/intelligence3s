//
//  AddMaterViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AddMaterViewController.h"
#import "FooterView.h"
#import "SoapUtil.h"
@interface AddMaterViewController ()
//物资编码
@property (nonatomic,strong)PersonalSettingItem *LLI1;
//物资描述
@property (nonatomic,strong)PersonalSettingItem *LL2;
//数量
@property (nonatomic,strong)PersonalSettingItem *LT3;
//订购单位
@property (nonatomic,strong)PersonalSettingItem *LL4;
//库房
@property (nonatomic,strong)PersonalSettingItem *LLI5;
//库房描述
@property (nonatomic,strong)PersonalSettingItem *LL6;
@end

@implementation AddMaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增物料详情";
    [self addFooter];
    [self addOne];
}
-(void)addOne{
    WEAKSELF
    self.LLI1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"物资编码:" type:PersonalSettingItemTypeArrow];
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"物资描述:" type:PersonalSettingItemTypeLabels];
    
    self.LT3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"数量:" type:PersonalSettingItemTypeText];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"订购单位:" type:PersonalSettingItemTypeLabels];
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"库房:" type:PersonalSettingItemTypeArrow];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"库房描述:" type:PersonalSettingItemTypeLabels];
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI1,_LL2,_LT3,_LL4,_LLI5,_LL6];
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
