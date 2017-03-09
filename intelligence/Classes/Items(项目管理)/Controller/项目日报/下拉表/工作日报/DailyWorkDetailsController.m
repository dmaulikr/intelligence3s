//
//  DailyWorkDetailsController.m
//  intelligence
//
//  Created by 丁进宇 on 16/9/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DailyWorkDetailsController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemTitleView.h"
#import "SoapUtil.h"

#import "ChoiceWorkView.h"
#import "ShareConstruction.h"
#import "DailyWorkModel.h"


@interface DailyWorkDetailsController ()
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

// 创建日期:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;
// 描述：
@property (nonatomic, strong) ProblemItemLTView *secondRow;
// 天气：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// 温度：
@property (nonatomic, strong) ProblemItemLTView *forthRow;
// 平均风速:
@property (nonatomic, strong) ProblemItemLTView *fifthRow;
// 工作日至活动
@property (nonatomic, strong) ProblemItemTitleView *sixthRow;
// 工作性质：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 工作班成员：
@property (nonatomic, strong) ProblemItemLTView *eighthRow;
// 工作任务：
@property (nonatomic, strong) ProblemItemLTView *ninthRow;
// 完成情况
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
// 异常情况说明
@property (nonatomic, strong) ProblemItemLTView *eleventhRow;
// 备注
@property (nonatomic, strong) ProblemItemLTView *twelfthRow;

@property (nonatomic, strong) DailyWorkModel *dailyWork;


@end

@implementation DailyWorkDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作日报详情";
    self.rootViewHeight.constant = 700;
    [self addViews];
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    self.dailyWork = shareConstruction.dailyWork;
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];

}

- (void)setDailyWork:(DailyWorkModel *)dailyWork{
    _dailyWork = dailyWork;
    if (dailyWork.RUNLOGDATE.length > 0) {
        self.firstRow.contentLabel.text = dailyWork.RUNLOGDATE;
        self.firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    
    if (dailyWork.DESCRIPTION.length > 0) {
        self.secondRow.contentText.text = dailyWork.DESCRIPTION;
        self.secondRow.placeholderLabel.text = @"";
    }
   
    if (dailyWork.WEATHER.length > 0) {
        self.thirdRow.contentLabel.text = dailyWork.WEATHER;
        self.thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    
    if (dailyWork.TEM.length > 0) {
        self.forthRow.contentText.text = dailyWork.TEM;
        self.forthRow.placeholderLabel.text = @"";
    }
    
    if (dailyWork.WINDSPEED.length > 0) {
        self.fifthRow.contentText.text = dailyWork.WINDSPEED;
        self.fifthRow.placeholderLabel.text = @"";
    }
    
    if (dailyWork.WORKTYPE.length > 0) {
        self.seventhRow.contentLabel.text = dailyWork.WORKTYPE;
        self.seventhRow.contentLabel.textColor = [UIColor blackColor];
    }
    
    if (dailyWork.WORKPG.length > 0) {
        self.eighthRow.contentText.text = dailyWork.WORKPG;
        self.eighthRow.placeholderLabel.text = @"";
    }
    
    if (dailyWork.WORKCRON.length > 0) {
        self.ninthRow.contentText.text = dailyWork.WORKCRON;
        self.ninthRow.placeholderLabel.text = @"";
    }
    
    if (dailyWork.COMPSTA.length > 0) {
        self.tenthRow.contentLabel.text = dailyWork.COMPSTA;
        self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    
    if (dailyWork.SITUATION.length > 0) {
        self.eleventhRow.contentText.text = dailyWork.SITUATION;
        self.eleventhRow.placeholderLabel.text = @"";
    }
    
    if (dailyWork.REMARK.length > 0) {
        self.twelfthRow.contentText.text = dailyWork.REMARK;
        self.twelfthRow.placeholderLabel.text = @"";
    }
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
    self.firstRow.type = ProblemDetailsTypeMustLLI;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.firstRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.firstRow.titleLabel.text = @"日期:";
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLTView showXibView];
    self.secondRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.secondRow.titleLabel.text = @"描述:";
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemDetailsTypeMustLLI;
    self.thirdRow.titleLabel.text = @"天气:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLTView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLLI;
    self.forthRow.titleLabel.text = @"温度℃:";
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.fifthRow = [ProblemItemLTView showXibView];
    self.fifthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.fifthRow.titleLabel.text = @"平均风速m/s:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.sixthRow = [ProblemItemTitleView showXibView];
    self.sixthRow.titleLabel.text = @"工作日志活动:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemItemTypeDefaultLLI;
    self.seventhRow.titleLabel.text = @"工作性质:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLTView showXibView];
    self.eighthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.eighthRow.titleLabel.text = @"工作班成员:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.ninthRow = [ProblemItemLTView showXibView];
    self.ninthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.ninthRow.titleLabel.text = @"工作任务:";
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLLI;
    self.tenthRow.titleLabel.text = @"完成情况:";
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLTView showXibView];
    self.eleventhRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.eleventhRow.titleLabel.text = @"异常情况说明:";
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.twelfthRow = [ProblemItemLTView showXibView];
    self.twelfthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.twelfthRow.titleLabel.text = @"备注:";
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
}

- (void)addBlocks{
    WEAKSELF
    
    self.firstRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_first];
    };
    
    self.thirdRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeWeather];
        work.WorkBlock = ^(NSString *str){
            weakSelf.thirdRow.contentLabel.text = str;
            weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
        
    };
    
    self.seventhRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeNatureWork];
        work.WorkBlock = ^(NSString *str){
            weakSelf.seventhRow.contentLabel.text = str;
            weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
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
    
    self.secondRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatesecondRowWithHeight:textHeight animated:YES];
    };
    
    self.forthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateforthRowWithHeight:textHeight animated:YES];
    };
    
    self.fifthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatefifthRowWithHeight:textHeight animated:YES];
    };
    
    self.eighthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateeighthRowWithHeight:textHeight animated:YES];
    };
    
    self.ninthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateninthRowWithHeight:textHeight animated:YES];
    };
    
    self.eleventhRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateeleventhRowWithHeight:textHeight animated:YES];
    };
    
    self.twelfthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatetwelfthRowWithHeight:textHeight animated:YES];
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
                          @"DESCRIPTION":[self determineString:self.secondRow.contentText.text],
                          @"WEATHER":[self determineString:self.thirdRow.contentLabel.text],
                          @"TEM":[self determineString:self.forthRow.contentText.text],
                          @"WINDSPEED":[self determineString:self.fifthRow.contentText.text],
                          @"WORKTYPE":[self determineString:self.seventhRow.contentLabel.text],
                          @"WORKPG":[self determineString:self.eighthRow.contentText.text],
                          @"WORKCRON":[self determineString:self.ninthRow.contentText.text],
                          @"COMPSTA":[self determineString:self.tenthRow.contentLabel.text],
                          @"SITUATION":[self determineString:self.eleventhRow.contentText.text],
                          @"REMARK":[self determineString:self.twelfthRow.contentText.text],
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
    CGRect rect = [self.secondRow.contentText convertRect:self.secondRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.forthRow.contentText convertRect:self.forthRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.fifthRow.contentText convertRect:self.fifthRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.eighthRow.contentText convertRect:self.eighthRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.ninthRow.contentText convertRect:self.ninthRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.eleventhRow.contentText convertRect:self.eleventhRow.contentText.bounds toView:self.view];
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
    CGRect rect = [self.twelfthRow.contentText convertRect:self.twelfthRow.contentText.bounds toView:self.view];
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
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.firstRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.firstRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_first;
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
