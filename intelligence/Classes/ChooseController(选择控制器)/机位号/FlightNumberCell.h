//
//  FlightNumberCell.h
//  intelligence
//
//  Created by 光耀 on 16/10/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightNoModel.h"
@interface FlightNumberCell : UITableViewCell
@property (nonatomic,copy)FlightNoModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
+(instancetype)flightNumberCell;
@end
