//
//  FunctionViewController.m
//  intelligence
//
//  Created by chris on 2017/2/27.
//  Copyright © 2017年 chris. All rights reserved.
//
#import "MyFlowLayout.h"
#import "FunctionViewController.h"
#import "ItemsCollectionViewCell.h"
#import "CollectionReusableView.h"
#import "StockQueryViewController.h"
#import "JSChartViewController.h"
#import "TableViewController.h"
#import "LoginViewController.h"
#import "DataFactory.h"
static NSString * cellIdentifier = @"FunctionItemsCollectionViewCell";
static NSString * kheaderIdentifier =@"headerIdentifier";
static NSString * kfooterIdentifier =@"footerIdentifier";

@interface FunctionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *headerCollection;
@property (nonatomic,strong)NSArray *operationArray0;
@property (nonatomic,strong)NSArray *operationArray1;
@property (nonatomic,strong)NSArray *operationArray2;
@property (nonatomic,strong)NSArray *operationArray3;
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"功能中心";
    self.view.backgroundColor = APPCOLOR;
    [self addData];
    [self createTableView];
    [self.headerCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    // Do any additional setup after loading the view from its nib.
    AccountModel *account = [AccountManager account];
    if (account.userName.length <= 0) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:login completion:^{
            
        }];
    }
    //测试通用方法    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createTableView{
    //创建瀑布流约束
    MyFlowLayout *layout = [[MyFlowLayout alloc]init];
    //设置行间距
    layout.lineSpace = 10;
    //设置列间距
    layout.columnsSpace = 0;
    //要布局的列数为3
    layout.numberOfColumns = 4;
    //设置宽高比
    layout.scal = CGSizeMake(1, 1);
    //设置section 的 上 左 下 右 边 ：top, left, bottom, right
    layout.sectionInsert = UIEdgeInsetsMake(10, 0, 10, 0);
    [layout setHeaderReferenceSize:CGSizeMake(ScreenWidth, 25)];
    [layout setFooterReferenceSize:CGSizeMake(ScreenWidth, 5)];
    //[layout setFooterReferenceSize:CGSizeMake(ScreenWidth, 20)];
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _headerCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight) collectionViewLayout:layout];
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"ItemsCollectionViewCell" bundle:nil];
    [_headerCollection registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [_headerCollection registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    //注册footerView Nib的view需要继承UICollectionReusableView
    [_headerCollection registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    
    //    _headerCollection.userInteractionEnabled=YES;
    _headerCollection.delegate=self;
    _headerCollection.dataSource=self;
    _headerCollection.clipsToBounds = YES; //如果不裁剪就会出界。
    //    _headerCollection.bounces = YES;
    
    _headerCollection.showsHorizontalScrollIndicator=NO; //指示条
    //[_headerCollection setBackgroundColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1]];
    [_headerCollection setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_headerCollection];
    [self.headerCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
    }];
}
-(void)addData{
    self.operationArray0 = @[
                            @{@"title":@"故障工单",@"icon":@"ic_gd_gz"},
                            @{@"title":@"调试工单",@"icon":@"ic_gd_ts"},
                            @{@"title":@"巡检工单",@"icon":@"ic_gd_xj"},
                            @{@"title":@"定检工单",@"icon":@"ic_gd_dj"},
                            @{@"title":@"排查工单",@"icon":@"ic_gd_pc"},
                            @{@"title":@"技改工单",@"icon":@"ic_gd_jg"},
                            @{@"title":@"终验收工单",@"icon":@"ic_gd_zys"},
                            @{@"title":@"预警排查工单",@"icon":@"ic_gd_yjpc"},
                            ];
    
    self.operationArray1 = @[
                            @{@"title":@"项目台账",@"icon":@"ic_xm_tj"},
                            @{@"title":@"项目日报",@"icon":@"ic_xm_rb"},
                            @{@"title":@"问题联络单",@"icon":@"ic_xm_wt"},
                            @{@"title":@"出差报告",@"icon":@"ic_xm_cc"},
                            ];
    
    self.operationArray2 = @[
                            @{@"title":@"运行记录",@"icon":@"ic_yw_yxjl"},
                            @{@"title":@"故障提报单",@"icon":@"ic_yw_gztb"},
                            ];
    
    self.operationArray3 = @[
                            @{@"title":@"行驶记录",@"icon":@"ic_zy_xs"},
                            @{@"title":@"加油记录",@"icon":@"ic_zy_jy"},
                            @{@"title":@"车辆维修",@"icon":@"ic_zy_wx"},
                            @{@"title":@"库存盘点",@"icon":@"ic_stock"},
                            @{@"title":@"库存查询",@"icon":@"ic_query"},
                            //@{@"title":@"图表",@"icon":@"ic_chart"},
                            ];

    
}
//collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.operationArray0.count;
            break;
        case 1:
            return self.operationArray1.count;
            break;
            
        case 2:
            return self.operationArray2.count;
            break;
            
        case 3:
            return self.operationArray3.count;
            break;
        
        default:
            break;
    }
    return 6;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.dic = self.operationArray0[indexPath.row];
            break;
        case 1:
            cell.dic = self.operationArray1[indexPath.row];
            break;
            
        case 2:
            cell.dic = self.operationArray2[indexPath.row];
            break;
            
        case 3:
            cell.dic = self.operationArray3[indexPath.row];
            break;
            
        default:
            break;
    }
    [cell.layer setCornerRadius:10];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth -0)/4, (ScreenWidth -0)/4);
}

#pragma mark - UICollectionViewDataSource
/**
 * 点击item推到下一个页面
 *
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        
    UIViewController *view;
    switch (indexPath.row) {
        case 0:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"故障工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 1:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"调试工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 2:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"巡检工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 3:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"定检工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 4:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"排查工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 5:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"技改工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 6:
            {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"终验收工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            }
            break;
        case 7:
            {
            NSLog(@"预警排查工单");
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"预警排查工单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
            
            }
            break;
    }
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
    
    if(indexPath.section==1)
    {
        UIViewController *view;
        if (indexPath.row == 0)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"项目台账";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 1)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"项目日报";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 2)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"问题联络单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 3)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"出差报告";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
    
    if(indexPath.section==2)
    {
        UIViewController *view;
        if (indexPath.row == 0)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"运行记录";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 1)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"故障提报单";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
    if(indexPath.section==3)
    {
        UIViewController *view;
        if (indexPath.row == 0)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"行驶记录";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 1)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"加油记录";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 2)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"车辆维修";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 3)
        {
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"库存盘点";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        else if (indexPath.row == 4){
            NSLog(@"库存查询");
            StockQueryViewController * stockQuery = [[StockQueryViewController alloc] init];
            view = stockQuery;
        }else if (indexPath.row == 5){
            NSLog(@"图表");
            TableViewController *tableView = [[TableViewController alloc]init];
            tableView.type=@"库存盘点";
            tableView.hidesBottomBarWhenPushed = YES;
            view = tableView;
        }
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    CollectionReusableView *view =  (CollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        //view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        view.backgroundColor = [UIColor whiteColor];
        switch (indexPath.section) {
            case 0:
                 view.label.text = @"工单管理";
                break;
            case 1:
                 view.label.text = @"项目管理";
                break;
            case 2:
                 view.label.text = @"运维管理";
                break;
            case 3:
                 view.label.text = @"资源管理";
                break;
                
            default:
                break;
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        view.label.text = @"";

    }
    return view;
}
@end
