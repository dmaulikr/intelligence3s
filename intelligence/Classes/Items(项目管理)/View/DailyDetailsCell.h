//
//  DailyDetailsCell.h
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyModel.h"

@interface DailyDetailsCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat leftLabelWight;
@property (nonatomic, strong) DailyModel *daily;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
