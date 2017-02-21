//
//  StockQueryTableViewCell.h
//  intelligence
//
//  Created by chris on 2016/12/2.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockQuery.h"

@interface StockQueryTableViewCell : UITableViewCell
@property (strong, nonatomic) StockQuery * stockQueryModel;
@property (strong, nonatomic) IBOutlet UIView *bview;
@property (strong, nonatomic) IBOutlet UILabel *SN;
@property (strong, nonatomic) IBOutlet UILabel *ITEMDESC;
@property (strong, nonatomic) IBOutlet UILabel *LOCATIONDESC;
@property (strong, nonatomic) IBOutlet UILabel *LOCATION;
@property (strong, nonatomic) IBOutlet UILabel *CURBAL;
@property (strong, nonatomic) IBOutlet UILabel *UNIT;
@property (strong, nonatomic) IBOutlet UILabel *BINNUM;
@property (strong, nonatomic) IBOutlet UILabel *ITEMNUM;

@end
