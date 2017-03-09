//
//  ProblemDetailsController.m
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProblemDetailsController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemModel.h"
#import "ProblemItemTitleView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemLBView.h"

#import "SupportDepartmentController.h"
#import "RelatedRepairOrderController.h"
#import "ChooseItemNoController.h"
#import "ChooseItemNoModel.h"
#import "DailyDetailChoosePersonController.h"
#import "ChoosePersonModel.h"
#import "DTKDropdownMenuView.h"
#import "SoapUtil.h"
#import "ApprovalsView.h"
@interface ProblemDetailsController ()<UIAlertViewDelegate>
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat keyboardHeight;
    
    NSString *id1;
}
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 一:问题联络单基本信息
@property (nonatomic, strong) ProblemItemTitleView *firstTitle;
// 编号：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_firstRow;
// 描述：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_secondRow;
// *问题类型：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_thirdRow;
// *严重程度：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_forthRow;
// 相关故障工单:
@property (nonatomic, strong) ProblemItemLLIView *firstSection_fifthRow;
// *现场问题及进展描述:
@property (nonatomic, strong) ProblemItemLTView *firstSection_sixthRow;
// 二:项目信息
@property (nonatomic, strong) ProblemItemTitleView *secondTitle;
// *项目编号:
@property (nonatomic, strong) ProblemItemLLIView *secondSection_firstRow;
// 项目描述
@property (nonatomic, strong) ProblemItemLLIView *secondSection_secondRow;
// 项目负责人
@property (nonatomic, strong) ProblemItemLLIView *secondSection_thirdRow;
// 负责人电话
@property (nonatomic, strong) ProblemItemLLIView *secondSection_forthRow;
// 所属中心
@property (nonatomic, strong) ProblemItemLLIView *secondSection_fifthRow;
// 项目阶段
@property (nonatomic, strong) ProblemItemLLIView *secondSection_sixthRow;
// 三:提出问题
@property (nonatomic, strong) ProblemItemTitleView *thirdTitle;
// *需求提出人
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_firstRow;
// 提出人电话
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_secondRow;
// 提出人部门
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_thirdRow;
// 提出时间
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_forthRow;
// 状态
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_fifthRow;
// 四:支持部门
@property (nonatomic, strong) ProblemItemTitleView *forthTitle;
// *支持部门：
@property (nonatomic, strong) ProblemItemLLIView *forthSection_firstRow;
// *支持部门领导
@property (nonatomic, strong) ProblemItemLLIView *forthSection_secondRow;
// *需求完成时间:
@property (nonatomic, strong) ProblemItemLLIView *forthSection_thirdRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;
// 五:问题处理
@property (nonatomic, strong) ProblemItemTitleView *fifthTitle;
// *问题处理人：
@property (nonatomic, strong) ProblemItemLLIView *fifthSection_firstRow;
// 联系电话：
@property (nonatomic, strong) ProblemItemLLIView *fifthSection_secondRow;
// 解决人所属部门：
@property (nonatomic, strong) ProblemItemLLIView *fifthSection_thirdRow;
// 六:问题解决
@property (nonatomic, strong) ProblemItemTitleView *sixthTitle;
// *抵达时间:
@property (nonatomic, strong) ProblemItemLLIView *sixthSection_firstRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_second;
// 完成时间:
@property (nonatomic, strong) ProblemItemLLIView *sixthSection_secondRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_third;
// 解决问题及反馈:
@property (nonatomic, strong) ProblemItemLTView *sixthSection_thirdRow;
// 七:问题确认
@property (nonatomic, strong) ProblemItemTitleView *seventhTitle;
// 是否解决:
@property (nonatomic, strong) ProblemItemLBView *seventhSection_firstRow;
// 说明:
@property (nonatomic, strong) ProblemItemLTView *seventhSection_secondRow;


@end

@implementation ProblemDetailsController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联络单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.rootViewHeight.constant = 1590 + 60;
    id1 = self.problem.CREATEBY;
    [self addNotification];
    [self addFirstViews];
    [self addFirstBlocks];
    [self addSecondViews];
    [self addThirdViews];
    [self addForthViews];
    [self addForthBlocks];
    [self addFifthViews];
    [self addFifthBlocks];
    [self addSixthViews];
    [self addSixthBlocks];
    [self addSeventhViews];
    [self addSeventhBlocks];
    [self addScrollFooterView];
    [self addRightNavBarItem];
    
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDFEDBKCON" objectName:@"UDFEEDBACK" status:self.problem.STATUS compeletion:^(NSArray *fields) {
        NSLog(@"问题联络单单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}
- (void)addRightNavBarItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        
        [self checkRequiredFieldcompeletion:^(BOOL isOK) {
            if (isOK) {
                [self sendData];
            }
        }];
    }];

    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0] icon:@"more"];
    
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 200.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
-(void)sendData{
    //未完善
    if ([_problem.STATUS isEqualToString:@"已取消"]||[_problem.STATUS isEqualToString:@"已关闭"]||[_problem.STATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_problem.STATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_problem.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDFEEDBACK";
    popupView.mbo = @"UDFEEDBACK";
    popupView.keyValue = _problem.FEEDBACKNUM;
    popupView.key = @"FEEDBACKNUM";
    popupView.CloseBlick = ^(NSDictionary *dic){
        
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDNormal(str1);
        }
        
    };
    [popupView show];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要进行修改？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    };
    [self.view addSubview:self.footerView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self updata];
            break;
    }
}


- (void)updata{
    
    if (self.firstSection_thirdRow.contentLabel.text.length < 1 ||
        [self.firstSection_thirdRow.contentLabel.text isEqualToString:@"暂无数据"]) {
        HUDNormal(@"请选择问题类型");
        return;
    }else if (self.firstSection_forthRow.contentLabel.text.length < 1 ||
              [self.firstSection_forthRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择紧急程度");
        return;
    }else if (self.secondSection_firstRow.contentLabel.text.length < 1 ||
              [self.secondSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择项目编号");
        return;
    }else if (self.thirdSection_firstRow.contentLabel.text.length < 1 ||
              [self.thirdSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择提出需求人");
        return;
    }else if (self.forthSection_firstRow.contentLabel.text.length < 1 ||
              [self.forthSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择支持部门");
        return;
    }else if (self.fifthSection_firstRow.contentLabel.text.length < 1 ||
              [self.fifthSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择问题处理人");
        return;
    }
    SVHUD_NO_Stop(@"保存联络单中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"0"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            HUDNormal(@"保存成功")
        }else{
            HUDNormal(dic[@"errorMsg"])
        }
    };
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    
    NSDictionary *dic = @{
                          @"BRANCH":[self determineString:self.problem.UDFEEDBACKID],
                          @"COMPTIME":[self determineString:self.sixthSection_secondRow.contentLabel.text],
                          @"CREATENAME":[self determineString:self.thirdSection_firstRow.contentLabel.text],
                          @"CREATEDATE":[self determineString:self.thirdSection_forthRow.contentLabel.text],
                          @"CREATEBY":id1,
                          @"DEPT1":@"",
                          @"DEPT2":@"",
                          @"DEPT3":@"",
                          @"DESCRIPTION":[self determineString:self.firstSection_secondRow.contentLabel.text],
                          @"EMERGENCY":[self determineString:self.firstSection_forthRow.contentLabel.text],
                          @"FEEDBACKNUM":[self determineString:self.problem.FEEDBACKNUM],
                          @"FOUNDTIME":[self determineString:self.sixthSection_firstRow.contentLabel.text],
                          @"ISSTOP":@"0",
                          @"LEADER":[self determineString:self.forthSection_secondRow.contentLabel.text],
                          @"PHONE1":[self determineString:self.fifthSection_secondRow.contentLabel.text],
                          @"PHONE2":@"",
                          @"PHONE3":@"",
                          @"PROBLEMSITUATION":[self determineString:self.firstSection_sixthRow.contentText.text],
                          @"PROBLEMTYPE":[self determineString:self.firstSection_thirdRow.contentLabel.text],
                          @"PRODESC":[self determineString:self.problem.PRODESC],
                          @"PROGRESS":@"",
                          @"PRONUM":[self determineString:self.secondSection_firstRow.contentLabel.text],
                          @"PRORES":[self determineString:self.sixthSection_firstRow.contentLabel.text],
                          @"PROSTAGE":[self determineString:self.thirdSection_fifthRow.contentLabel.text],
                          @"REMARK":@"",
                          @"RESPONSETIME":[self determineString:self.forthSection_thirdRow.contentLabel.text],
                          @"SOLVEDBY":[self determineString:self.fifthSection_firstRow.contentLabel.text],
                          @"SOLVENAME":[self determineString:self.forthSection_secondRow.contentLabel.text],
                          @"STATUS":[self determineString:self.problem.STATUS],
                          @"SUPPORTDEPT":[self determineString:self.forthSection_firstRow.contentLabel.text],
                          @"WORKORDERNUM":[self determineString:self.firstSection_fifthRow.contentLabel.text],
                          @"relationShip":relationShip,
                          };
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDFEEDBACK"},
                     @{@"mboKey" : @"FEEDBACKNUM"},
                     @{@"mboKeyValue" : self.problem.FEEDBACKNUM}
                     ];
    
    [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
}

/**
 *  用于不同的请求 传的参数是json
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)determineString:(NSString *)str{
    if([str isEqualToString:@"暂无数据"] ||
       str.length < 1){
        return @"";
    }else{
        return str;
    }
}

- (void)addFirstViews{
    
    self.firstTitle = [ProblemItemTitleView showXibView];
    self.firstTitle.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.firstTitle.titleLabel.text = @"问题联络单基本信息";
    
    [self.rootView addSubview:self.firstTitle];
    
    self.firstSection_firstRow = [ProblemItemLLIView showXibView];
    self.firstSection_firstRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_firstRow.titleLabel.text = @"编号:";
    if (self.problem.FEEDBACKNUM.length > 0) {
        self.firstSection_firstRow.contentLabel.text = self.problem.FEEDBACKNUM;
        self.firstSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"编号" forKey:@"FEEDBACKNUM"];
    [self.rootView addSubview:self.firstSection_firstRow];
    [self.firstSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_secondRow = [ProblemItemLLIView showXibView];
    self.firstSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.firstSection_secondRow.titleLabel.text = @"描述:";
    if (self.problem.DESCRIPTION.length > 0) {
        self.firstSection_secondRow.contentLabel.text = self.problem.DESCRIPTION;
        self.firstSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    CGFloat secondRowLabelHeight = [self computeHeight:self.firstSection_secondRow.contentLabel];
    [self.SetingItems setValue:@"描述" forKey:@"DESCRIPTION"];
    [self.rootView addSubview:self.firstSection_secondRow];
    [self.firstSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(secondRowLabelHeight);
    }];
    
    self.firstSection_thirdRow = [ProblemItemLLIView showXibView];
    self.firstSection_thirdRow.type = ProblemDetailsTypeMustLLI;
    self.firstSection_thirdRow.titleLabel.text = @"问题类型:";
    if (self.problem.PROBLEMTYPE.length > 0) {
        self.firstSection_thirdRow.contentLabel.text = self.problem.PROBLEMTYPE;
        self.firstSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"问题类型" forKey:@"PROBLEMTYPE"];
    [self.rootView addSubview:self.firstSection_thirdRow];
    [self.firstSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_forthRow = [ProblemItemLLIView showXibView];
    self.firstSection_forthRow.type = ProblemDetailsTypeMustLLI;
    self.firstSection_forthRow.titleLabel.text  = @"紧急程度:";
    if (self.problem.EMERGENCY.length > 0) {
        self.firstSection_forthRow.contentLabel.text = self.problem.EMERGENCY;
        self.firstSection_forthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"紧急程度" forKey:@"EMERGENCY"];
    [self.rootView addSubview:self.firstSection_forthRow];
    [self.firstSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_fifthRow = [ProblemItemLLIView showXibView];
    self.firstSection_fifthRow.type = ProblemItemTypeDefaultLLI;
    self.firstSection_fifthRow.titleLabel.text  = @"相关故障工单:";
    if (self.problem.WORKORDERNUM.length > 0) {
        self.firstSection_fifthRow.contentLabel.text = self.problem.WORKORDERNUM;
        self.firstSection_fifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"相关故障工单" forKey:@"WORKORDERNUM"];
    [self.rootView addSubview:self.firstSection_fifthRow];
    [self.firstSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(45);
    }];

    self.firstSection_sixthRow = [ProblemItemLTView showXibView];
    self.firstSection_sixthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.firstSection_sixthRow.titleLabel.text  = @"现场问题及进展描述:";
    if (self.problem.PROBLEMSITUATION.length > 0) {
        self.firstSection_sixthRow.placeholderLabel.hidden = YES;
        self.firstSection_sixthRow.contentText.text = self.problem.PROBLEMSITUATION;
        self.firstSection_sixthRow.contentText.textColor = [UIColor blackColor];
    }
    CGFloat textViewHeight = [self computeTextViewHeight:self.firstSection_sixthRow.contentText];
    [self.SetingItems setValue:@"现场问题及进展描述" forKey:@"PROBLEMSITUATION"];
    [self.rootView addSubview:self.firstSection_sixthRow];
    [self.firstSection_sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(textViewHeight);
    }];

}

- (void)addSecondViews{
    self.secondTitle = [ProblemItemTitleView showXibView];
    self.secondTitle.titleLabel.text = @"项目信息";
    [self.rootView addSubview:self.secondTitle];
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.secondSection_firstRow = [ProblemItemLLIView showXibView];
    self.secondSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.secondSection_firstRow.titleLabel.text = @"项目编号:";
    if (self.problem.PRONUM.length > 0) {
        self.secondSection_firstRow.contentLabel.text = self.problem.PRONUM;
        self.secondSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目编号" forKey:@"PRONUM"];
    [self.rootView addSubview:self.secondSection_firstRow];
    [self.secondSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_secondRow = [ProblemItemLLIView showXibView];
    self.secondSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_secondRow.titleLabel.text = @"项目描述:";
    if (self.problem.PRODESC.length > 0) {
        self.secondSection_secondRow.contentLabel.text = self.problem.PRODESC;
        self.secondSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目描述" forKey:@"PRODESC"];
    [self.rootView addSubview:self.secondSection_secondRow];
    [self.secondSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_thirdRow = [ProblemItemLLIView showXibView];
    self.secondSection_thirdRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_thirdRow.titleLabel.text = @"项目负责人:";
    if (self.problem.PRORES.length > 0) {
        self.secondSection_thirdRow.contentLabel.text = self.problem.PRORES;
        self.secondSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目负责人" forKey:@"PRORES"];
    [self.rootView addSubview:self.secondSection_thirdRow];
    [self.secondSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_forthRow = [ProblemItemLLIView showXibView];
    self.secondSection_forthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_forthRow.titleLabel.text = @"负责人电话:";
    if (self.problem.PHONE1.length > 0) {
        self.secondSection_forthRow.contentLabel.text = self.problem.PHONE1;
        self.secondSection_forthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"负责人电话" forKey:@"PHONE1"];
    [self.rootView addSubview:self.secondSection_forthRow];
    [self.secondSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_fifthRow = [ProblemItemLLIView showXibView];
    self.secondSection_fifthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_fifthRow.titleLabel.text = @"所属中心:";
    if (self.problem.BRANCH.length > 0) {
        self.secondSection_fifthRow.contentLabel.text = self.problem.BRANCH;
        self.secondSection_fifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"所属中心" forKey:@"BRANCH"];
    [self.rootView addSubview:self.secondSection_fifthRow];
    [self.secondSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.secondSection_sixthRow = [ProblemItemLLIView showXibView];
    self.secondSection_sixthRow.type = ProblemItemTypeDefaultLL;
    self.secondSection_sixthRow.titleLabel.text = @"项目阶段:";
    if (self.problem.PROSTAGE.length > 0) {
        self.secondSection_sixthRow.contentLabel.text = self.problem.PROSTAGE;
        self.secondSection_sixthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目阶段" forKey:@"PROSTAGE"];
    [self.rootView addSubview:self.secondSection_sixthRow];
    [self.secondSection_sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addThirdViews{
    self.thirdTitle = [ProblemItemTitleView showXibView];
    self.thirdTitle.titleLabel.text = @"问题提出";
    [self.rootView addSubview:self.thirdTitle];
    [self.thirdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.thirdSection_firstRow = [ProblemItemLLIView showXibView];
    self.thirdSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.thirdSection_firstRow.titleLabel.text = @"需求提出人:";
    if (self.problem.CREATENAME.length > 0) {
        self.thirdSection_firstRow.contentLabel.text = self.problem.CREATENAME;
        self.thirdSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"需求提出人" forKey:@"CREATENAME"];
    [self.rootView addSubview:self.thirdSection_firstRow];
    [self.thirdSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdSection_secondRow = [ProblemItemLLIView showXibView];
    self.thirdSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.thirdSection_secondRow.titleLabel.text = @"提出人电话:";
    if (self.problem.PHONE2.length > 0) {
        self.thirdSection_secondRow.contentLabel.text = self.problem.PHONE2;
        self.thirdSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"提出人电话" forKey:@"PHONE2"];
    [self.rootView addSubview:self.thirdSection_secondRow];
    [self.thirdSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdSection_thirdRow = [ProblemItemLLIView showXibView];
    self.thirdSection_thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdSection_thirdRow.titleLabel.text = @"提出人部门:";
    if (self.problem.DEPT1.length > 0) {
        self.thirdSection_thirdRow.contentLabel.text = self.problem.DEPT1;
        self.thirdSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"提出人部门" forKey:@"DEPT1"];
    [self.rootView addSubview:self.thirdSection_thirdRow];
    [self.thirdSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdSection_forthRow = [ProblemItemLLIView showXibView];
    self.thirdSection_forthRow.type = ProblemItemTypeDefaultLL;
    self.thirdSection_forthRow.titleLabel.text = @"提出时间:";
    if (self.problem.CREATEDATE.length > 0) {
        self.thirdSection_forthRow.contentLabel.text = self.problem.CREATEDATE;
        self.thirdSection_forthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"提出时间" forKey:@"CREATEDATE"];
    [self.rootView addSubview:self.thirdSection_forthRow];
    [self.thirdSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdSection_fifthRow = [ProblemItemLLIView showXibView];
    self.thirdSection_fifthRow.type = ProblemItemTypeDefaultLL;
    self.thirdSection_fifthRow.titleLabel.text = @"状态:";
    if (self.problem.STATUS.length > 0) {
        self.thirdSection_fifthRow.contentLabel.text = self.problem.STATUS;
        self.thirdSection_fifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"状态" forKey:@"STATUS"];
    [self.rootView addSubview:self.thirdSection_fifthRow];
    [self.thirdSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addForthViews{
    self.forthTitle = [ProblemItemTitleView showXibView];
    self.forthTitle.titleLabel.text = @"支持部门";
    [self.rootView addSubview:self.forthTitle];
    [self.forthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.forthSection_firstRow = [ProblemItemLLIView showXibView];
    self.forthSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.forthSection_firstRow.titleLabel.text = @"支持部门:";
    if (self.problem.SUPPORTDEPT.length > 0) {
        self.forthSection_firstRow.contentLabel.text = self.problem.SUPPORTDEPT;
        self.forthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"支持部门" forKey:@"SUPPORTDEPT"];
    [self.rootView addSubview:self.forthSection_firstRow];
    [self.forthSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthSection_secondRow = [ProblemItemLLIView showXibView];
    self.forthSection_secondRow.type = ProblemItemTypeDefaultLLI;
    self.forthSection_secondRow.titleLabel.text = @"支持部门领导:";
    if (self.problem.LEADER.length > 0) {
        self.forthSection_secondRow.contentLabel.text = self.problem.LEADER;
        self.forthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"支持部门领导" forKey:@"LEADER"];
    [self.rootView addSubview:self.forthSection_secondRow];
    [self.forthSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthSection_thirdRow = [ProblemItemLLIView showXibView];
    self.forthSection_thirdRow.type = ProblemItemTypeDefaultLLI;
    self.forthSection_thirdRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.forthSection_thirdRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.forthSection_thirdRow.titleLabel.text = @"需求完成时间:";
    if (self.problem.RESPONSETIME.length > 0) {
        self.forthSection_thirdRow.contentLabel.text = self.problem.RESPONSETIME;
        self.forthSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"需求完成时间" forKey:@"RESPONSETIME"];
    [self.rootView addSubview:self.forthSection_thirdRow];
    [self.forthSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addFifthViews{
    self.fifthTitle = [ProblemItemTitleView showXibView];
    self.fifthTitle.titleLabel.text = @"问题处理";
    [self.rootView addSubview:self.fifthTitle];
    [self.fifthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.fifthSection_firstRow = [ProblemItemLLIView showXibView];
    self.fifthSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.fifthSection_firstRow.titleLabel.text = @"问题处理人:";
    if (self.problem.SOLVEDBY.length > 0) {
        self.fifthSection_firstRow.contentLabel.text = self.problem.SOLVEDBY;
        self.fifthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"问题处理人" forKey:@"SOLVEDBY"];
    [self.rootView addSubview:self.fifthSection_firstRow];
    [self.fifthSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthSection_secondRow = [ProblemItemLLIView showXibView];
    self.fifthSection_secondRow.type = ProblemItemTypeDefaultLL;
    self.fifthSection_secondRow.titleLabel.text = @"联系电话:";
    if (self.problem.PHONE2.length > 0) {
        self.fifthSection_secondRow.contentLabel.text = self.problem.PHONE3;
        self.fifthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"联系电话" forKey:@"PHONE3"];
    [self.rootView addSubview:self.fifthSection_secondRow];
    [self.fifthSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthSection_thirdRow = [ProblemItemLLIView showXibView];
    self.fifthSection_thirdRow.type = ProblemItemTypeDefaultLL;
    self.fifthSection_thirdRow.titleLabel.text = @"解决人所属部门:";
    if (self.problem.DEPT1.length > 0) {
        self.fifthSection_thirdRow.contentLabel.text = self.problem.DEPT3;
        self.fifthSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"解决人所属部门" forKey:@"DEPT3"];
    [self.rootView addSubview:self.fifthSection_thirdRow];
    [self.fifthSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addSixthViews{
    self.sixthTitle = [ProblemItemTitleView showXibView];
    self.sixthTitle.titleLabel.text = @"问题解决";
    [self.rootView addSubview:self.sixthTitle];
    [self.sixthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.sixthSection_firstRow = [ProblemItemLLIView showXibView];
    self.sixthSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.sixthSection_firstRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.sixthSection_firstRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.sixthSection_firstRow.titleLabel.text = @"抵达时间:";
    if (self.problem.FOUNDTIME.length > 0) {
        self.sixthSection_firstRow.contentLabel.text = self.problem.FOUNDTIME;
        self.sixthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"抵达时间" forKey:@"FOUNDTIME"];
    [self.rootView addSubview:self.sixthSection_firstRow];
    [self.sixthSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthSection_secondRow = [ProblemItemLLIView showXibView];
    self.sixthSection_secondRow.type = ProblemItemTypeDefaultLLI;
    self.sixthSection_secondRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.sixthSection_secondRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.sixthSection_secondRow.titleLabel.text = @"完成时间:";
    if (self.problem.COMPTIME.length > 0) {
        self.sixthSection_secondRow.contentLabel.text = self.problem.COMPTIME;
        self.sixthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"完成时间" forKey:@"COMPTIME"];
    [self.rootView addSubview:self.sixthSection_secondRow];
    [self.sixthSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthSection_thirdRow = [ProblemItemLTView showXibView];
    self.sixthSection_thirdRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.sixthSection_thirdRow.titleLabel.text = @"解决问题及反馈:";
    if (self.problem.PROGRESS.length > 0) {
        self.sixthSection_thirdRow.placeholderLabel.hidden = YES;
        self.sixthSection_thirdRow.contentText.text = self.problem.PROGRESS;
        self.sixthSection_thirdRow.contentText.textColor = [UIColor blackColor];
    }
    CGFloat textViewHeight = [self computeTextViewHeight:self.sixthSection_thirdRow.contentText];
    [self.SetingItems setValue:@"解决问题及反馈" forKey:@"PROGRESS"];
    [self.rootView addSubview:self.sixthSection_thirdRow];
    [self.sixthSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(textViewHeight);
    }];
}

- (void)addSeventhViews{
    self.seventhTitle = [ProblemItemTitleView showXibView];
    self.seventhTitle.titleLabel.text = @"问题确认";
    [self.rootView addSubview:self.seventhTitle];
    [self.seventhTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.seventhSection_firstRow = [ProblemItemLBView showXibView];
    self.seventhSection_firstRow.titleLabel.text = @"是否确认:";
    
    [self.rootView addSubview:self.seventhSection_firstRow];
    [self.seventhSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhSection_secondRow = [ProblemItemLTView showXibView];
    self.seventhSection_secondRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.seventhSection_secondRow.titleLabel.text = @"说明:";
    if (self.problem.REMARK.length > 0) {
        self.seventhSection_secondRow.placeholderLabel.hidden = YES;
        self.seventhSection_secondRow.contentText.text = self.problem.REMARK;
        self.seventhSection_secondRow.contentText.textColor = [UIColor blackColor];
    }
    CGFloat textViewHeight = [self computeTextViewHeight:self.seventhSection_secondRow.contentText];
    [self.SetingItems setValue:@"说明" forKey:@"REMARK"];
    [self.rootView addSubview:self.seventhSection_secondRow];
    [self.seventhSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(textViewHeight);
    }];
}

- (void)addFirstBlocks{
    WEAKSELF
    self.firstSection_sixthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateFirstSection_forthRowWithHeight:textHeight animated:YES];
    };
    
    self.firstSection_thirdRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultType];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.firstSection_thirdRow.contentLabel.text = str;
            weakSelf.firstSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.firstSection_forthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultTypeDegree];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.firstSection_forthRow.contentLabel.text = str;
            weakSelf.firstSection_forthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.firstSection_fifthRow.executeTapContentLabel = ^(){
        RelatedRepairOrderController *vc = [[RelatedRepairOrderController alloc] init];
        vc.title = @"相关故障工单";
        vc.executeCellClick = ^(RelatedRepairOrderModel *model){
            if (model.WORKORDERID.length > 0) {
                weakSelf.firstSection_fifthRow.contentLabel.text = model.WORKORDERID;
                weakSelf.firstSection_fifthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.firstSection_fifthRow.contentLabel.text = @"暂无数据";
                weakSelf.firstSection_fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (void)addForthBlocks{
    WEAKSELF
    
    self.forthSection_firstRow.executeTapContentLabel = ^(){
        SupportDepartmentController *vc = [[SupportDepartmentController alloc] init];
        vc.executeCellClick = ^(SupportDepartmentModel *model){
            if (model.DESCRIPTION.length > 0) {
                weakSelf.forthSection_firstRow.contentLabel.text = model.DESCRIPTION;
                weakSelf.forthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.forthSection_firstRow.contentLabel.text = @"暂无数据";
                weakSelf.forthSection_firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.forthSection_secondRow.executeTapContentLabel = ^(){
        
        if (weakSelf.forthSection_firstRow.contentLabel.text.length < 1 ||
            [weakSelf.forthSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]) {
            WHUDNormal(@"请选择支持部门");
            return ;
        }
        
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.name = weakSelf.forthSection_firstRow.contentLabel.text;
        vc.title = @"支持部门领导";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            if (model.DISPLAYNAME.length > 0) {
                weakSelf.forthSection_secondRow.contentLabel.text = model.DISPLAYNAME;
                weakSelf.forthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.forthSection_secondRow.contentLabel.text = @"暂无数据";
                weakSelf.forthSection_secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.forthSection_thirdRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_first];
    };
}

- (void)addFifthBlocks{
    WEAKSELF
    weakSelf.fifthSection_firstRow.executeTapContentLabel = ^(){
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择处理人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            if (model.DISPLAYNAME.length > 0) {
                weakSelf.fifthSection_firstRow.contentLabel.text = model.DISPLAYNAME;
                weakSelf.fifthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.fifthSection_firstRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthSection_firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.PRIMARYPHONE.length > 0) {
                weakSelf.fifthSection_secondRow.contentLabel.text = model.PRIMARYPHONE;
                weakSelf.fifthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.fifthSection_secondRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthSection_secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.DEPARTDESC.length > 0) {
                weakSelf.fifthSection_thirdRow.contentLabel.text = model.DEPARTDESC;
                weakSelf.fifthSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.fifthSection_thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthSection_thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (void)addSixthBlocks{
    WEAKSELF
    self.sixthSection_firstRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_second];
    };
    
    self.sixthSection_secondRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_third];
    };
    
    self.sixthSection_thirdRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSixthSection_thirdRowWithHeight:textHeight animated:YES];
    };
    
}

- (void)addSeventhBlocks{
    WEAKSELF
    self.seventhSection_secondRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSeventhSection_secondRowWithHeight:textHeight animated:YES];
    };
}

- (CGFloat)computeHeight:(UILabel *)label{
    CGFloat labelHeight = [LabelSize heightOfLabel:label];
    if (labelHeight + 20 > 45) {
        return labelHeight + 20;
    }
    return 45;
}

- (CGFloat)computeTextViewHeight:(UITextView *)textView{
    CGFloat textViewHeight = textView.contentSize.height;
    if (textViewHeight + 20 > 60) {
        return textViewHeight + 20;
    }
    return 60;
}

- (void)updateFirstSection_forthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
    [self.firstSection_sixthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.firstSection_sixthRow.contentText convertRect:self.firstSection_sixthRow.contentText.bounds toView:self.view];
    CGFloat bottom = ScreenHeight - rect.origin.y - rect.size.height;
    if (bottom < keyboardHeight + 10) {
        [self.rootScrollView setContentOffset:scrollPoint];
    }
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)updateSixthSection_thirdRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
    [self.sixthSection_thirdRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.sixthSection_thirdRow.contentText convertRect:self.sixthSection_thirdRow.contentText.bounds toView:self.view];
    CGFloat bottom = ScreenHeight - rect.origin.y - rect.size.height;
    if (bottom < keyboardHeight + 10) {
        [self.rootScrollView setContentOffset:scrollPoint];
    }
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}


- (void)updateSeventhSection_secondRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
    [self.seventhSection_secondRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.seventhSection_secondRow.contentText convertRect:self.seventhSection_secondRow.contentText.bounds toView:self.view];
    CGFloat bottom = ScreenHeight - rect.origin.y - rect.size.height;
    if (bottom < keyboardHeight + 10) {
        [self.rootScrollView setContentOffset:scrollPoint];
    }
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
}

- (TXTimeChoose *)timeYear_first{
    WEAKSELF
    if (!_timeYear_first) {
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.forthSection_thirdRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.forthSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_first;
}

- (TXTimeChoose *)timeYear_second{
    WEAKSELF
    if (!_timeYear_second) {
        _timeYear_second = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_second.backString = ^(NSDate *data){
            weakSelf.sixthSection_firstRow.contentLabel.text = [weakSelf.timeYear_second stringFromDate:data];
            weakSelf.sixthSection_firstRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_second;
}

- (TXTimeChoose *)timeYear_third{
    WEAKSELF
    if (!_timeYear_third) {
        _timeYear_third = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_third.backString = ^(NSDate *data){
            weakSelf.sixthSection_secondRow.contentLabel.text = [weakSelf.timeYear_third stringFromDate:data];
            weakSelf.sixthSection_secondRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_third;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  
}
-(void)checkRequiredFieldcompeletion:(void (^)(BOOL isOK))compeletion
{
    
    NSMutableArray *nullFields=[NSMutableArray array];
    
    if (self.RequiredFields.count<=0) {
        compeletion(YES);
    }
    else
    {
        for (NSString * str in self.RequiredFields) {
            
            NSString * value =[self.problem valueForKey:str];
            
            if (value.length==0) {
                
                NSString *value2 = [self.SetingItems valueForKey:str];
                
                if (value2.length>0) {
                    
                    [nullFields addObject:value2];
                }
            }
            
        }
        
        if (nullFields.count>0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:[NSString stringWithFormat:@"以下内容未填写<%@>,请填写并保存后进行其它操作",nullFields] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * comfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert addAction:cancel];
                [alert addAction:comfirm];
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            compeletion(YES);
        }
    }
}

@end
