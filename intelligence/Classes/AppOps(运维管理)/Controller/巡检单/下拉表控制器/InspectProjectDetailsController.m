//
//  InspectProjectDetailsController.m
//  intelligence
//
//  Created by  on 16/8/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "InspectProjectDetailsController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ProblemItemLBView.h"
#import "SoapUtil.h"
#import "DTKDropdownMenuView.h"
#import "ShareConstruction.h"
#import "UploadPicturesViewController.h"

@interface InspectProjectDetailsController ()
{
    CGFloat lastTextHeight;
    CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 任务:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
// 描述：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 系统/项目：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// 子系统/子项目：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// 标准/检修方法:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
// 序号:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
// T巡检部位：
@property (nonatomic, strong) ProblemItemLTView *seventhRow;
// 是否完成：
@property (nonatomic, strong) ProblemItemLBView *eighthRow;

@end

@implementation InspectProjectDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"巡检项目详情";
    self.rootViewHeight.constant = 470;
    [self createUI];
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];
    [self addRightNavBarItem];
}

- (void)addNotification{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
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
    
    NSString *yorn;
    if (self.eighthRow.chooseBtn.selected) {
        yorn = @"Y";
    }else{
        yorn = @"N";
    }
    NSDictionary *dic = @{
                          @"JPTASK":[self determineString:self.firstRow.contentLabel.text],
                          @"DESCRIPTION":[self determineString:self.secondRow.contentLabel.text],
                          @"JO1":[self determineString:self.thirdRow.contentLabel.text],
                          @"JO2":[self determineString:self.forthRow.contentLabel.text],
                          @"JO3":[self determineString:self.fifthRow.contentLabel.text],
                          @"SERIALNUM":[self determineString:self.sixthRow.contentLabel.text],
                          @"INSPUNIT":[self determineString:self.seventhRow.contentText.text],
                          @"OK":yorn,
//                          @"mboObjectName" : @"UDINSPO"
                          };
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    shareConstruction.inspectProject = [InspectProjectModel mj_objectWithKeyValues:dic];
    shareConstruction.inspectProject.dic = dic;
    [self.navigationController popViewControllerAnimated:YES];
    if (self.executeupdata) {
        self.executeupdata(self.index);
    }
}

- (NSString *)determineString:(NSString *)str{
    if([str isEqualToString:@"暂无数据"] ||
       str.length < 1){
        return @"";
    }else{
        return str;
    }
}

- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_commit" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0] icon:@"more"];
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)pushWithIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = @"UDINSPROJECT";
            vc.ownerid = self.inspectProject.UDINSPROJECTID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)createUI{
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"任务:";
    if (self.inspectProject.JPTASK.length > 0) {
        self.firstRow.contentLabel.text = self.inspectProject.JPTASK;
        self.firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLL;
    self.secondRow.titleLabel.text = @"描述:";
    if (self.inspectProject.DESCRIPTION.length > 0) {
        self.secondRow.contentLabel.text = self.inspectProject.DESCRIPTION;
        self.secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdRow.titleLabel.text = @"系统/项目:";
    if (self.inspectProject.JO1.length > 0) {
        self.thirdRow.contentLabel.text = self.inspectProject.JO1;
        self.thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLL;
    self.forthRow.titleLabel.text = @"子系统/子项目:";
    if (self.inspectProject.JO2.length > 0) {
        self.forthRow.contentLabel.text = self.inspectProject.JO2;
        self.forthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLL;
    self.fifthRow.titleLabel.text = @"标准/检修方法:";
    if (self.inspectProject.JO3.length > 0) {
        self.fifthRow.contentLabel.text = self.inspectProject.JO3;
        self.fifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    CGFloat fifthRowHeight = [self computeHeight:self.fifthRow.contentLabel];
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(fifthRowHeight);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemItemTypeDefaultLL;
    self.sixthRow.titleLabel.text = @"序号:";
    if (self.inspectProject.SERIALNUM.length > 0) {
        self.sixthRow.contentLabel.text = self.inspectProject.SERIALNUM;
        self.sixthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLTView showXibView];
    self.seventhRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.seventhRow.titleLabel.text = @"巡检部位:";
    if (self.inspectProject.LOCDESC.length > 0) {
        self.seventhRow.contentText.text = self.inspectProject.LOCDESC;
        self.seventhRow.contentText.textColor = [UIColor blackColor];
        self.seventhRow.placeholderLabel.text = @"";
    }
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.eighthRow = [ProblemItemLBView showXibView];
    self.eighthRow.titleLabel.text = @"已完成:";
    if ([self.inspectProject.OK isEqualToString:@"Y"]) {
        self.eighthRow.chooseBtn.selected = YES;
    }else{
        self.eighthRow.chooseBtn.selected = NO;
    }
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addBlocks{
    WEAKSELF
    self.seventhRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSeventhRowWithHeight:textHeight animated:YES];
    };
}

- (void)updateSeventhRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
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

- (CGFloat)computeHeight:(UILabel *)label{
    CGSize labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(ScreenWidth - 120 - 20 - 5, MAXFLOAT)];
    CGFloat labelHeight = labelSize.height;
    if (labelHeight + 20 > 45) {
        self.rootViewHeight.constant += (labelHeight - 20);
        return labelHeight + 20;
    }
    return 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
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
