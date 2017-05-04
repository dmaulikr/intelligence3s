//
//  AddDebugViewController.m
//  intelligence
//
//  Created by chris on 16/8/9.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddDebugViewController.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"
@interface AddDebugViewController ()
/** ------第一部分----*/
/** 描述*/
@property (nonatomic,strong)PersonalSettingItem *LT1;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LL2;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL4;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LL5;
/** 计划结束时间*/
@property (nonatomic,strong)PersonalSettingItem *LL6;

@end

@implementation AddDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建调试工单";
    [self addRightNavBarItem];
    [self addOne];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"调试工单子表" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
    menuView.currentNav = self.navigationController;
    
    menuView.dropWidth = 130.f;
    //    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = RGBCOLOR(102, 102, 102);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
    //    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)pushWithIndex:(NSInteger)index
{
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            //            FanTypeViewController *vc = [[FanTypeViewController alloc] init];
            //            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            //            ProjectPersonViewController *vc = [[ProjectPersonViewController alloc] init];
            //            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 3:{
            //            ProjectCarsViewController *vc = [[ProjectCarsViewController alloc] init];
            //            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)addOne{
    self.LT1 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabel];
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目编号:" type:PersonalSettingItemTypeLabels];
    _LL2.operation = ^{
        //选择
    };
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划开始时间:" type:PersonalSettingItemTypeLabels];
    _LL5.operation = ^{
        //选择
    };
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"技术结束时间:" type:PersonalSettingItemTypeLabels];
    _LL6.operation = ^{
        //选择
    };
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LT1,_LL2,_LL3,_LL4,_LL5,_LL6];
    [_allGroups addObject:group];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}



@end
