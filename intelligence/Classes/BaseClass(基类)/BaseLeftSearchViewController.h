//
//  BaseLeftSearchViewController.h
//  intelligence
//
//  Created by chris on 16/7/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLeftSearchViewController : UIViewController<UISearchBarDelegate>
@property (nonatomic,strong)URLSessionTask *task;
@property(nonatomic,strong)UISearchBar *searchBar;

@end
