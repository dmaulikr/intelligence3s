//
//  InspectProjectDetailsController.h
//  intelligence
//
//  Created by  on 16/8/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BasePushViewController.h"
#import "InspectProjectModel.h"


@interface InspectProjectDetailsController : BasePushViewController

@property (nonatomic, strong) InspectProjectModel *inspectProject;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void (^executeupdata)(NSInteger);


@end
