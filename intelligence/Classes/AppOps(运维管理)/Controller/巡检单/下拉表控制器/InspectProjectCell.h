//
//  InspectProjectCell.h
//  intelligence
//
//  Created by  on 16/8/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectProjectModel.h"
#import "ProjectCarsModel.h"

@interface InspectProjectCell : UITableViewCell

@property (nonatomic, strong) InspectProjectModel *inspectProject;
@property (nonatomic, strong) ProjectCarsModel *projectCars;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
