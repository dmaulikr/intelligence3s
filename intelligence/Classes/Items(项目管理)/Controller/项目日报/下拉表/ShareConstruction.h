//
//  ShareConstruction.h
//  intelligence
//
//  Created by chris on 16/9/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstructionModel.h"
#import "HoistingModel.h"
#import "DailyWorkModel.h"
#import "ToolingManagementModel.h"
#import "InspectProjectModel.h"
#import "Runliner.h"

@interface ShareConstruction : NSObject
@property (nonatomic, strong) ConstructionModel *construction;
@property (nonatomic, strong) HoistingModel *hoisting;
@property (nonatomic, strong) DailyWorkModel *dailyWork;
@property (nonatomic, strong) ToolingManagementModel *toolingManagement;
@property (nonatomic, strong) InspectProjectModel *inspectProject;
@property (nonatomic, strong) NSMutableArray * runlineModels;
@property (nonatomic, strong) NSMutableDictionary * stockQueryCondicitonDictionary;

+ (ShareConstruction *)sharedConstruction;
@end
