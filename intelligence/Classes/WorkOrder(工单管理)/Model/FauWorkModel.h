//
//  FauWorkModel.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FauWorkModel : NSObject
@property (nonatomic, copy) NSString *PRONAME;         // 项目描述

@property (nonatomic,copy)NSString *ACTSTART;        // 实际开始时间
@property (nonatomic,copy)NSString *PMCHGEVALEND;    // 位置描述
@property (nonatomic,copy)NSString *UDPROJECTNUM;    // 项目编号
@property (nonatomic,copy)NSString *CREATEBY;
@property (nonatomic,copy)NSString *UDRESTARTTIME;   // 故障开始时间
@property (nonatomic,copy)NSString *NAME3;           // 维护/运行人员3
@property (nonatomic,copy)NSString *GZWTDESC;        // 故障问题   //故障问题描述
@property (nonatomic,copy)NSString *NAME1;           // 维护/运行人员1
@property (nonatomic,copy)NSString *UDPROBDESC;      // 故障隐患描述
@property (nonatomic,copy)NSString *UDRPRRSBNAME;    // 提报人
@property (nonatomic,copy)NSString *UDZGLIMIT;       // 提报时间  //故障回复时间
@property (nonatomic,copy)NSString *BRANCH;          // 中心
@property (nonatomic,copy)NSString *CREATEDATE;      // 创建时间
@property (nonatomic,copy)NSString *SCHEDSTART;      // 计划开始时间
@property (nonatomic,copy)NSString *WONUM;           // 工单号
@property (nonatomic,copy)NSString *UDINSPOBY3;
@property (nonatomic,copy)NSString *UDFAILURECODE;     // 故障问题
@property (nonatomic,copy)NSString *UDGZDJ;          // 故障等级
@property (nonatomic,copy)NSString *ISSTOPED;        // 是否停机    //故障隐患描述
@property (nonatomic,copy)NSString *DESCRIPTION;     // 描述
@property (nonatomic,copy)NSString *LEADNAME;        // 负责人 //维护/运行组长
@property (nonatomic,copy)NSString *UDLOCNUM;        // 机位号
@property (nonatomic,copy)NSString *UDLOCATION;      // 设备位置
@property (nonatomic,copy)NSString *NAME2;           // 维护/运行人员2
@property (nonatomic,copy)NSString *PMCHGEVALSTART;
@property (nonatomic,copy)NSString *ACTFINISH;       // 实际完成时间
@property (nonatomic,copy)NSString *SCHEDFINISH;     // 计划完成时间
@property (nonatomic,copy)NSString *WORKTYPE;
@property (nonatomic,copy)NSString *GZLDESC;         // 故障类
@property (nonatomic,copy)NSString *UDGZTYPE;        // 故障类型
@property (nonatomic,copy)NSString *UDJGRESULT;      // 累计停机时间
@property (nonatomic,copy)NSString *UDPLANNUM;       // 终验收计划号
@property (nonatomic,copy)NSString *LOCDESC;
@property (nonatomic,copy)NSString *UDREPORTNUM;
@property (nonatomic,copy)NSString *FAILURECODE;
@property (nonatomic,copy)NSString *UDSTATUS;        // 状态
@property (nonatomic,copy)NSString *WORKORDERID;
@property (nonatomic,copy)NSString *UDSTOPTIME;      // 故障开始时间
@property (nonatomic,copy)NSString *CULEVEL;
@property (nonatomic,copy)NSString *UDRPRRSB;
@property (nonatomic,copy)NSString *UDINSPOBY;
@property (nonatomic,copy)NSString *LEAD;
@property (nonatomic,copy)NSString *UDINSPOBY2;
@property (nonatomic,copy)NSString *CREATENAME;      // 创建人


//调试工单
@property (nonatomic,copy)NSString *PRONUM;
@property (nonatomic,copy)NSString *STATUS;
@property (nonatomic,copy)NSString *PLANEND;
@property (nonatomic,copy)NSString *PLANSTART;
@property (nonatomic,copy)NSString *DEBUGWORKORDERNUM;
@property (nonatomic,copy)NSString *DEBUGWORKORDERID;
//技改工单
//技改标准
@property (nonatomic,copy)NSString *UDJPNUM;
//计划开始时间
@property (nonatomic,copy)NSString *UDPLSTARTDATE;
//计划完成时间
@property (nonatomic,copy)NSString *UDPLSTOPDATE;
//风机型号
@property (nonatomic,copy)NSString *WTCODE;
//技改原因
@property (nonatomic,copy)NSString *PCRESON;
//主控程序版本号
@property (nonatomic,copy)NSString *UDFJAPPNUM;
//技改类型
@property (nonatomic,copy)NSString *UDJGTYPE;
//风机跟踪
@property (nonatomic,copy)NSString *UDFJFOL;
//技改结果
@property (nonatomic,copy)NSString *PERINSPR;
//风机台数
@property (nonatomic,copy)NSString *PCCOMPNUM;
@property (nonatomic,copy)NSString *REALCOMP;
@property (nonatomic,copy)NSString *PLANNUM;
@property (nonatomic,copy)NSString *JGPLANNUM;       //技改计划编号
@property (nonatomic,copy)NSString *UDRLSTARTDATE;   //实际开始时间
@property (nonatomic,copy)NSString *UDRLSTOPDATE;    //实际完成时间
@property (nonatomic,copy)NSString *UDREMARK;        //没有编码的物料
@property (nonatomic,copy)NSString *UDZGMEASURE;     //故障处理方案
@property (nonatomic,copy)NSString *PCTYPE;          //排查类型
@property (nonatomic,copy)NSString *DJTYPE;
@property (nonatomic,copy)NSString *ISBIGPAR;
@property (nonatomic,copy)NSString *DJPLANNUM;
@end
