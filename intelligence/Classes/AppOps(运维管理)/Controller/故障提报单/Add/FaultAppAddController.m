//
//  FaultAppAddController.m
//  intelligence
//
//  Created by  on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FaultAppAddController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "ChoiceWorkView.h"
#import "ProblemItemLBView.h"

#import "RelatedRepairOrderController.h"
#import "ChooseItemNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "FlightNoController.h"
#import "EquipmentLocationController.h"
#import "FaultClassController.h"
#import "FaultCodeController.h"
#import "SoapUtil.h"

@interface FaultAppAddController ()
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

@property (nonatomic, copy) NSString *faultCodeStr;


// 中心:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
// *项目编号：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 项目名称：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// *机位号：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// *设备位置:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
// 故障等级:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
// 故障类型：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 报障时间：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_first;

// 故障结束时间：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
@property (nonatomic, strong) TXTimeChoose *timeYear_second;

// 状态
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
// 提报人
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
// 提报时间
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
// 故障类
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;
// 故障代码
@property (nonatomic, strong) ProblemItemLLIView *fourteenthRow;
// 故障描述
@property (nonatomic, strong) ProblemItemLTView *fifteenthRow;
// 处理结果
@property (nonatomic, strong) ProblemItemLTView *sixteenthRow;
// 备注
@property (nonatomic, strong) ProblemItemLTView *seventeenthRow;


@end

@implementation FaultAppAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增故障提报单";
    self.rootViewHeight.constant = 875;
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
    self.firstRow.titleLabel.text = @"中心:";
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemDetailsTypeMustLLI;
    self.secondRow.titleLabel.text = @"项目编号:";
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdRow.titleLabel.text = @"项目名称:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemDetailsTypeMustLLI;
    self.forthRow.titleLabel.text = @"机位号:";
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemDetailsTypeMustLLI;
    self.fifthRow.titleLabel.text = @"设备位置:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemDetailsTypeMustLLI;
    self.sixthRow.titleLabel.text = @"故障等级:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemDetailsTypeMustLLI;
    self.seventhRow.titleLabel.text = @"故障类型:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemDetailsTypeMustLLI;
    self.eighthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.eighthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.eighthRow.titleLabel.text = @"报障时间:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLL;
    self.ninthRow.rightImageView.image = [UIImage imageNamed:@"ic_choose_data"];
    self.ninthRow.rightImageView.contentMode = UIViewContentModeScaleToFill;
    self.ninthRow.titleLabel.text = @"故障结束时间:";
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemDetailsTypeMustLLI;
    self.tenthRow.titleLabel.text = @"状态:";
    self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    self.tenthRow.contentLabel.text = @"新建";
    [self.rootView addSubview:self.tenthRow];
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLL;
    self.eleventhRow.titleLabel.text = @"提报人:";
    AccountModel *model = [AccountManager account];
    self.eleventhRow.contentLabel.textColor = [UIColor blackColor];
    self.eleventhRow.contentLabel.text = model.userName;
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.twelfthRow = [ProblemItemLLIView showXibView];
    self.twelfthRow.type = ProblemItemTypeDefaultLL;
    self.twelfthRow.titleLabel.text = @"提报时间:";
    self.twelfthRow.contentLabel.textColor = [UIColor blackColor];
    self.twelfthRow.contentLabel.text = kGetCurrentTime(@"yyyy-MM-dd HH:mm:ss");
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemDetailsTypeMustLLI;
    self.thirteenthRow.titleLabel.text = @"故障类:";
    [self.rootView addSubview:self.thirteenthRow];
    [self.thirteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twelfthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fourteenthRow = [ProblemItemLLIView showXibView];
    self.fourteenthRow.type = ProblemDetailsTypeMustLLI;
    self.fourteenthRow.titleLabel.text = @"故障代码:";
    [self.rootView addSubview:self.fourteenthRow];
    [self.fourteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifteenthRow = [ProblemItemLTView showXibView];
    self.fifteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.fifteenthRow.titleLabel.text = @"故障描述:";
    [self.rootView addSubview:self.fifteenthRow];
    [self.fifteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.sixteenthRow = [ProblemItemLTView showXibView];
    self.sixteenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.sixteenthRow.titleLabel.text = @"处理结果:";
    [self.rootView addSubview:self.sixteenthRow];
    [self.sixteenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifteenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    self.seventeenthRow = [ProblemItemLTView showXibView];
    self.seventeenthRow.type = ProblemItemLTViewTypeHiddenRedMark;
    self.seventeenthRow.titleLabel.text = @"备注:";
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
        ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
        vc.title = @"选择项目编号";
        vc.executeClickCell = ^(ChooseItemNoModel *model){
            if (model.BRANCHDESC.length > 0) {
                weakSelf.firstRow.contentLabel.text = model.BRANCHDESC;
                weakSelf.firstRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.firstRow.contentLabel.text = @"暂无数据";
                weakSelf.firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.PRONUM.length > 0) {
                weakSelf.secondRow.contentLabel.text = model.PRONUM;
                weakSelf.secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondRow.contentLabel.text = @"暂无数据";
                weakSelf.secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.DESCRIPTION.length > 0) {
                weakSelf.thirdRow.contentLabel.text = model.DESCRIPTION;
                weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.forthRow.executeTapContentLabel = ^(){
        if (weakSelf.secondRow.contentLabel.text.length < 5) {
            HUDNormal(@"请选择项目编号");
            return;
        }else{
            FlightNoController *vc = [[FlightNoController alloc] init];
            vc.requestCoding = weakSelf.secondRow.contentLabel.text;
            vc.executeCellClick = ^(FlightNoModel *model){
                if (model.LOCNUM.length > 0) {
                    weakSelf.forthRow.contentLabel.text = model.LOCNUM;
                    weakSelf.forthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.forthRow.contentLabel.text = @"暂无数据";
                    weakSelf.forthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.fifthRow.executeTapContentLabel = ^(){
        if (weakSelf.secondRow.contentLabel.text.length < 5) {
            HUDNormal(@"请选择项目编号");
            return;
        }else if ([weakSelf.forthRow.contentLabel.text isEqualToString:@"暂无数据"]){
            HUDNormal(@"请选择机位号");
            return;
        }else{
            EquipmentLocationController *vc = [[EquipmentLocationController alloc] init];
            vc.requestCoding1 = weakSelf.secondRow.contentLabel.text;
            vc.requestCoding2 = weakSelf.forthRow.contentLabel.text;
            vc.executeCellClick = ^(EquipmentLocationModel *model){
                if (model.LOCATION.length > 0) {
                    weakSelf.fifthRow.contentLabel.text = model.LOCATION;
                    weakSelf.fifthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.fifthRow.contentLabel.text = @"暂无数据";
                    weakSelf.fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.sixthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultTypeDegree];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.sixthRow.contentLabel.text = str;
            weakSelf.sixthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.seventhRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultFaultType];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.seventhRow.contentLabel.text = str;
            weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.eighthRow.executeTapContentLabel = ^(){
        [weakSelf.view addSubview:weakSelf.timeYear_first];
    };
    
//    self.ninthRow.executeTapContentLabel = ^(){
//        [weakSelf.view addSubview:weakSelf.timeYear_second];
//    };
    
    self.tenthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeFaultState];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.tenthRow.contentLabel.text = str;
            weakSelf.tenthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.thirteenthRow.executeTapContentLabel = ^(){
        FaultClassController *vc = [[FaultClassController alloc] init];
        vc.executeCellClick = ^(FaultClassModel *model){
            if (model.FAILURELIST.length > 0) {
                weakSelf.faultCodeStr = model.FAILURELIST;
                weakSelf.thirteenthRow.contentLabel.text = model.CODEDESC;
                weakSelf.thirteenthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirteenthRow.contentLabel.text = @"暂无数据";
                weakSelf.thirteenthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.fourteenthRow.executeTapContentLabel = ^(){
        if ([weakSelf.thirteenthRow.contentLabel.text isEqualToString:@"暂无数据"]) {
            HUDNormal(@"请选择故障类");
            return ;
        }else{
            FaultCodeController *vc = [[FaultCodeController alloc] init];
            vc.requestCoding = weakSelf.faultCodeStr;
            vc.executeCellClick = ^(FaultCodeModel *model){
                if (model.FAILURECODE.length > 0) {
                    weakSelf.fourteenthRow.contentLabel.text = model.CODEDESC;
                    weakSelf.fourteenthRow.contentLabel.textColor = [UIColor blackColor];
                }else{
                    weakSelf.fourteenthRow.contentLabel.text = @"暂无数据";
                    weakSelf.fourteenthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
                }
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.fifteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateFifteenthRowWithHeight:textHeight animated:NO];
    };
    
    self.sixteenthRow.executeTextHeightChage = ^(CGFloat textHeight){
        [weakSelf updateSixteenthRowWithHeight:textHeight animated:NO];
    };
    
    self.seventeenthRow.executeTextHeightChage = ^(CGFloat textHeight){
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
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    
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
                          @"BRANCH":[self determineString:self.fifthRow.contentLabel.text],
                          @"CREATEBY":[self determineString:self.eleventhRow.contentLabel.text],
                          @"CUDESCRIBE":[self determineString:self.fifteenthRow.contentText.text],
                          @"END_TIME":[self determineString:self.ninthRow.contentLabel.text],
                          @"FAULT_CODE":[self determineString:self.forthRow.contentLabel.text],
                          @"FAULT_CODE1":[self determineString:self.fourteenthRow.contentLabel.text],
                          @"HAPPEN_TIME":[self determineString:self.twelfthRow.contentLabel.text],
                          @"LOCATION":[self determineString:self.fifthRow.contentLabel.text],
                          @"LOCATION_CODE":[self determineString:self.forthRow.contentLabel.text],
                          @"PRONUM":[self determineString:self.secondRow.contentLabel.text],
                          @"REMARK":[self determineString:self.seventeenthRow.contentText.text],
                          @"REPORTTIME":[self determineString:self.eighthRow.contentLabel.text],
                          @"RESULT":[self determineString:self.sixteenthRow.contentText.text],
                          @"STATUSTYPE":[self determineString:self.tenthRow.contentLabel.text],
                          @"relationShip":relationShip,
                          };
    AccountModel *account = [AccountManager account];
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDREPORT"},
                     @{@"mboKey" : @"REPORTNUM"},
                     @{@"personId" : account.personId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
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

- (void)updateSixteenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight2;
    lastTextHeight2 = height;
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


- (void)updateSeventeenthRowWithHeight:(CGFloat)height animated:(BOOL)animated {
    if (height < 50) {
        return;
    }
    CGFloat scrollHeight = height - lastTextHeight3;
    lastTextHeight3 = height;
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

- (TXTimeChoose *)timeYear_first{
    WEAKSELF
    if (!_timeYear_first) {
        _timeYear_first = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_first.backString = ^(NSDate *data){
            weakSelf.eighthRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.eighthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_first;
}

- (TXTimeChoose *)timeYear_second{
    WEAKSELF
    if (!_timeYear_second) {
        _timeYear_second = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        _timeYear_second.backString = ^(NSDate *data){
            weakSelf.ninthRow.contentLabel.text = [weakSelf.timeYear_first stringFromDate:data];
            weakSelf.ninthRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear_second;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
