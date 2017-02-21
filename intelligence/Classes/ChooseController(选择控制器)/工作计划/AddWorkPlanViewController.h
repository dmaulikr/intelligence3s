//
//  AddWorkPlanViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "WorksPlanModel.h"
@interface AddWorkPlanViewController : ProfileSettingViewController
@property (nonatomic,assign)NSInteger number;
@property (nonatomic,assign)WorkType types;
@property (nonatomic,copy)void (^backModel)(WorksPlanModel *);
@end
