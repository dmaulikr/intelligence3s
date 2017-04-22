//
//  TripReportModel.h
//  intelligence
//
//  Created by chris on 2016/11/22.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripReportModel : NSObject
@property (nonatomic, copy) NSString * SERIALNUMBER;//编号
@property (nonatomic, copy) NSString * DESCRIPTION;//描述
@property (nonatomic, copy) NSString * ACOUNT;//出差人编号
@property (nonatomic, copy) NSString * NAME1;//出差人姓名
@property (nonatomic, copy) NSString * DEPTNUM;//部门编号
@property (nonatomic, copy) NSString * DEPTNAME;//部门名称
@property (nonatomic, copy) NSString * CREATEBY;//录入人;
@property (nonatomic, copy) NSString * CREATER_DISPLAYNAME;// 录入人姓名
@property (nonatomic, copy) NSString * CREATEDATE;//录入日期
@property (nonatomic, copy) NSString * TRIPCODE;//出差申请编号
@property (nonatomic, copy) NSString * TRIPDATE;//出差日期
@property (nonatomic, copy) NSString * PROJECT;//出差项目
@property (nonatomic, copy) NSString * PROJECTNAME;//项目名称
@property (nonatomic, copy) NSString * TOPLACE;//出差地点
@property (nonatomic, copy) NSString * TRIPCONTENT;//出差事由
@property (nonatomic, copy) NSString * WORKCONTENT;//工作内容
@end
