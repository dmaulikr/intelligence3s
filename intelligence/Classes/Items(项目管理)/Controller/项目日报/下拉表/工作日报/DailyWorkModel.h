//
//  DailyWorkModel.h
//  intelligence
//
//  Created by 丁进宇 on 16/9/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyWorkModel : NSObject
@property (nonatomic, copy) NSString *RUNLOGDATE;
@property (nonatomic, copy) NSString *DESCRIPTION;
@property (nonatomic, copy) NSString *WEATHER;
@property (nonatomic, copy) NSString *TEM;
@property (nonatomic, copy) NSString *WINDSPEED;
@property (nonatomic, copy) NSString *WORKTYPE;
@property (nonatomic, copy) NSString *WORKPG;
@property (nonatomic, copy) NSString *WORKCRON;
@property (nonatomic, copy) NSString *COMPSTA;
@property (nonatomic, copy) NSString *SITUATION;
@property (nonatomic, copy) NSString *REMARK;
@property (nonatomic, copy) NSString *mboObjectName;

@property (nonatomic, strong) NSDictionary *dic;


@end
