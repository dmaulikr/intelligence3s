//
//  DetailsStockViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BasePushViewController.h"
#import "StockModel.h"
@interface DetailsStockViewController : BasePushViewController
@property (nonatomic,strong)StockModel *stock;
@property (nonatomic,copy)NSString *objectname;
@end
