//
//  ZB_TableViewController.h
//  intelligence
//
//  Created by chris on 2017/8/22.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestJsonFactry.h"
#import "StockViewCell.h"



@interface ZB_TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSString*type;
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)URLSessionTask *task;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)NSString * url;
@property (nonatomic,strong)NSString * search;
@property (nonatomic,strong)NSMutableArray * array;
@property (nonatomic)NSUInteger page;
@end
