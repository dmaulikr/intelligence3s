//
//  TripReportAddViewController.m
//  intelligence
//
//  Created by chris on 2016/11/22.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "TripReportAddViewController.h"
#import "ProblemItemLBView.h"
#import "ProblemItemLLIView.h"
#import "ProblemItemLTView.h"
#import "DailyDetailsFooterView.h"
#import "DTKDropdownMenuView.h"
#import "SoapUtil.h"
#import "ChooseItemNoController.h"
#import "ChoiceWorkView.h"
#import "DailyDetailChoosePersonController.h"
#import "SupportDepartmentController.h"

@interface TripReportAddViewController ()<UITextFieldDelegate>
{
    NSString * personid;
    NSString * CREATER_DISPLAYNAME;
    NSString * DEPTNAME;
    NSString * NAME1;
    NSString * PROJECTNAME;
}
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rootViewHeight;
@property (nonatomic, strong) DailyDetailsFooterView *footerView;
//姓名:
@property (nonatomic, strong) ProblemItemLLIView *firstRow;
//部门：
@property (nonatomic, strong) ProblemItemLLIView *thirdRow;
//录入人：
@property (nonatomic, strong) ProblemItemLLIView *forthRow;
//出差项目:
@property (nonatomic, strong) ProblemItemLLIView *fifthRow;
//出差地点:
@property (nonatomic, strong) ProblemItemLLIView *sixthRow;
//出差日期：
@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
//出差是由：
@property (nonatomic, strong) ProblemItemLLIView *eighthRow;
//工作内容：
@property (nonatomic, strong) ProblemItemLLIView *ninthRow;
//录入时间
@property (nonatomic, strong) ProblemItemLLIView *tenthRow;

@property (nonatomic, strong) TXTimeChoose * timeYear1;

@end

@implementation TripReportAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self addScrollFooterView];
    [self addBlocks];
    [self queryUserInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addViews
{
    WEAKSELF
    AccountModel *account = [AccountManager account];
    self.firstRow = [ProblemItemLLIView showXibView];
    self.firstRow.type = ProblemItemTypeDefaultLL;
    self.firstRow.frame = CGRectMake(0, 0, ScreenWidth, 45);
    self.firstRow.titleLabel.text = @"出差人工号:";
    self.firstRow.contentLabel.text = [NSString stringWithFormat:@"%@(%@)",account.userName,account.displayName];
    self.firstRow.contentLabel.textColor = [UIColor blackColor];
    [self.rootView addSubview:self.firstRow];
    
    self.thirdRow = [ProblemItemLLIView showXibView];
    self.thirdRow.type = ProblemItemTypeDefaultLL;
    self.thirdRow.titleLabel.text = @"部门编号:";
    [self.rootView addSubview:self.thirdRow];
    [self.thirdRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.forthRow = [ProblemItemLLIView showXibView];
    self.forthRow.type = ProblemItemTypeDefaultLL;
    self.forthRow.titleLabel.text = @"录入人:";
    
    self.forthRow.contentLabel.text =[NSString stringWithFormat:@"%@(%@)",account.userName,account.displayName];
    self.forthRow.contentLabel.textColor = [UIColor blackColor];
    [self.rootView addSubview:self.forthRow];
    [self.forthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.fifthRow = [ProblemItemLLIView showXibView];
    self.fifthRow.type = ProblemItemTypeDefaultLL;
    self.fifthRow.titleLabel.text = @"出差项目编号:";
    [self.rootView addSubview:self.fifthRow];
    [self.fifthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sixthRow = [ProblemItemLLIView showXibView];
    self.sixthRow.type = ProblemItemTypeDefaultLT;
    self.sixthRow.titleLabel.text = @"出差地点:";
    [self.rootView addSubview:self.sixthRow];
    [self.sixthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fifthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.seventhRow = [ProblemItemLLIView showXibView];
    self.seventhRow.type = ProblemItemTypeDefaultLL;
    self.seventhRow.titleLabel.text = @"出差日期:";
    //self.seventhRow.contentLabel.textColor = [UIColor blackColor];
    
    [self.rootView addSubview:self.seventhRow];
    [self.seventhRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    self.eighthRow = [ProblemItemLLIView showXibView];
    self.eighthRow.type = ProblemItemTypeDefaultLT;
    
    self.eighthRow.titleLabel.text = @"出差事由:";
    [self.rootView addSubview:self.eighthRow];
    [self.eighthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seventhRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(45);
    }];
    self.eighthRow.executeTapContentLabel = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.eighthRow.contentTextField.text title:weakSelf.eighthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.eighthRow.contentTextField.text=value;
        }];
    };
    
    
    self.ninthRow = [ProblemItemLLIView showXibView];
    self.ninthRow.type = ProblemItemTypeDefaultLV;
    self.ninthRow.titleLabel.text = @"工作内容:";

    
    self.ninthRow.executeTapContentLabel = ^{
        
        [weakSelf popInputTextViewContent:weakSelf.ninthRow.contentLabel.text title:weakSelf.ninthRow.titleLabel.text compeletion:^(NSString *value) {
            weakSelf.ninthRow.contentLabel.text=value;
        }];
    };
    
    self.ninthRow.contentLabel.textColor = [UIColor blackColor];
    
    [self.rootView addSubview:self.ninthRow];
    
    [self.ninthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eighthRow.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(90);
    }];
    
    self.tenthRow = [ProblemItemLLIView showXibView];
    self.tenthRow.type = ProblemItemTypeDefaultLL;
    self.tenthRow.titleLabel.text = @"录入时间:";
    self.tenthRow.contentLabel.textColor = [UIColor blackColor];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.tenthRow.contentLabel.text = [formatter stringFromDate:[NSDate date]];
    
    [self.rootView addSubview:self.tenthRow];
    
    [self.tenthRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ninthRow.mas_bottom).offset(0);
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
- (void)addBlocks
{
    WEAKSELF
    self.firstRow.executeTapContentLabel = ^()
    {
         NSLog(@"选择工号");
        DailyDetailChoosePersonController *vc = [[DailyDetailChoosePersonController alloc] init];
        vc.title = @"选择联系人";
        vc.exetuceClickCell = ^(ChoosePersonModel *model){
            
            if (model.PERSONID.length > 0) {
                weakSelf.firstRow.contentLabel.text = [NSString stringWithFormat:@"%@(%@)",model.PERSONID,model.DISPLAYNAME],
                weakSelf.firstRow.contentLabel.textColor = [UIColor blackColor];
                NAME1 = model.DISPLAYNAME;
            }else{
                weakSelf.firstRow.contentLabel.text = @"暂无数据";
                weakSelf.firstRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
            if(model.DEPARTMENT.length > 0)
            {
                weakSelf.thirdRow.contentLabel.text =[NSString stringWithFormat:@"%@(%@)",model.DEPARTMENT,model.DEPARTDESC];
                NSLog(@"%@",[model mj_keyValues]);
                weakSelf.thirdRow.contentLabel.textColor = [UIColor blackColor];
                DEPTNAME = model.DEPARTDESC;
            }else{
                weakSelf.thirdRow.contentLabel.text = @"暂无数据";
                weakSelf.thirdRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.thirdRow.executeTapContentLabel = ^{
        
        SupportDepartmentController *vc = [[SupportDepartmentController alloc] init];
        
        vc.executeCellClick = ^(SupportDepartmentModel *model){
            NSLog(@"选择部门 %@",model.DEPTNUM);
            weakSelf.thirdRow.contentLabel.text =[NSString stringWithFormat:@"%@(%@)",model.DEPTNUM,model.DESCRIPTION];
        };
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    self.fifthRow.executeTapContentLabel = ^()
    {
         NSLog(@"选择项目");
        ChooseItemNoController *choose = [[ChooseItemNoController alloc]init];
        choose.executeClickCell = ^(ChooseItemNoModel *model){
            if (model.PRONUM.length > 0) {
                weakSelf.fifthRow.contentLabel.text = model.PRONUM;
                weakSelf.fifthRow.contentLabel.textColor = [UIColor blackColor];
                NSLog(@"%@",[model mj_keyValues]);
                PROJECTNAME = model.DESCRIPTION;
            }else{
                weakSelf.fifthRow.contentLabel.text = @"暂无数据";
                weakSelf.fifthRow.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
            }
        };
        [weakSelf.navigationController pushViewController:choose animated:YES];
    };
    self.eighthRow.executeTapContentLabel = ^()
    {
         NSLog(@"选择出差时间");
    };
    self.seventhRow.executeTapContentLabel= ^()
    {
       [weakSelf.view addSubview:weakSelf.timeYear1];
    };
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
    AccountModel *account = [AccountManager account];
    NSLog(@"%@",[account mj_keyValues]);
    NSString *strPersonId = account.personId;
    CREATER_DISPLAYNAME = account.displayName;
    
    
    NSDictionary *dict = @{@"":@""};
    NSArray *relationShip = @[dict];
    
    NSDictionary *dic = @{
                          @"ACOUNT":self.firstRow.contentLabel.text.length>0?[self.firstRow.contentLabel.text componentsSeparatedByString:@"("][0]:@"",//出差人工号
                          @"DEPTNUM":self.thirdRow.contentLabel.text.length>0?[self.thirdRow.contentLabel.text componentsSeparatedByString:@"("][0]:@"",//部门编号
                          @"CREATEBY":self.forthRow.contentLabel.text.length>0?[self.forthRow.contentLabel.text componentsSeparatedByString:@"("][0]:@"",//录入人
                          @"PROJECT":self.fifthRow.contentLabel.text.length>0?self.fifthRow.contentLabel.text:@"",//项目编号
                          @"TOPLACE":self.sixthRow.contentTextField.text.length>0?self.sixthRow.contentTextField.text:@"",//地点
                          @"TRIPDATE":self.seventhRow.contentLabel.text.length>0?self.seventhRow.contentLabel.text:@"",//出差日期
                          @"TRIPCONTENT":self.eighthRow.contentTextField.text.length>0?self.eighthRow.contentTextField.text:@"",//出差事由
                          @"WORKCONTENT":self.ninthRow.contentTextView.text.length>0?self.ninthRow.contentTextView.text:@"",//工作内容
                          @"CREATEDATE":self.tenthRow.contentLabel.text.length>0?self.tenthRow.contentLabel.text:@"",//录入时间
                          //@"CREATER.DISPLAYNAME":CREATER_DISPLAYNAME?CREATER_DISPLAYNAME:@"",
                          //@"DEPTNAME":DEPTNAME?DEPTNAME:@"",
                          @"DESCRIPTION":[NSString stringWithFormat:@"%@%@_的出差总结报告",self.tenthRow.contentLabel.text,NAME1],
                          @"NAME1":NAME1?NAME1:@"",
                          //@"PROJECTNAME":PROJECTNAME?PROJECTNAME:@"",
                          //@"SERIALNUMBER":strPersonId,
                          //@"TRIPCODE":@"",
                          @"relationShip":relationShip
                          };
//    {,,"DEPTNUM":"18","DESCRIPTION":"t","NAME1":"A10239","PROJECT":"S1-20100020","TOPLACE":"y","TRIPCONTENT":"f\n","TRIPDATE":"2017-3-13 00:00:00","WORKCONTENT":"r","relationShip":[{"":""}]}
    /*
     DESCRIPTION;//描述
     ACOUNT;//出差人编号
     DEPTNUM;//部门编号
     CREATEBY;//录入人;
     CREATEDATE;//录入日期
     TRIPDATE;//出差日期
     PROJECT;//出差项目
     TOPLACE;//出差地点
     TRIPCONTENT;//出差事由
     WORKCONTENT;//工作内容
     */

    
    NSArray *arr = @[
                     @{@"json" : [self dictionaryToJson:dic]},
                     @{@"flag" : @"1"},
                     @{@"mboObjectName" : @"UDTRIPREPORT"},
                     @{@"mboKey" : @"SERIALNUMBER"},
                     @{@"personId" : strPersonId}
                     ];
    
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"最终值 %@",textField.text);
    return;
}
- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.seventhRow.contentLabel.text = [weakSelf.timeYear1 stringFromDate:data];
            weakSelf.seventhRow.contentLabel.textColor = [UIColor blackColor];
        };
    }
    return _timeYear1;
}
//查询用户部门信息
-(void)queryUserInfo
{
    AccountModel *account = [AccountManager account];
    NSDictionary *dic = @{@"STATUS":@"=活动",@"PERSONID":account.userName};
    
    NSDictionary *requestDic = @{@"appid":@"UDPERSON",
                                 @"objectname":@"PERSON",
                                 @"curpage":@(0),
                                 @"showcount":@(20),
                                 @"option":@"read",
                                 @"condition":dic};
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        NSArray *array = response[@"result"][@"resultlist"];
        if ([array count]==1) {
            NSString *tmp =array[0][@"DEPARTMENT"];
            
            if (tmp.length>0) {
                NSString *str = [NSString stringWithFormat:@"%@(%@)",array[0][@"DEPARTMENT"],array[0][@"DEPARTDESC"]];
                NSLog(@"单个用户的部门信息 %@",str);
                self.thirdRow.contentLabel.text=str?str:@"";
                self.thirdRow.contentLabel.textColor=[UIColor blackColor];
            }
        }
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
    }];
}
@end
