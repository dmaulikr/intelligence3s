//
//  AddWorkDeViewController.m
//  intelligence
//
//  Created by chris on 16/9/10.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddWorkDeViewController.h"
#import "DailyDetailChoosePersonController.h"
#import "FooterView.h"
#import "FanTypeViewController.h"
@interface AddWorkDeViewController ()
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

@implementation AddWorkDeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增调试工单子表详情";
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
    if ([SettingContent(_LLI3) isEqualToString:@""]) {
        HUDNormal(@"请选择调试日期");
        return;
    }else if ([SettingContent(_LLI1) isEqualToString:@""]){
        HUDNormal(@"请选择风机编码");
        return;
    }else if ([SettingContent(_LT2) isEqualToString:@""]){
        HUDNormal(@"请选择LT2");
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
   
    if (self.backModel) {
        self.backModel(model);
    }
    HUDNormal(@"保存成功");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addOne{
    
    WEAKSELF
    self.LLI1 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"风机编码:" type:PersonalSettingItemTypeLabels];
    _LLI1.operation = ^{
        FanTypeViewController *fan = [[FanTypeViewController alloc]init];
        fan.requestCode = weakSelf.number;
        fan.backModel = ^(FanTypeModel *mode){
            weakSelf.LLI1.content = mode.LOCNUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:fan animated:YES];
    };

    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"机台号:" type:PersonalSettingItemTypeLabel];
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        [weakSelf.view endEditing:YES];
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"并网运行日期:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        [weakSelf.view endEditing:YES];
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    self.LLI5 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"静态调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        [weakSelf.view endEditing:YES];
        [weakSelf.view addSubview:weakSelf.timeYear3];
    };
    
    self.LLI6 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"动态调试日期:" type:PersonalSettingItemTypeArrow];
    _LLI6.operation = ^{
        [weakSelf.view endEditing:YES];
        [weakSelf.view addSubview:weakSelf.timeYear4];
    };
    
    self.LT7 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"程序版本号:" type:PersonalSettingItemTypeLabel];
    
    self.LT7.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LT7.content title:weakSelf.LT7.title compeletion:^(NSString *value) {
            weakSelf.LT7.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    
    self.LLI8 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试负责人:" type:PersonalSettingItemTypeArrow];
    _LLI8.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose1 = model;
            weakSelf.LLI8.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI9 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试组长:" type:PersonalSettingItemTypeArrow];
    _LLI9.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose2 = model;
            weakSelf.LLI9.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI10 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师1:" type:PersonalSettingItemTypeArrow];
    _LLI10.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose3 = model;
            weakSelf.LLI10.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI11 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师2:" type:PersonalSettingItemTypeArrow];
    _LLI11.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose4 = model;
            weakSelf.LLI11.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    
    self.LLI12 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"调试工程师3:" type:PersonalSettingItemTypeArrow];
    _LLI12.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose5 = model;
            weakSelf.LLI12.content = model.PERSONID;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };

    self.LT13 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"问题记录:" type:PersonalSettingItemTypeLabel];
    
    self.LT13.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LT13.content title:weakSelf.LT13.title compeletion:^(NSString *value) {
            weakSelf.LT13.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    
    
    self.LT14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"处理过程:" type:PersonalSettingItemTypeLabel];
    
    self.LT14.operation = ^{
        [weakSelf popInputTextViewContent:weakSelf.LT14.content title:weakSelf.LT14.title compeletion:^(NSString *value) {
            weakSelf.LT14.content=value;
            [weakSelf.tableView reloadData];
        }];
    };
    

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
