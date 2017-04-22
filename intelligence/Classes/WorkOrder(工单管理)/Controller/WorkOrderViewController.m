//
//  WorkOrderViewController.m
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "WorkOrderViewController.h"
#import "MyFlowLayout.h"
#import "ItemsCollectionViewCell.h"
#import "FauWorkViewController.h"
static NSString *cellIdentifier = @"ItemsCollectionViewCell";
@interface WorkOrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *headerCollection;
@property (nonatomic,strong)NSArray *operationArray;

@end

@implementation WorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工单管理";
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
    [self.headerCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
    }];
}
-(void)addData{
    self.operationArray = @[
                            @{@"title":@"故障工单",@"icon":@"ic_udreport"},
                            @{@"title":@"终验收工单",@"icon":@"ic_aa"},
                            @{@"title":@"调试工单",@"icon":@"ic_dc"},
                            @{@"title":@"排查工单",@"icon":@"ic_sp"},
                            @{@"title":@"技改工单",@"icon":@"ic_tp"},
                            @{@"title":@"定检工单",@"icon":@"ic_ws"},
                      
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
    NSString *worktype;
    NSString *name;
    NSString *appid;
    NSString *objectname;
    NSString *orderby;
    ChoiceType type = ChoiceTypeClose;
    switch (indexPath.row) {
        case 0:
            worktype = @"FR";//故障工单
            appid = @"UDREPORTWO";
            objectname = @"WORKORDER";
            orderby = @"WORKORDERID desc";
            name = @"故障工单";
            type = ChoiceTypeFR;
            break;
        case 1:
            worktype = @"AA";//终验收工单
            appid = @"UDZYSWO";
            objectname = @"WORKORDER";
            orderby = @"WONUM desc";
            name = @"终验收工单";
            type = ChoiceTypeAA;
            break;
        case 2:
            worktype = @"DC";//调试工单
            appid = @"DEBUGORDER";
            objectname = @"DEBUGWORKORDER";
            orderby = @"DEBUGWORKORDERNUM desc";
            name = @"调试工单";
            type = ChoiceTypeDC;
            break;
        case 3:
            worktype = @"SP";//排查工单
            appid = @"UDPCWO";
            objectname = @"WORKORDER";
            orderby = @"WORKORDERID desc";
            name = @"排查工单";
            type = ChoiceTypeSP;
            break;
        case 4:
            worktype = @"TP";//技改工单
            appid = @"UDJGWO";
            objectname = @"WORKORDER";
            orderby = @"WORKORDERID desc";
            name = @"技改工单";
            type = ChoiceTypeTPS;
            break;
        case 5:
            worktype = @"WS";//定检工单
            appid = @"UDDJWO";
            objectname = @"WORKORDER";
            orderby = @"WORKORDERID desc";
            name = @"定检工单";
            type = ChoiceTypeTP;
            break;
        default:
            break;
    }
    FauWorkViewController *fauWork = [[FauWorkViewController alloc]init];
    fauWork.worktype = worktype;
    fauWork.name = name;
    fauWork.Choice = type;
    fauWork.appid = appid;
    fauWork.objectname = objectname;
    fauWork.orderby = orderby;
    [self.navigationController pushViewController:fauWork animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
