//
//  ProblemDetailsLLICells.h
//  intelligence
//
//  Created by  on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProblemModel.h"

@interface ProblemDetailsLLICells : UITableViewCell

@property (nonatomic, strong) ProblemModel *problem;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat leftLabelWight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
