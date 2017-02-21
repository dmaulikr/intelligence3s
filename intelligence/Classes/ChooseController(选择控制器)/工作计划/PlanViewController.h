//
//  PlanViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "WorksPlanModel.h"
@interface PlanViewController : ProfileSettingViewController
@property (nonatomic,strong)WorksPlanModel *model;
@property (nonatomic,assign)WorkType types;

@property (nonatomic,copy)void (^backModels)(WorksPlanModel *);
@property (nonatomic,copy)void (^deleteModels)(WorksPlanModel *);

@end
