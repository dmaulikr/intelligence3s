//
//  AddMaterielsViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AddMaterielsViewController.h"
#import "FanNumViewController.h"
#import "FooterView.h"

@interface AddMaterielsViewController ()
@property (nonatomic,strong)PersonalSettingItem *LLI1;
@property (nonatomic,strong)PersonalSettingItem *LL2;
@property (nonatomic,strong)PersonalSettingItem *LT3;
@property (nonatomic,strong)PersonalSettingItem *LL4;
@property (nonatomic,strong)PersonalSettingItem *LLI5;
@property (nonatomic,strong)PersonalSettingItem *LL6;
@end

@implementation AddMaterielsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增物料详情";
    [self addFooter];
    [self addOne];
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
    footer.frame = CGRectMake(0, ScreenHeight - 55, ScreenWidth, 55);
    [self.view addSubview:footer];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-55);
    }];
}
//取消
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)saveClick{
    if ([SettingContent(_LLI1) isEqualToString:@""]) {
        HUDNormal(@"请选择物资编码");
        return;
    }else if ([SettingContent(_LT3) isEqualToString:@""]){
        HUDNormal(@"请选择数量");
        return;
    }else if ([SettingContent(_LLI5) isEqualToString:@""]){
        HUDNormal(@"请选择库房");
        return;
    }

    MaterielsModel *model = [[MaterielsModel alloc]init];
    model.ITEMNUM = SettingContent(_LLI1);
    model.ITEMDESC = SettingContent(_LL2);
    model.ITEMQTY = SettingContent(_LT3);
    model.ORDERUNIT = SettingContent(_LL4);
    model.LOCATION = SettingContent(_LLI5);
    model.LOCDESC = SettingContent(_LL6);
    model.TYPE = @"add";
    model.isnumber = 1;
    if (self.backMater) {
        self.backMater(model);
    }
    HUDNormal(@"保存成功");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addOne{
    WEAKSELF
    self.LLI1 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"物资编码:" type:PersonalSettingItemTypeArrow];
    _LLI1.operation = ^{
        FanNumViewController *fan =[[FanNumViewController alloc]init];
        fan.type = ChooseTypeWUZI;
        fan.executeCellClick = ^(FanNumModle *fan){
            weakSelf.LLI1.content = fan.ITEMNUM;
            weakSelf.LL2.content = fan.DESCRIPTION;
            weakSelf.LL4.content = fan.ORDERUNIT;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:fan animated:YES];
    };
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"物资描述:" type:PersonalSettingItemTypeLabels];
    
    self.LT3 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"数量:" type:PersonalSettingItemTypeText];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"订购单位:" type:PersonalSettingItemTypeLabels];
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"库房:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        FanNumViewController *fan =[[FanNumViewController alloc]init];
        fan.executeCellClick = ^(FanNumModle *model){
            weakSelf.LLI5.content = model.LOCATION;
            weakSelf.LL6.content = model.DESCRIPTION;
            [weakSelf.tableView reloadData];
        };
        fan.type = ChooseTypeKUFA;
        [weakSelf.navigationController pushViewController:fan animated:YES];
    };
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"库房描述:" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI1,_LL2,_LT3,_LL4,_LLI5,_LL6];
    [_allGroups addObject:group];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
@end
