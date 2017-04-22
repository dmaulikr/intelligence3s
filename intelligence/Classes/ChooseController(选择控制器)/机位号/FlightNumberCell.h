//
//  FlightNumberCell.h
//  intelligence
//
//  Created by chris on 16/10/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightNoModel.h"
@interface FlightNumberCell : UITableViewCell
@property (nonatomic,copy)FlightNoModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
+(instancetype)flightNumberCell;
@end
