//
//  FlightNoController.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FlightNoModel.h"

@interface FlightNoController : BaseSearchViewController

@property (nonatomic, copy) void(^executeCellClick)(FlightNoModel *);
@property (nonatomic, copy) NSString *requestCoding;  // 项目编号


@end
