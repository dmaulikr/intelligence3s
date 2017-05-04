//
//  BaseLeftSearchViewController.m
//  intelligence
//
//  Created by chris on 16/7/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseLeftSearchViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "QRCodeViewController.h"
#import "JANALYTICSService.h"
@interface BaseLeftSearchViewController ()
{
    UIView *_naView;
}
@end

@implementation BaseLeftSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPCOLOR;
    [self createNav];
    //[self setupLeftMenuButton];
    // Do any additional setup after loading the view.
}
-(void)setupLeftMenuButton{
    UIButton *addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImg setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    [addImg addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(0, 5, 30, 30);
    
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    
    QRCodeViewController* qrvc = [[QRCodeViewController alloc] init];
    [self presentViewController:qrvc animated:YES completion:nil];
}

-(void)createNav{
    _naView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
    _naView.backgroundColor = RGBCOLOR(46, 93, 154);
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
    _searchBar.barTintColor = RGBCOLOR(46, 93, 154);
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [_naView addSubview:_searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_naView);
    }];
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
/** 控制器取消的时候调用*/
- (void)dealloc
{
    [self.task cancel];
}
-(void)viewDidAppear:(BOOL)animated
{
    [JANALYTICSService startLogPageView:NSStringFromClass([self class])];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [JANALYTICSService stopLogPageView:NSStringFromClass([self class])];
}
/** 视图将要消失*/
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //结束编辑
    [self.view endEditing:YES];
    SVHUD_Stop
}

@end
