//
//  BaseSearchViewController.h
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSearchViewController : UIViewController<UISearchBarDelegate>
@property (nonatomic,strong)URLSessionTask *task;
@property(nonatomic,strong)UISearchBar *searchBar;
@end
