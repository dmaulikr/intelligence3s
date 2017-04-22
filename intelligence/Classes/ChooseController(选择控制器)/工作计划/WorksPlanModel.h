//
//  WorksPlanModel.h
//  intelligence
//
//  Created by chris on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorksPlanModel : NSObject
//任务号
@property (nonatomic,copy)NSString *TASKID;
//描述
@property (nonatomic,copy)NSString *DESCRIPTION;
//0
@property (nonatomic,copy)NSString *ESTDUR;
//负责人
@property (nonatomic,copy)NSString *OWNER;
//负责人
@property (nonatomic,copy)NSString *OWNERNAME;

@property (nonatomic,copy)NSString *TYPE;

@property (nonatomic,copy)NSString *WORKORDERID;
@property (nonatomic,assign) NSInteger isnumber;

@end
