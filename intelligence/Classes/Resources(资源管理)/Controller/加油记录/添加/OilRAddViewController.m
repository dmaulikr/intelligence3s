//
//  OilRAddViewController.m
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "OilRAddViewController.h"
#import "DetailsSearchController.h"
#import "OptionsMaintainModel.h"
#import "ChoiceWorkView.h"
#import "FooterView.h"
#import "SoapUtil.h"
@interface OilRAddViewController ()
/** ------第一部分------*/
/** 车牌号*/
@property (nonatomic, strong)PersonalSettingItem *LLI1;
/** 车辆名称*/
@property (nonatomic, strong)PersonalSettingItem *LL2;
/** ------第二部分------*/
/** 加油日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI3;
/** 上次加油里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LT4;
/** 本次加油里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LT5;
/** 加油卡编号*/
@property (nonatomic,strong)PersonalSettingItem *LLI5I;
/** 油品号*/
@property (nonatomic, strong)PersonalSettingItem *LLI6;
/** 单价*/
@property (nonatomic, strong)PersonalSettingItem *LT7;
/** 加油费*/
@property (nonatomic, strong)PersonalSettingItem *LT8;
/** 发票号*/
@property (nonatomic, strong)PersonalSettingItem *LT9;
/** 加油地点*/
@property (nonatomic, strong)PersonalSettingItem *LT10;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC11;
/** 备注*/
@property (nonatomic, strong)PersonalSettingItem *LT12;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear;
@property (nonatomic,strong)NSMutableDictionary *dics;
//项目编号
@property (nonatomic,strong)NSString *pronum;
@end

@implementation OilRAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加油记录新建";
    [self addFooter];
    [self addOne];
    [self addTwo];
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
        HUDNormal(@"请选择车牌号");
        return;
    }else if ([SettingContent(_LLI3) isEqualToString:@""]) {
        HUDNormal(@"请选择加油日期");
        return;
    }else if ([SettingContent(_LT7) isEqualToString:@""]) {
        HUDNormal(@"请输入单价");
        return;
    }else if ([SettingContent(_LT8) isEqualToString:@""]) {
        HUDNormal(@"请输入加油费");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (weakSelf.backName) {
                weakSelf.backName(dic);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }else{
            HUDNormal(dic[@"errorMsg"]);
        }
    };
    NSString *str;
    if (_LC11.content.length ==0) {
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
                           @"CHARGEDATE":SettingContent(_LLI3),
                           @"COMISORNO":str,
                           @"CREATEDATE":SettingContent(_LLI3),
                           @"DRIVERID":model.personId,
                           @"FUELCOST":SettingContent(_LT8),
                           @"INVOICENUM":SettingContent(_LT9),
                           @"LICENSENUM":SettingContent(_LLI1),
                           @"NUMBER1":SettingContent(_LT5),
                           @"NUMBER2":SettingContent(_LT4),
                           @"NUMBER4":SettingContent(_LLI6),
                           @"PLACE":SettingContent(_LT10),
                           @"PRICE":SettingContent(_LT7),
                           @"REMARK":SettingContent(_LT12),
                           @"NOWPROJECT":self.pronum,
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"flag":@"1"},
                     @{@"mboObjectName":@"UDCARFUELCHARGE"},
                     @{@"mboKey":@"CARFUELCHARGENUM"},
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
    self.LLI1 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"车牌号:" type:PersonalSettingItemTypeArrow];
    _LLI1.operation = ^{
        DetailsSearchController *details = [[DetailsSearchController alloc]init];
        details.BackBlock = ^(id model){
            OptionsMaintainModel *options = (OptionsMaintainModel *)model;
            weakSelf.LLI1.content = options.LICENSENUM;
            weakSelf.LL2.content = options.DRIVER;
            weakSelf.LT4.content = options.NUMBER1;
            weakSelf.pronum = options.PRONUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:details animated:YES];
    };
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"车辆名称:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆基础信息";
    group.items = @[_LLI1,_LL2,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI3 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:kGetCurrentTime(@"yyyy-MM-dd") withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"加油日期:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear];
    };
    
    self.LT4 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"上次加油里程表读数:" type:PersonalSettingItemTypeLabel];
    
    self.LT5 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"本次加油里程表读数:" type:PersonalSettingItemTypeLabel];
    
    
    self.LLI5I = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"油品号:" type:PersonalSettingItemTypeArrow];
    _LLI5I.operation =^{
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeBANH];
        work.WorkBlock = ^(NSString *str){
            weakSelf.LLI5I.content = str;
            [weakSelf.tableView reloadData];
        };
        [work ShowInView:weakSelf.view];
    };

    
    self.LLI6 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"油品号:" type:PersonalSettingItemTypeArrow];
    _LLI6.operation =^{
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeOil];
        work.WorkBlock = ^(NSString *str){
            weakSelf.LLI6.content = str;
            [weakSelf.tableView reloadData];
        };
        [work ShowInView:weakSelf.view];
    };
    self.LT7 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"单价:" type:PersonalSettingItemTypeLabel];
    
    self.LT8 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"加油费:" type:PersonalSettingItemTypeLabel];
    
    self.LT9 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"发票号:" type:PersonalSettingItemTypeLabel];
    
    self.LT10 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"加油地点:" type:PersonalSettingItemTypeLabel];
    
    self.LC11 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
    
    self.LT12 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"备注:" type:PersonalSettingItemTypeLabel];
    
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"加油记录详细信息";
    group.items = @[_LLI3,_LT4,_LLI5I,_LT5,_LLI6,_LT7,_LT8,_LT9,_LT10,_LC11,_LT12];
    [_allGroups addObject:group];

}

- (TXTimeChoose *)timeYear{
    WEAKSELF
    if (!_timeYear) {
        self.timeYear = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear.backString = ^(NSDate *data){
            weakSelf.LLI3.content = [weakSelf.timeYear stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear;
}




@end
