//
//  DetailsStockViewController.h
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BasePushViewController.h"
#import "StockModel.h"
@interface DetailsStockViewController : BasePushViewController
@property (nonatomic,strong)StockModel *stock;
@property (nonatomic,copy)NSString *objectname;
@end
