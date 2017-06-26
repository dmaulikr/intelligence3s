//
//  TripReportDetailsViewController.m
//  intelligence
//
//  Created by chris on 2016/11/22.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "TripReportDetailsViewController.h"
#import "ProblemItemLBView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "DailyDetailsFooterView.h"
#import "DTKDropdownMenuView.h"
#import "ApprovalsView.h"
@interface TripReportDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;
//姓名:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
//描述：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
//部门：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
//录入人：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
//出差项目:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
//出差地点:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
//出差日期：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
//出差是由：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
//工作内容：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
//录入时间
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;

@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
@end

@implementation TripReportDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[self.model mj_keyValues]);
    [self addViews];
    [self addScrollFooterView];
    [self addRightNavBarItem];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 TOPLACE : 云南蒙自;
 NAME1 : 田鸿业;
 TRIPDATE : 2016-09-17 00:00:00;
 DESCRIPTION : 16-09-17田鸿业_的出差总结报告;
 CREATEDATE : 2016-10-11 00:00:00;
 DEPTNUM : 918;
 SERIALNUMBER : 1306;
 PROJECT : S1-20110028;
 PROJECTNAME : 华电云南朵古一期;
 TRIPCONTENT : 到云贵区域进行智能风场管理系统推广培训;
 WORKCONTENT : 1	推广概况
 */
-(void)addViews
{
    WEAKSELF
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLT;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"姓名:";
    self.firstRow.contentTextField.text = [NSString stringWithFormat:@"%@ %@",_model.ACOUNT,_model.NAME1];
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLV;
    self.secondRow.titleLabel.text = @"描述:";
    self.secondRow.contentTextView.text = _model.DESCRIPTION;
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(65);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLT;
    self.thirdRow.titleLabel.text = @"部门:";
    self.thirdRow.contentTextField.text = _model.DEPTNAME;
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLT;
    self.forthRow.titleLabel.text = @"出差项目:";
    self.forthRow.contentTextField.text = [NSString stringWithFormat:@"%@%@",_model.PROJECT,_model.PROJECTNAME];
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLT;
    self.fifthRow.titleLabel.text = @"出差地点:";
    self.fifthRow.contentTextField.text = _model.TOPLACE;
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemItemTypeDefaultLT;
    self.sixthRow.titleLabel.text = @"出差日期:";
    self.sixthRow.contentTextField.text =_model.TRIPDATE;
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemItemTypeDefaultLV;
    self.seventhRow.titleLabel.text = @"出差事由:";
    self.seventhRow.contentTextView.text = _model.TRIPCONTENT;
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(90);
    }];
    self.seventhRow.executeTapContentLabel = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.seventhRow.contentTextView.text title:weakSelf.seventhRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.seventhRow.contentTextView.text=value;
        }];
    };
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLV;
    
    self.eighthRow.titleLabel.text = @"工作内容:";
    self.eighthRow.contentTextView.text = _model.WORKCONTENT;
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(90);
    }];
    
    self.eighthRow.executeTapContentLabel = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.eighthRow.contentTextView.text title:weakSelf.eighthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.eighthRow.contentTextView.text=value;
        }];
    };
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLT;
    self.ninthRow.titleLabel.text = @"录入人:";
    self.ninthRow.contentTextField.text = _model.CREATEBY;
    AccountModel *model = [AccountManager account];
    self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    
    [self.rootView addSubview:self.ninthRow];
    
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLT;
    self.tenthRow.titleLabel.text = @"录入时间:";
    self.tenthRow.contentTextField.text = _model.CREATEDATE;
    self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    
    self.tenthRow.contentLabel.text =model.displayName;
    [self.rootView addSubview:self.tenthRow];
    
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLV;
    self.eleventhRow.titleLabel.text = @"出差申请编号:";
    self.eleventhRow.contentTextView.text = _model.TRIPCODE;
    
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    [self.rootScrollView setContentSize:CGSizeMake(0, 650)];
}

- (void)addScrollFooterView{
    WEAKSELF
    self.footerView = [DailyDetailsFooterView showXibView];
    self.footerView.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    self.footerView.executeBtnCancelClick = ^(){
        NSLog(@"取消");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.footerView.executeBtnSaveClick = ^(){
        NSLog(@"保存");
        [weakSelf updata];
    };
    [self.view addSubview:self.footerView];
}
- (void)addRightNavBarItem{
    WEAKSELF

    DTKDropdownItem *item = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [weakSelf sendData];
    }];
    
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0,40.f, 40.f) dropdownItems:@[item] icon:@"more"];
    
    
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 150.f;
    //    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    //    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
- (void)updata
{
    
}
//发送工作流
-(void)sendData{
    if ([_model.STATUS isEqualToString:@"已取消"]||[_model.STATUS isEqualToString:@"已关闭"]||[_model.STATUS isEqualToString:@"已完成"]) {
        
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_model.STATUS];
        HUDJuHua(str);
        return;
    }
    
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_model.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"TRIPREPORT";
    popupView.mbo = @"UDTRIPREPORT";
    popupView.keyValue = _model.UDTRIPREPORTID;
    popupView.key = @"UDTRIPREPORTID";
    popupView.CloseBlick = ^(NSDictionary *dic){
        
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDNormal(str1);
        }
        
    };
    [popupView show];
}
@end
