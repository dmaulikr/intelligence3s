//
//  ConstructionDailyAddController.m
//  intelligence
//
//  Created by  on 16/8/12.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ConstructionDailyAddController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ProblemItemLBView.h"
#import "ChoiceWorkView.h"

#import "DailyDetailChoosePersonController.h"
#import "FanNumViewController.h"
#import "ChoiceWorkView.h"
#import "SoapUtil.h"

#import "ConstructionModel.h"
#import "ShareConstruction.h"
#import "FlightNoController.h"

@interface ConstructionDailyAddController ()
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat lastTextHeight4;
    CGFloat lastTextHeight5;
    CGFloat keyboardHeight;
    
    NSString *boolStr;
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
// 风机号：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// *当前项目阶段：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// 征地:
@property (nonatomic, strong) ProblemItemLTView *fifthRow;
// 场内道路:
@property (nonatomic, strong) ProblemItemLTView *sixthRow;
// 场外道路：
@property (nonatomic, strong) ProblemItemLTView *seventhRow;
// 村民阻工：
@property (nonatomic, strong) ProblemItemLBView *eighthRow;
// 备注：
@property (nonatomic, strong) ProblemItemLTView *ninthRow;
// 现场重点描述
@property (nonatomic, strong) ProblemItemLTView *tenthRow;
// 基础开挖
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
//
@property (nonatomic, strong) TXTimeChoose *timeYear_first;
// 基础浇筑
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
//
@property (nonatomic, strong) TXTimeChoose *timeYear_second;
// 基础环到货
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;
//
@property (nonatomic, strong) TXTimeChoose *timeYear_third;
// 塔筒到货
@property (nonatomic, strong) ProblemItemLLIView *fourteenthRow;
//
@property (nonatomic, strong) TXTimeChoose *timeYear_fouth;
// 现场押车记录
@property (nonatomic, strong) ProblemItemLLIView *fifteenthRow;

@end


@implementation ConstructionDailyAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增土建阶段日报详情";
    self.rootViewHeight.constant = 805;
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
    WEAKSELF
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
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLLI;
    self.thirdRow.titleLabel.text = @"风机号:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
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
    self.fifthRow.titleLabel.text = @"征地:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.sixthRow = [ProblemItemLTView showXibView];
    self.sixthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.sixthRow.titleLabel.text = @"场内跑道:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.seventhRow = [ProblemItemLTView showXibView];
    self.seventhRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.seventhRow.titleLabel.text = @"场外跑道:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.eighthRow = [ProblemItemLBView showXibView];
    self.eighthRow.titleLabel.text = @"村民阻工:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLTView showXibView];
    self.ninthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.ninthRow.titleLabel.text = @"备注:";
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    self.ninthRow.executeTextHeightChage = ^(CGFloat textHeight) {
        
        [weakSelf popInputTextViewContent:weakSelf.ninthRow.contentText.text title:weakSelf.ninthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.ninthRow.contentText.text=value;
        }];
    };
    
    self.tenthRow = [ProblemItemLTView showXibView];
    self.tenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.tenthRow.titleLabel.text = @"现场重难点描述:";
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    self.tenthRow.executeTextHeightChage = ^(CGFloat textHeight) {
        [weakSelf popInputTextViewContent:weakSelf.tenthRow.contentText.text title:weakSelf.tenthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.tenthRow.contentText.text=value;
        }];
    };
    
    
    
    
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLLI;
    self.eleventhRow.titleLabel.text = @"基础开挖:";
    self.eleventhRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.eleventhRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemItemTypeDefaultLLI;
    self.twelfthRow.titleLabel.text = @"基础浇筑:";
    self.twelfthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.twelfthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemDetailsTypeMustLLI;
    self.thirteenthRow.titleLabel.text = @"基础环到货:";
    self.thirteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.thirteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fourteenthRow = [ProblemItemLLIView showXibView];
    self.fourteenthRow.type = ProblemItemTypeDefaultLLI;
    self.fourteenthRow.titleLabel.text = @"塔筒到货:";
    self.fourteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.fourteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    [self.rootView addSubview:self.fourteenthRow];
    [self.fourteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifteenthRow = [ProblemItemLLIView showXibView];
    self.fifteenthRow.type = ProblemItemTypeDefaultLT;
    self.fifteenthRow.titleLabel.text = @"现场押车记录:";
    [self.rootView addSubview:self.fifteenthRow];
    [self.fifteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
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
    
    self.thirdRow.executeTapContentLabel = ^(){
        FlightNoController *choose = [[FlightNoController alloc]init];
        choose.requestCoding = weakSelf.requestStr;
        choose.executeCellClick = ^(FlightNoModel *model){
            weakSelf.thirdRow.contentLabel.text = model.LOCNUM;
            weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    
    self.forthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeProjectPhase];
        work.WorkBlock = ^(NSString *str){
            weakSelf.forthRow.contentLabel.text = str;
            weakSelf.forthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [work ShowInView:weakSelf.view];
    };
    
    self.fifthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateFifthRowWithHeight:textHeight animated:YES];
    };
    
    self.sixthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSixthRowWithHeight:textHeight animated:YES];
    };
    
    self.seventhRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSeventhRowWithHeight:textHeight animated:YES];
    };
    
    self.ninthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateNinthRowWithHeight:textHeight animated:YES];
    };
    
    self.tenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateTenthRowWithHeight:textHeight animated:YES];
    };
    
    self.eleventhRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_first];
    };
    
    self.twelfthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_second];
    };
    
    self.thirteenthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_third];
    };
    
    self.fourteenthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_fouth];
    };
}

- (void)addScrollFooterView{
    WEAKSELF
    self.footerView = [DailyDetailsFooterView showXibView];
    self.footerView.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    self.footerView.executeBtnCancelClick = ^(){

        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.footerView.executeBtnSaveClick = ^(){

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
     "TYPE":"add",
     "CREATEDATE":"2016-11-09",
     "PERSONDESC":"闵红卫",
     "PERSONID":"A10078",
     "FUNNUM":"001#",
     "PROPHASE":"调试期",
     "LAND":"征地",
     "INSIDEROAD":"场内跑到",
     "OUTSIDEROAD":"场外跑到",
     "VILLAGERINVOLVED":"1"
     "REMARK":"备注",
     "KEYPOINT":"现场重点描述",
     "BASESTART":"2016-11-01",
     "BASEPLACING":"2016-11-02",
     "BASEAOG":"2016-11-03",
     "TAMERAOG":"2016-11-04",
     "VEHICLERECORDS":"现场押车记录",
     }*/
    
    if (self.eighthRow.chooseBtn.selected) {
        boolStr = @"Y";
    }else{
        boolStr = @"N";
    }
    
    NSDictionary *dic = @{
                          @"TYPE":@"add",
                          @"PRORUNLOGNUM":self.PRORUNLOGNUM?self.PRORUNLOGNUM:@"",
                          @"CREATEDATE":[self determineString:self.firstRow.contentLabel.text],
                          @"PERSONDESC":[self determineString:self.secondRow.contentLabel.text],
                          @"PERSONID" :PERSONID,
                          @"FUNNUM":[self determineString:self.thirdRow.contentLabel.text],
                          @"PROPHASE":[self determineString:self.forthRow.contentLabel.text],
                          @"LAND":[self determineString:self.fifthRow.contentText.text],
                          @"INSIDEROAD":[self determineString:self.sixthRow.contentText.text],
                          @"OUTSIDEROAD":[self determineString:self.seventhRow.contentText.text],
                          @"VILLAGERINVOLVED":boolStr,
                          @"REMARK":[self determineString:self.ninthRow.contentText.text],
                          @"KEYPOINT":[self determineString:self.tenthRow.contentText.text],
                          @"BASESTART":[self determineString:self.eleventhRow.contentLabel.text],
                          @"BASEPLACING":[self determineString:self.twelfthRow.contentLabel.text],
                          @"BASEAOG":[self determineString:self.thirteenthRow.contentLabel.text],
                          @"TAMERAOG":[self determineString:self.fourteenthRow.contentLabel.text],
                          @"VEHICLERECORDS" : [self determineString:self.fifteenthRow.contentLabel.text],
                          };
    
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    shareConstruction.construction = [ConstructionModel mj_objectWithKeyValues:dic];
    shareConstruction.construction.dic = dic;
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

- (void)updateFifthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
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

- (void)updateSixthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
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


- (void)updateSeventhRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
    [self.seventhRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.seventhRow.contentText convertRect:self.seventhRow.contentText.bounds toView:self.view];
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

- (void)updateNinthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
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

- (void)updateTenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
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
            weakSelf.eleventhRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.eleventhRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_first;
}

- (TXTimeChoose *)timeYear_second{
    WEAKSELF
    if (!_timeYear_second) {
        _timeYear_second = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_second.backString = ^(NSDate *data){
            weakSelf.twelfthRow.contentLabel.text = [weakSelf.timeYear_second stringFromDate:data];
            weakSelf.twelfthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_second;
}

- (TXTimeChoose *)timeYear_third{
    WEAKSELF
    if (!_timeYear_third) {
        _timeYear_third = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_third.backString = ^(NSDate *data){
            weakSelf.thirteenthRow.contentLabel.text = [weakSelf.timeYear_third stringFromDate:data];
            weakSelf.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_third;
}

- (TXTimeChoose *)timeYear_fouth{
    WEAKSELF
    if (!_timeYear_fouth) {
        _timeYear_fouth = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_fouth.backString = ^(NSDate *data){
            weakSelf.fourteenthRow.contentLabel.text = [weakSelf.timeYear_fouth stringFromDate:data];
            weakSelf.fourteenthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_fouth;
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
