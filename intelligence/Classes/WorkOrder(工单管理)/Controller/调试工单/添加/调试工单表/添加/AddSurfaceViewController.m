//
//  AddSurfaceViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AddSurfaceViewController.h"
#import "SoapUtil.h"
#import "FooterView.h"
@interface AddSurfaceViewController ()

//风机编码
@property (nonatomic,strong)PersonalSettingItem *LL1;
//机台号
@property (nonatomic,strong)PersonalSettingItem *LT2;
//调试日期
@property (nonatomic,strong)PersonalSettingItem *LL3;
//并网运行日期
@property (nonatomic,strong)PersonalSettingItem *LL4;
//静态调试日期
@property (nonatomic,strong)PersonalSettingItem *LL5;
//动态调试日期
@property (nonatomic,strong)PersonalSettingItem *LL6;
//程序版本号
@property (nonatomic,strong)PersonalSettingItem *LT7;
//调试责任人
@property (nonatomic,strong)PersonalSettingItem *LL8;
//调试组长
@property (nonatomic,strong)PersonalSettingItem *LL9;
//调试工程师1
@property (nonatomic,strong)PersonalSettingItem *LL10;
//调试工程师2
@property (nonatomic,strong)PersonalSettingItem *LL11;
//调试工程师3
@property (nonatomic,strong)PersonalSettingItem *LL12;
//问题记录
@property (nonatomic,strong)PersonalSettingItem *LT13;
//处理过程
@property (nonatomic,strong)PersonalSettingItem *LT14;
//备注
@property (nonatomic,strong)PersonalSettingItem *LT15;
@end

@implementation AddSurfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增调试工单表详情";
    [self addFooter];
    [self addUIOne];
}

-(void)addUIOne{
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"风机编码:" type:PersonalSettingItemTypeText];
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"机台号:" type:PersonalSettingItemTypeLabels];
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"调试日期:" type:PersonalSettingItemTypeText];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"并网运行日期:" type:PersonalSettingItemTypeLabels];

    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"静态调试日期:" type:PersonalSettingItemTypeText];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"动态调试日期:" type:PersonalSettingItemTypeLabels];

    
    self.LT7 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"程序版本号:" type:PersonalSettingItemTypeText];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试责任人:" type:PersonalSettingItemTypeLabels];

    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试组长:" type:PersonalSettingItemTypeText];
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师1:" type:PersonalSettingItemTypeLabels];

    
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师2:" type:PersonalSettingItemTypeText];
    
    self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师3:" type:PersonalSettingItemTypeLabels];

    self.LT13 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"问题记录:" type:PersonalSettingItemTypeText];
    
    self.LT14 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"处理过程:" type:PersonalSettingItemTypeLabels];
    
    self.LT15 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"备注:" type:PersonalSettingItemTypeLabels];
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LL3,_LL4,_LL5,_LL6,_LT7,_LL8,_LL9,_LL10,_LL11,_LL12,_LT13,_LT14,_LT15,];
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
