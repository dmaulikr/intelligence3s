//
//  WorkPlanViewController.h
//  intelligence
//
//  Created by chris on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BasePushViewController.h"
#import "WorksPlanModel.h"
@interface WorkPlanViewController : BasePushViewController
@property (nonatomic,copy)NSString *parent;
@property (nonatomic,assign)WorkType types;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSArray *deleArray;
@property (nonatomic,assign)NSInteger numbers;
@property (nonatomic,assign)BOOL dele;
@property (nonatomic, copy) void(^executeCellClick)(NSArray *);
@property (nonatomic, copy) void(^updataCellClick)(NSArray *,BOOL dele);

@end
