//
//  DetailsTravelViewController.m
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailsTravelViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"
#import "BusinessXViewController.h"
@interface DetailsTravelViewController ()
/** ------第一部分------*/
/** 编号*/
@property (nonatomic, strong)PersonalSettingItem *LL1;
/** 描述*/
@property (nonatomic, strong)PersonalSettingItem *LL2;
/** 车牌号*/
@property (nonatomic, strong)PersonalSettingItem *LL3;
/** 车辆名称*/
@property (nonatomic, strong)PersonalSettingItem *LL4;
/** 司机*/
@property (nonatomic, strong)PersonalSettingItem *LL5;
/** 司机名称*/
@property (nonatomic ,strong)PersonalSettingItem *LL6;
/** 所属项目*/
@property (nonatomic, strong)PersonalSettingItem *LL7;
/** 所属中心*/
@property (nonatomic, strong)PersonalSettingItem *LL8;
/** ------第二部分------*/
/** 创建人*/
@property (nonatomic, strong)PersonalSettingItem *LL9;
/** 创建人名称*/
@property (nonatomic, strong)PersonalSettingItem *LL10;
/** 创建时间*/
@property (nonatomic, strong)PersonalSettingItem *LL11;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC12;
/** ------第三部分------*/
/** 出车日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI13;
/** 出车时间*/
@property (nonatomic, strong)PersonalSettingItem *LLI14;
/** 出发地*/
@property (nonatomic, strong)PersonalSettingItem *LL15;
/** 目的地*/
@property (nonatomic, strong)PersonalSettingItem *LL16;
/** 出车事由*/
@property (nonatomic, strong)PersonalSettingItem *LL17;
/** ------第四部分------*/
/** 业务单号*/
@property (nonatomic, strong)PersonalSettingItem *LL18;
/** 任务类型*/
@property (nonatomic, strong)PersonalSettingItem *LL19;
/** 起始里程*/
@property (nonatomic, strong)PersonalSettingItem *LL20;
/** 结束里程*/
@property (nonatomic, strong)PersonalSettingItem *LL21;
/** 上次耗油*/
@property (nonatomic, strong)PersonalSettingItem *LL22;
/** 标准耗油*/
@property (nonatomic, strong)PersonalSettingItem *LL23;
/** 路桥费*/
@property (nonatomic, strong)PersonalSettingItem *LL24;
/** 编辑*/
@property (nonatomic, assign)BOOL isEdit;
/** footer*/
@property (nonatomic, strong)FooterView *footer;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear;
/** 小时*/
@property (nonatomic,strong)TXTimeChoose *timeHour;
@property (nonatomic,strong)NSMutableDictionary *dics;


@end

@implementation DetailsTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行驶记录详情";
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
    [self addRightNavBarItem];
    [self addOne];
    [self addTwo];
    [self addThree];
    [self addFours];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDCARDRIVELOG",@"ACTIONNAME":@"查看行驶记录"}];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"编辑" iconName:@"ic_edit" callBack:^(NSUInteger index, id info) {
        [weakSelf addFooter];
    }];
    
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1] icon:@"more"];
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
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = _objectname;
            vc.ownerid = _stock.UDCARDRIVELOGID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)addFooter{
    if([_stock.COMISORNO isEqualToString:@"1"]||[_stock.COMISORNO isEqualToString:@"已提交"]){
        HUDNormal(@"该记录状态已提交,不可编辑");
        return;
    }
    WEAKSELF
    if(weakSelf.isEdit){
        weakSelf.isEdit = NO;
        CGRect frame = self.tableView.frame;
        frame.size.height += 50;
        weakSelf.tableView.frame = frame;
        [weakSelf.footer removeFromSuperview];
        [weakSelf changeClick:weakSelf.isEdit];
    }else{
        weakSelf.isEdit = YES;
        CGRect frame = self.tableView.frame;
        frame.size.height -= 50;
        weakSelf.tableView.frame = frame;
        weakSelf.footer = [FooterView footerView];
        [weakSelf.footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.footer.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
        
        weakSelf.footer.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
        [self.view addSubview:weakSelf.footer];
        [weakSelf changeClick:weakSelf.isEdit];
    }
}
-(void)changeClick:(BOOL)change{
    WEAKSELF
    weakSelf.LC12.click = change;
    weakSelf.LLI13.click = change;
    weakSelf.LLI14.click = change;
    weakSelf.LL15.click = change;
    weakSelf.LL16.click = change;
    weakSelf.LL17.click = change;
    weakSelf.LL21.click = change;
    weakSelf.LL23.click = change;
    weakSelf.LL24.click = change;
    [weakSelf.tableView reloadData];
}

//取消
-(void)backClick{
    [self addFooter];
}
//保存
-(void)saveClick{
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"errorNo"]];
        if ([str isEqualToString:@"1"]) {
            SVHUD_ERROR(dic[@"errorMsg"]);
        }
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.BackUpda) {
                self.BackUpda(dic);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    NSString *strs;
    if (_LC12.content.length == 0) {
        strs = @"未提交";
    }else{
        strs = @"已提交";
    }
    AccountModel *model = [AccountManager account];
    NSDictionary *dicy = @{};
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
                           @"CARDRIVELOGNUM":SettingContent(_LL1),
                           @"CARNAME":SettingContent(_LL4),
                           @"CREATEBY":SettingContent(_LL10),
                           @"CREATEDATE":SettingContent(_LL11),
                           @"DEPARTURE":SettingContent(_LL15),
                           @"DESCRIPTION":SettingContent(_LL2),
                           @"DESTINATION":SettingContent(_LL16),
                           @"DRIVERID":model.personId,
                           @"DRIVERID1":SettingContent(_LL5),
                           @"DRIVERNAME":SettingContent(_LL6),
                           @"ENDNUMBER":SettingContent(_LL21),
                           @"FEE":SettingContent(_LL24),
                           @"GOREASON":SettingContent(_LL17),
                           @"LASTFUELCONSUMPTION":SettingContent(_LL22),
                           @"LICENSENUM":SettingContent(_LL3),
                           @"STANDARDFUELCONSUMPTION":SettingContent(_LL23),
                           @"STARTDATE":SettingContent(_LLI13),
                           @"STARTNUMBER":SettingContent(_LL20),
                           @"STARTTIME":SettingContent(_LLI14),
                           @"UDCARDRIVELOGID":_stock.UDCARDRIVELOGID,
                           @"COMISORNO":strs,
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"mboObjectName":@"UDCARDRIVELOG"},
                     @{@"mboKey":@"CARDRIVELOGNUM"},
                     @{@"mboKeyValue":SettingContent(_LL1)},
                     ];
    [soap requestMethods:@"mobileserviceUpdateMbo" withDate:arr];
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


-(void)setStock:(TravelRModel *)stock{
    _stock = stock;
}
//第一部分
-(void)addOne{
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CARDRIVELOGNUM withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"记录编号:" type:PersonalSettingItemTypeLabels];
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.LICENSENUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车牌号:" type:PersonalSettingItemTypeLabels];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CARNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车辆名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERID1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机:" type:PersonalSettingItemTypeLabels];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRODESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属项目:" type:PersonalSettingItemTypeLabels];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRANCHDESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属中心:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆信息";
    group.items = @[_LL1,_LL2,_LL3,_LL4,_LL5,_LL6,_LL7,_LL8,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERID withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabel];

    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEBY withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人名称:" type:PersonalSettingItemTypeLabel];
    
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建时间:" type:PersonalSettingItemTypeLabel];
    
    self.LC12 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.COMISORNO withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"录入信息";
    group.items = @[_LL9,_LL10,_LL11,_LC12,];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data"  withContent:_stock.STARTDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"出车日期:" type:PersonalSettingItemTypeArrow];
    
    _LLI13.operation = ^{
        if (weakSelf.isEdit) {
            [weakSelf.view addSubview:weakSelf.timeYear];
        }
    };
    
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"ic_choose_time" withContent:_stock.STARTTIME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"出车时间:" type:PersonalSettingItemTypeArrow];
    _LLI14.operation = ^{
        if (weakSelf.isEdit) {
            [weakSelf.view addSubview:weakSelf.timeHour];
        }
    };
    self.LL15 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DEPARTURE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"出发地:" type:PersonalSettingItemTypeText];
    
    self.LL16 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESTINATION withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"目的地:" type:PersonalSettingItemTypeText];
    
    self.LL17 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.GOREASON withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"出车事由:" type:PersonalSettingItemTypeText];
   
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"出车信息";
    group.items = @[_LLI13,_LLI14,_LL15,_LL16,_LL17];
    [_allGroups addObject:group];
}
//第四部分
-(void)addFours{
    WEAKSELF
    self.LL18 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.WONUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"业务单号:" type:PersonalSettingItemTypeArrow];
    
        _LL18.operation = ^{
            if (weakSelf.isEdit) {
            BusinessXViewController *business = [[BusinessXViewController alloc]init];
            business.executeCellClick = ^(BusinessModel *model){
                weakSelf.LL18.content = model.NUM;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:business animated:YES];
                }
        };
    
    self.LL19 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.WORKTYPE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"任务类型:" type:PersonalSettingItemTypeLabel];
    
    self.LL20 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.STARTNUMBER withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"起始里程(公里):" type:PersonalSettingItemTypeLabel];
    
    self.LL21 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ENDNUMBER withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"结束里程(公里):" type:PersonalSettingItemTypeText];
    
    self.LL22 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.LASTFUELCONSUMPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"上次油耗(升):" type:PersonalSettingItemTypeLabel];
    
    self.LL23 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.STANDARDFUELCONSUMPTION withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"标准油耗(升):" type:PersonalSettingItemTypeText];
    
    self.LL24 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.FEE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"路桥费(元):" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆行驶详情信息";
    group.items =@[_LL18,_LL19,_LL20,_LL21,_LL22,_LL23,_LL24];
    [_allGroups addObject:group];
    
}

- (TXTimeChoose *)timeYear{
    WEAKSELF
    if (!_timeYear) {
        self.timeYear = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear.backString = ^(NSDate *data){
            weakSelf.LLI13.content = [weakSelf.timeYear stringFromDate:data];
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
            weakSelf.LLI14.content = [weakSelf.timeHour stringFromDate:data];
            [weakSelf.tableView  reloadData];
        };
    }
    return _timeHour;
}

@end
