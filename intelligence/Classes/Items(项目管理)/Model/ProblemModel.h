//
//  ProblemModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProblemModel : NSObject
@property (nonatomic,strong)NSString *EMERGENCY;            // 紧急程度
@property (nonatomic,strong)NSString *PRONUM;               // 项目编号
@property (nonatomic,strong)NSString *PROBLEMSITUATION;     // 现场问题及进展测试
@property (nonatomic,strong)NSString *PROSTAGE;             // 项目阶段
@property (nonatomic,strong)NSString *SOLVENAME;
@property (nonatomic,strong)NSString *FEEDBACKNUM;          // 编号
@property (nonatomic,strong)NSString *PHONE1;               // 负责人电话
@property (nonatomic,strong)NSString *PROBLEMTYPE;          // 问题类型
@property (nonatomic,strong)NSString *DEPT3;                // 解决人所属部门
@property (nonatomic,strong)NSString *PROGRESS;
@property (nonatomic,strong)NSString *WORKORDERNUM;         // 相关故障工单
@property (nonatomic,strong)NSString *RESPONSETIME;
@property (nonatomic,strong)NSString *PHONE3;               // 联系电话
@property (nonatomic,strong)NSString *DEPT2;                // 支持部门
@property (nonatomic,strong)NSString *CREATEDATE;           // 提出时间
@property (nonatomic,strong)NSString *CREATENAME;           // 需求提出人
@property (nonatomic,strong)NSString *LEADER;               // 支持部门领导
@property (nonatomic,strong)NSString *SOLVEDBY;             // 问题处理人
@property (nonatomic,strong)NSString *REMARK;
@property (nonatomic,strong)NSString *COMPTIME;
@property (nonatomic,strong)NSString *FOUNDTIME;
@property (nonatomic,strong)NSString *DEPT1;            // 提出人部门
@property (nonatomic,strong)NSString *ISSTOP;
@property (nonatomic,strong)NSString *CREATEBY;
@property (nonatomic,strong)NSString *PRODESC;          // 项目描述
@property (nonatomic,strong)NSString *STATUS;           // 状态
@property (nonatomic,strong)NSString *PHONE2;           // 提出人电话
@property (nonatomic,strong)NSString *UDFEEDBACKID;
@property (nonatomic,strong)NSString *PRORES;           // 项目负责人
@property (nonatomic,strong)NSString *SUPPORTDEPT;
@property (nonatomic,strong)NSString *BRANCH;           // 所属中心
@property (nonatomic,strong)NSString *DESCRIPTION;      // 描述


@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat leftLabelWight;

- (NSComparisonResult)compareParkInfo:(ProblemModel *)parkinfo;

@end
