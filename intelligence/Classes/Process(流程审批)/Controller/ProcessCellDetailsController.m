//
//  ProcessCellDetailsController.m
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProcessCellDetailsController.h"
#import "ProcessDetailsCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "ProcessDetailsFooterView.h"
#import "ProcessApprovalPopupWindowView.h"
#import "SoapUtil.h"


#import "FaultWorkViewController.h"//故障工单
#import "CheckWorkViewController.h"//终验收工单
#import "DebugWorkViewController.h"//调试工单
#import "CheckingWorkController.h"//排查工单
#import "TechnologyViewController.h"//技改工单
#import "CheckWorksViewController.h"//定检工单

#import "ProblemDetailsController.h"//问题联络单
#import "DetailsStockViewController.h"//库存盘点单
#import "FaultAppDetailsViewController.h"//故障提报单
#import "PollingDetailsController.h"//巡检单
#import "WebViewController.h"//网页

@interface ProcessCellDetailsController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProcessDetailsFooterView *footerView;
@property(nonatomic, retain) NSXMLParser *xmlParser;


@end

@implementation ProcessCellDetailsController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavBarHeight - 80) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流程审批详情";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
    }];
    [self addFooterView];
}

- (void)addFooterView{
    self.footerView = [ProcessDetailsFooterView showXibView];
    self.footerView.frame = CGRectMake(0, 0, ScreenWidth, 110);
    [self.footerView.btnApproval addTarget:self action:@selector(btnApprovalClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.btnDetail addTarget:self action:@selector(btnDetaillClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footerView;
}

- (void)btnApprovalClick:(UIButton *)sender{
    WEAKSELF
    ProcessApprovalPopupWindowView *popupView = [[ProcessApprovalPopupWindowView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    popupView.process = _process;
    popupView.CloseBlick = ^(NSString *str){
        if (weakSelf.UpdataBlock) {
            weakSelf.UpdataBlock(str);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
        [popupView show];
}
-(NSString *)workTypeAPPID:(NSString *)appid
{
    if ([appid isEqualToString:@"UDREPORTWO"]) {
        return @"FR";
    }
    if ([appid isEqualToString:@"UDZYSWO"]) {
        return @"AA";
    }
    if ([appid isEqualToString:@"UDPCWO"]) {
        return @"SP";
    }
    if ([appid isEqualToString:@"UDJGWO"]) {
        return @"TP";
    }
    if ([appid isEqualToString:@"UDDJWO"]) {
        return @"WS";
    }
        return @"DC";
}

- (void)btnDetaillClick:(UIButton *)sender{
    
    NSMutableString *mString=[NSMutableString stringWithString:self.process.OWNERID];
    [mString deleteCharactersInRange:[self.process.OWNERID rangeOfString:@","]];
    
    NSLog(@"查看详情");
    if ([self.process.OWNERTABLE isEqualToString:@"WORKORDER"])
    {

        NSLog(@"工单 %@",mString);
        
        NSString * workType=[self workTypeAPPID:self.process.APP];
        
        NSDictionary * param=@{@"WORKORDERID":mString,@"worktype":workType,@"choose":@"",@"appid":self.process.APP,@"objectname":@"WORKORDER",@"orderby":@"WORKORDERID desc"};
        
        [self requestData:1 param:param];
    }
    else if ([self.process.OWNERTABLE isEqualToString:@"DEBUGWORKORDER"])
    {
        NSLog(@"调试工单");
        NSLog(@"工单 %@",mString);
        
        NSDictionary * param=@{@"DEBUGWORKORDERID":mString,
                               @"worktype":@"DC",
                               @"choose":@"",@"appid":@"DEBUGWORKORDER",@"objectname":@"DEBUGORDER",@"orderby":@"DEBUGWORKORDERID desc"};
        
        [self requestData:1 param:param];
    }
    else if ([self.process.OWNERTABLE isEqualToString:@"UDSTOCK"])
    {
        NSLog(@"库存盘点单");
        
        [self requestSTOCKData:1 identity:(NSString*)mString];
        
    }
    else if ([self.process.OWNERTABLE isEqualToString:@"UDFEEDBACK"])
    {
        NSLog(@"问题联络单");
        [self requestFEEDBACKData:1 identity:mString];
    }
    else if ([self.process.OWNERTABLE isEqualToString:@"UDREPORT"])
    {
        NSLog(@"故障提报单");
        [self requestREPORTData:1 identity:mString];
    }
    else if ([self.process.OWNERTABLE isEqualToString:@"UDINSPO"])
    {
        NSLog(@"巡检单");
        [self requestINSPOData:1 identity:mString];
    }
    else
    {
        NSLog(@"其它流程跳转到网络");
        [self toWebviewidentity:mString];
    }
}
//查询工单信息并跳转
- (void)requestData:(NSInteger)page param:(NSDictionary*)param{
    
    NSString*worktype=param[@"worktype"];
    NSString*choose=param[@"choose"];
    NSString*appid=param[@"appid"];
    NSString*objectname=param[@"objectname"];
    NSString*orderby=param[@"orderby"];
    NSString*WORKORDERID=param[@"WORKORDERID"];
    NSString*DEBUGWORKORDERID=param[@"DEBUGWORKORDERID"];
    
    
    NSDictionary *requestDic;
    NSDictionary *dic = @{
                          @"WORKTYPE":worktype,
                          @"UDSTATUS":choose,
                          @"WORKORDERID":WORKORDERID,
                          };
    if ([worktype isEqualToString:@"DC"]){
        NSDictionary *dics = @{
                               @"STATUS":choose,
                               @"DEBUGWORKORDERID":DEBUGWORKORDERID
                               };
        if ([choose isEqualToString:@""]) {
            requestDic = @{
                           @"appid"     :appid,
                           @"objectname":objectname,
                           @"curpage"   :@(page),
                           @"showcount" :@(20),
                           @"option"    :@"read",
                           @"orderby"   :orderby,
                           };
        }else{
            requestDic = @{
                           @"appid"     :appid,
                           @"objectname":objectname,
                           @"curpage"   :@(page),
                           @"showcount" :@(20),
                           @"option"    :@"read",
                           @"orderby"   :orderby,
                           @"condition" :dics,
                           };
        }
    }else{
        requestDic = @{
                       @"appid"     :appid,
                       @"objectname":objectname,
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :orderby,
                       @"condition" :dic,
                       };
    }
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        NSLog(@"查询结果：%@",response);

        NSDictionary *dic =response[@"result"][@"resultlist"][0];
        
        FauWorkModel *stock = [FauWorkModel mj_objectWithKeyValues:dic];
        //故障工单
        if([worktype isEqualToString:@"FR"])
        {

            FaultWorkViewController *details = [[FaultWorkViewController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        if([worktype isEqualToString:@"AA"])
        //终验收工单
        {
            CheckWorkViewController *details = [[CheckWorkViewController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        if([worktype isEqualToString:@"DC"])
        //调试工单
        {
            DebugWorkViewController *details = [[DebugWorkViewController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        if([worktype isEqualToString:@"SP"])
        //排查工单
        {
            CheckingWorkController *details = [[CheckingWorkController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        if([worktype isEqualToString:@"TP"])
        //技改工单
        {
            TechnologyViewController *details = [[TechnologyViewController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        if([worktype isEqualToString:@"WS"])
        //定检工单
        {
            CheckWorksViewController *details = [[CheckWorksViewController alloc]init];
            details.stock = stock;
            details.objectname = objectname;
            [self.navigationController pushViewController:details animated:YES];
        }
        
        

    } fail:^(NSError *error) {
        SVHUD_Stop
        SVHUD_ERROR(@"网络异常")
    }];
}
//查询库存盘点信息并跳转
- (void)requestSTOCKData:(NSInteger)page identity:(NSString*)identity
{
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDSTOCK",
                                 @"objectname":@"UDSTOCK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"STOCKNUM DESC",
                                 @"condition" :@{@"STOCKNUM":identity}
                                 };
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        
        NSLog(@"response %@",response);
        
        SVHUD_Stop
        NSDictionary *dic = response[@"result"][@"resultlist"][0];
 
        StockModel *stock = [StockModel mj_objectWithKeyValues:dic];
        
        DetailsStockViewController *details = [[DetailsStockViewController alloc]init];
        details.stock = stock;
        details.objectname = @"UDSTOCK";
        [self.navigationController pushViewController:details animated:YES];

        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")

    }];
}
//查询问题联络单信息并跳转
- (void)requestFEEDBACKData:(NSInteger)page identity:(NSString*)identity
{
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDFEDBKCON",
                                 @"objectname":@"UDFEEDBACK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"FEEDBACKNUM desc",
                                 @"condition" :@{@"FEEDBACKNUM":identity}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop

        NSArray *array = response[@"result"][@"resultlist"];
        NSDictionary *dic = array[0];
        
        ProblemModel *stock = [ProblemModel mj_objectWithKeyValues:dic];
        ProblemDetailsController *vc = [[ProblemDetailsController alloc] init];
        vc.problem = stock;
        vc.title = @"联络单详情";
        [self.navigationController pushViewController:vc animated:YES];
        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
    }];
}
//查询故障提报单信息并跳转
- (void)requestREPORTData:(NSInteger)page identity:(NSString*)identity
{
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDREPORT",
                                 @"objectname":@"UDREPORT",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"REPORTNUM DESC",
                                 @"condition" :@{@"REPORTNUM":identity}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop

        NSArray *array = response[@"result"][@"resultlist"];
        NSDictionary *dic = array[0];
        PaultAppModel *stock = [PaultAppModel mj_objectWithKeyValues:dic];
        FaultAppDetailsViewController *vc = [[FaultAppDetailsViewController alloc] init];
        vc.pault = stock;
        vc.title = @"故障提报单详情";
        [self.navigationController pushViewController:vc animated:YES];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")

    }];
}
//查询巡检单信息并跳转
- (void)requestINSPOData:(NSInteger)page identity:(NSString*)identity
{
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDINSPOAPP",
                                 @"objectname":@"UDINSPO",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"INSPONUM DESC",
                                 @"condition" :@{@"INSPONUM":identity}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop

        NSArray *array = response[@"result"][@"resultlist"];
        NSDictionary *dic = array[0];
        
        PollingModel *stock = [PollingModel mj_objectWithKeyValues:dic];
        PollingDetailsController *vc = [[PollingDetailsController alloc] init];
        vc.polling = stock;
        vc.title = @"巡检单详情";
        [self.navigationController pushViewController:vc animated:YES];

    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")

    }];
}
-(void)toWebviewidentity:(NSString*)identity
{
    NSString * urlString =[NSString stringWithFormat:@"/maximo/ui/?event=loadapp&value=%@&uniqueid=%@",self.process.APP,identity] ;
    
    NSString *urls = GETSTRING_WITH(BASE_URL,urlString);
    
    WebViewController * wv = [[WebViewController alloc] init];
    
    wv.urlString=urls;
    
    [self.navigationController pushViewController:wv animated:YES];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProcessDetailsCell *cell = [ProcessDetailsCell cellWithTableView:tableView];
    _process.index = indexPath.section;
    _process.leftLabelWight = 110;
    cell.process = _process;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _process.index = indexPath.section;
    CGFloat cellHeight = [self.tableView cellHeightForIndexPath:indexPath model:_process keyPath:@"process" cellClass:[ProcessDetailsCell class] contentViewWidth:[self cellContentViewWith]];
    return cellHeight;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
