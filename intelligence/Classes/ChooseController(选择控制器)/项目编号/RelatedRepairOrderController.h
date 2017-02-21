//
//  RelatedRepairOrderController.h
//  intelligence
//
//  Created by  on 16/8/14.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "RelatedRepairOrderModel.h"

@interface RelatedRepairOrderController : BaseSearchViewController

@property (nonatomic, copy) void(^executeCellClick)(RelatedRepairOrderModel *);


@end
