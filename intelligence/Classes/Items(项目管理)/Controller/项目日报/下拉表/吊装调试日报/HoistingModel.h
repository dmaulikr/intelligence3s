//
//  HoistingModel.h
//  intelligence
//
//  Created by chris on 16/9/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HoistingModel : NSObject

@property (nonatomic, copy) NSString *CREATEDATE;
@property (nonatomic, copy) NSString *NAME;
@property (nonatomic, copy) NSString *PROPHASE;
@property (nonatomic, copy) NSString *WORKJOB;
@property (nonatomic, copy) NSString *FUNNUM;
@property (nonatomic, copy) NSString *REMARK1;
@property (nonatomic, copy) NSString *DZSTART;
@property (nonatomic, copy) NSString *DZCOMP;
@property (nonatomic, copy) NSString *INSTALLCHECK;
@property (nonatomic, copy) NSString *DEBUGGING2;
@property (nonatomic, copy) NSString *DEBUGGING;
@property (nonatomic, copy) NSString *DEBUGGINGCHECK;
@property (nonatomic, copy) NSString *STARTRUNNING;
@property (nonatomic, copy) NSString *COMPRUNNING;
@property (nonatomic, copy) NSString *COMPCHECKING;
@property (nonatomic, copy) NSString *mboObjectName;

@property (nonatomic, strong) NSDictionary *dic;

@end
