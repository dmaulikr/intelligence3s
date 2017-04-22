//
//  DailyModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyModel : NSObject
@property (nonatomic,copy)NSString *DESCRIPTION;     // 描述
@property (nonatomic,copy)NSString *PRONUM;          // 项目编号
@property (nonatomic,copy)NSString *UDPRORESC;       // 负责人
@property (nonatomic,copy)NSString *CONTDESC;        // 联系人
@property (nonatomic,copy)NSString *BRANCH;          // 中心
@property (nonatomic,copy)NSString *YEAR;            // 年
@property (nonatomic,copy)NSString *MONTH;           // 月
@property (nonatomic,copy)NSString *PROSTAGE;        // 阶段
@property (nonatomic,copy)NSString *STATUS;          // 状太
@property (nonatomic,copy)NSString *CONTRACTS;       // F00433
@property (nonatomic,copy)NSString *PRORUNLOGNUM;    // 编号
@property (nonatomic,copy)NSString *RESPONSID;       // F00433
@property (nonatomic, copy) NSString *UDPRORUNLOGID; // 965
@property (nonatomic, copy) NSString *PHONENUN;      // 电话

@property (nonatomic, copy) NSString *CHANGEDATE;

@property (nonatomic, copy) NSString *CONTDNAME;
@property (nonatomic, copy) NSString *CHANGEBY;





@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger leftLabelWight;

@end
