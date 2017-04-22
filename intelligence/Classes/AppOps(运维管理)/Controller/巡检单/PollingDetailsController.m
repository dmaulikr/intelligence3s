//
//  PollingDetailsController.m
//  intelligence
//
//  Created by  on 16/8/9.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "PollingDetailsController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLBView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemLBView.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"
#import "ShareConstruction.h"

#import "ChooseItemNoController.h"
#import "FanTypeViewController.h"
#import "FlightNoController.h"
#import "DailyDetailChoosePersonController.h"

#import "InspectProjectController.h"
#import "ApprovalsView.h"
@interface PollingDetailsController ()
{
    NSString *yorn;
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;

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
// *风机型号:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
// *巡检标准：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 机位号：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
// 设备位置：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
// 状态
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
// 巡检计划单号
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
// 巡检负责人
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
// 巡检人员
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;
// 巡检人员
@property (nonatomic, strong) ProblemItemLLIView *fourteenthRow;
// 巡检人员
@property (nonatomic, strong) ProblemItemLLIView *fifteenthRow;
// 是否停机
@property (nonatomic, strong) ProblemItemLBView *sixteenthRow;
// 巡检日期
@property (nonatomic, strong) ProblemItemLLIView *seventeenthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear3;

// 停机时间
@property (nonatomic, strong) ProblemItemLLIView *eighteenthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear4;

// 恢复时间
@property (nonatomic, strong) ProblemItemLLIView *nineteenthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear5;

// 累计停机时间
@property (nonatomic, strong) ProblemItemLLIView *twentiethRow;
// 创建人
@property (nonatomic, strong) ProblemItemLLIView *twentyfirstRow;
// 创建时间
@property (nonatomic, strong) ProblemItemLLIView *twentysecondRow;
// 修改人
@property (nonatomic, strong) ProblemItemLLIView *twentythirdRow;
// 修改时间
@property (nonatomic, strong) ProblemItemLLIView *twentyfourthRow;
// 天气
@property (nonatomic, strong) ProblemItemLLIView *twentyfifthRow;
// 计划开始日期
@property (nonatomic, strong) ProblemItemLLIView *twentysixthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;

// 计划完成日期
@property (nonatomic, strong) ProblemItemLLIView *twentyseventhRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_second;

// 上次巡查时间
@property (nonatomic, strong) ProblemItemLLIView *twentyeighthRow;
// 下次巡查时间
@property (nonatomic, strong) ProblemItemLLIView *twentyninthRow;



@end

@implementation PollingDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"巡检单详情";
    self.rootViewHeight.constant = 1310 +50;
    [self addViews];
    [self addBlocks];
    [self addRightNavBarItem];
    if ([self.polling.STATUS isEqualToString:@"待执行"]) {
        [self addScrollFooterView];
    }
    
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDINSPOAPP" objectName:@"UDINSPO" status:self.polling.STATUS compeletion:^(NSArray *fields) {
        NSLog(@"巡检单单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDINSPO",@"ACTIONNAME":@"查看巡检工单"}];
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
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        NSString *str1 = [NSString stringWithFormat:@"单号%@保存成功",dic[@"INSPONUM"]];
        if (![str isEqualToString:@"0"]) {
            HUDNormal(@"保存失败稍后再试");
        }else{
            HUDNormal(str1);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    

    if (self.sixteenthRow.chooseBtn.selected) {
        yorn = @"Y";
    }else{
        yorn = @"N";
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSDictionary *dic = @{
                          @"BRANCH":[self determineString:self.thirdRow.contentLabel.text],
                          @"BRANCHDESC":self.polling.BRANCHDESC,
                          @"CHANGEBY":[self determineString:self.twentythirdRow.contentLabel.text],
                          @"CHANGEDATE":[self determineString:self.twentyfourthRow.contentLabel.text],
                          @"COMPTIME":[self determineString:self.twentyseventhRow.contentLabel.text],
                          @"CREATEBY":[self determineString:self.twentyfirstRow.contentLabel.text],
                          @"CREATEDATE":[self determineString:self.twentysecondRow.contentLabel.text],
                          @"DESCRIPTION":[self determineString:self.secondRow.contentLabel.text],
                          @"INSPOBY":[self determineString:self.thirteenthRow.contentLabel.text],
                          @"INSPODATE":[self determineString:self.seventeenthRow.contentLabel.text],
                          @"INSPPLANNUM":[self determineString:self.eleventhRow.contentLabel.text],
                          @"INSPONUM":[self determineString:self.firstRow.contentLabel.text],
                          @"ISSTOP":yorn,
                          @"JPDESC":[self determineString:self.seventhRow.contentLabel.text],
                          @"JPNUM":self.polling.JPNUM,
                          @"MODELTYPE":[self determineString:self.sixthRow.contentLabel.text],
                          @"NAME":self.polling.NAME,
                          @"NAME1":self.polling.NAME1,
                          @"OKTIME":self.polling.OKTIME,
                          @"PRODESC":self.polling.PRODESC,
                          @"PRONUM":self.polling.PRONUM,
                          @"RESBY":self.polling.RESBY,
                          @"STARTTIME":self.polling.STARTTIME,
                          @"STATUS":self.polling.STATUS,
                          @"STOPTIME":self.polling.STOPTIME,
                          @"UDINSPOID":self.polling.UDINSPOID,
                          @"UDLOCNUM":self.polling.UDLOCNUM,
                          @"WEATHER":self.polling.WEATHER,
                          @"relationShip":relationShip,
                          };
    [dictionary addEntriesFromDictionary:dic];
    ShareConstruction *share = [ShareConstruction sharedConstruction];
    if (share.inspectProject.dic.allKeys.count > 0) {
        [dictionary addEntriesFromDictionary:share.inspectProject.dic];
        
    }
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dictionary]},
                     @{@"mboObjectName" : @"UDINSPO"},
                     @{@"mboKey" : @"INSPONUM"},
                     @{@"mboKeyValue" : self.polling.INSPONUM}
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

- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"巡检项目" iconName:@"ic_xjxm" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [self checkRequiredFieldcompeletion:^(BOOL isOK) {
            if (isOK) {
                [self sendData];
            }
        }];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_commit" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
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
            InspectProjectController *vc = [[InspectProjectController alloc] init];
            vc.requestCode = self.firstRow.contentLabel.text;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            
            
        }break;
        case 2:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = @"UDINSPO";
            vc.ownerid    = self.polling.UDINSPOID;
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

- (void)addViews{
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"编号:";
    if (self.polling.INSPONUM.length > 0) {
        self.firstRow.contentLabel.text = self.polling.INSPONUM;
        self.firstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"编号" forKey:@"INSPONUM"];
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLL;
    self.secondRow.titleLabel.text = @"描述:";
    if (self.polling.DESCRIPTION.length > 0) {
        self.secondRow.contentLabel.text = self.polling.DESCRIPTION;
        self.secondRow.contentLabel.textColor = [UIColor blackColor];
    }
    CGFloat seconRowHeight = [self computeHeight:self.secondRow.contentLabel];
    [self.SetingItems setValue:@"描述" forKey:@"DESCRIPTION"];
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(seconRowHeight);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdRow.titleLabel.text = @"中心:";
    if (self.polling.BRANCH.length > 0) {
        self.thirdRow.contentLabel.text = self.polling.BRANCH;
        self.thirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"中心" forKey:@"BRANCH"];
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemDetailsTypeMustLL;
    self.forthRow.titleLabel.text = @"项目编号:";
    if (self.polling.PRONUM.length > 0) {
        self.forthRow.contentLabel.text = self.polling.PRONUM;
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
    if (self.polling.PRODESC.length > 0) {
        self.fifthRow.contentLabel.text = self.polling.PRODESC;
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
    self.sixthRow.type = ProblemDetailsTypeMustLL;
    self.sixthRow.titleLabel.text = @"风机型号:";
    if (self.polling.MODELTYPE.length > 0) {
        self.sixthRow.contentLabel.text = self.polling.MODELTYPE;
        self.sixthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"风机型号" forKey:@"MODELTYPE"];
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemDetailsTypeMustLL;
    self.seventhRow.titleLabel.text = @"巡检标准:";
    if (self.polling.JPDESC.length > 0) {
        self.seventhRow.contentLabel.text = self.polling.JPDESC;
        self.seventhRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检标准" forKey:@"JPDESC"];
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemDetailsTypeMustLL;
    self.eighthRow.titleLabel.text = @"机位号:";
    if (self.polling.UDLOCNUM.length > 0) {
        self.eighthRow.contentLabel.text = self.polling.UDLOCNUM;
        self.eighthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"机位号" forKey:@"UDLOCNUM"];
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLL;
    self.ninthRow.titleLabel.text = @"设备位置:";
    if (self.polling.FJNUM.length > 0) {
        self.ninthRow.contentLabel.text = self.polling.FJNUM;
        self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"设备位置" forKey:@"FJNUM"];
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(0);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLL;
    self.tenthRow.titleLabel.text = @"状态:";
    if (self.polling.STATUS.length > 0) {
        self.tenthRow.contentLabel.text = self.polling.STATUS;
        self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"状态" forKey:@"STATUS"];
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLL;
    self.eleventhRow.titleLabel.text = @"巡检计划单号:";
    if (self.polling.INSPPLANNUM.length > 0) {
        self.eleventhRow.contentLabel.text = self.polling.INSPPLANNUM;
        self.eleventhRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检计划单号" forKey:@"INSPPLANNUM"];
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemDetailsTypeMustLL;
    self.twelfthRow.titleLabel.text = @"巡检负责人:";
    if (self.polling.NAME.length > 0) {
        self.twelfthRow.contentLabel.text = self.polling.NAME;
        self.twelfthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检负责人" forKey:@"NAME"];
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemDetailsTypeMustLL;
    self.thirteenthRow.titleLabel.text =  @"巡检人员:";
    if (self.polling.INSPOBY.length > 0) {
        self.thirteenthRow.contentLabel.text = self.polling.NAME1;
        self.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检人员" forKey:@"NAME1"];
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fourteenthRow = [ProblemItemLLIView showXibView];
    self.fourteenthRow.type = ProblemItemTypeDefaultLL;
    self.fourteenthRow.titleLabel.text = @"巡检人员:";
    if (self.polling.INSPOBY2.length > 0) {
        self.fourteenthRow.contentLabel.text = self.polling.NAME2;
        self.fourteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检人员" forKey:@"NAME2"];
    [self.rootView addSubview:self.fourteenthRow];
    [self.fourteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifteenthRow = [ProblemItemLLIView showXibView];
    self.fifteenthRow.type = ProblemItemTypeDefaultLL;
    self.fifteenthRow.titleLabel.text = @"巡检人员:";
    if (self.polling.INSPOBY3.length > 0) {
        self.fifteenthRow.contentLabel.text = self.polling.NAME3;
        self.fifteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检人员" forKey:@"NAME3"];
    [self.rootView addSubview:self.fifteenthRow];
    [self.fifteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixteenthRow = [ProblemItemLBView showXibView];
    self.sixteenthRow.titleLabel.text = @"是否停机:";
    if (self.polling.ISSTOP > 0) {
        self.sixteenthRow.chooseBtn.selected = YES;
    }
    [self.SetingItems setValue:@"是否停机" forKey:@"ISSTOP"];
    [self.rootView addSubview:self.sixteenthRow];
    [self.sixteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventeenthRow = [ProblemItemLLIView showXibView];
    self.seventeenthRow.type = ProblemItemTypeDefaultLLI;
    self.seventeenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.seventeenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.seventeenthRow.titleLabel.text = @"巡检日期:";
    if (self.polling.INSPODATE.length > 0) {
        self.seventeenthRow.contentLabel.text = self.polling.INSPODATE;
        self.seventeenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"巡检日期" forKey:@"INSPODATE"];
    [self.rootView addSubview:self.seventeenthRow];
    [self.seventeenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighteenthRow = [ProblemItemLLIView showXibView];
    self.eighteenthRow.type = ProblemItemTypeDefaultLLI;
    self.eighteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.eighteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.eighteenthRow.titleLabel.text = @"停机时间:";
    if (self.polling.STOPTIME.length > 0) {
        self.eighteenthRow.contentLabel.text = self.polling.STOPTIME;
        self.eighteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"停机时间" forKey:@"STOPTIME"];
    [self.rootView addSubview:self.eighteenthRow];
    [self.eighteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventeenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.nineteenthRow = [ProblemItemLLIView showXibView];
    self.nineteenthRow.type = ProblemItemTypeDefaultLLI;
    self.nineteenthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.nineteenthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.nineteenthRow.titleLabel.text = @"恢复时间:";
    if (self.polling.OKTIME.length > 0) {
        self.nineteenthRow.contentLabel.text = self.polling.OKTIME;
        self.nineteenthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"恢复时间" forKey:@"OKTIME"];
    [self.rootView addSubview:self.nineteenthRow];
    [self.nineteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentiethRow = [ProblemItemLLIView showXibView];
    self.twentiethRow.type = ProblemItemTypeDefaultLL;
    self.twentiethRow.titleLabel.text = @"累计停机时间:";
    if (self.polling.ALLTIME.length > 0) {
        self.twentiethRow.contentLabel.text = self.polling.ALLTIME;
        self.twentiethRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"累计停机时间" forKey:@"ALLTIME"];
    [self.rootView addSubview:self.twentiethRow];
    [self.twentiethRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nineteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyfirstRow = [ProblemItemLLIView showXibView];
    self.twentyfirstRow.type = ProblemItemTypeDefaultLL;
    self.twentyfirstRow.titleLabel.text = @"创建人:";
    if (self.polling.CREATEBY.length > 0) {
        self.twentyfirstRow.contentLabel.text = self.polling.CREATEBY;
        self.twentyfirstRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"创建人" forKey:@"CREATEBY"];
    [self.rootView addSubview:self.twentyfirstRow];
    [self.twentyfirstRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentiethRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentysecondRow = [ProblemItemLLIView showXibView];
    self.twentysecondRow.type = ProblemItemTypeDefaultLL;
    self.twentysecondRow.titleLabel.text = @"创建时间:";
    if (self.polling.CREATEDATE.length > 0) {
        self.twentysecondRow.contentLabel.text = self.polling.CREATEDATE;
        self.twentysecondRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"创建时间" forKey:@"CREATEDATE"];
    [self.rootView addSubview:self.twentysecondRow];
    [self.twentysecondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyfirstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentythirdRow = [ProblemItemLLIView showXibView];
    self.twentythirdRow.type = ProblemItemTypeDefaultLL;
    self.twentythirdRow.titleLabel.text = @"修改人:";
    if (self.polling.CHANGEBY.length > 0) {
        self.twentythirdRow.contentLabel.text = self.polling.CHANGEBYNAME;
        self.twentythirdRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"修改人" forKey:@"CHANGEBYNAME"];
    [self.rootView addSubview:self.twentythirdRow];
    [self.twentythirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentysecondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyfourthRow = [ProblemItemLLIView showXibView];
    self.twentyfourthRow.type = ProblemItemTypeDefaultLL;
    self.twentyfourthRow.titleLabel.text = @"修改时间:";
    if (self.polling.CHANGEDATE.length > 0) {
        self.twentyfourthRow.contentLabel.text = self.polling.CHANGEDATE;
        self.twentyfourthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"修改时间" forKey:@"CHANGEDATE"];
    [self.rootView addSubview:self.twentyfourthRow];
    [self.twentyfourthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentythirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyfifthRow = [ProblemItemLLIView showXibView];
    self.twentyfifthRow.type = ProblemItemTypeDefaultLL;
    self.twentyfifthRow.titleLabel.text = @"天气:";
    if (self.polling.WEATHER.length > 0) {
        self.twentyfifthRow.contentLabel.text = self.polling.WEATHER;
        self.twentyfifthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"天气" forKey:@"WEATHER"];
    [self.rootView addSubview:self.twentyfifthRow];
    [self.twentyfifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyfourthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentysixthRow = [ProblemItemLLIView showXibView];
    self.twentysixthRow.type = ProblemDetailsTypeMustLL;
    self.twentysixthRow.titleLabel.text = @"计划开始日期:";
    if (self.polling.STARTTIME.length > 0) {
        self.twentysixthRow.contentLabel.text = self.polling.STARTTIME;
        self.twentysixthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"计划开始日期" forKey:@"STARTTIME"];
    [self.rootView addSubview:self.twentysixthRow];
    [self.twentysixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyfifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyseventhRow = [ProblemItemLLIView showXibView];
    self.twentyseventhRow.type = ProblemDetailsTypeMustLL;
    self.twentyseventhRow.titleLabel.text = @"计划完成日期:";
    if (self.polling.COMPTIME.length > 0) {
        self.twentyseventhRow.contentLabel.text = self.polling.COMPTIME;
        self.twentyseventhRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"计划完成日期" forKey:@"COMPTIME"];
    [self.rootView addSubview:self.twentyseventhRow];
    [self.twentyseventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentysixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyeighthRow = [ProblemItemLLIView showXibView];
    self.twentyeighthRow.type = ProblemItemTypeDefaultLL;
    self.twentyeighthRow.titleLabel.text = @"上次巡查时间:";
    if (self.polling.LASTRUNDATE.length > 0) {
        self.twentyeighthRow.contentLabel.text = self.polling.LASTRUNDATE;
        self.twentyeighthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"上次巡查时间" forKey:@"LASTRUNDATE"];
    [self.rootView addSubview:self.twentyeighthRow];
    [self.twentyeighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyseventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twentyninthRow = [ProblemItemLLIView showXibView];
    self.twentyninthRow.type = ProblemItemTypeDefaultLL;
    self.twentyninthRow.titleLabel.text = @"下次巡查时间:";
    if (self.polling.NEXTRUNDATE.length > 0) {
        self.twentyninthRow.contentLabel.text = self.polling.NEXTRUNDATE;
        self.twentyninthRow.contentLabel.textColor = [UIColor blackColor];
    }
    [self.SetingItems setValue:@"下次巡查时间" forKey:@"NEXTRUNDATE"];
    [self.rootView addSubview:self.twentyninthRow];
    [self.twentyninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twentyeighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addBlocks{
    WEAKSELF
    // 新建状态下 项目编号、风机型号、机位号、天气、巡检负责人和巡检人员、是否停机、计划开始时间、计划结束时间应该是可以编辑的
    // 待执行时，是否停机、巡检日期、停机时间、恢复时间可编辑
    if ([self.polling.STATUS isEqualToString:@"新建"]) {
        // 项目编号
        self.forthRow.executeTapContentLabel = ^(){
            ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
            vc.title = @"选择项目编号";
            vc.executeClickCell = ^(ChooseItemNoModel *model){
                if (model.DESCRIPTION.length > 0) {
                    weakSelf.secondRow.contentLabel.text = model.DESCRIPTION;
                    weakSelf.secondRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.secondRow.contentLabel.text = @"暂无数据";
                    weakSelf.secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
                
                if (model.BRANCHDESC.length > 0) {
                    weakSelf.thirdRow.contentLabel.text = model.BRANCHDESC;
                    weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.thirdRow.contentLabel.text = @"暂无数据";
                    weakSelf.thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
                
                if (model.PRONUM.length > 0) {
                    weakSelf.forthRow.contentLabel.text = model.PRONUM;
                    weakSelf.forthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.forthRow.contentLabel.text = @"暂无数据";
                    weakSelf.forthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        // 风机型号
        self.sixthRow.executeTapContentLabel = ^(){
            if (weakSelf.forthRow.contentLabel.text == 0 ) {
                WHUDNormal(@"请选择项目编号");
                return ;        
            }
            FanTypeViewController *fan = [[FanTypeViewController alloc]init];
            fan.requestCode = weakSelf.forthRow.contentLabel.text;
            fan.backModel = ^(FanTypeModel *model){
                if (model.MODELTYPE.length > 0) {
                    weakSelf.sixthRow.contentLabel.text = model.MODELTYPE;
                    weakSelf.sixthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.sixthRow.contentLabel.text = @"暂无数据";
                    weakSelf.sixthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:fan animated:YES];
        };
        // 机位号
        self.eighthRow.executeTapContentLabel = ^(){
            if (weakSelf.eighthRow.contentLabel.text.length == 0) {
                WHUDNormal(@"请选择项目编号");
                return ;
            }
            FlightNoController *choose = [[FlightNoController alloc]init];
            choose.requestCoding = weakSelf.forthRow.contentLabel.text;
            choose.executeCellClick = ^(FlightNoModel *model){
                if (model.LOCNUM.length > 0) {
                    weakSelf.eighthRow.contentLabel.text = model.LOCNUM;
                    weakSelf.eighthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.eighthRow.contentLabel.text = @"暂无数据";
                    weakSelf.eighthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:choose animated:YES];
        };
        // 天气
        self.twentyfifthRow.executeTapContentLabel = ^(){
            ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeWeather];
            work.WorkBlock = ^(NSString *str){
                weakSelf.twentyfifthRow.contentLabel.text = str;
                weakSelf.twentyfifthRow.contentLabel.textColor = [UIColor blackColor];
            };
            [work ShowInView:weakSelf.view];
        };
        // 巡检负责人
        self.twelfthRow.executeTapContentLabel = ^(){
            DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
            vc.title = @"巡检负责人";
            vc.exetuceClickCell = ^(ChoosePersonModel *model){
                if (model.DISPLAYNAME.length > 0) {
                    weakSelf.twelfthRow.contentLabel.text = model.DISPLAYNAME;
                    weakSelf.twelfthRow.contentLabel.textColor = [UIColor blackColor];
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        // 巡检人员
        self.thirteenthRow.executeTapContentLabel = ^(){
            DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
            vc.title = @"巡检人员";
            vc.exetuceClickCell = ^(ChoosePersonModel *model){
                if (model.DISPLAYNAME.length > 0) {
                    weakSelf.thirteenthRow.contentLabel.text = model.DISPLAYNAME;
                    weakSelf.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        // 巡检人员
        self.fourteenthRow.executeTapContentLabel = ^(){
            DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
            vc.title = @"巡检人员";
            vc.exetuceClickCell = ^(ChoosePersonModel *model){
                if (model.DISPLAYNAME.length > 0) {
                    weakSelf.fourteenthRow.contentLabel.text = model.DISPLAYNAME;
                    weakSelf.fourteenthRow.contentLabel.textColor = [UIColor blackColor];
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        // 巡检人员
        self.fifteenthRow.executeTapContentLabel = ^(){
            DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
            vc.title = @"巡检人员";
            vc.exetuceClickCell = ^(ChoosePersonModel *model){
                if (model.DISPLAYNAME.length > 0) {
                    weakSelf.fifteenthRow.contentLabel.text = model.DISPLAYNAME;
                    weakSelf.fifteenthRow.contentLabel.textColor = [UIColor blackColor];
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        // 计划开始时间
        self.twentysixthRow.executeTapContentLabel = ^(){
            [weakSelf.view addSubview:weakSelf.timeYear_first];
        };
        // 计划结束时间
        self.twentyseventhRow.executeTapContentLabel = ^(){
            [weakSelf.view addSubview:weakSelf.timeYear_second];
        };
        
    }else if ([self.polling.STATUS isEqualToString:@"待执行"]){
        // 巡检日期
        self.seventeenthRow.executeTapContentLabel = ^(){
            [weakSelf.view addSubview:weakSelf.timeYear3];
        };
        // 停机时间
        self.eighteenthRow.executeTapContentLabel = ^(){
            [weakSelf.view addSubview:weakSelf.timeYear4];
        };
        // 恢复时间
        self.nineteenthRow.executeTapContentLabel = ^(){
            [weakSelf.view addSubview:weakSelf.timeYear5];
        };
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
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.twentysixthRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.twentysixthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_first;
}

- (TXTimeChoose *)timeYear_second{
    WEAKSELF
    if (!_timeYear_second) {
        _timeYear_second = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _timeYear_second.backString = ^(NSDate *data){
            weakSelf.twentyseventhRow.contentLabel.text = [weakSelf.timeYear_second stringFromDate:data];
            weakSelf.twentyseventhRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_second;
}

- (TXTimeChoose *)timeYear3{
    WEAKSELF
    if (!_timeYear3) {
        _timeYear3 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _timeYear3.backString = ^(NSDate *data){
            weakSelf.seventeenthRow.contentLabel.text = [weakSelf.timeYear3 stringFromDate:data];
            weakSelf.seventeenthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear3;
}

- (TXTimeChoose *)timeYear4{
    WEAKSELF
    if (!_timeYear4) {
        _timeYear4 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear4.backString = ^(NSDate *data){
            weakSelf.eighteenthRow.contentLabel.text = [weakSelf.timeYear4 stringFromDate:data];
            weakSelf.eighteenthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear4;
}

- (TXTimeChoose *)timeYear5{
    WEAKSELF
    if (!_timeYear5) {
        _timeYear5 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear5.backString = ^(NSDate *data){
            weakSelf.nineteenthRow.contentLabel.text = [weakSelf.timeYear5 stringFromDate:data];
            weakSelf.nineteenthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
            
            NSString * value =[self.polling valueForKey:str];
            
            
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
    if ([_polling.STATUS isEqualToString:@"已取消"]||[_polling.STATUS isEqualToString:@"已关闭"]||[_polling.STATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_polling.STATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_polling.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDINSPO";
    popupView.mbo = @"UDINSPO";
    popupView.keyValue = _polling.UDINSPOID;
    popupView.key = @"UDINSPOID";
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
