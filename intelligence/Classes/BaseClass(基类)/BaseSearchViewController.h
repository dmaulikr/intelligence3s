//
//  BaseSearchViewController.h
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSearchViewController : UIViewController<UISearchBarDelegate>
@property (nonatomic,strong)URLSessionTask *task;
@property(nonatomic,strong)UISearchBar *searchBar;
@end
