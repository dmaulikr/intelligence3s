//
//  SupportDepartmentController.h
//  intelligence
//
//  Created by  on 16/8/16.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "SupportDepartmentModel.h"

@interface SupportDepartmentController : BaseSearchViewController

@property (nonatomic, copy) void(^executeCellClick)(SupportDepartmentModel *);

@end
