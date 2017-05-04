//
//  ToolingManagementAddController.m
//  intelligence
//
//  Created by  on 16/8/13.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ToolingManagementAddController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemTitleView.h"
#import "SoapUtil.h"

#import "ChoiceWorkView.h"
#import "ShareConstruction.h"
#import "ToolingManagementModel.h"

@interface ToolingManagementAddController ()
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat lastTextHeight4;
    CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 日期:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;
// 类型：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 已到货物：
@property (nonatomic, strong) ProblemItemLTView *thirdRow;
// 已吊装数：
@property (nonatomic, strong) ProblemItemLTView *forthRow;
// 已返厂数:
@property (nonatomic, strong) ProblemItemLTView *fifthRow;
// 风场丢失数:
@property (nonatomic, strong) ProblemItemLTView *sixthRow;


@end

@implementation ToolingManagementAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增工装管理详情";
    self.rootViewHeight.constant = ScreenHeight;
    [self addViews];
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];
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
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLLI;
    self.secondRow.titleLabel.text = @"类型:";
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLTView showXibView];
    self.thirdRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.thirdRow.titleLabel.text = @"已到货物:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.forthRow = [ProblemItemLTView showXibView];
    self.forthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.forthRow.titleLabel.text = @"已返厂数:";
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
    
    self.sixthRow = [ProblemItemLTView showXibView];
    self.sixthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.sixthRow.titleLabel.text = @"风场丢失数:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
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
    
    self.secondRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeToolingType];
        work.WorkBlock = ^(NSString *str){
            weakSelf.secondRow.contentLabel.text = str;
            weakSelf.secondRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
    };
    
    self.thirdRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatethirdRowWithHeight:textHeight animated:YES];
    };
    
    self.forthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateforthRowWithHeight:textHeight animated:YES];
    };
    
    self.fifthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatefifthRowWithHeight:textHeight animated:YES];
    };
    
    self.sixthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatesixthRowWithHeight:textHeight animated:YES];
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
    
    /*
     {
     "NUMBER1":"1",
     "NUMBER2":"2",
     "NUMBER3":"3",
     "NUMBER4":"4",
     "RUNLOGDATE":"2016-11-02",
     "TYPE":"add",
     "TYPE2":"1.5MW轮毂工装"
     }
     */
    
    
    
    NSDictionary *dic = @{
                          @"TYPE":@"add",
                          @"PRORUNLOGNUM":self.PRORUNLOGNUM?self.PRORUNLOGNUM:@"",
                          @"RUNLOGDATE":[self determineString:self.firstRow.contentLabel.text],
                          @"TYPE":[self determineString:self.secondRow.contentLabel.text],
                          @"NUMBER1":[self determineString:self.thirdRow.contentText.text],
                          @"NUMBER2":[self determineString:self.forthRow.contentText.text],
                          @"NUMBER3":[self determineString:self.fifthRow.contentText.text],
                          @"NUMBER4":[self determineString:self.sixthRow.contentText.text],
                          };
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    shareConstruction.toolingManagement = [ToolingManagementModel mj_objectWithKeyValues:dic];
    shareConstruction.toolingManagement.dic = dic;
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

- (void)updatethirdRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
    [self.thirdRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.thirdRow.contentText convertRect:self.thirdRow.contentText.bounds toView:self.view];
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

- (void)updatesixthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight4;
    lastTextHeight4 = height;
    [self.sixthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.sixthRow.contentText convertRect:self.sixthRow.contentText.bounds toView:self.view];
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
