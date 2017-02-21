//
//  FaultClassController.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FaultClassModel.h"

@interface FaultClassController : BaseSearchViewController
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic, copy) void(^executeCellClick)(FaultClassModel *);
@end
