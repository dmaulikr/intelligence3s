//
//  FlightNumberViewController.h
//  intelligence
//
//  Created by chris on 16/10/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FlightNoModel.h"
@interface FlightNumberViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(FlightNoModel *);
@property (nonatomic, copy) NSString *requestCoding;  // 项目编号
@end
