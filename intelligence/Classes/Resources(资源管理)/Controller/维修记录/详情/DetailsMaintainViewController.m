//
//  DetailsMaintainViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DetailsMaintainViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"

@interface DetailsMaintainViewController ()
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
/** 录入人*/
@property (nonatomic, strong)PersonalSettingItem *LL11;
/** 录入日期*/
@property (nonatomic, strong)PersonalSettingItem *LL12;
/** ------第二部分------*/
/** 维修开始日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI13;
/** 维修结束日期*/
@property (nonatomic, strong)PersonalSettingItem *LLI14;
/** 维修单价*/
@property (nonatomic, strong)PersonalSettingItem *LL15;
/** 维修数量*/
@property (nonatomic, strong)PersonalSettingItem *LL16;
/** 维修总额*/
@property (nonatomic, strong)PersonalSettingItem *LL17;
/** 维修发票号*/
@property (nonatomic, strong)PersonalSettingItem *LL18;
/** ------第三部分------*/
/** 维修类型*/
@property (nonatomic, strong)PersonalSettingItem *LL19;
/** 维修地点*/
@property (nonatomic, strong)PersonalSettingItem *LL20;
/** 维修.保养.更换项目*/
@property (nonatomic, strong)PersonalSettingItem *LL21;
/** 上次维修里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LL22;
/** 本次维修里程表读数*/
@property (nonatomic, strong)PersonalSettingItem *LL23;
/** 是否提交*/
@property (nonatomic, strong)PersonalSettingItem *LC24;
/** 备注*/
@property (nonatomic, strong)PersonalSettingItem *LL25;
/** 编辑*/
@property (nonatomic, assign)BOOL isEdit;
/** footer*/
@property (nonatomic, strong)FooterView *footer;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear1;
/** 年*/
@property (nonatomic,strong)TXTimeChoose *timeYear2;
@property (nonatomic,strong)NSMutableDictionary *dics;

@end

@implementation DetailsMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"维修记录详情";
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
    [self addRightNavBarItem];
    [self addOne];
    [self addTwo];
    [self addThree];
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
            vc.ownerid = _maintain.UDCARMAINLOGID;
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
    if([_maintain.COMISORNO isEqualToString:@"已提交"]||[_maintain.COMISORNO isEqualToString:@"1"]){
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
    weakSelf.LL15.click = change;
    weakSelf.LL16.click = change;
    weakSelf.LL17.click = change;
    weakSelf.LL18.click = change;
    weakSelf.LL20.click = change;
    weakSelf.LL21.click = change;
    weakSelf.LL22.click = change;
    weakSelf.LL23.click = change;
    weakSelf.LC24.click = change;
    weakSelf.LL25.click = change;
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
            if(self.BackUpda){
                self.BackUpda(dic);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    AccountModel *model = [AccountManager account];
    NSDictionary *dicy = @{};
    NSArray *arrays = @[
                        dicy,
                        ];
    NSString *str;
    if (_LC24.content.length == 0) {
        str = @"未提交";
    }else{
        str = @"已提交";
    }
    
    NSDictionary *dic1 = @{
                           @"BRANCHDESC":SettingContent(_LL10),
                           @"CREATEBY":SettingContent(_LL11),
                           @"CREATEDATE":SettingContent(_LLI13),
                           @"DESCRIPTION":SettingContent(_LL2),
                           @"DRIVERID":_maintain.DRIVERID,
                           @"DRIVERID1":SettingContent(_LL3),
                           @"DRIVERNAME":SettingContent(_LL6),
                           @"ENDDATE":SettingContent(_LL12),
                           @"INVOICENUM":SettingContent(_LL18),
                           @"LICENSENUM":SettingContent(_LL3),
                           @"MAINCONTENT":SettingContent(_LL21),
                           @"MAINDATE":SettingContent(_LLI13),
                           @"MAINLOGNUM":SettingContent(_LL1),
                           @"MAINNUMBER":SettingContent(_LL16),
                           @"MAINPLACE":SettingContent(_LL20),
                           @"NUMBER1":SettingContent(_LL22),
                           @"NUMBER2":SettingContent(_LL23),
                           @"PRICE":SettingContent(_LL15),
                           @"PRODESC":SettingContent(_LL9),
                           @"REMARK":SettingContent(_LL25),
                           @"SERVICETYPE":SettingContent(_LL19),
                           @"STARTDATE":SettingContent(_LLI13),
                           @"TOTALPRICE":SettingContent(_LL17),
                           @"UDCARMAINLOGID":_maintain.UDCARMAINLOGID,
                           @"VEHICLENAME":SettingContent(_LL4),
                           @"COMISORNO":str,
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"mboObjectName":@"UDCARMAINLOG"},
                     @{@"mboKey":@"MAINLOGNUM"},
                     @{@"mboKeyValue":model.personId},
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

-(void)setMaintain:(MaintainModel *)maintain{
    _maintain = maintain;
}
//第一部分
-(void)addOne{
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.MAINLOGNUM withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"编号:" type:PersonalSettingItemTypeLabels];
    
    //text的size
    //115 max
    CGSize textMaxSize = CGSizeMake(ScreenWidth-130, MAXFLOAT);
    CGSize textSize = [_maintain.DESCRIPTION sizeWithFont:font(16) maxSize:textMaxSize];
    NSLog(@"%f",textSize.height);
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.DESCRIPTION withHeight:textSize.height+6  withClick:NO withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabels];
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.LICENSENUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车牌号:" type:PersonalSettingItemTypeLabels];
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.VEHICLENAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"车辆名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.DRIVERID1 withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机:" type:PersonalSettingItemTypeLabels];
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.DRIVERNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"司机名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.RESPONSID withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"责任人:" type:PersonalSettingItemTypeLabels];
    
    self.LL8 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.RESPNAME withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"责任人名称:" type:PersonalSettingItemTypeLabels];
    
    self.LL9 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.PRODESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属项目:" type:PersonalSettingItemTypeLabels];
    
    self.LL10 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.BRANCHDESC withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"所属中心:" type:PersonalSettingItemTypeLabels];
    
    self.LL11 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.CREATEBY withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"录入人:" type:PersonalSettingItemTypeLabels];
    
    self.LL12 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.CREATEDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"录入日期:" type:PersonalSettingItemTypeLabels];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"基本信息";
    group.items = @[_LL1,_LL2,_LL3,_LL4,_LL5,_LL6,_LL7,_LL8,_LL9,_LL10,_LL11,_LL12,];
    [_allGroups addObject:group];
}
//第二部分
-(void)addTwo{
    WEAKSELF
    self.LLI13 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_maintain.STARTDATE withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修开始日期:" type:PersonalSettingItemTypeArrow];
        _LLI13.operation = ^{
            if (weakSelf.isEdit) {
            [weakSelf.view addSubview:weakSelf.timeYear1];
            }
        };
    self.LLI14 = [PersonalSettingItem itemWithIcon:@"ic_choose_data" withContent:_maintain.ENDDATE withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"维修结束日期:" type:PersonalSettingItemTypeArrow];
    
        _LLI14.operation = ^{
            if (weakSelf.isEdit) {
            [weakSelf.view addSubview:weakSelf.timeYear2];
            }
        };
    self.LL15 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.PRICE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修单价:" type:PersonalSettingItemTypeText];
    
    self.LL16 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.MAINNUMBER withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修数量:" type:PersonalSettingItemTypeText];
    
    self.LL17 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.TOTALPRICE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修总额:" type:PersonalSettingItemTypeText];
    
    self.LL18 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.INVOICENUM withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修发票号:" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"维修信息";
    group.items = @[_LLI13,_LLI14,_LL15,_LL16,_LL17,_LL18];
    [_allGroups addObject:group];
}
-(void)addThree{
    self.LL19 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.SERVICETYPE withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"维修类型:" type:PersonalSettingItemTypeLabels];
    
    self.LL20 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.MAINPLACE withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修地点:" type:PersonalSettingItemTypeText];
    
    self.LL21 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.MAINCONTENT withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"维修.保养.更换项目:" type:PersonalSettingItemTypeText];
    
    self.LL22 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.NUMBER2 withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"上次维修里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LL23 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.NUMBER1 withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"本次维修里程表读数:" type:PersonalSettingItemTypeText];
    
    self.LC24 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.COMISORNO withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"是否提交:" type:PersonalSettingItemTypeChoice];
    
    self.LL25 = [PersonalSettingItem itemWithIcon:nil withContent:_maintain.REMARK withHeight:CELLHEIGHT  withClick:_isEdit withStar:NO title:@"备注:" type:PersonalSettingItemTypeText];
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.header = @"维修信息";
    group.items = @[_LL19,_LL20,_LL21,_LL22,_LL23,_LC24,_LL25];
    [_allGroups addObject:group];

}
- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.LLI13.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LLI14.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}


@end
