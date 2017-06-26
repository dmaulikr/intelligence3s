//
//  DetailsStockViewController.m
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailsStockViewController.h"
#import "DetailsStockHeader.h"
#import "DetailsViewCell.h"
#import "DetailStockModel.h"
#import "DetailViewHeader.h"
#import "HitStockViewController.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
#import "ApprovalsView.h"
@interface DetailsStockViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSInteger _number;
    NSInteger _arrayCount;
}
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation DetailsStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"盘点详情";
    self.dataArray = [NSMutableArray array];
    _number = 1;
    [self addRightNavBarItem];
    [self requestData:1 isUpdata:YES];
    [self initTableView];
    [self request];
    
    self.SetingItems = [NSMutableDictionary dictionary];
    [self checkWFPRequiredWithAppId:@"UDSTOCKLINE" objectName:@"UDSTOCKLINE" status:self.stock.STATUS compeletion:^(NSArray *fields) {
        NSLog(@"库存盘点必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
}

- (void)addRightNavBarItem{

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"盘点明细行" iconName:@"ic_xjxm" callBack:^(NSUInteger index, id info) {
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [self checkRequiredFieldcompeletion:^(BOOL isOK) {
            if (isOK) {
                
                [self sendData];
            }
        }];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"上传附件" iconName:@"ic_commit" callBack:^(NSUInteger index, id info) {
        
        NSLog(@"rightItem%lu",(unsigned long)index);
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = _objectname;
        vc.ownerid = _stock.STOCKNUM;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
    
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)setStock:(StockModel *)stock{
    _stock = stock;
}
//创建tableview
- (void)initTableView{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65) style:UITableViewStyleGrouped] ;
    _tableview.dataSource = self;
    _tableview.delegate =self;
    [self.view addSubview:_tableview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addHeader];
}
-(void)settingDegate{
    WEAKSELF
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakSelf.tableview.emptyDataSetDelegate = self;
        weakSelf.tableview.emptyDataSetSource = self;
    });
}
-(void)addHeader{
    DetailsStockHeader *detail = [DetailsStockHeader detailsStockHeader];
    detail.pandian.text = _stock.STOCKNUM;//盘点单号
    [self.SetingItems setValue:@"盘点单号" forKey:@"STOCKNUM"];
    detail.miaoshu.text = _stock.DESCRIPTION;//描述
    [self.SetingItems setValue:@"描述" forKey:@"DESCRIPTION"];
    detail.pingzheng.text = _stock.ZPDNUM;//凭证
    [self.SetingItems setValue:@"凭证" forKey:@"ZPDNUM"];
    detail.cangku.text = _stock.LOCDESC;//仓库名称
    [self.SetingItems setValue:@"仓库名称" forKey:@"LOCDESC"];
    detail.mingpan.selected = [_stock.ISOPEN isEqualToString:@"Y"]?YES:NO;//明盘
    [self.SetingItems setValue:@"明盘" forKey:@"ISOPEN"];
    detail.anping.selected = [_stock.ISCLOSE isEqualToString:@"Y"]?YES:NO;//暗盘
    [self.SetingItems setValue:@"暗盘" forKey:@"ISCLOSE"];
    detail.chuangjian.text = _stock.CREATENAME;//创建人
    [self.SetingItems setValue:@"创建人" forKey:@"CREATENAME"];
    detail.shijian.text = _stock.CREATEDATE;//创建时间
    [self.SetingItems setValue:@"创建时间" forKey:@"CREATEDATE"];
    
    
    CGSize textMaxSize = CGSizeMake(ScreenWidth-130, MAXFLOAT);
    CGSize textSize = [_stock.DESCRIPTION sizeWithFont:font(16) maxSize:textMaxSize];
    CGFloat allHeight = 376;
    if (textSize.height>45) {
        detail.miaoshuHeight.constant = textSize.height;
      allHeight = (allHeight -45 + textSize.height);
    }
    
    detail.frame = CGRectMake(0, 0, ScreenWidth, allHeight);
    self.tableview.tableHeaderView = detail;
}


//上下拉刷新
-(void)request{
    WEAKSELF
    // 下拉刷新
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _number = 1;
            [weakSelf requestData:_number isUpdata:YES];

    }];
    //    // 上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _number ++;
            [weakSelf requestData:_number isUpdata:NO];

    }];
}
//全部加载
- (void)requestData:(NSInteger)page isUpdata:(BOOL)data{
    NSDictionary *dic = @{
                          
                          @"LGORT":_stock.LOCATION,
                          @"STOCKNUM":_stock.STOCKNUM
                          };
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDSTOCKLINE",
                                 @"objectname":@"UDSTOCKLINE",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"condition" :dic
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        SVHUD_Stop
        if (data) {
            [self.dataArray removeAllObjects];
        }
        _arrayCount = _dataArray.count;
        NSArray *array = response[@"result"][@"resultlist"];
        for (NSDictionary *dic in array) {
            NSLog(@"dic %@",dic);
            DetailStockModel *stock = [DetailStockModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:stock];
        }
        if (data) {
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
            if(_dataArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(_dataArray.count < _arrayCount +20){
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 结束刷新
                [self.tableview.mj_footer endRefreshing];
            }
        }
        [self.tableview reloadData];
        [self settingDegate];
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsStockcell"];
    if (!cell) {
        cell = [DetailsViewCell detailsViewCell];
    }
    cell.detail = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HitStockViewController *hit = [[HitStockViewController alloc]init];
    hit.stock = _dataArray[indexPath.row];
    hit.stocks = _stock;
    [self.navigationController pushViewController:hit animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [DetailViewHeader detailViewHeader];
}
//发送工作流
-(void)sendData{
    if ([_stock.STATUS isEqualToString:@"已取消"]||[_stock.STATUS isEqualToString:@"已关闭"]||[_stock.STATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_stock.STATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_stock.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDSTOCK";
    popupView.mbo = @"UDSTOCK";
    popupView.keyValue = _stock.STOCKNUM;
    popupView.key = @"STOCKNUM";
    popupView.CloseBlick = ^(NSDictionary *dic){
        
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDJuHua(dic[@"errorMsg"]);
        }
        
    };
    [popupView show];
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
            
            NSString * value =[self.stock valueForKey:str];
            
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
                
            }];
            [alert addAction:cancel];
            [alert addAction:comfirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            compeletion(YES);
        }
    }
}
@end
