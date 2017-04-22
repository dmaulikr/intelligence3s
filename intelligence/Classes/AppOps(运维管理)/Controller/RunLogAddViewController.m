//
//  RunLogAddViewController.m
//  intelligence
//
//  Created by chris on 2016/11/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "RunLogAddViewController.h"
#import "ProblemItemLBView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "DailyDetailsFooterView.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
#import "ChooseItemNoController.h"
#import "ChoiceWorkView.h"
#import "DailyDetailChoosePersonController.h"
#import "SoapUtil.h"
#import "ShareConstruction.h"
#import "DailylogActivityViewController.h"
@interface RunLogAddViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;
//中心编号:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
//中心描述：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
//项目编号：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
//项目描述：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
//年:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
//月:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
//负责人：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
//负责人描述：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
//录入人编号：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
//录入人描述
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
//录入时间
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;

@end

@implementation RunLogAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self addScrollFooterView];
    [self addRightNavBarItem];
    [self addBlocks];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addViews
{
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLT;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"中心编号:";
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLT;
    self.secondRow.titleLabel.text = @"中心描述:";
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemDetailsTypeMustLLI;
    self.thirdRow.titleLabel.text = @"项目编号:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLT;
    self.forthRow.titleLabel.text = @"项目描述:";
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemDetailsTypeMustLLI;
    self.fifthRow.titleLabel.text = @"年:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemDetailsTypeMustLLI;
    self.sixthRow.titleLabel.text = @"月:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemDetailsTypeMustLLI;
    self.seventhRow.titleLabel.text = @"负责人:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLT;

    self.eighthRow.titleLabel.text = @"负责人描述:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLL;
    self.ninthRow.titleLabel.text = @"录入人编号:";
    AccountModel *model = [AccountManager account];
    self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    self.ninthRow.contentLabel.text = model.userName;
    [self.rootView addSubview:self.ninthRow];
    
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLL;
    self.tenthRow.titleLabel.text = @"录入人描述:";
    self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    
    self.tenthRow.contentLabel.text =model.displayName;
    [self.rootView addSubview:self.tenthRow];
    
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eleventhRow = [ProblemItemLLIView showXibView];
    self.eleventhRow.type = ProblemItemTypeDefaultLL;
    self.eleventhRow.titleLabel.text = @"录入时间:";
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * str = [formatter stringFromDate:[NSDate date]];
    self.eleventhRow.contentLabel.textColor = [UIColor blackColor];
    self.eleventhRow.contentLabel.text = str;
    [self.rootView addSubview:self.eleventhRow];
    [self.eleventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
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
- (void)updata
{
    if ([[self determineString:self.firstRow.contentTextField.text] isEqualToString:@""]) {
        HUDNormal(@"请选择中心编号");
        return;
    }else if ([[self determineString:self.secondRow.contentTextField.text] isEqualToString:@""]){
        HUDNormal(@"请选择中心");
        return;
    }else if ([[self determineString:self.thirdRow.contentLabel.text] isEqualToString:@""]){
        HUDNormal(@"请选择项目编号");
        return;
    }else if ([[self determineString:self.forthRow.contentTextField.text] isEqualToString:@""]){
        HUDNormal(@"请选择项目描述");
        return;
    }else if ([[self determineString:self.fifthRow.contentLabel.text] isEqualToString:@""]){
        HUDNormal(@"请选择年");
        return;
    }else if ([[self determineString:self.sixthRow.contentLabel.text] isEqualToString:@""]){
        HUDNormal(@"请选择月");
        return;
    }else if ([[self determineString:self.seventhRow.contentLabel.text] isEqualToString:@""]){
        HUDNormal(@"请选择负责人");
        return;
    }else if ([[self determineString:self.eighthRow.contentTextField.text] isEqualToString:@""]){
        HUDNormal(@"请填写负责人描述");
        return;
    }
    
    
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
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    
    NSArray * runlines = shareConstruction.runlineModels;
    
    NSMutableArray * runlinesDic = [NSMutableArray array];
    
    NSArray *relationShip;
    
    if (runlines.count>0) {
        runlinesDic = [Runliner mj_keyValuesArrayWithObjectArray:runlines];
        relationShip = runlinesDic;
    }
    else
    {
        NSDictionary *dict = @{};
        relationShip = @[dict];
    }
    NSDictionary *dic = @{
                          @"BRANCH":[self determineString:self.firstRow.contentTextField.text],//中心编号
                          @"BRANCHDESC":[self determineString:self.secondRow.contentTextField.text],//中心描述
                          @"PRONUM":[self determineString:self.thirdRow.contentLabel.text],//项目编号
                          //@"PRODESC":[self determineString:self.forthRow.contentTextField.text],//项目描述
                          @"YEAR":[self determineString:self.fifthRow.contentLabel.text],//年
                          @"MONTH":[self determineString:self.sixthRow.contentLabel.text],//月
                          @"PROHEAD":[self determineString:self.seventhRow.contentLabel.text],//负责人
                          @"NAME1":[self determineString:self.eighthRow.contentTextField.text],//负责人描述
                          @"CREATER":[self determineString:self.ninthRow.contentLabel.text],//录入人编号
                          @"CREATENAME":[self determineString:self.tenthRow.contentLabel.text],//录入人描述
                          @"CREATETIME":[self determineString:self.eleventhRow.contentLabel.text],//录入时间
                          @"DESCRIPTION":[NSString stringWithFormat:@"%@%@_%@运行记录",
                                         [self determineString:self.tenthRow.contentLabel.text],
                                         [self determineString:self.tenthRow.contentLabel.text],
                                         [self determineString:self.forthRow.contentTextField.text]],
                          @"relationShip": relationShip
                          };
    AccountModel *account = [AccountManager account];
    NSString *strPersonId = account.personId;
    

 
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDRUNLOGR"},
                     @{@"mboKey" : @"LOGNUM"},
                     @{@"personId" : strPersonId},
                     ];
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}
- (void)addBlocks
{
    WEAKSELF
    self.thirdRow.executeTapContentLabel = ^(){
        ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
        vc.title = @"选择项目编号";
        vc.executeClickCell = ^(ChooseItemNoModel *model){
            NSLog(@"%@",model);
            if (model.BRANCHDESC.length > 0) {
                weakSelf.secondRow.contentTextField.text = model.BRANCHDESC;
                weakSelf.secondRow.contentTextField.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondRow.contentTextField.text = @"暂无数据";
                weakSelf.secondRow.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.PRONUM.length > 0) {
                weakSelf.thirdRow.contentLabel.text = model.PRONUM;
                weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            if (model.DESCRIPTION.length > 0) {
                weakSelf.forthRow.contentTextField.text = model.DESCRIPTION;
                weakSelf.forthRow.contentTextField.textColor = [UIColor blackColor];
            }else{
                weakSelf.forthRow.contentTextField.text = @"暂无数据";
                weakSelf.forthRow.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
            }
            if (model.BRANCH.length > 0) {
                weakSelf.firstRow.contentTextField.text = model.BRANCH;
                weakSelf.firstRow.contentTextField.textColor = [UIColor blackColor];
            }else{
                weakSelf.firstRow.contentTextField.text = @"暂无数据";
                weakSelf.firstRow.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
            }

        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.fifthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailYear];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.fifthRow.contentLabel.text = str;
            weakSelf.fifthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    self.sixthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailMonth];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.sixthRow.contentLabel.text = str;
            weakSelf.sixthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    self.seventhRow.executeTapContentLabel = ^(){
        
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择联系人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            
            if (model.PERSONID.length > 0) {
                weakSelf.seventhRow.contentLabel.text = model.PERSONID;
                weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.seventhRow.contentLabel.text = @"暂无数据";
                weakSelf.seventhRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            if (model.DISPLAYNAME.length > 0) {
                weakSelf.eighthRow.contentTextField.text = model.DISPLAYNAME;
                weakSelf.eighthRow.contentTextField.textColor = [UIColor blackColor];
            }else{
                weakSelf.eighthRow.contentTextField.text = @"暂无数据";
                weakSelf.eighthRow.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作日志活动" iconName:@"ic_gzrz" callBack:^(NSUInteger index, id info) {
        DailylogActivityViewController * log = [[DailylogActivityViewController alloc] init];
        log.title=@"工作日志活动列表";
        log.LOGNUM = @"";
        [weakSelf.navigationController pushViewController:log animated:YES];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0] icon:@"more"];
    
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 130.f;
    //    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    //    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSString *)determineString:(NSString *)str{
    
    if([str isEqualToString:@"暂无数据"] ||str.length==0){
        return @"";
    }else{
        return str;
    }
}
@end
