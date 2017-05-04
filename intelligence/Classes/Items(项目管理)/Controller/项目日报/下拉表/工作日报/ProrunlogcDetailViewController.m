//
//  ProrunlogcDetailViewController.m
//  intelligence
//
//  Created by chris on 2017/4/17.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "ProrunlogcDetailViewController.h"
#import "AppDelegate.h"
#import "ShareConstruction.h"
@interface ProrunlogcDetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *worknum;
@property (strong, nonatomic) IBOutlet UITextField *workpg;
@property (strong, nonatomic) IBOutlet UITextField *worktype;
@property (strong, nonatomic) IBOutlet UITextField *workcron;
@property (strong, nonatomic) IBOutlet UITextField *compsta;
@property (strong, nonatomic) IBOutlet UITextField *situaion;
@property (strong, nonatomic) IBOutlet UITextField *remark;

@end

@implementation ProrunlogcDetailViewController
//// 工作性质：
//@property (nonatomic, strong) ProblemItemLLIView *seventhRow;
//// 工作班成员：
//@property (nonatomic, strong) ProblemItemLTView *eighthRow;
//// 工作任务：
//@property (nonatomic, strong) ProblemItemLTView *ninthRow;
//// 完成情况
//@property (nonatomic, strong) ProblemItemLLIView *tenthRow;
//// 异常情况说明
//@property (nonatomic, strong) ProblemItemLTView *eleventhRow;
//// 备注
//@property (nonatomic, strong) ProblemItemLTView *twelfthRow;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"工作日志活动"];
    [self setupRightMenuButton];
    if(self.udPRORUNLOGC){
    [self.worknum setText:self.udPRORUNLOGC.WORKNUM];
    [self.workpg setText:self.udPRORUNLOGC.WORKPG];
    [self.worktype setText:self.udPRORUNLOGC.WORKTYPE];
    [self.workcron setText:self.udPRORUNLOGC.WORKCRON];
    [self.workcron setAdjustsFontSizeToFitWidth:YES];
    [self.compsta setText:self.udPRORUNLOGC.COMPSTA];
    [self.situaion setText:self.udPRORUNLOGC.SITUATION];
    [self.remark setText:self.udPRORUNLOGC.REMARK];
    
    [self.worknum setEnabled:NO];
    [self.workpg setEnabled:NO];
    [self.worktype setEnabled:NO];
    [self.compsta setEnabled:NO];
    [self.situaion setEnabled:NO];
    [self.remark setEnabled:NO];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupRightMenuButton{
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setTitle:@"保存" forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 5, 50, 30);
    // leftItem设置
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightButtonPress{
    
    if(!self.udPRORUNLOGC){
        NSLog(@"新建");
        self.udPRORUNLOGC = [[UDPRORUNLOGC alloc] init];
        self.udPRORUNLOGC.WORKNUM = self.worknum.text?self.worknum.text:@"";
        self.udPRORUNLOGC.WORKPG = self.workpg.text?self.workpg.text:@"";
        self.udPRORUNLOGC.WORKTYPE=self.worktype.text?self.worktype.text:@"";
        self.udPRORUNLOGC.WORKCRON=self.workcron.text?self.workcron.text:@"";
        self.udPRORUNLOGC.COMPSTA =self.compsta.text?self.compsta.text:@"";
        self.udPRORUNLOGC.SITUATION=self.situaion.text?self.situaion.text:@"";
        self.udPRORUNLOGC.REMARK=self.remark.text?self.remark.text:@"";
        
        self.udPRORUNLOGC.WINDSPEED = self.dailyWork.WINDSPEED?:@"";
        self.udPRORUNLOGC.TEM= self.dailyWork.TEM?:@"";
        self.udPRORUNLOGC.DESCRIPTION= self.dailyWork.DESCRIPTION?:@"";
        self.udPRORUNLOGC.RUNLOGDATE= self.dailyWork.RUNLOGDATE?:@"";
        self.udPRORUNLOGC.PRORUNLOGNUM= @"";
        self.udPRORUNLOGC.WEATHER= self.dailyWork.WEATHER?:@"";
        
        NSLog(@"%@",[self.udPRORUNLOGC mj_keyValues]);
        //保存在本地
        AppDelegate*app=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [app.createDataObject addObject:self.udPRORUNLOGC];
    }
    else
    {
        //对已有的进行修改
        self.udPRORUNLOGC = [[UDPRORUNLOGC alloc] init];
        self.udPRORUNLOGC.WORKNUM = self.worknum.text;
        self.udPRORUNLOGC.WORKPG = self.workpg.text;
        self.udPRORUNLOGC.WORKTYPE=self.worktype.text;
        self.udPRORUNLOGC.WORKCRON=self.workcron.text;
        self.udPRORUNLOGC.COMPSTA =self.compsta.text;
        self.udPRORUNLOGC.SITUATION=self.situaion.text;
        self.udPRORUNLOGC.REMARK=self.remark.text;
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
