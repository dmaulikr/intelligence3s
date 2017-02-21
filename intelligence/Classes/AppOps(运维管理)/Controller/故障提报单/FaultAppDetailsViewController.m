//
//  FaultAppDetailsViewController.m
//  intelligence
//
//  Created by  on 16/8/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FaultAppDetailsViewController.h"
#import "DailyDetailsFooterView.h"
#import "DTKDropdownMenuView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ProblemItemLBView.h"
#import "ChoiceWorkView.h"

#import "FlightNoController.h"
#import "SoapUtil.h"

#import "FaultClassController.h"
#import "FaultCodeController.h"
#import "CauseProblemViewController.h"
#import "UploadPicturesViewController.h"
#import "DailyDetailChoosePersonController.h"
#import "FlightNoModel.h"
#import "EquipmentLocationController.h"
#import "ApprovalsView.h"
@interface FaultAppDetailsViewController ()<UIAlertViewDelegate>
{
    CGFloat lastTextHeight;
    CGFloat lastTextHeight2;
    CGFloat lastTextHeight3;
    CGFloat keyboardHeight;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;
@property (nonatomic, copy)     NSString *str1;


// 编号:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
// 描述：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 中心：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// *项目编号：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// 项目名称:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
// *机位号:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
// *设备位置：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 故障等级：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
// 故障类型：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
// *报障时间
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;
// 故障是否已结束
@property (nonatomic, strong) ProblemItemLBView *eleventhRow;
// 故障结束时间
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
// 状态
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;
// 是否由集控生成
@property (nonatomic, strong) ProblemItemLBView *fourteenthRow;
// 提报人
@property (nonatomic, strong) ProblemItemLLIView *fifteenthRow;
// 提报时间
@property (nonatomic, strong) ProblemItemLLIView *sixteenthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_second;
// 故障类
@property (nonatomic, strong) ProblemItemLLIView *seventeenthRow;
// 故障代码
@property (nonatomic, strong) ProblemItemLLIView *eighteenthRow;
// 故障描述
@property (nonatomic, strong) ProblemItemLTView *nineteenthRow;
// 处理结果
@property (nonatomic, strong) ProblemItemLTView *twentiethRow;
// 备注
@property (nonatomic, strong) ProblemItemLTView *twentyfirstRow;
// 故障工单号
@property (nonatomic, strong) ProblemItemLLIView *twentysecondRow;
// 质量问题反馈单号 23
@property (nonatomic, strong) ProblemItemLLIView *twentythirdRow;

@end

@implementation FaultAppDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootViewHeight.constant = 1150;
    [self addViews];
    [self addBlocks];
    [self addScrollFooterView];
    [self addNotification];
    [self addRightNavBarItem];
    
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDREPORT" objectName:@"UDREPORT" status:self.pault.STATUSTYPE compeletion:^(NSArray *fields) {
        NSLog(@"故障提报单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
}



- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"生成故障工单" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"生成质量问题反馈单" iconName:@"ic_realinfo" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [self checkRequiredFieldcompeletion:^(BOOL isOK) {
            if (isOK) {
                [self sendData];
            }
        }];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_commit" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
        
    }];
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"故障原因及措施" iconName:@"ic_failreport" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2,item3,item4] icon:@"more"];
    
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

- (void)pushWithIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            [self updataForFirst];
        }break;
        case 1:{
            if ([self.pault.STATUSTYPE isEqualToString:@"已提报"]) {
                [self updataForSecond];
            }else{
                HUDNormal(@"已提报状态才可以生成质量问题反馈单")
            }
            
        }break;
        case 2:{
            NSLog(@"发送工作流");
        }break;
        case 3:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = @"UDREPORT";
            vc.ownerid = self.pault.UDREPORTID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 4:{
            CauseProblemViewController *vc = [[CauseProblemViewController alloc] init];
            if ([self.eighteenthRow.contentLabel.text isEqualToString:@"暂无数据"] || self.eighteenthRow.contentLabel.text.length < 1) {
                HUDNormal(@"请选择故障代码")
                return;
            }
            vc.requestCode = self.eighteenthRow.contentLabel.text;
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

- (void)updataForFirst{
    SVHUD_NO_Stop(@"生成中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"0"]) {
            NSString *str = [NSString stringWithFormat:@"单号%@生成成功",dic[@"WONUM"]];
            HUDNormal(str);
            self.twentysecondRow.contentLabel.text = dic[@"WONUM"];
            self.twentysecondRow.contentLabel.textColor = [UIColor blackColor];
//            [self performSelector:@selector(updata) withObject:nil afterDelay:1.0f];
        }else{
            HUDNormal(@"生成失败");
        }
    };
    NSDictionary *dict = @{};
    NSArray *relationShip = @[dict];

    AccountModel *account = [AccountManager account];
    NSDictionary *dic = @{
                          @"BRANCH":[self determineString:self.pault.BRANCH],
                          @"CREATEBY" : [self determineString:self.pault.CREATEBY],
                          @"CREATEDATE":[self determineString:self.sixteenthRow.contentLabel.text],
                          @"FAILURECODE":[self determineString:self.seventeenthRow.contentLabel.text],
                          @"ISBIGPAR":@"0",
                          @"ISSTOPED":@"0",
                          @"PERINSPR":@"0",
                          @"PROBLEMCODE":[self determineString:self.eighteenthRow.contentLabel.text],
                          @"UDLOCATION" : [self determineString:self.seventhRow.contentLabel.text],
                          @"UDLOCNUM":[self determineString:self.sixthRow.contentLabel.text],
                          @"UDPROJECTNUM":[self determineString:self.forthRow.contentLabel.text],
                          @"UDREPORTNUM":[self determineString:self.firstRow.contentLabel.text],
                          @"UDRPRRSB":[self determineString:account.userName],
                          @"UDZGLIMIT":[self determineString:self.tenthRow.contentLabel.text],
                          @"UDSTATUS":[self determineString:self.thirteenthRow.contentLabel.text],
                          @"WORKTYPE":@"FR",
                          @"WONUM" : [self determineString:self.twentysecondRow.contentLabel.text],
                          @"UDPBFORMNUM":[self determineString:self.twentythirdRow.contentLabel.text],
                          @"relationShip":relationShip,
                          };
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"WORKORDER"},
                     @{@"mboKey" : @"WONUM"},
                     @{@"personId" : account.personId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}

- (void)updataForSecond{
    SVHUD_NO_Stop(@"生成中");
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"0"]) {
            NSString *str1 = [NSString stringWithFormat:@"%@",dic[@"QTYFORMNUM"]];
            NSString *str2 = [NSString stringWithFormat:@"单号%@生成成功",str1];
            self.twentythirdRow.contentLabel.text = dic[@"QTYFORMNUM"];
            self.twentythirdRow.contentLabel.textColor = [UIColor blackColor];
            HUDNormal(str2);
        }else{
            HUDNormal(dic[@"errorMsg"]);
        }
    };
    NSDictionary *dict = @{};
    NSArray *relationShip = @[dict];
    
    /*{"FAULTDATE":"2016-08-04",
     "relationShip":[{}],
     "PRONUM":"S1-20140042",
     "PERSONID":"ZHANGS"}
     ("mboObjectName",
     mboObjectName);
     //表名   UDQTYFORM
     ("mboKey", mboKey);
     //表主键     QTYFORMNUM
     */
    
    
    AccountModel *account = [AccountManager account];
    NSDictionary *dic = @{
                          @"FAULTDATE":[self determineString:self.tenthRow.contentLabel.text],
                          @"PRONUM":[self determineString:self.firstRow.contentLabel.text],
                          @"relationShip":relationShip,
                          };
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDQTYFORM"},
                     @{@"mboKey" : @"QTYFORMNUM"},
                     @{@"personId" : account.personId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
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

- (void)addViews{
    
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"编号:";
    if (self.pault.REPORTNUM.length > 0) {
        self.firstRow.contentLabel.text = self.pault.REPORTNUM;
        self.firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"编号" forKey:@"REPORTNUM"];
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLL;
    self.secondRow.titleLabel.text = @"描述:";
    if (self.pault.DESCRIPTION.length > 0) {
        self.secondRow.contentLabel.text = self.pault.DESCRIPTION;
        self.secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    CGFloat secondRowHeight = [self computeHeight:self.secondRow.contentLabel];
    [self.SetingItems setValue:@"描述" forKey:@"DESCRIPTION"];
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(secondRowHeight);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdRow.titleLabel.text = @"中心:";
    if (self.pault.BRANCHDESC.length > 0) {
        self.thirdRow.contentLabel.text = self.pault.BRANCHDESC;
        self.thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"中心" forKey:@"BRANCHDESC"];
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemDetailsTypeMustLLI;
    self.forthRow.titleLabel.text = @"项目编号:";
    if (self.pault.PRONUM.length > 0) {
        self.forthRow.contentLabel.text = self.pault.PRONUM;
        self.forthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目编号" forKey:@"PRONUM"];
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLL;
    self.fifthRow.titleLabel.text = @"项目名称:";
    if (self.pault.PRODESC.length > 0) {
        self.fifthRow.contentLabel.text = self.pault.PRODESC;
        self.fifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"项目名称" forKey:@"PRODESC"];
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemDetailsTypeMustLLI;
    self.sixthRow.titleLabel.text = @"机位号:";
    if (self.pault.LOCATION_CODE.length > 0) {
        self.sixthRow.contentLabel.text = self.pault.LOCATION_CODE;
        self.sixthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"机位号" forKey:@"LOCATION_CODE"];
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemDetailsTypeMustLLI;
    self.seventhRow.titleLabel.text = @"设备位置:";
    if (self.pault.LOCATION.length > 0) {
        self.seventhRow.contentLabel.text = self.pault.LOCATION;
        self.seventhRow.contentLabel.textColor = [UIColor blackColor];
    }
    CGFloat secondRowHeight1 = [self computeHeight:self.seventhRow.titleLabel];
    [self.SetingItems setValue:@"设备位置" forKey:@"LOCATION"];
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(secondRowHeight1);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLLI;
    self.eighthRow.titleLabel.text = @"故障等级:";
    if (self.pault.UDGZDJ.length > 0) {
        self.eighthRow.contentLabel.text = self.pault.UDGZDJ;
        self.eighthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障等级" forKey:@"UDGZDJ"];
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLLI;
    self.ninthRow.titleLabel.text = @"故障类型:";
    if (self.pault.UDGZTYPE.length > 0) {
        self.ninthRow.contentLabel.text = self.pault.UDGZTYPE;
        self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障类型" forKey:@"UDGZTYPE"];
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemDetailsTypeMustLLI;
    self.tenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.tenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.tenthRow.titleLabel.text = @"报障时间:";
    if (self.pault.HAPPEN_TIME.length > 0) {
        self.tenthRow.contentLabel.text = self.pault.HAPPEN_TIME;
        self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"报障时间" forKey:@"HAPPEN_TIME"];
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLBView showXibView];
    self.eleventhRow.titleLabel.text = @"故障是否结束:";
    if ([self.pault.IS_END isEqualToString:@"Y"]) {
        self.eleventhRow.chooseBtn.selected = YES;
    }
    [self.SetingItems setValue:@"故障是否结束" forKey:@"IS_END"];
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemItemTypeDefaultLLI;
    self.twelfthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.twelfthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.twelfthRow.titleLabel.text = @"故障结束时间:";
    if (self.pault.END_TIME.length > 0) {
        self.twelfthRow.contentLabel.text = self.pault.END_TIME;
        self.twelfthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障结束时间" forKey:@"END_TIME"];
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemItemTypeDefaultLLI;
    self.thirteenthRow.titleLabel.text =  @"状态:";
    if (self.pault.STATUSTYPE.length > 0) {
        self.thirteenthRow.contentLabel.text = self.pault.STATUSTYPE;
        self.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"状态" forKey:@"STATUSTYPE"];
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fourteenthRow = [ProblemItemLBView showXibView];
    self.fourteenthRow.titleLabel.text = @"是否由集控生成:";
    if ([self.pault.CUISPLAN isEqualToString:@"Y"]) {
        self.fourteenthRow.chooseBtn.selected = YES;
    }
    [self.SetingItems setValue:@"是否由集控生成" forKey:@"CUISPLAN"];
    [self.rootView addSubview:self.fourteenthRow];
    [self.fourteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifteenthRow = [ProblemItemLLIView showXibView];
    self.fifteenthRow.type = ProblemItemTypeDefaultLL;
    self.fifteenthRow.titleLabel.text = @"提报人:";
    if (self.pault.CREATEBY.length > 0) {
        self.fifteenthRow.contentLabel.text = self.pault.CREATEBY;
        self.fifteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"提报人" forKey:@"CREATEBY"];
    [self.rootView addSubview:self.fifteenthRow];
    [self.fifteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixteenthRow = [ProblemItemLLIView showXibView];
    self.sixteenthRow.type = ProblemItemTypeDefaultLL;
    self.sixteenthRow.titleLabel.text = @"提报时间:";
    if (self.pault.REPORTTIME.length > 0) {
        self.sixteenthRow.contentLabel.text = self.pault.REPORTTIME;
        self.sixteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"提报时间" forKey:@"REPORTTIME"];
    [self.rootView addSubview:self.sixteenthRow];
    [self.sixteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventeenthRow = [ProblemItemLLIView showXibView];
    self.seventeenthRow.type = ProblemDetailsTypeMustLLI;
    self.seventeenthRow.titleLabel.text = @"故障类:";
    if (self.pault.FAULT_CODE.length > 0) {
        self.seventeenthRow.contentLabel.text = self.pault.FAULT_CODE;
        self.seventeenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障类" forKey:@"FAULT_CODE"];
    [self.rootView addSubview:self.seventeenthRow];
    [self.seventeenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighteenthRow = [ProblemItemLLIView showXibView];
    self.eighteenthRow.type = ProblemDetailsTypeMustLLI;
    self.eighteenthRow.titleLabel.text = @"故障代码:";
    if (self.pault.FAULT_CODE1.length > 0) {
        self.eighteenthRow.contentLabel.text = self.pault.FAULT_CODE1;
        self.eighteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障代码" forKey:@"FAULT_CODE1"];
    [self.rootView addSubview:self.eighteenthRow];
    [self.eighteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventeenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.nineteenthRow = [ProblemItemLTView showXibView];
    self.nineteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.nineteenthRow.titleLabel.text = @"故障描述:";
    if (self.pault.CUDESCRIBE.length) {
        self.nineteenthRow.contentText.text = self.pault.CUDESCRIBE;
        self.nineteenthRow.placeholderLabel.hidden = YES;
        self.nineteenthRow.contentText.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障描述" forKey:@"CUDESCRIBE"];
    [self.rootView addSubview:self.nineteenthRow];
    [self.nineteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.twentiethRow = [ProblemItemLTView showXibView];
    self.twentiethRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.twentiethRow.titleLabel.text = @"处理结果:";
    if (self.pault.RESULT.length) {
        self.twentiethRow.contentText.text = self.pault.RESULT;
        self.twentiethRow.placeholderLabel.hidden = YES;
        self.twentiethRow.contentText.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"处理结果" forKey:@"RESULT"];
    [self.rootView addSubview:self.twentiethRow];
    [self.twentiethRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nineteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.twentyfirstRow = [ProblemItemLTView showXibView];
    self.twentyfirstRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.twentyfirstRow.titleLabel.text = @"备注:";
    if (self.pault.REMARK.length) {
        self.twentyfirstRow.contentText.text = self.pault.REMARK;
        self.twentyfirstRow.placeholderLabel.hidden = YES;
        self.twentyfirstRow.contentText.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"备注" forKey:@"REMARK"];
    [self.rootView addSubview:self.twentyfirstRow];
    [self.twentyfirstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentiethRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.twentysecondRow = [ProblemItemLLIView showXibView];
    self.twentysecondRow.type = ProblemItemTypeDefaultLL;
    self.twentysecondRow.titleLabel.text = @"故障工单号:";
    if (self.pault.WONUM.length) {
        self.twentysecondRow.contentLabel.text = self.pault.WONUM;
        self.twentysecondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"故障工单号" forKey:@"WONUM"];
    [self.rootView addSubview:self.twentysecondRow];
    [self.twentysecondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyfirstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentythirdRow = [ProblemItemLLIView showXibView];
    self.twentythirdRow.type = ProblemItemTypeDefaultLL;
    self.twentythirdRow.titleLabel.text = @"质量问题反馈单号:";
    if (self.pault.UDPBFORMNUM.length) {
        self.twentythirdRow.contentLabel.text = self.pault.UDPBFORMNUM;
        self.twentythirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"质量问题反馈单号" forKey:@"UDPBFORMNUM"];
    [self.rootView addSubview:self.twentythirdRow];
    [self.twentythirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentysecondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
}

- (void)addBlocks{
    WEAKSELF
    
    self.sixthRow.executeTapContentLabel = ^(){
        if (weakSelf.forthRow.contentLabel.text.length < 5) {
            WHUDNormal(@"请选择项目编号");
            return;
        }else{
            FlightNoController *vc = [[FlightNoController alloc] init];
            vc.requestCoding = weakSelf.forthRow.contentLabel.text;
            vc.executeCellClick = ^(FlightNoModel *model){
                if (model.LOCNUM.length > 0) {
                    weakSelf.sixthRow.contentLabel.text = model.LOCNUM;
                    weakSelf.sixthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.sixthRow.contentLabel.text = @"暂无数据";
                    weakSelf.sixthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.seventhRow.executeTapContentLabel = ^(){
        if (weakSelf.sixthRow.contentLabel.text.length < 1 ||
            [weakSelf.sixthRow.contentLabel.text isEqualToString:@"暂无数据"]) {
            WHUDNormal(@"请选择设机位号")
        }else{
            EquipmentLocationController *vc = [[EquipmentLocationController alloc] init];
            vc.requestCoding1 = weakSelf.forthRow.contentLabel.text;
            vc.requestCoding2 = weakSelf.sixthRow.contentLabel.text;
            vc.executeCellClick = ^(EquipmentLocationModel *model){
                if (model.DESCRIPTION.length > 0) {
                    weakSelf.seventhRow.contentLabel.text = model.LOCATION;
                    weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.seventhRow.contentLabel.text = @"暂无数据";
                    weakSelf.seventhRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.eighthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultTypeDegree];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.eighthRow.contentLabel.text = str;
            weakSelf.eighthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.ninthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultFaultType];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.ninthRow.contentLabel.text = str;
            weakSelf.ninthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.thirteenthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultState];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.thirteenthRow.contentLabel.text = str;
            weakSelf.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.seventeenthRow.executeTapContentLabel = ^(){
        FaultClassController *vc = [[FaultClassController alloc] init];
        vc.title = @"故障类";
        vc.executeCellClick = ^(FaultClassModel *model){
            if (model.CODEDESC.length > 0) {
                weakSelf.pault.FAULT_CODE = model.FAILURECODE;
                weakSelf.seventeenthRow.contentLabel.text = model.CODEDESC;
                weakSelf.seventeenthRow.contentLabel.textColor = [UIColor blackColor];
                weakSelf.str1 = model.FAILURELIST;
            }else{
                weakSelf.seventeenthRow.contentLabel.text = @"暂无数据";
                weakSelf.seventeenthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.eighteenthRow.executeTapContentLabel = ^(){
        if (weakSelf.seventeenthRow.contentLabel.text.length < 1 ||
            [weakSelf.seventeenthRow.contentLabel.text isEqualToString:@"暂无数据"] ||
            weakSelf.str1.length < 1) {
            WHUDNormal(@"请选择故障类");
            return ;
        }
        FaultCodeController *vc = [[FaultCodeController alloc] init];
        vc.title = @"故障代码";
        vc.requestCoding = weakSelf.str1;
        vc.executeCellClick = ^(FaultCodeModel *model){
            if (model.CODEDESC.length > 0) {
                weakSelf.eighteenthRow.contentLabel.text = model.FAILURECODE;
                weakSelf.eighteenthRow.contentLabel.textColor = [UIColor blackColor];
                weakSelf.nineteenthRow.contentText.text = model.CODEDESC;
                weakSelf.nineteenthRow.placeholderLabel.hidden = YES;
            }else{
                weakSelf.eighteenthRow.contentLabel.text = @"暂无数据";
                weakSelf.eighteenthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.tenthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_first];
    };
    
    self.twelfthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_second];
    };
    
    self.nineteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateFifteenthRowWithHeight:textHeight animated:NO];
    };
    
    self.twentiethRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSixteenthRowWithHeight:textHeight animated:NO];
    };
    
    self.twentyfirstRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSeventeenthRowWithHeight:textHeight animated:NO];
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
            
        default:
            break;
    }
}

- (void)updata{
    
    if (self.forthRow.contentLabel.text.length < 1 ||
        [self.forthRow.contentLabel.text isEqualToString:@"暂无数据"]) {
        HUDNormal(@"项目编号")
        return;
    }
    SVHUD_NO_Stop(@"保存中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",dic[@"errorMsg"]];
        if ([str isEqualToString:@"1"]) {
            HUDNormal(str2);
        }else{
            HUDNormal(@"保存成功")
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    NSDictionary *dic = @{
                          @"relationShip":relationShip,
                          @"REPORTNUM":[self determineString:self.firstRow.contentLabel.text],
                          @"DESCRIPTION":[self determineString:self.secondRow.contentLabel.text],
                          @"PRODESC":[self determineString:self.thirdRow.contentLabel.text],
                          @"BRANCH":self.pault.BRANCH,
                          @"PRONUM":[self determineString:self.forthRow.contentLabel.text],
                          @"FAULT_CODE":[self determineString:self.sixthRow.contentLabel.text],
                          @"LOCATION":[self determineString:self.seventhRow.contentLabel.text],
                          @"UDGZDJ":[self determineString:self.eighthRow.contentLabel.text],
                          @"HAPPEN_TIME":[self determineString:self.tenthRow.contentLabel.text],
                          @"IS_END":self.eleventhRow.chooseBtn.selected ? @"Y" : @"N",
                          @"END_TIME":[self determineString:self.twelfthRow.contentLabel.text],
                          @"STATUSTYPE":[self determineString:self.thirteenthRow.contentLabel.text],
                          @"CUISPLAN":self.fourteenthRow.chooseBtn.selected ? @"Y":@"N",
                          @"CREATEBY":self.pault.CREATEBY,
                          @"REPORTTIME":[self determineString:self.sixteenthRow.contentLabel.text],
                          @"FAULT_CODEDESC":[self determineString:self.seventeenthRow.contentLabel.text],
                          @"FAULT_CODE1":[self determineString:self.eighteenthRow.contentLabel.text],
                          @"FAULT_CODE1DESC":[self determineString:self.nineteenthRow.contentText.text],
                          @"RESULT":[self determineString:self.twentiethRow.contentText.text],
                          @"REMARK":[self determineString:self.twentyfirstRow.contentText.text],
                          @"CUDESCRIBE":[self determineString:self.nineteenthRow.contentText.text],
                          @"WONUM":[self determineString:self.twentysecondRow.contentLabel.text],
                          @"UDPBFORMNUM":[self determineString:self.twentythirdRow.contentLabel.text],
                          @"UDREPORTID":self.pault.UDREPORTID,
                          };
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"mboObjectName" : @"UDREPORT"},
                     @{@"mboKey" : @"REPORTNUM"},
                     @{@"mboKeyValue" : self.firstRow.contentLabel.text}
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

- (void)updateFifteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight;
    lastTextHeight = height;
    [self.nineteenthRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.nineteenthRow.contentText convertRect:self.nineteenthRow.contentText.bounds toView:self.view];
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

- (void)updateSixteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
    [self.twentiethRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.twentiethRow.contentText convertRect:self.twentiethRow.contentText.bounds toView:self.view];
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


- (void)updateSeventeenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
    [self.twentyfirstRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 10);
        self.rootViewHeight.constant += scrollHeight;
    }];
    
    CGPoint scrollPoint = CGPointMake(self.rootScrollView.contentOffset.x, self.rootScrollView.contentOffset.y + scrollHeight);
    CGRect rect = [self.twentyfirstRow.contentText convertRect:self.twentyfirstRow.contentText.bounds toView:self.view];
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

- (TXTimeChoose *)timeYear_first{
    WEAKSELF
    if (!_timeYear_first) {
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.tenthRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.tenthRow.contentLabel.textColor = [UIColor blackColor];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
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
            
            NSString * value =[self.pault valueForKey:str];
        
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
-(void)sendData{
    //未完善
    if ([_pault.STATUSTYPE isEqualToString:@"已取消"]||[_pault.STATUSTYPE isEqualToString:@"已关闭"]||[_pault.STATUSTYPE isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_pault.STATUSTYPE];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_pault.STATUSTYPE isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDREPORT";
    popupView.mbo = @"UDREPORT";
    popupView.keyValue = _pault.UDREPORTID;
    popupView.key = @"UDREPORTID";
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
