//
//  ProblemDetailsLLCell.h
//  intelligence
//
//  Created by  on 16/8/3.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProblemModel.h"

@interface ProblemDetailsLLCell : UITableViewCell


@property (nonatomic, strong) ProblemModel *problem;


@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat leftLabelWight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
