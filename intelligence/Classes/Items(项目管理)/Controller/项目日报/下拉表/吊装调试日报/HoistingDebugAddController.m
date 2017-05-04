//
//  HoistingDebugAddController.m
//  intelligence
//
//  Created by chris on 16/8/12.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "HoistingDebugAddController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemTitleView.h"


#import "DailyDetailChoosePersonController.h"
#import "ChoiceWorkView.h"
#import "FanNumViewController.h"
#import "SoapUtil.h"

#import "ShareConstruction.h"
#import "HoistingModel.h"
#import "FlightNoController.h"


@interface HoistingDebugAddController ()
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat lastTextHeight4;
    CGFloat lastTextHeight5;
    CGFloat lastTextHeight6;
    CGFloat lastTextHeight7;
    CGFloat lastTextHeight8;
    CGFloat lastTextHeight9;
    CGFloat lastTextHeight10;
    CGFloat lastTextHeight11;
    CGFloat lastTextHeight12;
    CGFloat keyboardHeight;
    
    NSString *PERSONID;
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 创建日期:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
// 项目负责人：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 项目负责人描述：
@property (nonatomic, strong) ProblemItemLTView *thirdRow;
// 当前项目阶段：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// 当日工作内容:
@property (nonatomic, strong) ProblemItemLTView *fifthRow;
// 详细工作内容
@property (nonatomic, strong) ProblemItemTitleView *sixthRow;
// 机位号：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 备注：
@property (nonatomic, strong) ProblemItemLTView *eighthRow;
// 吊装开始：
@property (nonatomic, strong) ProblemItemLTView *ninthRow;
// 吊装完成
@property (nonatomic, strong) ProblemItemLTView *tenthRow;
// 安装验收
@property (nonatomic, strong) ProblemItemLTView *eleventhRow;
// 并网调试
@property (nonatomic, strong) ProblemItemLTView *twelfthRow;
// 动态调试
@property (nonatomic, strong) ProblemItemLTView *thirteenthRow;
// 调试验收
@property (nonatomic, strong) ProblemItemLTView *fourteenthRow;
// 试运行开始
@property (nonatomic, strong) ProblemItemLTView *fifteenthRow;
// 试运行完成
@property (nonatomic, strong) ProblemItemLTView *sixteenthRow;
// 预验收完成
@property (nonatomic, strong) ProblemItemLTView *seventeenthRow;

@end

@implementation HoistingDebugAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增吊装调试日报";
    self.rootViewHeight.constant = 1010;
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
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"创建日期:";
    self.firstRow.contentLabel.text = kGetCurrentTime(@"yyyy-MM-dd");
    self.firstRow.contentLabel.textColor = [UIColor blackColor];
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLLI;
    self.secondRow.titleLabel.text = @"项目负责人:";
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLTView showXibView];
    self.thirdRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.thirdRow.titleLabel.text = @"项目负责人描述:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLLI;
    self.forthRow.titleLabel.text = @"当前项目阶段:";
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLTView showXibView];
    self.fifthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.fifthRow.titleLabel.text = @"当日工作内容:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.sixthRow = [ProblemItemTitleView showXibView];
    self.sixthRow.titleLabel.text = @"详细工作内容:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemItemTypeDefaultLLI;
    self.seventhRow.titleLabel.text = @"机位号:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLTView showXibView];
    self.eighthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.eighthRow.titleLabel.text = @"备注:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.ninthRow = [ProblemItemLTView showXibView];
    self.ninthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.ninthRow.titleLabel.text = @"主机累计到货数:";
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.tenthRow = [ProblemItemLTView showXibView];
    self.tenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.tenthRow.titleLabel.text = @"轮毂累计到货数:";
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.eleventhRow = [ProblemItemLTView showXibView];
    self.eleventhRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.eleventhRow.titleLabel.text = @"叶片累计到货数:";
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.twelfthRow = [ProblemItemLTView showXibView];
    self.twelfthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.twelfthRow.titleLabel.text = @"基础浇筑完成累计数:";
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.thirteenthRow = [ProblemItemLTView showXibView];
    self.thirteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.thirteenthRow.titleLabel.text = @"吊装完成累计数:";
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.fourteenthRow = [ProblemItemLTView showXibView];
    self.fourteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.fourteenthRow.titleLabel.text = @"安装验收完成累计数:";
    [self.rootView addSubview:self.fourteenthRow];
    [self.fourteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.fifteenthRow = [ProblemItemLTView showXibView];
    self.fifteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.fifteenthRow.titleLabel.text = @"试运行台数:";
    [self.rootView addSubview:self.fifteenthRow];
    [self.fifteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.sixteenthRow = [ProblemItemLTView showXibView];
    self.sixteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.sixteenthRow.titleLabel.text = @"试运行完成台数:";
    [self.rootView addSubview:self.sixteenthRow];
    [self.sixteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.seventeenthRow = [ProblemItemLTView showXibView];
    self.seventeenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.seventeenthRow.titleLabel.text = @"预验收完成台数:";
    [self.rootView addSubview:self.seventeenthRow];
    [self.seventeenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
}

- (void)addBlocks{
    WEAKSELF
    
    self.secondRow.executeTapContentLabel = ^(){
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择联系人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            if (model.DISPLAYNAME.length > 0) {
                PERSONID = model.PERSONID;
                weakSelf.secondRow.contentLabel.text = model.DISPLAYNAME;
                weakSelf.secondRow.contentLabel.textColor = [UIColor blackColor];
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.forthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeProjectPhase];
        work.WorkBlock = ^(NSString *str){
            weakSelf.forthRow.contentLabel.text = str;
            weakSelf.forthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
    };
    
    self.seventhRow.executeTapContentLabel = ^(){
//        FanNumViewController *fan = [[FanNumViewController alloc]init];
//        fan.type = ChooseTypeFNI;
//        fan.executeCellClick = ^(FanNumModle *mode){
//            if (mode.ITEMNUM.length > 0) {
//                weakSelf.seventhRow.contentLabel.text = mode.ITEMNUM;
//                weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
//            }
//        };
//        [weakSelf.navigationController pushViewController:fan animated:YES];
        
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.requestCoding = weakSelf.requestStr;
        choose.executeCellClick = ^(FlightNoModel *model){
            weakSelf.seventhRow.contentLabel.text = model.LOCNUM;
            weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    
    self.thirdRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateThirdRowWithHeight:textHeight animated:YES];
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
    
    self.tenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatetenthRowWithHeight:textHeight animated:YES];
    };
    
    self.eleventhRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateeleventhRowWithHeight:textHeight animated:YES];
    };
    
    self.twelfthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatetwelfthRowWithHeight:textHeight animated:YES];
    };
    
    self.thirteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatethirteenthRowWithHeight:textHeight animated:YES];
    };
    
    self.fourteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatefourteenthRowWithHeight:textHeight animated:YES];
    };
    
    self.fifteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatefifteenthRowWithHeight:textHeight animated:YES];
    };
    
    self.sixteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updatesixteenthRowWithHeight:textHeight animated:YES];
    };
    
    self.seventeenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateseventeenthRowWithHeight:textHeight animated:YES];
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
    
    /*
     "PRORUNLOGNUM":"1086",
     "TYPE":"add",
     "relationShip":[{"UDPRORUNLOGLINE2":""}]
     
     "CREATEDATE":"2016-11-08",
     "PERSONID":"A10078",
     "PROPHASE":"调试期",
     "NAME":"闵红卫",
     "WORKJOB":"当日工作内容"
     
     "DZNUM":"001#",
     "REMARK1":"备注",
     "CLXPRODUCTION":"主机累计到货数",
     "COMPCHECKING":"轮毂累计到货数",
     "COMPRUNNING":"叶片累计到货数",
     "BASECOMP":"基础浇筑完成累计数",
     "BPQPRODUCTION":"吊装完成累计数",
     "DEBUGGING":"电气安装完成累计数",
     "DEBUGGING2":"安装验收完成累计数",
     "DATE1":"2016-11-01",
     "DATE2":"2016-11-02",
     "DATE3":"2016-11-03",
     "DEBUGGINGCHECK":"试运行台数",
     "DZCOMP":"试运行完成台数",
     "DZSTART":"预验收完成台数",
     */
    self.firstRow.contentLabel.text=[NSString stringWithFormat:@"%@ 00:00:00",self.firstRow.contentLabel.text];
    NSDictionary *dic = @{
                          @"PRORUNLOGNUM":self.PRORUNLOGNUM?self.PRORUNLOGNUM:@"",
                          @"TYPE":@"add",
                          @"CREATEDATE":self.firstRow.contentLabel.text?self.firstRow.contentLabel.text:@"",
                          @"PERSONID":PERSONID?PERSONID:@"",
                          @"PROPHASE":self.forthRow.contentLabel.text?self.forthRow.contentLabel.text:@"",
                          @"NAME":self.secondRow.contentLabel.text?self.secondRow.contentLabel.text:@"",
                          @"WORKJOB":self.fifthRow.contentText.text?self.fifthRow.contentText.text:@"",
                          @"DZNUM":self.seventhRow.contentLabel.text?self.seventhRow.contentLabel.text:@"",
                          @"REMARK1":self.eighthRow.contentText.text?self.eighthRow.contentText.text:@"",
                          @"CLXPRODUCTION":self.ninthRow.contentText.text?self.ninthRow.contentText.text:@"",
                          @"COMPCHECKING":self.tenthRow.contentText.text?self.tenthRow.contentText.text:@"",
                          @"COMPRUNNING":self.eleventhRow.contentText.text?self.eleventhRow.contentText.text:@"",
                          @"BASECOMP":self.twelfthRow.contentText.text?self.twelfthRow.contentText.text:@"",
                          @"BPQPRODUCTION":self.thirteenthRow.contentText.text?self.thirteenthRow.contentText.text:@"",
//                          "DEBUGGING":"电气安装完成累计数",
                          @"DEBUGGING2":self.fourteenthRow.contentText.text?self.fourteenthRow.contentText.text:@"",
                          @"DEBUGGINGCHECK":self.fifteenthRow.contentText.text?self.fifteenthRow.contentText.text:@"",
                          @"DZCOMP":self.sixteenthRow.contentText.text?self.sixteenthRow.contentText.text:@"",
                          @"DZSTART":self.seventeenthRow.contentText.text?self.seventeenthRow.contentText.text:@"",
                          };
    
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    shareConstruction.hoisting = [HoistingModel mj_objectWithKeyValues:dic];
    shareConstruction.hoisting.dic = dic;
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

- (void)updateThirdRowWithHeight:(CGFloat)height animated:(BOOL)animated {
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

- (void)updatefifthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
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
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
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
    CGFloat scrollHeight = height - lastTextHeight4;
    lastTextHeight4 = height;
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

- (void)updatetenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight5;
    lastTextHeight5 = height;
    [self.tenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.tenthRow.contentText convertRect:self.tenthRow.contentText.bounds toView:self.view];
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

- (void)updatethirteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight8;
    lastTextHeight8 = height;
    [self.thirteenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.thirteenthRow.contentText convertRect:self.thirteenthRow.contentText.bounds toView:self.view];
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

- (void)updatefourteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight9;
    lastTextHeight9 = height;
    [self.fourteenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.fourteenthRow.contentText convertRect:self.fourteenthRow.contentText.bounds toView:self.view];
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

- (void)updatefifteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight10;
    lastTextHeight10 = height;
    [self.fifteenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.fifteenthRow.contentText convertRect:self.fifteenthRow.contentText.bounds toView:self.view];
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

- (void)updatesixteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight11;
    lastTextHeight11 = height;
    [self.sixteenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.sixteenthRow.contentText convertRect:self.sixteenthRow.contentText.bounds toView:self.view];
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

- (void)updateseventeenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight12;
    lastTextHeight12 = height;
    [self.seventeenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.seventeenthRow.contentText convertRect:self.seventeenthRow.contentText.bounds toView:self.view];
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
