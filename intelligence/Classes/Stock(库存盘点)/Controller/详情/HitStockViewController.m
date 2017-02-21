//
//  HitStockViewController.m
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "HitStockViewController.h"
#import "FooterView.h"
#import "SoapUtil.h"
@interface HitStockViewController ()
/** 行项目*/
@property (nonatomic,strong)PersonalSettingItem *LL1;
/** 物料编码*/
@property (nonatomic,strong)PersonalSettingItem *LL2;
/** 物料描述*/
@property (nonatomic,strong)PersonalSettingItem *LL3;
/** 单位*/
@property (nonatomic,strong)PersonalSettingItem *LL4;
/** 账存数量*/
@property (nonatomic,strong)PersonalSettingItem *LL4I;
/** 实盘数量*/
@property (nonatomic,strong)PersonalSettingItem *LT5;
/** 差异原因*/
@property (nonatomic,strong)PersonalSettingItem *LT6;
@property (nonatomic,strong)NSMutableDictionary *dics;

@end

@implementation HitStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"盘点明细行";
    [self addFooter];
    [self addOne];
}
-(void)addFooter{
    FooterView *footer = [FooterView footerView];
    [footer.cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.saveBtn setTitle:@"上传" forState:UIControlStateNormal];
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
-(void)setStocks:(StockModel *)stocks{
    _stocks = stocks;
}
//保存
-(void)saveClick{
    SVHUD_NO_Stop(@"提交中");
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop
        if ([dic[@"success"] isEqualToString:@"成功"]) {
            HUDStop
            HUDNormal(@"修改库存盘点成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            HUDNormal(@"修改失败,稍后再试");
            HUDStop
        }
    };
    NSDictionary *dicy = @{
                           @"UDSTOCKLINE":@"",
                           };
    NSArray *arrays = @[
                        dicy,
                        ];
    
    NSDictionary *udDic = @{
                            @"DIFFREASON":SettingContent(_LT6),
                            @"LGORT":_stock.LGORT.length?_stock.LGORT:@"",
                            @"MAKTX":_stock.MAKTX.length?_stock.MAKTX:@"",
                            @"MATNR":_stock.MATNR.length?_stock.MATNR:@"",
                            @"MSEHL":_stock.MSEHL.length?_stock.MSEHL:@"",
                            @"NUMEXIST":_stock.NUMEXIST.length?_stock.NUMEXIST:@"",
                            @"STOCKNUM":_stock.STOCKNUM.length?_stock.STOCKNUM:@"",
                            @"TYPE":@"update",
                            @"ZPDROW":_stock.ZPDROW.length?_stock.ZPDROW:@"",
                            @"ACTUALQTY":SettingContent(_LT5),
                            @"DIFFQTY":@"0",
                            @"UDSTOCKLINEID":_stock.UDSTOCKLINEID.length?_stock.UDSTOCKLINEID:@"",
                            };
    NSDictionary *dic1 = @{
                           @"CREATEDATE":_stocks.CREATEDATE.length?_stocks.CREATEDATE:@"",
                           @"CREATEDBY":_stocks.CREATEDBY.length?_stocks.CREATEDBY:@"",
                           @"CREATENAME":_stocks.CREATENAME.length?_stocks.CREATENAME:@"",
                           @"DESCRIPTION":_stocks.DESCRIPTION.length?_stocks.DESCRIPTION:@"",
                           @"ISCLOSE":_stocks.ISCLOSE.length?_stocks.ISCLOSE:@"",
                           @"ISOPEN":_stocks.ISOPEN.length?_stocks.ISOPEN:@"",
                           @"LOCATION":_stocks.LOCATION.length?_stocks.LOCATION:@"",
                           @"LOCDESC":_stocks.LOCDESC.length?_stocks.LOCDESC:@"",
                           @"STATUS":_stocks.STATUS.length?_stocks.STATUS:@"",
                           @"STOCKNUM":_stocks.STOCKNUM.length?_stocks.STOCKNUM:@"",
                           @"UDSTOCKID":_stocks.UDSTOCKID.length?_stocks.UDSTOCKID:@"",
                           @"ZPDNUM":_stocks.ZPDNUM.length?_stocks.ZPDNUM:@"",
                           @"UDSTOCKLINE":udDic,
                           @"relationShip":arrays,
                           };
    _dics = [NSMutableDictionary dictionaryWithDictionary:dic1];
    NSArray *arr = @[
                     @{@"json":[self dictionaryToJson:_dics]},
                     @{@"mboObjectName":@"UDSTOCK"},
                     @{@"mboKey":@"STOCKNUM"},
                     @{@"mboKeyValue":_stock.STOCKNUM},
                     ];
    HUDJuHuaNoStop(@"正在上传");
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

-(void)setStock:(DetailStockModel *)stock{
    _stock = stock;
}
-(void)addOne{
    self.LL1 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ZPDROW withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"行项目:" type:PersonalSettingItemTypeLabels];
    
    self.LL2 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.MATNR withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"物料编码:" type:PersonalSettingItemTypeLabels];
    
    CGSize textMaxSize = CGSizeMake(ScreenWidth-130, MAXFLOAT);
    CGSize textSize = [_stock.MAKTX sizeWithFont:font(16) maxSize:textMaxSize];
    NSLog(@"%f",textSize.height);
    self.LL3 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.MAKTX withHeight:textSize.height > CELLHEIGHT?textSize.height:CELLHEIGHT  withClick:NO withStar:NO title:@"物料描述:" type:PersonalSettingItemTypeLabels];
    
    
    self.LL4 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.MSEHL withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"单位:" type:PersonalSettingItemTypeLabels];
    
//    self.LL4I = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ACTUALQTY withHeight:CELLHEIGHT  withClick:YES withStar:NO title:@"账存数量:" type:PersonalSettingItemTypeText];
    
    
    self.LT5 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.ACTUALQTY withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"实盘数量:" type:PersonalSettingItemTypeText];
    
    
    self.LT6 = [PersonalSettingItem itemWithIcon:nil withContent:_stock.DIFFREASON withHeight:CELLHEIGHT  withClick:NO withStar:NO title:@"差异原因:" type:PersonalSettingItemTypeText];
    
    PersonalSettingGroup *group = [[PersonalSettingGroup alloc] init];
    group.items = @[_LL1,_LL2,_LL3,_LL4,_LT5,_LT6];
    [_allGroups addObject:group];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
