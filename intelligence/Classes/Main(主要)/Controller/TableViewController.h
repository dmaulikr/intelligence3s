//
//  TableViewController.h
//  intelligence
//
//  Created by chris on 2017/6/26.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestJsonFactry.h"
@interface TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)NSString*type;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong)URLSessionTask *task;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)NSString * url;
@property (nonatomic,strong)NSString * search;
@property (nonatomic,strong)NSMutableArray * array;
@property (nonatomic)NSUInteger page;
@end
