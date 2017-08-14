//
//  DebugWorkViewController.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DebugWorkViewController.h"
#import "DTKDropdownMenuView.h"
#import "FooterView.h"
#import "UploadPicturesViewController.h"
#import "SoapUtil.h"
#import "ApprovalsView.h"
#import "WorkPlanViewController.h"
#import "WorkDebugsViewsController.h"
@interface DebugWorkViewController ()<UIAlertViewDelegate>
/** ------第一部分----*/
/** 工单号*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 描述*/
@property (nonatomic,strong)PersonalSettingItem *LT2;
/** 项目编号*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 状态*/
@property (nonatomic,strong)PersonalSettingItem *LL4;
/** 创建人*/
@property (nonatomic,strong)PersonalSettingItem *LL5;
/** 计划开始时间*/
@property (nonatomic,strong)PersonalSettingItem *LL6;
/** 计划结束时间*/
@property (nonatomic,strong)PersonalSettingItem *LL7;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear1;
//年月日
@property (nonatomic,strong)TXTimeChoose *timeYear2;
//编辑
@property (nonatomic,assign)BOOL isEdit;
@property (nonatomic,strong)NSMutableDictionary *dics;
@property (nonatomic,strong)NSMutableArray *workArray;
@property (nonatomic,strong) NSMutableArray *updataworkArray;
@property (nonatomic,assign) BOOL isworkDele;
@end

@implementation DebugWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调试工单详情";
    self.SetingItems = [NSMutableDictionary dictionary];
    _workArray = [NSMutableArray array];
    _updataworkArray = [NSMutableArray array];
    [self addRightNavBarItem];
    [self addFooter];
    
    _isEdit = YES;
    [self addOne];
    
    [self checkWFPRequiredWithAppId:@"DEBUGORDER" objectName:@"DEBUGWORKORDER" status:self.stock.STATUS compeletion:^(NSArray *fields) {
        NSLog(@"调试工单必填字段 %@",fields);
        self.RequiredFields=[NSMutableArray array];
        
        for (NSString *field in fields) {
            if (field.length>0) {
                [self.RequiredFields addObject:field];
            }
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MywindsendAnalysisInfo" object:nil userInfo:@{@"ACTIONCODE":@"WORKORDER_DC",@"ACTIONNAME":@"查看调试工单"}];
}
- (void)addRightNavBarItem{
    WEAKSELF
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"调试工单子表" iconName:@"ic_woactivity" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"发送工作流" iconName:@"ic_flower" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"图片上传" iconName:@"ic_upload" callBack:^(NSUInteger index, id info) {
        [weakSelf pushWithIndex:index];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"工作流任务分配" iconName:@"ic_tujian" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        NSLog(@"工作流任务分配");
        WfmListanceListViewController* vc= [[WfmListanceListViewController alloc] init];
        vc.OWNERID=_stock.DEBUGWORKORDERID;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1,item2,item3] icon:@"more"];
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
    WEAKSELF
    NSLog(@"跳转页面");
    switch (index) {
        case 0:{
            //调试工单子表
            WorkDebugsViewsController *work = [[WorkDebugsViewsController alloc]init];
            work.parent = SettingContent(_LL1);
            work.identifier = SettingContent(_LL3);
            work.executeCellClick = ^(NSArray *array){
                [weakSelf.workArray removeAllObjects];
                [weakSelf.workArray addObjectsFromArray:array];
            };
            work.updataCellClick = ^(NSArray *array,BOOL dele){
                [weakSelf.updataworkArray removeAllObjects];
                [weakSelf.updataworkArray addObjectsFromArray:array];
                weakSelf.isworkDele = dele;
            };
            work.dele = _isworkDele;
            work.array = self.workArray;
            work.deleArray = self.updataworkArray;
            [weakSelf.navigationController pushViewController:work animated:YES];
        }break;
        case 1:{
            //发送工作流
            [self checkRequiredFieldcompeletion:^(BOOL isOK) {
                if(isOK)
                {
                    [self sendData];
                }
            }];
        }break;
        case 2:{
            UploadPicturesViewController *vc = [[UploadPicturesViewController alloc] init];
            vc.ownertable = _objectname;
            vc.ownerid = _stock.WORKORDERID;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        default:
            break;
    }
}

//发送工作流
-(void)sendData{
    if ([_stock.STATUS isEqualToString:@"已取消"]||[_stock.STATUS isEqualToString:@"已关闭"]||[_stock.STATUS isEqualToString:@"已完成"]) {
        NSString *str = [NSString stringWithFormat:@"%@状态,不能发起工作流",_stock.STATUS];
        HUDJuHua(str);
        return;
    }
    NSString *str;
    NSString *str1;
    BOOL isOne;
    if([_stock.STATUS isEqualToString:@"新建"]){
        str = @"工作流启动成功";
        str1 = @"工作流启动失败";
        isOne = YES;
    }else{
        str = @"审批成功";
        str1 = @"审批失败";
        isOne = NO;
    }
    
    ApprovalsView *popupView = [[ApprovalsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withNumber:isOne];
    popupView.processname = @"UDDEBUGWOR";
    popupView.mbo = @"DEBUGWORKORDER";
    popupView.keyValue = _stock.DEBUGWORKORDERNUM;
    popupView.key = @"DEBUGWORKORDERNUM";
    popupView.CloseBlick = ^(NSDictionary *dic){
        if ([dic[@"success"] isEqualToString:@"成功"]||[dic[@"msg"] isEqualToString:@"工作流启动成功"]||[dic[@"status"] isEqualToString:@"等待批准"]) {
            HUDNormal(str);
        }else{
            HUDNormal(str1);
        }
    };
    [popupView show];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footer.saveBtn addTarget:self action:@selector(saveClicks) forControlEvents:UIControlEventTouchUpInside];
    
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
-(void)saveClicks{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定修改工单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self saveClick];
    }
}

//保存
-(void)saveClick{
    SVHUD_NO_Stop(@"提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            if (self.blackBlock) {
                self.blackBlock(@"修改工单成功");
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            HUDJuHua(dic[@"errorMsg"]);
        }
    };
    NSMutableArray *arrayst = [NSMutableArray array];
    for (NSDictionary *dic in self.updataworkArray) {
        WorkDebugsModel *work = [WorkDebugsModel mj_objectWithKeyValues:dic];
         NSMutableDictionary *dics1 = [NSMutableDictionary dictionary];
        if (work.CREW2.length) {
            [dics1 setObject:work.CREW2 forKey:@"CREW2"];
        }
        if (work.WINDDRIVENGENERATORNUM.length) {
            [dics1 setObject:work.WINDDRIVENGENERATORNUM forKey:@"WINDDRIVENGENERATORNUM"];
        }
        if (work.VESION.length) {
            [dics1 setObject:work.VESION forKey:@"VESION"];
        }
        if (work.TIME2.length) {
            [dics1 setObject:work.TIME2 forKey:@"TIME2"];
        }
        if (work.TIME1.length) {
            [dics1 setObject:work.TIME1 forKey:@"TIME1"];
        }
        if (work.SYNCHRONIZATIONDEBUGDATE.length) {
            [dics1 setObject:work.SYNCHRONIZATIONDEBUGDATE forKey:@"SYNCHRONIZATIONDEBUGDATE"];
        }
        if (work.RESPONSIBLEPERSON.length) {
            [dics1 setObject:work.RESPONSIBLEPERSON forKey:@"RESPONSIBLEPERSON"];
        }
        if (work.QUESTION.length) {
            [dics1 setObject:work.QUESTION forKey:@"QUESTION"];
        }
        if (work.FJLOCATION.length) {
            [dics1 setObject:work.FJLOCATION forKey:@"FJLOCATION"];
        }
        if (work.DYNAMICDEBUGDATE.length) {
            [dics1 setObject:work.DYNAMICDEBUGDATE forKey:@"DYNAMICDEBUGDATE"];
        }
        if (work.DISPOSE.length) {
            [dics1 setObject:work.DISPOSE forKey:@"DISPOSE"];
        }
        if (work.DEBUGLEADER.length) {
            [dics1 setObject:work.DEBUGLEADER forKey:@"DEBUGLEADER"];
        }
        if (work.CREW3.length) {
            [dics1 setObject:work.CREW3 forKey:@"CREW3"];
        }
        if (work.CREW.length) {
            [dics1 setObject:work.CREW forKey:@"CREW"];
        }
        [arrayst addObject:dics1];
    }
    AccountModel *model = [AccountManager account];
    NSMutableDictionary *dicy = [NSMutableDictionary dictionary];
    if (arrayst.count) {
        [dicy setObject:@"" forKey:@"UDDEBUGWORKORDERLINE"];
    }
    NSArray *arrays = @[
                        dicy,
                        ];
    NSDictionary *dic1 = @{
                           @"CREATEBY":SettingContent(_LL5),
                           @"DEBUGWORKORDERID":_stock.DEBUGWORKORDERID,
                           @"DEBUGWORKORDERNUM":SettingContent(_LL1),
                           @"DESCRIPTION":SettingContent(_LT2),
                           @"PRONUM":SettingContent(_LL3),
                           @"STATUS":SettingContent(_LL4),
                           @"PLANEND":SettingContent(_LL7),
                           @"PLANSTART":SettingContent(_LL6),
                           @"relationShip":arrays,
                           };
    NSMutableDictionary *dics1 = [NSMutableDictionary dictionary];
    [dics1 addEntriesFromDictionary:dic1];
    if (arrayst.count) {
        [dics1 setObject:arrayst forKey:@"UDDEBUGWORKORDERLINE"];
    }
    _dics = [NSMutableDictionary dictionaryWithDictionary:dics1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"mboObjectName":@"DEBUGWORKORDER"},
                     @{@"mboKey":@"DEBUGWORKORDERNUM"},
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

-(void)setStock:(FauWorkModel *)stock{
    _stock = stock;
}

-(void)addOne{
    WEAKSELF
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DEBUGWORKORDERNUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"工单号:" type:PersonalSettingItemTypeLabels];
    self.LL1.FieldName=@"DEBUGWORKORDERNUM";
    
    self.LT2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DESCRIPTION withHeight:CELLHEIGHT+3  withClick:_isEdit withStar:NO title:@"描述:" type:PersonalSettingItemTypeLabel];
    self.LT2.FieldName=@"DESCRIPTION";
    
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PRONUM withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"项目编号:" type:PersonalSettingItemTypeLabels];
    self.LL3.FieldName=@"PRONUM";
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.STATUS withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"状态:" type:PersonalSettingItemTypeLabels];
    self.LL4.FieldName=@"STATUS";
    
    self.LL5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.CREATEBY withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"创建人:" type:PersonalSettingItemTypeLabels];
    self.LL5.FieldName=@"CREATEBY";
    
    self.LL6 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PLANSTART withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"计划开始时间:" type:PersonalSettingItemTypeLabels];
    self.LL6.FieldName=@"PLANSTART";
    
    _LL6.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear1];
    };
    
    self.LL7 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.PLANEND withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"技术结束时间:" type:PersonalSettingItemTypeLabels];
    self.LL7.FieldName=@"PLANEND";
    
    
    _LL7.operation = ^{
        [weakSelf.view addSubview:weakSelf.timeYear2];
    };
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LT2,_LL3,_LL4,_LL5,_LL6,_LL7];
    [_allGroups addObject:group];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (TXTimeChoose *)timeYear1{
    WEAKSELF
    if (!_timeYear1) {
        self.timeYear1 = [[TXTimeChoose alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        self.timeYear1.backString = ^(NSDate *data){
            weakSelf.LL6.content = [weakSelf.timeYear1 stringFromDate:data];
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
            weakSelf.LL7.content = [weakSelf.timeYear2 stringFromDate:data];
            [weakSelf.tableView reloadData];
        };
    }
    return _timeYear2;
}
-(void)checkRequiredFieldcompeletion:(void (^)(BOOL isOK))compeletion
{
    
    NSMutableArray *nullFields=[NSMutableArray array];
    
    if (self.RequiredFields.count<=0) {
        compeletion(YES);
    }
    else
    {
        for (NSString * str in self.RequiredFields) {
            
            PersonalSettingItem *item = [self.SetingItems objectForKey:str];
            if (item) {
                
                if (item.content.length<=0) {
                    [nullFields addObject:item.title];
                    
                }
            }
            
        }
        if (nullFields.count>0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:[NSString stringWithFormat:@"以下内容未填写<%@>,请填写并保存后进行其它操作",nullFields] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * comfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [alert addAction:comfirm];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            compeletion(YES);
        }
    }
    
    
}
@end
