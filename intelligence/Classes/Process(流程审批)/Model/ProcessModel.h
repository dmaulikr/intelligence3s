//
//  ProcessModel.h
//  intelligence
//
//  Created by  on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessModel : NSObject

@property (nonatomic, copy) NSString *APP;//
@property (nonatomic, copy) NSString *ASSIGNCODE;//
@property (nonatomic, copy) NSString *ASSIGNSTATUS;//
@property (nonatomic, copy) NSString *DESCRIPTION;    // 描述
@property (nonatomic, copy) NSString *DUEDATE;        // 到日期
@property (nonatomic, copy) NSString *ORIGPERSON;     // 任务分配人
@property (nonatomic, copy) NSString *OWNERID;        //
@property (nonatomic, copy) NSString *OWNERTABLE;     // 应用程序名
@property (nonatomic, copy) NSString *PROCESSNAME;    // 过程名称
@property (nonatomic, copy) NSString *ROLEID;         // 任务角色
@property (nonatomic, copy) NSString *STARTDATE;      // 当前日期
@property (nonatomic, copy) NSString *WFASSIGNMENTID; // 编号
@property (nonatomic, copy) NSString *UDASSIGN01;     //
@property (nonatomic, copy) NSString *UDASSIGN02;     //



@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger leftLabelWight;












@end
