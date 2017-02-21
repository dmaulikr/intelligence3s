//
//  ResourcesViewController.m
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ResourcesViewController.h"
#import "MyFlowLayout.h"
#import "ItemsCollectionViewCell.h"
#import "MaintainRViewController.h"
#import "OilRViewController.h"
#import "TravelRViewController.h"
#import "StockQueryViewController.h"
#import "JSChartViewController.h"
static NSString *cellIdentifier = @"ItemsCollectionViewCell";
@interface ResourcesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *headerCollection;
@property (nonatomic,strong)NSArray *operationArray;

@end

@implementation ResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资源管理";
    self.view.backgroundColor = APPCOLOR;
    [self addData];
    [self createTableView];
    [self.headerCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
}


//创建观众TableView
-(void)createTableView{
    //创建瀑布流约束
    MyFlowLayout *layout = [[MyFlowLayout alloc]init];
    //设置行间距
    layout.lineSpace = 0;
    //设置列间距
    layout.columnsSpace = 13;
    //要布局的列数为3
    layout.numberOfColumns = 3;
    //设置宽高比
    layout.scal = CGSizeMake(1, 1);
    //设置section 的 上 左 下 右 边 ：top, left, bottom, right
    layout.sectionInsert = UIEdgeInsetsMake(5, 7, 0, 7);
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _headerCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight) collectionViewLayout:layout];
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"ItemsCollectionViewCell" bundle:nil];
    [_headerCollection registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    //    _headerCollection.userInteractionEnabled=YES;
    _headerCollection.delegate=self;
    _headerCollection.dataSource=self;
    _headerCollection.clipsToBounds = YES; //如果不裁剪就会出界。
    //    _headerCollection.bounces = YES;
    _headerCollection.showsHorizontalScrollIndicator=NO; //指示条
    _headerCollection.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_headerCollection];
}
-(void)addData{
    self.operationArray = @[
                            @{@"title":@"行驶记录",@"icon":@"ic_xsjl"},
                            @{@"title":@"加油记录",@"icon":@"ic_jyjl"},
                            @{@"title":@"维修记录",@"icon":@"ic_wxjl"},
                            @{@"title":@"库存查询",@"icon":@"ic_query"},
                            @{@"title":@"图表",@"icon":@"ic_chart"},
                            ];
}

//collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.operationArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.dic = self.operationArray[indexPath.row];
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth -45)/3, (ScreenWidth -45)/3);
}

#pragma mark - UICollectionViewDataSource
/**
 * 点击item推到下一个页面
 *
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *view;
    if (indexPath.row == 0) {
        TravelRViewController *travel = [[TravelRViewController alloc]init];
        view = travel;
    }else if (indexPath.row == 1){
        OilRViewController *oil = [[OilRViewController alloc]init];
        view = oil;
    }else if (indexPath.row == 2){
        MaintainRViewController *maintain = [[MaintainRViewController alloc]init];
        view = maintain;
    }else if (indexPath.row == 3){
        NSLog(@"库存查询");
        StockQueryViewController * stockQuery = [[StockQueryViewController alloc] init];
        view = stockQuery;
        
    }else if (indexPath.row == 4){
        NSLog(@"库存查询");
        JSChartViewController * chartView = [[JSChartViewController alloc] init];
        view = chartView;
        
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
