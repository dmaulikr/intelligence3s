//
//  AddMaintain.m
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "AddMaintain.h"
#import "DetailsSearchController.h"
#import "OptionsMaintainModel.h"
#import "FooterView.h"
#import "ChoiceWorkView.h"
#import "SoapUtil.h"
@interface AddMaintain ()
/** ------第一部分------*/
/** 车牌号*/
@property (nonatomic, strong)PersonalSettingItem *LLI1;
/** 车辆名称*/
@property (nonatomic, strong)PersonalSettingItem *LL2;
/** ------第二部分------*/
/** 维修开始日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI3;
/** 维修结束日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI4;
/** 维修单价*/
@property (nonatomic, strong)PersonalSettingItem *LT5;
/** 维修数量*/
@property (nonatomic, strong)PersonalSettingItem *LT6;
/** 维修总额*/
@property (nonatomic, strong)PersonalSettingItem *LT7;
/** 维修发票号*/
@property (nonatomic, strong)PersonalSettingItem *LT8;
/** 维修类型*/
@property (nonatomic, strong)PersonalSettingItem *LLI9;
/** 维修地点*/
@property (nonatomic, strong)PersonalSettingItem *LT10;
/** 维修.保养.更换项目*/
@property (nonatomic, strong)PersonalSettingItem *LT11;
/** 上次维修里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LT12;
/** 本次维修里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LT13;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC14;
/** 备注*/
@property (nonatomic, strong)PersonalSettingItem *LT15;
//选项
@property (nonatomic, strong)OptionsMaintainModel *options;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear1;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)NSMutableDictionary *dics;
//项目编号
@property (nonatomic,strong)NSString *pronum;
@end

@implementation AddMaintain

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"维修记录新建";
    [self addFooter];
    [self addOne];
    [self addTwo];
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
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
        HUDNormal(@"请选择维修开始日期");
        return;
    }else if ([SettingContent(_LLI4) isEqualToString:@""]) {
        HUDNormal(@"请选择维修结束日期");
        return;
    }else if ([SettingContent(_LT7) isEqualToString:@""]) {
        HUDNormal(@"请输入维修总额");
        return;
    }else if ([SettingContent(_LLI9) isEqualToString:@""]) {
        HUDNormal(@"请选择维修类型");
        return;
    }
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDCARMAINLOG",@"ACTIONNAME":@"维修记录"}];
            
            if (weakSelf.backName) {
                weakSelf.backName(dic);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSString *strs;
    if (_LC14.content.length == 0) {
        strs = @"未提交";
    }else{
        strs = @"已提交";
    }
    AccountModel *model = [AccountManager account];
    NSDictionary *dicy = @{};
    NSArray *arrays = @[
                        dicy,
                        ];
    NSString *str;
    if ([SettingContent(_LLI9) isEqualToString:@"事故维修"]) {
        str = @"accident";
    }else{
        str = @"normal";
    }
    NSDictionary *dic1 = @{
                           @"COMISORNO" :strs,
                           @"CREATEDATE":SettingContent(_LLI3),
                           @"DRIVERID":model.personId,
                           @"ENDDATE":SettingContent(_LLI4),
                           @"INVOICENUM":SettingContent(_LT8),
                           @"LICENSENUM":SettingContent(_LLI1),
                           @"MAINCONTENT":SettingContent(_LT11),
                           @"MAINNUMBER":SettingContent(_LT6),
                           @"MAINPLACE":SettingContent(_LT10),
                           @"NUMBER1":SettingContent(_LT13),
                           @"NUMBER2":SettingContent(_LT12),
                           @"PRICE":SettingContent(_LT5),
                           @"REMARK":SettingContent(_LT15),
                           @"SERVICETYPE":str,
                           @"NOWPROJECT":self.pronum,
                           @"STARTDATE":SettingContent(_LLI3),
                           @"TOTALPRICE":SettingContent(_LT7),
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"flag":@"1"},
                     @{@"mboObjectName":@"UDCARMAINLOG"},
                     @{@"mboKey":@"MAINLOGNUM"},
                     @{@"mboKeyValue":model.personId},
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
    self.LLI1 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"车牌号:" type:PersonalSettingItemTypeArrow];
    _LLI1.operation = ^{
        DetailsSearchController *details = [[DetailsSearchController alloc]init];
        details.BackBlock = ^(id model){
            OptionsMaintainModel *options = (OptionsMaintainModel *)model;
            weakSelf.LLI1.content = options.LICENSENUM;
            weakSelf.LL2.content = options.DRIVER;
            weakSelf.LT12.content = options.NUMBER3;
            weakSelf.pronum = options.PRONUM;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:details animated:YES];
    };
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车辆名称:" type:PersonalSettingItemTypeLabel];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆基础信息";
    group.items = @[_LLI1,_LL2,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI3 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"维修开始日期:" type:PersonalSettingItemTypeArrow];
    _LLI3.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LLI4 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:@"" withHeight:CELLHEIGHT  withClick:NO withStar:YES title:@"维修结束日期:" type:PersonalSettingItemTypeArrow];
    _LLI4.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    self.LT5 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修单价:" type:PersonalSettingItemTypeText];
    
    self.LT6 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修数量:" type:PersonalSettingItemTypeText];
    
    self.LT7 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"维修总额:" type:PersonalSettingItemTypeText];
    
    self.LT8 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修发票号:" type:PersonalSettingItemTypeText];
    
    self.LLI9 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:YES title:@"维修类型:" type:PersonalSettingItemTypeArrow];
    _LLI9.operation =^{
        ChoiceWorkView *work = [[ChoiceWorkView alloc]initWithFrame:weakSelf.view.bounds choice:ChoiceTypeMaintain];
        work.WorkBlock = ^(NSString *str){
            weakSelf.LLI9.content = str;
            [weakSelf.tableView reloadData];
        };
        [work ShowInView:weakSelf.view];
    };

    self.LT10 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修地点:" type:PersonalSettingItemTypeText];
    
    self.LT11 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修.保养.更换项目:" type:PersonalSettingItemTypeText];
    
    self.LT12 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"上次维修里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LT13 = [PersonalSettingItem itemWithIcon:@"more_next_icon" withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"本次维修里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LC14 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
    
    self.LT15 = [PersonalSettingItem itemWithIcon:nil withContent:@"" withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"备注:" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"维修信息";
    group.items = @[_LLI3,_LLI4,_LT5,_LT6,_LT7,_LT8,_LLI9,_LT10,_LT11,_LT12,_LT13,_LC14,_LT15];
    [_allGroups addObject:group];
}

- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
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
        self.timeYear2 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear2.backString = ^(NSDate *data){
            weakSelf.LLI4.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}


@end
