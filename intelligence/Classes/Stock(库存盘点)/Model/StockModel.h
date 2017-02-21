//
//  StockModel.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject
@property (nonatomic,strong)NSString *CREATEDATE;    //创建时间
@property (nonatomic,strong)NSString *CREATEDBY;     //创建人
@property (nonatomic,strong)NSString *DESCRIPTION;   //描述
@property (nonatomic,strong)NSString *ISCLOSE;       //暗盘
@property (nonatomic,strong)NSString *ISOPEN;        //明盘
@property (nonatomic,strong)NSString *LOCATION;
@property (nonatomic,strong)NSString *LOCDESC;       //仓库名称
@property (nonatomic,strong)NSString *STATUS;
@property (nonatomic,strong)NSString *STOCKNUM;      //盘点单号
@property (nonatomic,strong)NSString *UDSTOCKID;
@property (nonatomic,strong)NSString *ZPDNUM;        //盘点凭证号
@property (nonatomic,strong)NSString *CREATENAME;   //创建人
@end
