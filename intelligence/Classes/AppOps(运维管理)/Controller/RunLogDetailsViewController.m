//
//  RunLogDetailsViewController.m
//  intelligence
//
//  Created by chris on 2016/11/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "RunLogDetailsViewController.h"
#import "ProblemItemLBView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "DailyDetailsFooterView.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
#import "DailylogActivityViewController.h"
#import "ShareConstruction.h"
#import "Runliner.h"
#import "SoapUtil.h"
@interface RunLogDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;

@property (nonatomic, strong) DailyDetailsFooterView *footerView;
//运行日志编号
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
//描述
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
//中心编号
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
//中心描述
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
//项目编号
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
//项目描述
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
//年
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
//月
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
//负责人
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
//负责人描述
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
//录入人编号
@property (nonatomic, strong) ProblemItemLLIView *eleventhRow;
//录入人描述
@property (nonatomic, strong) ProblemItemLLIView *twelfthRow;
//录入时间
@property (nonatomic, strong) ProblemItemLLIView *thirteenthRow;

@end

@implementation RunLogDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_runlogModel) {
        return;
    }
    [self addViews];
    [self addScrollFooterView];
    [self addRightNavBarItem];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    
    if ([shareConstruction.runlineModels count]>0)
    {
        for (Runliner * one in shareConstruction.runlineModels) {
            NSLog(@"得到的新日志 %@",[one mj_keyValues]);
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 BRANCH : 852;
 NAME1 : ;
 UDRUNLOGRID : 1,219;
 PRODESC : 中广核甘肃北大桥第八风电场A区;
 CREATENAME : 杨玉鑫;
 DESCRIPTION : 2016-11-23 13:3:37杨玉鑫_中广核甘肃北大桥第八风电场A区2016年11月运行记录;
 BRANCHDESC : 西北工程运维中心;
 CREATER : I00115;
 MONTH : 11;
 YEAR : 2016;
 LOGNUM : 1316;
 PRONUM : S1-20130024;
 CREATETIME : 2016-11-23 13:3:37;
 PROHEAD : ;
 */
-(void)addViews
{
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLT;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"运行日志编号";
    self.firstRow.contentTextField.text=_runlogModel.LOGNUM;
    [self.rootView addSubview:self.firstRow];
    
    self.secondRow = [ProblemItemLLIView showXibView];
    self.secondRow.type = ProblemItemTypeDefaultLV;
    self.secondRow.titleLabel.text = @"描述:";
    self.secondRow.contentTextView.text =_runlogModel.DESCRIPTION;
    [self.rootView addSubview:self.secondRow];
    [self.secondRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(90);
    }];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLT;
    self.thirdRow.titleLabel.text = @"中心编号:";
     self.thirdRow.contentTextField.text = _runlogModel.BRANCH;
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLT;
    self.forthRow.titleLabel.text = @"中心描述:";
    self.forthRow.contentTextField.text = _runlogModel.BRANCHDESC;
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLT;
    self.fifthRow.titleLabel.text = @"项目编号:";
    self.fifthRow.contentTextField.text = _runlogModel.PRONUM;
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemItemTypeDefaultLV;
    self.sixthRow.titleLabel.text = @"项目描述:";
    self.sixthRow.contentTextView.text = _runlogModel.PRODESC;
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(65);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemItemTypeDefaultLT;
    self.seventhRow.titleLabel.text = @"年:";
    self.seventhRow.contentTextField.text = _runlogModel.YEAR;
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLT;
    
    self.eighthRow.titleLabel.text = @"月:";
    self.eighthRow.contentTextField.text = _runlogModel.MONTH;
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLT;
    self.ninthRow.titleLabel.text = @"负责人:";
    self.ninthRow.contentTextField.text = _runlogModel.PROHEAD;
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
    self.tenthRow.type = ProblemItemTypeDefaultLT;
    self.tenthRow.titleLabel.text = @"负责人描述:";
    self.tenthRow.contentTextField.text = _runlogModel.NAME1;
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
    self.eleventhRow.type = ProblemItemTypeDefaultLT;
    self.eleventhRow.titleLabel.text = @"录入人编号:";
    self.eleventhRow.contentTextField.text = _runlogModel.CREATER;
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
    self.twelfthRow.type = ProblemItemTypeDefaultLT;
    self.twelfthRow.titleLabel.text = @"录入人描述:";
    self.twelfthRow.contentTextField.text = _runlogModel.CREATENAME;
    [self.rootView addSubview:self.twelfthRow];
    [self.twelfthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eleventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.thirteenthRow = [ProblemItemLLIView showXibView];
    self.thirteenthRow.type = ProblemItemTypeDefaultLT;
    self.thirteenthRow.titleLabel.text = @"录入时间:";
    self.thirteenthRow.contentTextField.text = _runlogModel.CREATETIME;
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
    NSDictionary *dict = @{};
    NSArray *relationShip = @[dict];
    
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];
    
    if ([shareConstruction.runlineModels count]>0)
    {
        
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                          @"BRANCH":self.firstRow.contentLabel.text,//中心编号
                                                                          @"BRANCHDESC":self.firstRow.contentLabel.text,//中心描述
                                                                          @"PRONUM":self.firstRow.contentLabel.text,//项目编号
                                                                          @"PRODESC":self.firstRow.contentLabel.text,//项目描述
                                                                          @"YEAR":self.firstRow.contentLabel.text,//年
                                                                          @"MONTH":self.firstRow.contentLabel.text,//月
                                                                          @"PROHEAD":self.firstRow.contentLabel.text,//负责人
                                                                          @"NAME1":self.firstRow.contentLabel.text,//负责人描述
                                                                          @"CREATER":self.firstRow.contentLabel.text,//录入人编号
                                                                          @"CREATENAME":self.firstRow.contentLabel.text,//录入人描述
                                                                          @"CREATETIME":self.firstRow.contentLabel.text,//录入时间
                                                                          @"relationShip":relationShip
                                                                          }];
    if ([shareConstruction.runlineModels count]>0)
    {
        NSMutableArray * tmpArray=[NSMutableArray array];
        for (Runliner * one in shareConstruction.runlineModels) {
            [tmpArray addObject: [one mj_keyValues]];
        }
        [dic setObject:tmpArray forKey:@"UDRUNLINER"];
    }
    
    
    /*
     DESCRIPTION;//描述
     BRANCH;//中心编号
     BRANCHDESC;//中心描述
     PRONUM;//项目编号
     PRODESC;//项目描述
     YEAR;//年
     MONTH;//月
     PROHEAD;//负责人
     NAME1;//负责人描述
     CREATER;//录入人编号
     CREATENAME;//录入人描述
     CREATETIME;//录入时间
     */
    AccountModel *account = [AccountManager account];
    NSString *strPersonId = account.personId;
    NSLog(@"准备提交的信息 %@",dic);
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDRUNLOGR"},
                     @{@"mboKey" : @"LOGNUM"},
                     @{@"personId" : strPersonId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"工作日志活动" iconName:@"ic_gzrz" callBack:^(NSUInteger index, id info) {
        DailylogActivityViewController * log = [[DailylogActivityViewController alloc] init];
        log.title=@"工作日志活动列表";
        log.LOGNUM = self.runlogModel.LOGNUM;
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
@end
