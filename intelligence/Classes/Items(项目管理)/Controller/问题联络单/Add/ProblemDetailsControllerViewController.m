//
//  ProblemDetailsControllerViewController.m
//  intelligence
//
//  Created by chris on 16/8/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemDetailsControllerViewController.h"

@interface ProblemDetailsControllerViewController ()
/** 项目管理*/
@property (nonatomic, strong)ProblemModel *problem;

/** ---------  第一部分  ----------------*/
/** 问题类型*/
@property (nonatomic,strong)PersonalSettingItem * LLI1;
/** 紧急程度*/
@property (nonatomic,strong)PersonalSettingItem * LLI2;
/** 相关故障单*/
@property (nonatomic,strong)PersonalSettingItem * LLI3;
/** 现场问题*/
@property (nonatomic,strong)PersonalSettingItem * LT4;
/** ---------  第二部分  ----------------*/
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem * LLI5;
/** 项目描述*/
@property (nonatomic,strong)PersonalSettingItem * LL6;
/** 项目负责人*/
@property (nonatomic,strong)PersonalSettingItem * LL7;
/** 负责人电话*/
@property (nonatomic,strong)PersonalSettingItem * LL8;
/** 所属中心*/
@property (nonatomic,strong)PersonalSettingItem * LL9;
/** 项目阶段*/
@property (nonatomic,strong)PersonalSettingItem * LL10;
/** ---------  第三部分  ----------------*/
/** 需求提出人*/
@property (nonatomic,strong)PersonalSettingItem * LLI11;
/** 提出人电话*/
@property (nonatomic,strong)PersonalSettingItem * LL12;
/** 提出人部门*/
@property (nonatomic,strong)PersonalSettingItem * LL13;
/** 提出时间*/
@property (nonatomic,strong)PersonalSettingItem * LL14;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem * LL15;
@end

@implementation ProblemDetailsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addOne];
    [self addTwo];
    [self addThree];
}
//第一部分
-(void)addOne{
    self.LLI1 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"问题类型:" type:PersonalSettingItemTypeArrow];
    
    self.LLI2 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"紧急程度:" type:PersonalSettingItemTypeArrow];
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:@"more_next_icon"  withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"相关故障工单:" type:PersonalSettingItemTypeArrow];
    
    self.LT4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"现场问题及进展情况描述:" type:PersonalSettingItemTypeText];

    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"问题联络单基本信息";
    group.items = @[_LLI1,_LLI2,_LLI3,_LT4];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    self.LLI5 = [PersonalSettingItem itemWithIcon:@"more_next_icon"  withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目编号:" type:PersonalSettingItemTypeArrow];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目描述:" type:PersonalSettingItemTypeLabel];
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目负责人:" type:PersonalSettingItemTypeLabel];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"负责人电话:" type:PersonalSettingItemTypeLabel];
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属中心:" type:PersonalSettingItemTypeLabel];
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目阶段:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"项目信息";
    group.items = @[_LLI5,_LL6,_LL7,_LL8,_LL9,_LL10];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"需求提出人:" type:PersonalSettingItemTypeArrow];
    
    self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"提出人电话:" type:PersonalSettingItemTypeLabel];
    
    self.LL13 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"提出人部门:" type:PersonalSettingItemTypeLabel];
    
    self.LL14 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"提出时间:" type:PersonalSettingItemTypeLabel];
    
    self.LL15 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"问题提出";
    group.items = @[_LLI11,_LL12,_LL13,_LL14,_LL15,];
    [_allGroups addObject:group];
}

@end
