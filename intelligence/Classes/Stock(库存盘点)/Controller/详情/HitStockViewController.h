//
//  HitStockViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "DetailStockModel.h"
#import "StockModel.h"
@interface HitStockViewController : ProfileSettingViewController
@property (nonatomic,strong)DetailStockModel *stock;
@property (nonatomic,strong)StockModel *stocks;
@end
