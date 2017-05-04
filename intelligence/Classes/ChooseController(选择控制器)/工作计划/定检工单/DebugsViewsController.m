//
//  DebugsViewsController.m
//  intelligence
//
//  Created by chris on 16/9/10.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DebugsViewsController.h"
#import "DailyDetailChoosePersonController.h"
#import "FooterView.h"
#import "FanTypeViewController.h"
#import "DTKDropdownMenuView.h"
#import "UploadPicturesViewController.h"

@interface DebugsViewsController ()
@property (nonatomic,strong)PersonalSettingItem *LLI1;
@property (nonatomic,strong)PersonalSettingItem *LT2;
@property (nonatomic,strong)PersonalSettingItem *LLI3;
@property (nonatomic,strong)PersonalSettingItem *LLI4;
@property (nonatomic,strong)PersonalSettingItem *LLI5;

@property (nonatomic,strong)PersonalSettingItem *LLI6;
@property (nonatomic,strong)PersonalSettingItem *LT7;
@property (nonatomic,strong)PersonalSettingItem *LLI8;
@property (nonatomic,strong)PersonalSettingItem *LLI9;
@property (nonatomic,strong)PersonalSettingItem *LLI10;
@property (nonatomic,strong)PersonalSettingItem *LLI11;
@property (nonatomic,strong)PersonalSettingItem *LLI12;
@property (nonatomic,strong)PersonalSettingItem *LT13;
@property (nonatomic,strong)PersonalSettingItem *LT14;

@property (nonatomic,strong)TXTimeChoose *timeYear1;
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)TXTimeChoose *timeYear3;
@property (nonatomic,strong)TXTimeChoose *timeYear4;
@property (nonatomic,strong)TXTimeChoose *timeYear5;
@property (nonatomic,strong)ChoosePersonModel *choose1;
@property (nonatomic,strong)ChoosePersonModel *choose2;
@property (nonatomic,strong)ChoosePersonModel *choose3;
@property (nonatomic,strong)ChoosePersonModel *choose4;
@property (nonatomic,strong)ChoosePersonModel *choose5;

@end

@implementation DebugsViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调试工单子表详情";
    [self addFooter];
    [self addOne];
    [self addRightNavBarItem];
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
- (void)addRightNavBarItem{

    DTKDropdownItem *item = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
        vc.ownertable = @"UDDEBUGWORKORDERLINE";
        vc.ownerid = _model.DEBUGWORKORDERNUM;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item] icon:@"more"];
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
//取消
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)saveClick{
    if ([SettingContent(_LLI3) isEqualToString:@""]) {
        HUDNormal(@"调试日期不能为空");
        return;
    }else if ([SettingContent(_LLI1) isEqualToString:@""]){
        HUDNormal(@"风机编码不能为空");
        return;
    }else if ([SettingContent(_LT2) isEqualToString:@""]){
        HUDNormal(@"机台数不能为空");
        return;
    }
    WorkDebugsModel *model = [[WorkDebugsModel alloc]init];
    model.WINDDRIVENGENERATORNUM = SettingContent(_LLI1);
    model.FJLOCATION = SettingContent(_LT2);
    model.DYNAMICDEBUGDATE = SettingContent(_LLI3);
    model.SYNCHRONIZATIONDEBUGDATE = SettingContent(_LLI4);
    model.TIME1 = SettingContent(_LLI5);
    model.TIME2 = SettingContent(_LLI6);
    model.VESION = SettingContent(_LT7);
    model.RESPONSIBLEPERSON = SettingContent(_LLI8);
    model.DEBUGLEADER = SettingContent(_LLI9);
    model.CREW = SettingContent(_LLI10);
    model.CREW2 = SettingContent(_LLI11);
    model.CREW3 = SettingContent(_LLI12);
    model.QUESTION = SettingContent(_LT13);
    model.DISPOSE = SettingContent(_LT14);
    if (self.backModels) {
        self.backModels(model);
    }
    HUDNormal(@"保存成功");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addOne{
    
    WEAKSELF
    self.LLI1 = [PersonalSettingItem itemWithIcon:nil withContent:_model.WINDDRIVENGENERATORNUM withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"风机编码:" type:PersonalSettingItemTypeLabels];
    _LLI1.operation = ^{
            FanTypeViewController *fan = [[FanTypeViewController alloc]init];
            fan.requestCode = weakSelf.number;
            fan.backModel = ^(FanTypeModel *mode){
                weakSelf.LLI1.content = mode.LOCNUM;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:fan animated:YES];
        
    };
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:_model.FJLOCATION withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"机台数:" type:PersonalSettingItemTypeLabel];
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:nil withContent:_model.DYNAMICDEBUGDATE withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.SYNCHRONIZATIONDEBUGDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"并网运行日期:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.TIME1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"静态调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear3];
    };
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.TIME2 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"动态调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI6.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear4];
    };
    
    self.LT7 = [PersonalSettingItem itemWithIcon:@"" withContent:_model.VESION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"程序版本号:" type:PersonalSettingItemTypeLabel];
    
    self.LLI8 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.RESPONSIBLEPERSON withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试负责人:" type:PersonalSettingItemTypeArrow];
    _LLI8.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose1 = model;
            weakSelf.LLI8.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    
    self.LLI9 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.DEBUGLEADER withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试组长:" type:PersonalSettingItemTypeArrow];
    _LLI9.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose2 = model;
            weakSelf.LLI9.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    
    self.LLI10 = [PersonalSettingItem itemWithIcon:@"" withContent:_model.CREW withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师1:" type:PersonalSettingItemTypeArrow];
    _LLI10.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose3 = model;
            weakSelf.LLI10.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"" withContent:_model.CREW2 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师2:" type:PersonalSettingItemTypeArrow];
    _LLI11.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose4 = model;
            weakSelf.LLI11.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"" withContent:_model.CREW3 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师3:" type:PersonalSettingItemTypeArrow];
    _LLI12.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose5 = model;
            weakSelf.LLI12.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LT13 = [PersonalSettingItem itemWithIcon:@"" withContent:_model.QUESTION withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"问题记录:" type:PersonalSettingItemTypeLabel];
    
    self.LT14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_model.DISPOSE withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"处理过程:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LLI1,_LT2,_LLI3,_LLI4,_LLI5,_LLI6,_LT7,_LLI8,_LLI9,_LLI10,_LLI11,_LLI12,_LT13,_LT14,];
    [_allGroups addObject:group];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.LLI3.content = [weakSelf.timeYear1 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear1;
}

- (TXTimeChoose *)timeYear2{
    WEAKSELF
    if (!_timeYear2) {
        self.timeYear2 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear2.backString = ^(NSDate *data){
            weakSelf.LLI4.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}

- (TXTimeChoose *)timeYear3{
    WEAKSELF
    if (!_timeYear3) {
        self.timeYear3 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear3.backString = ^(NSDate *data){
            weakSelf.LLI5.content = [weakSelf.timeYear3 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear3;
}

- (TXTimeChoose *)timeYear4{
    WEAKSELF
    if (!_timeYear4) {
        self.timeYear4 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear4.backString = ^(NSDate *data){
            weakSelf.LLI6.content = [weakSelf.timeYear4 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear3;
}


@end
