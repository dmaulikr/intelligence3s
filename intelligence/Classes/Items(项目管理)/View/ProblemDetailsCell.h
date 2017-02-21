//
//  ProblemDetailsCell.h
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProblemModel.h"

typedef NS_ENUM(NSInteger, ProblemDetailsType) {
    ProblemDetailsTypeLL,               // label label
    ProblemDetailsTypeLLV,              // label label >
    ProblemDetailsTypeLLT,              // label label 日历
    ProblemDetailsTypeLT,               // label TextField
    ProblemDetailsTypeLR,               // label 口
};

@interface ProblemDetailsCell : UITableViewCell
@property (nonatomic, strong) ProblemModel *problem;
@property (nonatomic, assign) ProblemDetailsType cellType;

@property (nonatomic, assign) CGFloat leftLabelWight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
