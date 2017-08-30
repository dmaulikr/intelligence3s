//
//  ProblemAddController.m
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemAddController.h"
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

@interface ProblemAddController ()
{
    CGFloat lastTextHeight;
    CGFloat keyboardHeight;
    NSString *personid;
}

@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 一:问题联络单基本信息
@property (nonatomic, strong) ProblemItemTitleView *firstTitle;
// *问题类型：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_firstRow;
// *紧急程度：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_secondRow;
// 相关故障工单：
@property (nonatomic, strong) ProblemItemLLIView *firstSection_thirdRow;
// *现场问题：
@property (nonatomic, strong) ProblemItemLTView *firstSection_forthRow;
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
// 需求提出人
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_firstRow;
// 提出人电话
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_secondRow;
// 提出人部门
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_thirdRow;
// 提出时间
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_forthRow;
// 状态
@property (nonatomic, strong) ProblemItemLLIView *thirdSection_fifthRow;

@end

@implementation ProblemAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增联络单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.rootViewHeight.constant = 880;
    [self addNotification];
    [self addFirstViews];
    [self addFirstBlocks];
    [self addSecondViews];
    [self addSecondBlocks];
    [self addThirdViews];
    [self addThirdBlocks];
    [self addScrollFooterView];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
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

- (void)updata{
    
    if (self.firstSection_firstRow.contentLabel.text.length < 1 ||
        [self.firstSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]) {
        HUDNormal(@"请选择问题类型");
        return;
    }else if (self.firstSection_secondRow.contentLabel.text.length < 1 ||
              [self.firstSection_secondRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择紧急程度");
        return;
    }else if (self.secondSection_firstRow.contentLabel.text.length < 1 ||
              [self.secondSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择项目编号");
        return;
    }else if (self.thirdSection_firstRow.contentLabel.text.length < 1 ||
              [self.thirdSection_firstRow.contentLabel.text isEqualToString:@"暂无数据"]){
        HUDNormal(@"请选择需求联系人");
        return;
    }
    
    SVHUD_NO_Stop(@"保存联络单中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        if ([dic[@"status"] isEqualToString:@""]) {
            HUDNormal(@"保存失败稍后再试");
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSDictionary *dict = @{};
    NSArray *relationShip = @[dict];
    
//    {"CREATEBY":"游熹栋","EMERGENCY":"一般","PROBLEMSITUATION":"aaa","PROBLEMTYPE":"村民阻工","PRONUM":"S1-20070001","WORKORDERNUM":"165103","relationShip":[{"":""}]},mboObjectName=UDFEEDBACK,mboKey=FEEDBACKNUM,personId=ZHANGS
    
    NSDictionary *dic = @{
                          @"CREATENAME":self.thirdSection_firstRow.contentLabel.text,
                          @"EMERGENCY":self.firstSection_secondRow.contentLabel.text,
                          @"PROBLEMSITUATION":self.firstSection_forthRow.contentText.text,
                          @"PROBLEMTYPE":self.firstSection_firstRow.contentLabel.text,
                          @"PRONUM":self.secondSection_firstRow.contentLabel.text,
                          @"relationShip":relationShip,
                          };
    AccountModel *account = [AccountManager account];
    NSString *strPersonId = @"";
    if (personid.length < 1) {
        strPersonId = account.personId;
    }else{
        strPersonId = personid;
    }
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDFEEDBACK"},
                     @{@"mboKey" : @"FEEDBACKNUM"},
                     @{@"personId" : strPersonId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)addFirstViews{
    WEAKSELF
    self.firstTitle = [ProblemItemTitleView showXibView];
    self.firstTitle.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.firstTitle.titleLabel.text = @"问题联络单基本信息";
    [self.rootView addSubview:self.firstTitle];
    
    self.firstSection_firstRow = [ProblemItemLLIView showXibView];
    self.firstSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.firstSection_firstRow.titleLabel.text = @"问题类型:";
    [self.rootView addSubview:self.firstSection_firstRow];
    [self.firstSection_firstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstTitle.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_secondRow = [ProblemItemLLIView showXibView];
    self.firstSection_secondRow.type = ProblemDetailsTypeMustLLI;
    self.firstSection_secondRow.titleLabel.text = @"紧急程度:";
    [self.rootView addSubview:self.firstSection_secondRow];
    [self.firstSection_secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_thirdRow = [ProblemItemLLIView showXibView];
    self.firstSection_thirdRow.type = ProblemItemTypeDefaultLLI;
    self.firstSection_thirdRow.titleLabel.text = @"相关故障工单:";
    [self.rootView addSubview:self.firstSection_thirdRow];
    [self.firstSection_thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.firstSection_forthRow = [ProblemItemLTView showXibView];
    self.firstSection_forthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.firstSection_forthRow.titleLabel.text  = @"现场问题及进展描述:";
    [self.rootView addSubview:self.firstSection_forthRow];
    [self.firstSection_forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(60);
    }];
    self.firstSection_forthRow.executeTextHeightChage = ^(CGFloat textHeight) {
        
        [weakSelf popInputTextViewContent:weakSelf.firstSection_forthRow.contentText.text title:weakSelf.firstSection_forthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.firstSection_forthRow.contentText.text=value;
        }];
    };
}

- (void)addFirstBlocks{
    WEAKSELF
    
    self.firstSection_thirdRow.executeTapContentLabel = ^(){
        RelatedRepairOrderController *vc = [[RelatedRepairOrderController alloc] init];
        vc.executeCellClick = ^(RelatedRepairOrderModel *model){
            if (model.WORKORDERID.length > 0) {
                weakSelf.firstSection_thirdRow.contentLabel.text = model.WORKORDERID;
                weakSelf.firstSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.firstSection_thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.firstSection_thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.firstSection_forthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateFirstSection_forthRowWithHeight:textHeight animated:YES];
    };
    
    self.firstSection_firstRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultType];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.firstSection_firstRow.contentLabel.text = str;
            weakSelf.firstSection_firstRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.firstSection_secondRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultTypeDegree];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.firstSection_secondRow.contentLabel.text = str;
            weakSelf.firstSection_secondRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
}

- (void)addSecondViews{
    self.secondTitle = [ProblemItemTitleView showXibView];
    self.secondTitle.titleLabel.text = @"项目信息";
    [self.rootView addSubview:self.secondTitle];
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.secondSection_firstRow = [ProblemItemLLIView showXibView];
    self.secondSection_firstRow.type = ProblemDetailsTypeMustLLI;
    self.secondSection_firstRow.titleLabel.text = @"项目编号:";
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
    [self.rootView addSubview:self.secondSection_sixthRow];
    [self.secondSection_sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondSection_fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addSecondBlocks{
    WEAKSELF
    
    self.secondSection_firstRow.executeTapContentLabel = ^(){
        ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
        vc.title = @"选择项目编号";
        vc.executeClickCell = ^(ChooseItemNoModel *model){
            if (model.PRONUM.length>0) {
                weakSelf.secondSection_firstRow.contentLabel.textColor = [UIColor blackColor];
                weakSelf.secondSection_firstRow.contentLabel.text = model.PRONUM;
            }else{
                weakSelf.secondSection_firstRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.DESCRIPTION.length > 0) {
                weakSelf.secondSection_secondRow.contentLabel.text = model.DESCRIPTION;
                weakSelf.secondSection_secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondSection_secondRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.RESPONSNAME.length > 0) {
                weakSelf.secondSection_thirdRow.contentLabel.text = model.RESPONSNAME;
                weakSelf.secondSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondSection_thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.RESPONSPHONE.length > 0) {
                weakSelf.secondSection_forthRow.contentLabel.text = model.RESPONSPHONE;
                weakSelf.secondSection_forthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondSection_forthRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_forthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.BRANCHDESC.length > 0) {
                weakSelf.secondSection_fifthRow.contentLabel.text = model.BRANCHDESC;
                weakSelf.secondSection_fifthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondSection_fifthRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.PROSTAGE.length > 0) {
                weakSelf.secondSection_sixthRow.contentLabel.text = model.PROSTAGE;
                weakSelf.secondSection_sixthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondSection_sixthRow.contentLabel.text = @"暂无数据";
                weakSelf.secondSection_sixthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
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
    AccountModel *account = [AccountManager account];
    self.thirdSection_firstRow.contentLabel.text = account.displayName;
    self.thirdSection_firstRow.contentLabel.textColor = [UIColor blackColor];
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
    [self.rootView addSubview:self.thirdSection_fifthRow];
    [self.thirdSection_fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdSection_forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addThirdBlocks{
    WEAKSELF
    
    self.thirdSection_firstRow.executeTapContentLabel = ^(){
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择提出人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            personid = model.PERSONID;
            if (model.DISPLAYNAME.length > 0) {
                weakSelf.thirdSection_firstRow.contentLabel.text = model.DISPLAYNAME;
                weakSelf.thirdSection_firstRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdSection_firstRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdSection_firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.PRIMARYPHONE.length > 0) {
                weakSelf.thirdSection_secondRow.contentLabel.text = model.PRIMARYPHONE;
                weakSelf.thirdSection_secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdSection_secondRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdSection_secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.DEPARTDESC.length > 0) {
                weakSelf.thirdSection_thirdRow.contentLabel.text = model.DEPARTDESC;
                weakSelf.thirdSection_thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdSection_thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdSection_thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (void)updateFirstSection_forthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
    [self.firstSection_forthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.firstSection_forthRow.contentText convertRect:self.firstSection_forthRow.contentText.bounds toView:self.view];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
}



@end
