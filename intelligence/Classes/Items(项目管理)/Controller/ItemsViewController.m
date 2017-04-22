//
//  ItemsViewController.m
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ItemsViewController.h"
#import "MyFlowLayout.h"
#import "ItemsCollectionViewCell.h"
#import "LedgerItemsController.h"
#import "DailyItemsController.h"
#import "ProblemItemsController.h"
#import "TripReportViewController.h"
static NSString *cellIdentifier = @"ItemsCollectionViewCell";
@interface ItemsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *headerCollection;
@property (nonatomic,strong)NSArray *operationArray;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目管理";
    self.view.backgroundColor = APPCOLOR;
    [self addData];
    [self createTableView];
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
                            @{@"title":@"项目台账",@"icon":@"ic_udrro"},
                            @{@"title":@"项目日报",@"icon":@"ic_udrro_log"},
                            @{@"title":@"问题联络单",@"icon":@"ic_udfeedback"},
                            @{@"title":@"出差总结报告",@"icon":@"ic_trip"},
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
        LedgerItemsController *ledger = [[LedgerItemsController alloc]init];
        view = ledger;
    }else if (indexPath.row == 1){
        DailyItemsController *daily = [[DailyItemsController alloc]init];
        view = daily;
    }else if (indexPath.row == 2){
        ProblemItemsController *problem = [[ProblemItemsController alloc]init];
        view = problem;
    }
    else if (indexPath.row == 3){
        NSLog(@"跳到出差总结报告");
        TripReportViewController * trip = [[TripReportViewController alloc] init];
        trip.title = @"出差总结报告";
        view = trip;
    }
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
