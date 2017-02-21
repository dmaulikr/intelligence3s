//
//  DetailStockModel.h
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailStockModel : NSObject
@property (nonatomic,copy)NSString *MAKTX;         //物料描述
@property (nonatomic,copy)NSString *MATNR;         //物料编号
@property (nonatomic,copy)NSString *DIFFREASON;    //差异原因
@property (nonatomic,copy)NSString *MSEHL;         //单位
@property (nonatomic,copy)NSString *NUMEXIST;
@property (nonatomic,copy)NSString *STOCKNUM;
@property (nonatomic,copy)NSString *ZPDROW;        //行项目
@property (nonatomic,copy)NSString *LGORT;
@property (nonatomic,copy)NSString *DIFFQTY;
@property (nonatomic,copy)NSString *ACTUALQTY;     //实盘数量
@property (nonatomic,copy)NSString *UDSTOCKLINEID;
@end
