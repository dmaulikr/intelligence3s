//
//  DetailsOilViewController.m
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailsOilViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"

@interface DetailsOilViewController ()
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
@property (nonatomic, strong)PersonalSettingItem *LL6;
/** 责任人*/
@property (nonatomic, strong)PersonalSettingItem *LL7;
/** 责任人名称*/
@property (nonatomic, strong)PersonalSettingItem *LL8;
/** 所属项目*/
@property (nonatomic, strong)PersonalSettingItem *LL9;
/** 所属中心*/
@property (nonatomic, strong)PersonalSettingItem *LL10;
/** ------第二部分------*/
/** 录入人编号*/
@property (nonatomic, strong)PersonalSettingItem *LL11;
/** 录入人*/
@property (nonatomic, strong)PersonalSettingItem *LL12;
/** 录入日期*/
@property (nonatomic, strong)PersonalSettingItem *LL13;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC14;
/** ------第二部分------*/
/** 加油日期*/
@property (nonatomic, strong)PersonalSettingItem *LL15;
/** 上次加油里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LL16;
/** 本次加油里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LL17;
/** 里程差*/
@property (nonatomic, strong)PersonalSettingItem *LL18;
/** 油品号*/
@property (nonatomic, strong)PersonalSettingItem *LL19;
/** 本次加油量*/
@property (nonatomic, strong)PersonalSettingItem *LL20;
/** 单价*/
@property (nonatomic, strong)PersonalSettingItem *LL21;
/** 加油费*/
@property (nonatomic, strong)PersonalSettingItem *LL22;
/** 油耗*/
@property (nonatomic, strong)PersonalSettingItem *LL23;
/** 发票号*/
@property (nonatomic, strong)PersonalSettingItem *LL24;
/** 加油地点*/
@property (nonatomic, strong)PersonalSettingItem *LL25;
/** 备注*/
@property (nonatomic, strong)PersonalSettingItem *LL26;
/** 编辑*/
@property (nonatomic, assign)BOOL isEdit;
/** footer*/
@property (nonatomic, strong)FooterView *footer;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear;
@property (nonatomic,strong)NSMutableDictionary *dics;
@end

@implementation DetailsOilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加油记录详情";
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
    [self addRightNavBarItem];
    [self addOne];
    [self addTwo];
    [self addThree];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"UDCARFUELCHARGE",@"ACTIONNAME":@"查看加油记录"}];
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
            vc.ownerid = _stock.UDCARFUELCHARGEID;
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
    if([_stock.COMISORNO isEqualToString:@"已提交"]||[_stock.COMISORNO isEqualToString:@"1"]){
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
    weakSelf.LC14.click = change;
    weakSelf.LL21.click = change;
    weakSelf.LL16.click = change;
    weakSelf.LL17.click = change;
    weakSelf.LL22.click = change;
    weakSelf.LL24.click = change;
    weakSelf.LL25.click = change;
    weakSelf.LL26.click = change;
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
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.BackUpda) {
                self.BackUpda(dic);
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
    NSDictionary *dic1 = @{
                           @"BRACHDESC":SettingContent(_LL10),
                           @"CARFUELCHARGENUM":SettingContent(_LL1),
                           @"CHARGEDATE":SettingContent(_LL15),
                           @"CREATEBY":SettingContent(_LL12),
                           @"CREATEDATE":SettingContent(_LL13),
                           @"DESCRIPTION":SettingContent(_LL2),
                           @"DRIVERID":SettingContent(_LL11),
                           @"DRIVERID1":SettingContent(_LL5),
                           @"DRIVERNAME":SettingContent(_LL6),
                           @"FUELCOST":SettingContent(_LL22),
                           @"INVOICENUM":SettingContent(_LL24),
                           @"LASTFUELCONSUMPTION":SettingContent(_LL23),
                           @"LICENSENUM":SettingContent(_LL3),
                           @"NUMBER1":SettingContent(_LL17),
                           @"NUMBER2":SettingContent(_LL16),
                           @"NUMBER3":SettingContent(_LL18),
                           @"NUMBER4":SettingContent(_LL19),
                           @"NUMBER5":SettingContent(_LL20),
                           @"PLACE":SettingContent(_LL25),
                           @"PRICE":SettingContent(_LL21),
                           @"PRODESC":SettingContent(_LL9),
                           @"REMARK":SettingContent(_LL26),
                           @"UDCARFUELCHARGEID":_stock.UDCARFUELCHARGEID,
                           @"VEHICLENAME":SettingContent(_LL4),
                           @"COMISORNO":strs,
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"mboObjectName":@"UDCARFUELCHARGE"},
                     @{@"mboKey":@"CARFUELCHARGENUM"},
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


-(void)setStock:(OilRModel *)stock{
    _stock = stock;
}
//第一部分
-(void)addOne{
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CARFUELCHARGENUM withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"编号:" type:PersonalSettingItemTypeLabels];
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.LICENSENUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车牌号:" type:PersonalSettingItemTypeLabels];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.VEHICLENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车辆名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERID1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机:" type:PersonalSettingItemTypeLabels];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERID1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"责任人:" type:PersonalSettingItemTypeLabels];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.RESPNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"责任人名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRODESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属项目:" type:PersonalSettingItemTypeLabels];
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.BRACHDESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属中心:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"车辆信息";
    group.items = @[_LL1,_LL2,_LL3,_LL4,_LL5,_LL6,_LL7,_LL8,_LL9,_LL10,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DRIVERID withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"录入人编号:" type:PersonalSettingItemTypeLabel];

     self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEBY withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"录入人:" type:PersonalSettingItemTypeLabel];
    
     self.LL13 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"录入日期:" type:PersonalSettingItemTypeLabel];
    
     self.LC14 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.COMISORNO withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
 
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"录入信息";
    group.items = @[_LL11,_LL12,_LL13,_LC14,];
    [_allGroups addObject:group];
}
//第三部分
-(void)addThree{
    WEAKSELF
    self.LL15 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_stock.CHARGEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"加油日期:" type:PersonalSettingItemTypeArrow];
    _LL15.operation = ^{
        if (weakSelf.isEdit) {
            [weakSelf.view addSubview:weakSelf.timeYear];
        }
    };
    
    self.LL16 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.NUMBER2 withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"上次加油里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LL17 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.NUMBER1 withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"本次加油里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LL18 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.NUMBER3 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"里程差:" type:PersonalSettingItemTypeLabel];
    
    self.LL19 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.NUMBER4 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"油品号:" type:PersonalSettingItemTypeLabel];
    
    self.LL20 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.NUMBER5 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"本次加油量:" type:PersonalSettingItemTypeLabel];
    
    self.LL21 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRICE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"单价:" type:PersonalSettingItemTypeText];
    
    self.LL22 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.FUELCOST withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"加油费:" type:PersonalSettingItemTypeText];
    
    self.LL23 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.LASTFUELCONSUMPTION withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"油耗:" type:PersonalSettingItemTypeLabel];
    
    self.LL24 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.INVOICENUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"发票号:" type:PersonalSettingItemTypeText];
    
    self.LL25 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PLACE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"加油地点:" type:PersonalSettingItemTypeText];
    
    self.LL26 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.REMARK withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"备注:" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"录入信息";
    group.items = @[_LL15,_LL16,_LL17,_LL18,_LL19,_LL20,_LL21,_LL22,_LL23,_LL24,_LL25,_LL26];
    [_allGroups addObject:group];
}

- (TXTimeChoose *)timeYear{
    WEAKSELF
    if (!_timeYear) {
        self.timeYear = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear.backString = ^(NSDate *data){
            weakSelf.LL15.content = [weakSelf.timeYear stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear;
}

@end
