//
//  HitStockViewController.h
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "DetailStockModel.h"
#import "StockModel.h"
@interface HitStockViewController : ProfileSettingViewController
@property (nonatomic,strong)DetailStockModel *stock;
@property (nonatomic,strong)StockModel *stocks;
@end
