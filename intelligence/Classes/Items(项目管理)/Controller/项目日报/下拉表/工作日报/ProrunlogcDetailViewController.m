//
//  ProrunlogcDetailViewController.m
//  intelligence
//
//  Created by chris on 2017/4/17.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "ProrunlogcDetailViewController.h"

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
    [self setTitle:@"工作日志活动子表详情"];
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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
