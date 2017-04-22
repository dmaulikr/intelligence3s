//
//  RemedialMeasuresCell.h
//  intelligence
//
//  Created by  on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CauseProblemModel.h"

@interface RemedialMeasuresCell : UITableViewCell

@property (nonatomic, strong) CauseProblemModel *causeProblemModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
