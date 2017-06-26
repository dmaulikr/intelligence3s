//
//  DailylogActivityDetailsViewController.m
//  intelligence
//
//  Created by chris on 2016/11/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DailylogActivityDetailsViewController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemTitleView.h"
#import "SoapUtil.h"

#import "ChoiceWorkView.h"
#import "ShareConstruction.h"
#import "DailyWorkModel.h"

@interface DailylogActivityDetailsViewController ()
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat lastTextHeight4;
    CGFloat lastTextHeight5;
    CGFloat lastTextHeight6;
    CGFloat lastTextHeight7;
    CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

//日期:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
//描述
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
//天气：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
//温度：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
//平均风速
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
//人员考勤编号
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
//工作日志活动子表
@property (nonatomic, strong) ProblemItemTitleView *seventhRow;
//工作序号
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
//工作班成员
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
//工作性质
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
//工作任务
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
//完成情况
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
// 备注
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;


@end

@implementation DailylogActivityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作日志活动详情";
    if(!self.model)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    self.rootViewHeight.constant = 700;
    [self addViews];
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    self.dailyWork = shareConstruction.dailyWork;
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];
    
}

- (void)setDailyWork:(DailyWorkModel *)dailyWork
{
    
}


- (void)addNotification{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)addViews{
    
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLT;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.firstRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.firstRow.titleLabel.text = @"日期:";
    self.firstRow.contentTextField.text = self.model.LOGDATE;
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLT;
    self.secondRow.titleLabel.text = @"描述:";
    self.secondRow.contentTextField.text = self.model.NEWDESC;
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLT;
    self.thirdRow.titleLabel.text = @"天气:";
    self.thirdRow.contentTextField.text=self.model.WEATHER;
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLT;
    self.forthRow.titleLabel.text = @"温度℃:";
    self.forthRow.contentTextField.text = self.model.TEM;
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLT;
    self.fifthRow.titleLabel.text = @"平均风速m/s:";
    self.fifthRow.contentTextField.text = self.model.WINDSPEED;
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemItemTypeDefaultLT;
    self.sixthRow.titleLabel.text = @"人员考勤编号:";
    self.sixthRow.contentTextField.text = self.model.PERSONATTNUM;
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemTitleView showXibView];
    self.seventhRow.titleLabel.text = @"工作日志活动子表:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLT;
    self.eighthRow.titleLabel.text = @"工作序号:";
    self.eighthRow.contentTextField.text = self.model.WORKNUM;
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLT;
    self.ninthRow.titleLabel.text = @"工作班成员:";
    self.ninthRow.contentTextField.text = self.model.WORKPG;
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLT;
    self.tenthRow.titleLabel.text = @"工作性质:";
    self.tenthRow.contentTextField.text = self.model.WORKTYPE;
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLT;
    self.eleventhRow.titleLabel.text = @"工作任务:";
    self.eleventhRow.contentTextField.text = self.model.WORKCRON;
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    WEAKSELF
    
    self.eleventhRow.executeTapContentLabel = ^{
        [weakSelf popInputTextViewContent:weakSelf.eleventhRow.contentTextField.text title:weakSelf.eleventhRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.eleventhRow.contentTextField.text=value;
            
        }];
    };
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemItemTypeDefaultLT;
    self.twelfthRow.titleLabel.text = @"完成情况:";
    self.twelfthRow.contentTextField.text = self.model.COMPSTA;
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemItemTypeDefaultLT;
    self.thirteenthRow.titleLabel.text = @"备注:";
    self.thirteenthRow.contentTextField.text = self.model.REMARK;
    self.thirteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.thirteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    self.thirteenthRow.executeTapContentLabel  = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.thirteenthRow.contentTextField.text title:weakSelf.thirteenthRow.titleLabel.text compeletion:^(NSString *value) {
            
            weakSelf.thirteenthRow.contentTextField.text=value;
        }];
    };
}
- (void)addBlocks{
    WEAKSELF
    
    self.firstRow.executeTapContentLabel = ^(){
       
    };
    
    self.thirdRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeWeather];
        work.WorkBlock = ^(NSString *str){
            weakSelf.thirdRow.contentLabel.text = str;
            weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
        
    };
        
    self.tenthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeCompletion];
        work.WorkBlock = ^(NSString *str){
            weakSelf.tenthRow.contentLabel.text = str;
            weakSelf.tenthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
    };
    
    self.secondRow.executeTapContentLabel = ^(){
        
    };
    
    self.forthRow.executeTapContentLabel = ^(){
        
    };
    
    self.fifthRow.executeTapContentLabel = ^(){
        
    };
    
    self.eighthRow.executeTapContentLabel = ^(){
        
    };
    
    self.ninthRow.executeTapContentLabel = ^(){
        
    };
    
    self.eleventhRow.executeTapContentLabel = ^(){
        
    };
    
    self.twelfthRow.executeTapContentLabel = ^(){
        
    };
    
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
    SVHUD_NO_Stop(@"保存中");
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
    
    /*{json={"BRANCH":"856",
     "CREATEBY":"ZHANGS",
     "CUDESCRIBE":"aaaaaa",
     "END_TIME":"",
     "FAULT_CODE":"05",
     "FAULT_CODE1":"SC03_04_006",
     "HAPPEN_TIME":"2016-8-19 18:32:00",
     "LOCATION":"G003MKA04AG001-KN01",
     "LOCATION_CODE":"003#",
     "PRONUM":"S1-20110010",
     "REMARK":"aaaaa",
     "REPORTTIME":"2016-08-19 18:31:48",
     "RESULT":"aaaaa",
     "STATUSTYPE":"新建",
     "relationShip":[{"":""}]}; flag=1; mboObjectName=UDREPORT; mboKey=REPORTNUM; personId=ZHANGS; }
     */
    
    
    
    NSDictionary *dic = @{
                          @"RUNLOGDATE":[self determineString:self.firstRow.contentLabel.text],
                          @"DESCRIPTION":[self determineString:self.secondRow.contentTextField.text],
                          @"WEATHER":[self determineString:self.thirdRow.contentTextField.text],
                          @"TEM":[self determineString:self.forthRow.contentTextField.text],
                          @"WINDSPEED":[self determineString:self.fifthRow.contentTextField.text],
                          @"WORKPG":[self determineString:self.eighthRow.contentTextField.text],
                          @"WORKCRON":[self determineString:self.ninthRow.contentTextField.text],
                          @"COMPSTA":[self determineString:self.tenthRow.contentTextField.text],
                          @"SITUATION":[self determineString:self.eleventhRow.contentTextField.text],
                          @"REMARK":[self determineString:self.twelfthRow.contentTextField.text],
                          @"mboObjectName" : @"UDPRORUNLOGC"
                          };
    
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    shareConstruction.dailyWork = [DailyWorkModel mj_objectWithKeyValues:dic];
    shareConstruction.dailyWork.dic = dic;
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)updatesecondRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
    [self.secondRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.secondRow.contentTextField convertRect:self.secondRow.contentTextField.bounds toView:self.view];
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

- (void)updateforthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
    [self.forthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.forthRow.contentTextField convertRect:self.forthRow.contentTextField.bounds toView:self.view];
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


- (void)updatefifthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
    [self.fifthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.fifthRow.contentTextField convertRect:self.fifthRow.contentTextField.bounds toView:self.view];
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

- (void)updateeighthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight4;
    lastTextHeight4 = height;
    [self.eighthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.eighthRow.contentTextField convertRect:self.eighthRow.contentTextField.bounds toView:self.view];
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

- (void)updateninthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight5;
    lastTextHeight5 = height;
    [self.ninthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.ninthRow.contentTextField convertRect:self.ninthRow.contentTextField.bounds toView:self.view];
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

- (void)updateeleventhRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight6;
    lastTextHeight6 = height;
    [self.eleventhRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.eleventhRow.contentTextField convertRect:self.eleventhRow.contentTextField.bounds toView:self.view];
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

- (void)updatetwelfthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight7;
    lastTextHeight7 = height;
    [self.twelfthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.twelfthRow.contentTextField convertRect:self.twelfthRow.contentTextField.bounds toView:self.view];
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
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
}

@end
