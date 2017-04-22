//
//  AddWorkPlanViewController.m
//  intelligence
//
//  Created by chris on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddWorkPlanViewController.h"
#import "DailyDetailChoosePersonController.h"
#import "FooterView.h"

@interface AddWorkPlanViewController ()
@property (nonatomic,strong)PersonalSettingItem *LL1;
@property (nonatomic,strong)PersonalSettingItem *LT2;
@property (nonatomic,strong)PersonalSettingItem *LLI3;
@property (nonatomic,strong)PersonalSettingItem *LLI4;
@property (nonatomic,strong)PersonalSettingItem *LLI5;
@property (nonatomic,strong)PersonalSettingItem *LLI4s;
@property (nonatomic,strong)PersonalSettingItem *LLI5s;


@property (nonatomic,strong)PersonalSettingItem *LT6;
@property (nonatomic,strong)PersonalSettingItem *LC7;
@property (nonatomic,strong)PersonalSettingItem *LL8;
@property (nonatomic,strong)PersonalSettingItem *LLI9;
@property (nonatomic,strong)PersonalSettingItem *LLI10;
@property (nonatomic,strong)PersonalSettingItem *LT11;
@property (nonatomic,strong)PersonalSettingItem *LL12;
@property (nonatomic,strong)PersonalSettingItem *LL13;

@property (nonatomic,strong)ChoosePersonModel *choose1;
@property (nonatomic,strong)TXTimeChoose *timeYear1;
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)TXTimeChoose *timeYear3;
@property (nonatomic,strong)TXTimeChoose *timeYear21;
@property (nonatomic,strong)TXTimeChoose *timeYear31;

@end

@implementation AddWorkPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建任务";
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
        HUDNormal(@"请选择负责人");
        return;
    }
    WorksPlanModel *model = [[WorksPlanModel alloc]init];
    model.TASKID = SettingContent(_LL1);
    model.DESCRIPTION = SettingContent(_LT2);
    model.ESTDUR = @"0";
    model.OWNER = SettingContent(_LLI3);
    model.OWNERNAME = SettingContent(_LLI3);
//    model.shijiwancheng = SettingContent(_LLI5);
    model.TYPE = @"add";
    model.isnumber = 1;
    if (self.backModel) {
        self.backModel(model);
    }
    HUDNormal(@"保存成功");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addOne{
    
    WEAKSELF
    NSString *str = [NSString stringWithFormat:@"%ld",(_number+1)*10];
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:str withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"任务号:" type:PersonalSettingItemTypeLabels];
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"描述:" type:PersonalSettingItemTypeText];
    
    self.LLI3 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"负责人:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose1 = model;
            weakSelf.LLI3.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };

    
    self.LLI5 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"结束时间:" type:PersonalSettingItemTypeArrow];
    _LLI5.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear3];
    };
    
    self.LLI4s = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际开始时间:" type:PersonalSettingItemTypeArrow];
//    _LLI4s.operation = ^{
//        [weakSelf.view addSubview:weakSelf.timeYear21];
//    };
    
    
    self.LLI5s = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实际时间:" type:PersonalSettingItemTypeArrow];
//    _LLI5s.operation = ^{
//        [weakSelf.view addSubview:weakSelf.timeYear31];
//    };
    
    
    self.LT6 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"执行标准:" type:PersonalSettingItemTypeText];
    
    self.LC7 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"已完成?:" type:PersonalSettingItemTypeChoice];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"问题描述:" type:PersonalSettingItemTypeText];
    
    self.LLI9 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"整改期限:" type:PersonalSettingItemTypeArrow];
    _LLI9.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LLI10 = [PersonalSettingItem itemWithIcon:@"" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"整改负责人:" type:PersonalSettingItemTypeArrow];
    _LLI10.operation = ^{
        DailyDetailChoosePersonController *daily = [[DailyDetailChoosePersonController alloc]init];
        daily.exetuceClickCell = ^(ChoosePersonModel *model){
            weakSelf.choose1 = model;
            weakSelf.LLI10.content = model.DISPLAYNAME;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:daily animated:YES];
    };
    
    self.LT11 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"整改方案:" type:PersonalSettingItemTypeText];
    
    self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"整改完成情况:" type:PersonalSettingItemTypeLabels];
    
    self.LL13 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"备注:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    if(_types == WorkTypeCheck){
        group.items = @[_LL1,_LT2,_LLI3,_LLI5,_LT6,_LC7,_LL8,_LLI9,_LLI10,_LT11,_LL12,_LL13];
    }else{
        group.items = @[_LL1,_LT2,_LLI3,];
    }
    group.items = @[_LL1,_LT2,_LLI3,_LLI4s,_LLI5s];
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
            weakSelf.LLI9.content = [weakSelf.timeYear1 stringFromDate:data];
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

- (TXTimeChoose *)timeYear21{
    WEAKSELF
    if (!_timeYear21) {
        self.timeYear21 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear21.backString = ^(NSDate *data){
            weakSelf.LLI4s.content = [weakSelf.timeYear21 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear21;
}

- (TXTimeChoose *)timeYear31{
    WEAKSELF
    if (!_timeYear31) {
        self.timeYear31 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.timeYear31.backString = ^(NSDate *data){
            weakSelf.LLI5s.content = [weakSelf.timeYear31 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear31;
}



@end
