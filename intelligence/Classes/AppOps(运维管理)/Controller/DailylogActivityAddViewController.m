//
//  DailylogActivityAddViewController.m
//  intelligence
//
//  Created by chris on 2016/11/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DailylogActivityAddViewController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemTitleView.h"
#import "SoapUtil.h"

#import "ChoiceWorkView.h"
#import "ShareConstruction.h"
#import "DailyWorkModel.h"

@interface DailylogActivityAddViewController ()<UITextFieldDelegate>
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

@property (nonatomic, strong) TXTimeChoose *timeYear_first;

@end

@implementation DailylogActivityAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增工作日报详情";
    self.rootViewHeight.constant = 705;
    [self addViews];
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];
    _runLineDic = [NSMutableDictionary dictionary];
    [_runLineDic setObject:_PRORUNLOGNUM forKey:@"LOGNUM"];

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
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.firstRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.firstRow.titleLabel.text = @"日期:";
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLT;
    self.secondRow.titleLabel.text = @"描述:";
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
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemItemTypeDefaultLT;
    self.twelfthRow.titleLabel.text = @"完成情况:";
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
    self.thirteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.thirteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}
- (TXTimeChoose *)timeYear_first{
    WEAKSELF
    if (!_timeYear_first) {
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.firstRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.firstRow.contentLabel.textColor = [UIColor blackColor];
            [weakSelf.runLineDic setObject: weakSelf.firstRow.contentLabel.text forKey:@"LOGDATE"];
            NSLog(@"dictionary %@",weakSelf.runLineDic);
        };
    }
    return _timeYear_first;
}
- (void)addBlocks{
    WEAKSELF
    
    self.firstRow.executeTapContentLabel = ^(){
        
            [weakSelf.view addSubview:weakSelf.timeYear_first];
        
    };
    
    self.secondRow.contentTextField.delegate=self;
    self.secondRow.contentTextField.tag=2;
    
    self.thirdRow.contentTextField.delegate=self;
    self.thirdRow.contentTextField.tag=3;
    
    self.forthRow.contentTextField.delegate=self;
    self.forthRow.contentTextField.tag=4;
    
    self.fifthRow.contentTextField.delegate=self;
    self.fifthRow.contentTextField.tag=5;
    
    self.sixthRow.contentTextField.delegate=self;
    self.sixthRow.contentTextField.tag=6;
    

    
    self.eighthRow.contentTextField.delegate=self;
    self.eighthRow.contentTextField.tag=8;
    
    self.ninthRow.contentTextField.delegate=self;
    self.ninthRow.contentTextField.tag=9;
    
    self.tenthRow.contentTextField.delegate=self;
    self.tenthRow.contentTextField.tag=10;
    
    self.eleventhRow.contentTextField.delegate=self;
    self.eleventhRow.contentTextField.tag=11;
    
    self.twelfthRow.contentTextField.delegate=self;
    self.twelfthRow.contentTextField.tag=12;
    
    self.thirteenthRow.contentTextField.delegate=self;
    self.thirteenthRow.contentTextField.tag=13;

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"最终值 %@",textField.text);
    /*
     LOGDATE;//日期
     NEWDESC;//描述 2
     WEATHER;//天气 3
     TEM;//温度℃ 4
     WINDSPEED;//平均风速(m/s) 5
     PERSONATTNUM;//人员考勤编号 6
     WORKNUM;//工作序号 8
     WORKPG;//工作班成员 9
     WORKTYPE;//工作性质 10
     WORKCRON;//工作任务 11
     COMPSTA;//完成情况 12
     REMARK;//备注 13
     
     LOGNUM;//运行日志编号
     */
    switch (textField.tag) {
        case 2:
            [_runLineDic setObject:textField.text forKey:@"NEWDESC"];
            break;
        case 3:
            [_runLineDic setObject:textField.text forKey:@"WEATHER"];
            break;
        case 4:
            [_runLineDic setObject:textField.text forKey:@"TEM"];
            break;
        case 5:
            [_runLineDic setObject:textField.text forKey:@"WINDSPEED"];
            break;
        case 6:
            [_runLineDic setObject:textField.text forKey:@"PERSONATTNUM"];
            break;
        case 8:
            [_runLineDic setObject:textField.text forKey:@"WORKNUM"];
            break;
        case 9:
            [_runLineDic setObject:textField.text forKey:@"WORKPG"];
            break;
        case 10:
            [_runLineDic setObject:textField.text forKey:@"WORKTYPE"];
            break;
        case 11:
            [_runLineDic setObject:textField.text forKey:@"WORKCRON"];
            break;
        case 12:
            [_runLineDic setObject:textField.text forKey:@"COMPSTA"];
            break;
        case 13:
            [_runLineDic setObject:textField.text forKey:@"REMARK"];
            break;
            
        default:
            break;
    }
    NSLog(@"dictionary %@",_runLineDic);
    return;
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
    /*
     LOGDATE;//日期
     NEWDESC;//描述
     WEATHER;//天气
     TEM;//温度℃
     WINDSPEED;//平均风速(m/s)
     PERSONATTNUM;//人员考勤编号
     WORKNUM;//工作序号
     WORKPG;//工作班成员
     WORKTYPE;//工作性质
     WORKCRON;//工作任务
     COMPSTA;//完成情况
     REMARK;//备注
     LOGNUM;//运行日志编号
     */
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    
    Runliner * runlineModel = [Runliner mj_objectWithKeyValues:_runLineDic];
    
    [shareConstruction.runlineModels addObject:runlineModel];
    
    [self.navigationController popViewControllerAnimated:YES];
}
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
