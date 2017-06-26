//
//  TracelViewController.m
//  intelligence
//
//  Created by chris on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "TracelViewController.h"
#import "DetailsSearchController.h"
#import "OptionsMaintainModel.h"
#import "FooterView.h"
#import "SoapUtil.h"
#import "BusinessXViewController.h"
@interface TracelViewController ()
/** ------第一部分------*/
/** 车牌号*/
@property (nonatomic, strong)PersonalSettingItem *LLI1;
/** 车辆名称*/
@property (nonatomic, strong)PersonalSettingItem *LL2;
/** 司机*/
@property (nonatomic, strong)PersonalSettingItem *LL3;
/** 所属项目*/
@property (nonatomic, strong)PersonalSettingItem *LL4;
/** 所属中心*/
@property (nonatomic, strong)PersonalSettingItem *LL5;
/** ------第二部分------*/
/** 创建人*/
@property (nonatomic, strong)PersonalSettingItem *LL6;
/** 创建时间*/
@property (nonatomic, strong)PersonalSettingItem *LL7;
/** ------第三部分------*/
/** 出车日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI8;
/** 出车时间*/
@property (nonatomic, strong)PersonalSettingItem *LLI9;
/** 出发地*/
@property (nonatomic, strong)PersonalSettingItem *LT10;
/** 目的地*/
@property (nonatomic, strong)PersonalSettingItem *LT11;
/** 出车事由*/
@property (nonatomic, strong)PersonalSettingItem *LT12;
/** ------第四部分------*/
/** 业务单号*/
@property (nonatomic, strong)PersonalSettingItem *LL13;
/** 任务类型*/
@property (nonatomic, strong)PersonalSettingItem *LL14;
/** 起始里程*/
@property (nonatomic, strong)PersonalSettingItem *LL15;
/** 结束里程*/
@property (nonatomic, strong)PersonalSettingItem *LT16;
/** 标准油耗*/
@property (nonatomic, strong)PersonalSettingItem *LT17;
/** 路桥费*/
@property (nonatomic, strong)PersonalSettingItem *LT18;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC19;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear;
/** 小时*/
@property (nonatomic,strong)TXTimeChoose *timeHour;

@property (nonatomic,strong)NSMutableDictionary *dics;
//项目编号
@property (nonatomic,strong)NSString *pronum;

@end

@implementation TracelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行驶记录新建";
    [self addFooter];
    [self addOne];
    [self addTwo];
    [self addThree];
    [self addFour];
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
        HUDJuHua(@"请选择车牌号");
        return;
    }else if ([SettingContent(_LLI8) isEqualToString:@""]){
        HUDJuHua(@"请选择出车日期");
        return;
    }else if ([SettingContent(_LLI9) isEqualToString:@""]){
        HUDJuHua(@"请选择出车时间");
        return;
    }else if ([SettingContent(_LT10) isEqualToString:@""]){
        HUDJuHua(@"请输入出发地");
        return;
    }else if ([SettingContent(_LT12) isEqualToString:@""]){
        HUDJuHua(@"请输入出车事由");
        return;
    }else if ([SettingContent(_LT16) isEqualToString:@""]){
        HUDJuHua(@"请输入结束里程");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"1"]) {
            HUDNormal(dic[@"errorMsg"]);
        }
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.backModel) {
                self.backModel(dic);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSString *str;
    if (_LC19.content.length == 0) {
        str = @"未提交";
    }else{
        str = @"已提交";
    }
    
    AccountModel *model = [AccountManager account];
    NSDictionary *dicy = @{};
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
                           @"COMISORNO":str,
                           @"CREATEDATE":SettingContent(_LL7),
                           @"DEPARTURE":SettingContent(_LT10),
                           @"DESTINATION":SettingContent(_LT11),
                           @"DRIVERID":model.personId,
                           @"ENDNUMBER":SettingContent(_LT16),
                           @"FEE":SettingContent(_LT18),
                           @"GOREASON":SettingContent(_LT12),
                           @"LICENSENUM":SettingContent(_LLI1),
                           @"STANDARDFUELCONSUMPTION":SettingContent(_LT17),
                           @"NOWPROJECT":self.pronum,
                           @"STARTDATE":SettingContent(_LLI8),
                           @"STARTTIME":SettingContent(_LLI9),
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"flag":@"1"},
                     @{@"mboObjectName":@"UDCARDRIVELOG"},
                     @{@"mboKey":@"CARDRIVELOGNUM"},
                     @{@"personId":model.personId},
                     ];
    [soap requestMethods:@"mobileserviceInsertMbo" withDate:arr];
}
/**
 *  用于不同的请求 传的参数是json
 */
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//第一部分
-(void)addOne{
    WEAKSELF
    self.LLI1 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:nil withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"车牌号:" type:PersonalSettingItemTypeArrow];
    _LLI1.operation = ^{
        DetailsSearchController *details = [[DetailsSearchController alloc]init];
        details.BackBlock = ^(id model){
            OptionsMaintainModel *options = (OptionsMaintainModel *)model;
            weakSelf.LLI1.content = options.LICENSENUM;
            weakSelf.LL2.content = options.DRIVER;
            weakSelf.LL3.content = options.DRIVER;
            weakSelf.LL4.content = options.PRODESC;
            weakSelf.pronum = options.PRONUM;
            NSLog(@"项目编号 %@",weakSelf.pronum);
            weakSelf.LL5.content = options.BRANCHDESC;
            weakSelf.LL15.content = options.NUMBER2.length?options.NUMBER2:@"0";
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:details animated:YES];
    };
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车辆名称:" type:PersonalSettingItemTypeLabel];
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机:" type:PersonalSettingItemTypeLabel];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属项目:" type:PersonalSettingItemTypeLabel];
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属中心:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆基础信息";
    group.items = @[_LLI1,_LL2,_LL3,_LL4,_LL5];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    AccountModel *model = [AccountManager account];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:model.displayName withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabel];
    
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:kGetCurrentTime(@"yyyy-MM-dd") withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建日期:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"录入信息";
    group.items = @[_LL6,_LL7,];
    [_allGroups addObject:group];
}

//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI8 = [PersonalSettingItem itemWithIcon:@"ic_choose_data"  withContent:kGetCurrentTime(@"yyyy-MM-dd") withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"出车日期:" type:PersonalSettingItemTypeArrow];
    _LLI8.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear];
    };
    self.LLI9 = [PersonalSettingItem itemWithIcon:@"ic_choose_time" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"出车时间:" type:PersonalSettingItemTypeArrow];
    _LLI9.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeHour];
    };
    self.LT10 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"出发地:" type:PersonalSettingItemTypeLabel];
    
    self.LT11 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"目的地:" type:PersonalSettingItemTypeLabel];
    
    self.LT12 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"出车事由:" type:PersonalSettingItemTypeLabel];
    self.LT12.operation = ^ {
        
        [weakSelf popInputTextViewContent:weakSelf.LT12.content title:weakSelf.LT12.title compeletion:^(NSString *value) {
            
            weakSelf.LT12.content=value;
            [weakSelf.tableView reloadData];
            
        }];
    };
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆信息";
    group.items = @[_LLI8,_LLI9,_LT10,_LT11,_LT12];
    [_allGroups addObject:group];
}
//第三部分
-(void)addFour{
    WEAKSELF
    self.LL13 = [PersonalSettingItem itemWithIcon:nil  withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"业务单号:" type:PersonalSettingItemTypeArrow];
    _LL13.operation = ^{
        BusinessXViewController *business = [[BusinessXViewController alloc]init];
        business.executeCellClick = ^(BusinessModel *model){
            weakSelf.LL13.content = model.NUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:business animated:YES];
    };
    
    self.LL14 = [PersonalSettingItem itemWithIcon:nil  withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"任务类型:" type:PersonalSettingItemTypeLabels];
    
    self.LL15 = [PersonalSettingItem itemWithIcon:nil  withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"起始里程(公里):" type:PersonalSettingItemTypeLabels];
    
    self.LT16 = [PersonalSettingItem itemWithIcon:nil  withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"结束里程(公里):" type:PersonalSettingItemTypeLabel];
    
    self.LT17 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"标准油耗(升):" type:PersonalSettingItemTypeLabel];
    
    self.LT18 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"路桥费(元):" type:PersonalSettingItemTypeLabel];
    
    self.LC19 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆行驶详情信息";
    group.items = @[_LL13,_LL14,_LL15,_LT16,_LT17,_LT18,_LC19,];
    [_allGroups addObject:group];
}

- (TXTimeChoose *)timeYear{
    WEAKSELF
    if (!_timeYear) {
        self.timeYear = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear.backString = ^(NSDate *data){
            weakSelf.LLI8.content = [weakSelf.timeYear stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear;
}
- (TXTimeChoose *)timeHour{
    WEAKSELF
    if (!_timeHour) {
        self.timeHour = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeTime];
        self.timeHour.backString = ^(NSDate *data){
            weakSelf.LLI9.content = [weakSelf.timeHour stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeHour;
}



@end
