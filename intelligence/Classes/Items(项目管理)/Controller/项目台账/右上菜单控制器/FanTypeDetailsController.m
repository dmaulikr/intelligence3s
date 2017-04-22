//
//  FanTypeDetailsController.m
//  intelligence
//
//  Created by  on 16/8/28.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "FanTypeDetailsController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ProblemItemTitleView.h"
#import "ChoiceWorkView.h"
#import "RelatedRepairOrderController.h"
#import "ChooseItemNoController.h"
#import "ChooseItemNoModel.h"
#import "DailyDetailChoosePersonController.h"
#import "ChoosePersonModel.h"
#import "SoapUtil.h"


@interface FanTypeDetailsController ()

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 一:风机详情信息
@property (nonatomic, strong) ProblemItemTitleView *firstTitle;
// 机位号：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_firstRow;
// 型号：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_secondRow;
// 风机状态
@property (nonatomic, strong) ProblemItemLLIView *firstSection_thirdRow;
// 机台号
@property (nonatomic, strong) ProblemItemLLIView *firstSection_forthRow;
// 成品物料描述
@property (nonatomic, strong) ProblemItemLLIView *firstSection_fifthRow;
// 程敏物料描述
@property (nonatomic, strong) ProblemItemLLIView *firstSection_sixthRow;
// 二:各项目日期信息
@property (nonatomic, strong) ProblemItemTitleView *secondTitle;
// 土建完成日期:
@property (nonatomic, strong) ProblemItemLLIView *secondSection_firstRow;
// 吊装完成日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_secondRow;
// 调试完成日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_thirdRow;
// 并网日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_forthRow;
// 预验收完成日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_fifthRow;
// 终验收完成日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_sixthRow;
// 上次完成日期
@property (nonatomic, strong) ProblemItemLLIView *secondSection_seventhRow;
// 下次巡检
@property (nonatomic, strong) ProblemItemLLIView *secondSection_eighthRow;
// 首次巡检
@property (nonatomic, strong) ProblemItemLLIView *secondSection_ninthRow;
// 半年
@property (nonatomic, strong) ProblemItemLLIView *secondSection_tenthRow;
// 全年
@property (nonatomic, strong) ProblemItemLLIView *secondSection_eleventhRow;
// 下次
@property (nonatomic, strong) ProblemItemLLIView *secondSection_thirteenthRow;



@end

@implementation FanTypeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootViewHeight.constant = 45 * 13 + 80 + 45 * 6 + 20;
    [self addFirstViews];
//    [self addFirstBlocks];
     [self addSecondViews];
//     [self addSecondBlocks];
}

- (void)addFirstViews{
    self.firstTitle = [ProblemItemTitleView showXibView];
    self.firstTitle.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.firstTitle.titleLabel.text = @"风机详情信息";
    [self.rootView addSubview:self.firstTitle];
    
    self.firstSection_firstRow = [ProblemItemLLIView showXibView];
    self.firstSection_firstRow.type = ProblemItemTypeDefaultLL;
    [self setTextWithCell:self.firstSection_firstRow withString:self.model.LOCNUM];
    self.firstSection_firstRow.titleLabel.text = @"机位号:";
    
    [self.rootView addSubview:self.firstSection_firstRow];
    [self.firstSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_secondRow = [ProblemItemLLIView showXibView];
    self.firstSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_secondRow.titleLabel.text = @"型号:";
    [self setTextWithCell:self.firstSection_secondRow withString:self.model.MODELTYPE];
    [self.rootView addSubview:self.firstSection_secondRow];
    [self.firstSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_thirdRow = [ProblemItemLLIView showXibView];
    self.firstSection_thirdRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_thirdRow.titleLabel.text = @"风机状体:";
    [self setTextWithCell:self.firstSection_thirdRow withString:self.model.STATUS];
    [self.rootView addSubview:self.firstSection_thirdRow];
    [self.firstSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_forthRow = [ProblemItemLLIView showXibView];
    self.firstSection_forthRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_forthRow.titleLabel.text  = @"机台号:";
    [self setTextWithCell:self.firstSection_forthRow withString:self.model.EMPST];
    [self.rootView addSubview:self.firstSection_forthRow];
    [self.firstSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_fifthRow = [ProblemItemLLIView showXibView];
    self.firstSection_fifthRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_fifthRow.titleLabel.text  = @"成品物料代码(SAP):";
    [self setTextWithCell:self.firstSection_fifthRow withString:self.model.SAPNUM];
    [self.rootView addSubview:self.firstSection_fifthRow];
    [self.firstSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(55);
    }];
    
    self.firstSection_sixthRow = [ProblemItemLLIView showXibView];
    self.firstSection_sixthRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_sixthRow.titleLabel.text  = @"成品物料描述:";
    [self setTextWithCell:self.firstSection_sixthRow withString:self.model.SAPDESC];
    [self.rootView addSubview:self.firstSection_sixthRow];
    [self.firstSection_sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(45);
    }];
    
    
}

- (void)addSecondViews{
    self.secondTitle = [ProblemItemTitleView showXibView];
    self.secondTitle.titleLabel.text = @"各项日期信息";
    [self.rootView addSubview:self.secondTitle];
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.secondSection_firstRow = [ProblemItemLLIView showXibView];
    self.secondSection_firstRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_firstRow.titleLabel.text = @"土建完成日期:";
    [self setTextWithCell:self.secondSection_firstRow withString:self.model.XJDATE];
    [self.rootView addSubview:self.secondSection_firstRow];
    [self.secondSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_secondRow = [ProblemItemLLIView showXibView];
    self.secondSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_secondRow.titleLabel.text = @"吊装完成日期:";
    [self setTextWithCell:self.secondSection_secondRow withString:self.model.DZDATE];
    [self.rootView addSubview:self.secondSection_secondRow];
    [self.secondSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_thirdRow = [ProblemItemLLIView showXibView];
    self.secondSection_thirdRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_thirdRow.titleLabel.text = @"调试完成日期:";
    [self setTextWithCell:self.secondSection_thirdRow withString:self.model.BWDATE];
    [self.rootView addSubview:self.secondSection_thirdRow];
    [self.secondSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_forthRow = [ProblemItemLLIView showXibView];
    self.secondSection_forthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_forthRow.titleLabel.text = @"并网运行日期:";
    [self setTextWithCell:self.secondSection_forthRow withString:self.model.TSDATE];
    [self.rootView addSubview:self.secondSection_forthRow];
    [self.secondSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_fifthRow = [ProblemItemLLIView showXibView];
    self.secondSection_fifthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_fifthRow.titleLabel.text = @"预验收完成日期:";
    [self setTextWithCell:self.secondSection_fifthRow withString:self.model.YYSDATE];
    [self.rootView addSubview:self.secondSection_fifthRow];
    [self.secondSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_sixthRow = [ProblemItemLLIView showXibView];
    self.secondSection_sixthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_sixthRow.titleLabel.text = @"终验收完成日期:";
    [self.rootView addSubview:self.secondSection_sixthRow];
    [self setTextWithCell:self.secondSection_sixthRow withString:self.model.DJDATE4];
    [self.secondSection_sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_seventhRow = [ProblemItemLLIView showXibView];
    self.secondSection_seventhRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_seventhRow.titleLabel.text = @"上次巡检日期:";
    [self setTextWithCell:self.secondSection_seventhRow withString:self.model.XJDATE];
    [self.rootView addSubview:self.secondSection_seventhRow];
    [self.secondSection_seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_eighthRow = [ProblemItemLLIView showXibView];
    self.secondSection_eighthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_eighthRow.titleLabel.text = @"下次巡检日期:";
    [self setTextWithCell:self.secondSection_eighthRow withString:self.model.XJDATE2];
    [self.rootView addSubview:self.secondSection_eighthRow];
    [self.secondSection_eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_ninthRow = [ProblemItemLLIView showXibView];
    self.secondSection_ninthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_ninthRow.titleLabel.text = @"首检完成日期:";
    [self setTextWithCell:self.secondSection_ninthRow withString:self.model.DJDATE1];
    [self.rootView addSubview:self.secondSection_ninthRow];
    [self.secondSection_ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_tenthRow = [ProblemItemLLIView showXibView];
    self.secondSection_tenthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_tenthRow.titleLabel.text = @"半年检完成日期:";
    [self setTextWithCell:self.secondSection_tenthRow withString:self.model.DJDATE2];
    [self.rootView addSubview:self.secondSection_tenthRow];
    [self.secondSection_tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_eleventhRow = [ProblemItemLLIView showXibView];
    self.secondSection_eleventhRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_eleventhRow.titleLabel.text = @"全年检完成日期:";
    [self setTextWithCell:self.secondSection_eleventhRow withString:self.model.JDDATE3];
    [self.rootView addSubview:self.secondSection_eleventhRow];
    [self.secondSection_eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_thirteenthRow = [ProblemItemLLIView showXibView];
    self.secondSection_thirteenthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_thirteenthRow.titleLabel.text = @"下次定检日期日期:";
    [self setTextWithCell:self.secondSection_thirteenthRow withString:self.model.DJDATE5];
    [self.rootView addSubview:self.secondSection_thirteenthRow];
    [self.secondSection_thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(55);
    }];
}

- (void)setTextWithCell:(ProblemItemLLIView *)cell withString:(NSString *)str{
    if (str.length > 0) {
        cell.contentLabel.text = str;
        cell.contentLabel.textColor = [UIColor blackColor];
    }else{
        cell.contentLabel.text = @"暂无数据";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
