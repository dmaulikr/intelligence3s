//
//  TableViewController.m
//  intelligence
//
//  Created by chris on 2017/6/26.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "TableViewController.h"
#import "StockViewCell.h"
#import "UDWARNINGWO.h"
#import "YJPC_ViewController.h"
@interface TableViewController ()

@end

@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.type];
    self.table.dataSource=self;
    self.table.delegate=self;
    
    [self initTable];
    self.page=1;
    [self requestData:0];
    self.array = [NSMutableArray array];
    NSLog(@"出现了");
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"出现了");
    [self.searchBar setDelegate:self];
    [self.searchBar setPrompt:@"输入关键字以搜索"];

    _searchBar.barTintColor = RGBCOLOR(0, 0, 0);
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    //改变searchBar颜色
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    view.backgroundColor = RGBCOLOR(189, 189, 195);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithUIView:view]];
    [_searchBar insertSubview:imageView atIndex:1];
}
//改变颜色
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
-(void)initTable{
    WEAKSELF
    // 下拉加载
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.array=[NSMutableArray array];
        weakSelf.page=1;
        [weakSelf requestData:self.page];
    }];
    // 上拉刷新
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page+=1;
        [weakSelf requestData:self.page];
    }];
}
- (void)requestData:(NSInteger)page{
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDWARNINGWO",
                                 @"objectname":@"UDWARNINGWO",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"WONUM desc"
                                 };
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        NSLog(@"response %@",response);
        SVHUD_Stop
        
        NSArray *dataArray = response[@"result"][@"resultlist"];
        
        for (NSDictionary *dic in dataArray) {
            UDWARNINGWO *object = [UDWARNINGWO mj_objectWithKeyValues:dic];
            [self.array addObject:object];
        }
        [self.table reloadData];
            // 结束刷新
            [self.table.mj_header endRefreshing];
        
            if([dataArray count]<20){
                [self.table.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.table.mj_footer endRefreshing];
            }
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UDWARNINGWO"];
    if (!cell) {
        cell =  [[[NSBundle mainBundle]loadNibNamed:@"StockViewCell" owner:nil options:nil] lastObject];;
    }
    UDWARNINGWO * object= [self.array objectAtIndex:indexPath.row];
    [cell.top setText:object.WONUM];
    [cell.bottom setText:object.DESCRIPTION];
    [cell.index setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YJPC_ViewController *yjpc = [[YJPC_ViewController alloc] init];
    UDWARNINGWO * object= [self.array objectAtIndex:indexPath.row];
    yjpc.Kmodel = object;
    yjpc.key = @"预警排查工单";
    [self.navigationController pushViewController:yjpc animated:YES];
    
}
#pragma mark
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
}// return NO to not become first responder

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text starts editing

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
}// return NO to not resign first responder

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text ends editing

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when text changes (including clear)

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
} // called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}// called when keyboard search button pressed

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
} // called when bookmark button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}   // called when cancel button pressed

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
} // called when search results button pressed

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
