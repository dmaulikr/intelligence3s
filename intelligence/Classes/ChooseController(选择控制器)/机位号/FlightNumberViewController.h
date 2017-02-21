//
//  FlightNumberViewController.h
//  intelligence
//
//  Created by 光耀 on 16/10/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FlightNoModel.h"
@interface FlightNumberViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(FlightNoModel *);
@property (nonatomic, copy) NSString *requestCoding;  // 项目编号
@end
