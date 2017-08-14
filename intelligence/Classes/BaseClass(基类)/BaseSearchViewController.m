//
//  BaseSearchViewController.m
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "JANALYTICSService.h"
@interface BaseSearchViewController ()
{
    UIView *_naView;
}

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPCOLOR;
    [self createNav];
    // Do any additional setup after loading the view.
}
-(void)createNav{
    _naView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
    _naView.backgroundColor = RGBCOLOR(189, 189, 195);
    [self.view addSubview:_naView];
    [_naView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(44);
    }];
    [self initSearchBar];
}
//创建searchBar
-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    _searchBar.barTintColor = RGBCOLOR(189, 189, 195);
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [_naView addSubview:_searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_naView);
    }];
    //改变searchBar颜色
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    view.backgroundColor = RGBCOLOR(47, 93, 154);;
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
/** 控制器取消的时候调用*/
- (void)dealloc
{
    [self.task cancel];
}
/** 视图将要消失*/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //结束编辑
    [self.view endEditing:YES];
    SVHUD_Stop
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
