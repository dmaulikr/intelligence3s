//
//  FaultCodeController.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FaultCodeModel.h"

@interface FaultCodeController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(FaultCodeModel *);
@property (nonatomic, copy) NSString *requestCoding;  // 故障编号
@end
