//
//  CauseProblemCell.h
//  intelligence
//
//  Created by  on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CauseProblemModel.h"
#import "ProjectPersonModel.h"

@interface CauseProblemCell : UITableViewCell

@property (nonatomic, strong) CauseProblemModel *causeProblemModel;
@property (nonatomic, strong) ProjectPersonModel *projectPersonModel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
