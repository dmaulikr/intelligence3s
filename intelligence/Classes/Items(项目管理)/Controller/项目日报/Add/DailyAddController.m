//
//  DailyAddController.m
//  intelligence
//
//  Created by  on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DailyAddController.h"
#import "DailyDetailsFooterView.h"
#import "ProblemItemLLIView.h"
#import "ChoiceWorkView.h"
#import "ChooseItemNoController.h"
#import "DailyDetailChoosePersonController.h"
#import "DTKDropdownMenuView.h"

#import "ChooseItemNoModel.h"
#import "ChoosePersonModel.h"

#import "SoapUtil.h"
#import "ShareConstruction.h"
#import "ConstructionDailyAddController.h"
#import "HoistingDebugAddController.h"
#import "DailyWorkController.h"
#import "ToolingManagementAddController.h"

@interface DailyAddController ()
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;

// 描述:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
// *项目编号：
@property (nonatomic, strong) ProblemItemLLIView *secondRow;
// 所属中心：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
// 现场负责人：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
// *现场联系人:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
// *年:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
// *月：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
// 项目阶段：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
// 状态：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;

@property (nonatomic, strong) NSString * PRONUM;

@end

@implementation DailyAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日报新增";
    if ((9 * 45 + 60) >= ScreenHeight) {
         self.rootViewHeight.constant = 9 * 45 + 60;
    }else{
         self.rootViewHeight.constant = 9 * 45;
    }
    [self addRows];
    [self addBlocks];
    [self addScrollFooterView];
    [self addRightNavBarItem];
}
- (void)addRightNavBarItem{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"土建阶段日报" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"吊装调试日报" iconName:@"ic_diaozhuang" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"工作日报" iconName:@"ic_realinfo" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工装管理" iconName:@"ic_gzgl" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2,item3] icon:@"more"];
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

            //土建阶段日报
            ConstructionDailyAddController *vc = [[ConstructionDailyAddController alloc] init];
            vc.requestStr = self.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            //吊装调试日报
            HoistingDebugAddController *vc = [[HoistingDebugAddController alloc] init];
            vc.requestStr = self.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{
            //工作日报
            DailyWorkController *vc = [[DailyWorkController alloc] init];
            vc.requestStr = self.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 3:{
            //工装管理
            ToolingManagementAddController *vc = [[ToolingManagementAddController alloc] init];
            vc.requestStr = self.PRONUM;
            vc.PRORUNLOGNUM = self.daily.PRORUNLOGNUM;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}
- (void)addRows{
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"描述:";
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
    self.thirdRow.titleLabel.text = @"所属中心:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLT;
    self.forthRow.titleLabel.text = @"现场负责人:";
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];

    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemDetailsTypeMustLLI;
    self.fifthRow.titleLabel.text = @"现场联系人:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemDetailsTypeMustLLI;
    self.sixthRow.titleLabel.text = @"年:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemDetailsTypeMustLLI;
    self.seventhRow.titleLabel.text = @"月:";
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLL;
    self.eighthRow.titleLabel.text = @"项目阶段:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLL;
    self.ninthRow.contentLabel.text = @"新建";
    self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    self.ninthRow.titleLabel.text = @"状态:";
    [self.rootView addSubview:self.ninthRow];
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)addBlocks{
    WEAKSELF
    
    self.secondRow.executeTapContentLabel = ^(){
        ChooseItemNoController *vc = [[ChooseItemNoController alloc] init];
        vc.title = @"选择项目";
        vc.executeClickCell = ^(ChooseItemNoModel *model){
            weakSelf.PRONUM = model.PRONUM;
            if (model.PRONUM.length > 0) {
                weakSelf.secondRow.contentLabel.text = model.PRONUM;
                weakSelf.secondRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.secondRow.contentLabel.text = @"暂无数据";
                weakSelf.secondRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            weakSelf.daily.PRORUNLOGNUM = model.DESCRIPTION;
            if (model.DESCRIPTION.length > 0) {
                weakSelf.firstRow.contentLabel.text = model.DESCRIPTION;
                weakSelf.firstRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.firstRow.contentLabel.text = @"暂无数据";
                weakSelf.firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            weakSelf.daily.BRANCH = model.BRANCHDESC;
            if (model.BRANCHDESC.length > 0) {
                weakSelf.thirdRow.contentLabel.text = model.BRANCHDESC;
                weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            weakSelf.daily.UDPRORESC = model.RESPONSNAME;
            if (model.RESPONSNAME.length > 0) {
                weakSelf.forthRow.contentTextField.text = model.RESPONSNAME;
            }
            weakSelf.daily.CONTDNAME = model.RESPONSNAME;
            if (model.RESPONSNAME.length > 0) {
                weakSelf.fifthRow.contentLabel.text = model.RESPONSNAME;
                weakSelf.fifthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.fifthRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            if (model.PROSTAGE.length > 0) {
                weakSelf.eighthRow.contentLabel.text = model.PROSTAGE;
                weakSelf.eighthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.eighthRow.contentLabel.text = @"暂无数据";
                weakSelf.eighthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            
            
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.fifthRow.executeTapContentLabel = ^(){
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择联系人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.daily.CONTDNAME = model.DISPLAYNAME;
            if (model.DISPLAYNAME.length > 0) {
                weakSelf.fifthRow.contentLabel.text = model.DISPLAYNAME;
                weakSelf.fifthRow.contentLabel.textColor = [UIColor blackColor];
            }else{
                weakSelf.fifthRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.sixthRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailYear];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.sixthRow.contentLabel.text = str;
            weakSelf.sixthRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
    };
    
    self.seventhRow.executeTapContentLabel = ^(){
        ChoiceWorkView *popup = [[ChoiceWorkView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) choice:ChoiceTypeDailMonth];
        popup.WorkBlock = ^(NSString *str){
            weakSelf.seventhRow.contentLabel.text = str;
            weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
        };
        [popup ShowInView:weakSelf.view];
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

        
        if (weakSelf.sixthRow.contentLabel.text.length==0||[weakSelf.sixthRow.contentLabel.text isEqualToString:@"暂无数据"]) {
            WHUDNormal(@"年 未填写");
            return ;
        }
        else if(![weakSelf isPureNumandCharacters:weakSelf.sixthRow.contentLabel.text])
        {
            
            WHUDNormal(@"年 格式不对");
            return ;
        }
        
        if (weakSelf.seventhRow.contentLabel.text.length==0||[weakSelf.seventhRow.contentLabel.text isEqualToString:@"暂无数据"]) {
            WHUDNormal(@"月 未填写");
            return ;
        }
        else if(![weakSelf isPureNumandCharacters:weakSelf.seventhRow.contentLabel.text])
        {
            
            WHUDNormal(@"月 格式不对");
            return ;
        }
        
        [weakSelf updata];
    };
    
    [self.view addSubview:self.footerView];
}

- (void)updata{
    SVHUD_NO_Stop(@"保存日报中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        
        NSLog(@"结果 %@",dic);
        
        SVHUD_Stop;
        if ([dic[@"status"] isEqualToString:@""]) {
            HUDNormal(@"保存失败稍后再试");
        }else{
            NSString *str2 = [NSString stringWithFormat:@"编号%@日志新增成功",dic[@"PRORUNLOGNUM"]];
            HUDNormal(str2);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    //
    ShareConstruction *shareConstruction = [ShareConstruction sharedConstruction];

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *relationShip = [NSMutableArray array];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:@{
                                                                              @"CONTRACTS":@"",
                                                                              @"RESPONSID":@"",
                                                                              @"DESCRIPTION":self.firstRow.contentLabel.text,
                                                                              @"PRONUM":self.secondRow.contentLabel.text,
                                                                              @"UDPRORESC":self.fifthRow.contentLabel.text,
                                                                              @"YEAR":self.sixthRow.contentLabel.text,
                                                                              @"MONTH":self.seventhRow.contentLabel.text,
                                                                              @"PROSTAGE":self.eighthRow.contentLabel.text,
                                                                              @"STATUS":self.ninthRow.contentLabel.text,
                                                                              @"relationShip":relationShip,
                                                                              }];
    //土建
    if (shareConstruction.construction) {
        NSLog(@"土建");
         [dic setObject:[NSArray arrayWithObject:shareConstruction.construction.dic] forKey:@"UDPRORUNLOGLINE1"];
        
        
        [dict setObject:@"" forKey:@"UDPRORUNLOGLINE1"];
    }
    //吊装
    if (shareConstruction.hoisting) {
        NSLog(@"吊装");
        [dic setObject:[NSArray arrayWithObject:shareConstruction.hoisting.dic] forKey:@"UDPRORUNLOGLINE2"];
       
        [dict setObject:@"" forKey:@"UDPRORUNLOGLINE2"];
    }
    //工作日报
    if (shareConstruction.dailyWork) {
        NSLog(@"工作日报");
         [dic setObject:[NSArray arrayWithObject:shareConstruction.dailyWork.dic] forKey:@"UDPRORUNLOGLINE"];
       
        [dict setObject:@"" forKey:@"UDPRORUNLOGLINE"];
    }
    //工装管理
    if (shareConstruction.toolingManagement) {
        
        NSLog(@"工装管理");
         [dic setObject:[NSArray arrayWithObject:shareConstruction.toolingManagement.dic] forKey:@"UDPRORUNLOGLINE4"];
        
        [dict setObject:@"" forKey:@"UDPRORUNLOGLINE4"];
        
    }
    if (relationShip.count==0) {
        [dict setObject:@"" forKey:@""];
        [relationShip addObject:dict];
    }
    AccountModel *account = [AccountManager account];
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDPRORUNLOG"},
                     @{@"mboKey" : @"PRORUNLOGNUM"},
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    
    if(string.length > 0)
    {
        return NO;
    } 
    return YES;
}
@end
