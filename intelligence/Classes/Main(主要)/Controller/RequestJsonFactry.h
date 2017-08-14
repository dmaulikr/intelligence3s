//
//  RequestJsonFactry.h
//  intelligence
//
//  Created by chris on 2017/8/7.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestJsonFactry : NSObject
//预警排查工单
+(NSDictionary*)getRequestJsonfor_YJPCGD_With:(NSString*) search page:(NSInteger)page;

//故障工单
+(NSDictionary*)getRequestJsonfor_GZGD_With:(NSString*) search page:(NSInteger)page;

//调试工单
+(NSDictionary*)getRequestJsonfor_TSGD_With:(NSString*) search page:(NSInteger)page;

//巡检工单
+(NSDictionary*)getRequestJsonfor_XJGD_With:(NSString*) search page:(NSInteger)page;

//定检工单
+(NSDictionary*)getRequestJsonfor_DJGD_With:(NSString*) search page:(NSInteger)page;

//排查工单
+(NSDictionary*)getRequestJsonfor_PCGD_With:(NSString*) search page:(NSInteger)page;

//技改工单
+(NSDictionary*)getRequestJsonfor_JGGD_With:(NSString*) search page:(NSInteger)page;

//终验收工单
+(NSDictionary*)getRequestJsonfor_ZYSGD_With:(NSString*) search page:(NSInteger)page;

//项目台账
+(NSDictionary*)getRequestJsonfor_XMTJ_With:(NSString*) search page:(NSInteger)page;

//项目日报
+(NSDictionary*)getRequestJsonfor_XMRB_With:(NSString*) search page:(NSInteger)page;

//问题联络单
+(NSDictionary*)getRequestJsonfor_WTLLD_With:(NSString*) search page:(NSInteger)page;

//出差报告
+(NSDictionary*)getRequestJsonfor_CCBG_With:(NSString*) search page:(NSInteger)page;

//运行记录
+(NSDictionary*)getRequestJsonfor_YXJL_With:(NSString*) search page:(NSInteger)page;

//故障提报单
+(NSDictionary*)getRequestJsonfor_GZTBD_With:(NSString*) search page:(NSInteger)page;

//行驶记录
+(NSDictionary*)getRequestJsonfor_XSJL_With:(NSString*) search page:(NSInteger)page;

//加油记录
+(NSDictionary*)getRequestJsonfor_JYJL_With:(NSString*) search page:(NSInteger)page;

//车辆维修
+(NSDictionary*)getRequestJsonfor_CLWX_With:(NSString*) search page:(NSInteger)page;

//库存盘点
+(NSDictionary*)getRequestJsonfor_KCPD_With:(NSString*) search page:(NSInteger)page;

//流程审批
+(NSDictionary*)getRequestJsonfor_LCSP_With:(NSString*) search page:(NSInteger)page;

//调试工单子表
+(NSDictionary*)getRequestJsonfor_TSGDZB_With:(NSString*) search page:(NSInteger)page;

//人员
+(NSDictionary*)getRequestJsonfor_RY_With:(NSString*) search page:(NSInteger)page;

//风机
+(NSDictionary*)getRequestJsonfor_FJ_With:(NSString*) search page:(NSInteger)page;

@end
