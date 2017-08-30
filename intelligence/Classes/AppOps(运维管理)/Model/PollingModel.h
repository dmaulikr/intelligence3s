//
//  PollingModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PollingModel : NSObject
@property (nonatomic,strong)NSString *LASTRUNDATE;       // 上次巡查时间
@property (nonatomic,strong)NSString *ISSTOP;
@property (nonatomic,strong)NSString *CREATEBY;          // 创建人
@property (nonatomic,strong)NSString *FJNUM;
@property (nonatomic,strong)NSString *INSPPLANNUM;       // 巡检计划单号
@property (nonatomic,strong)NSString *STOPTIME;
@property (nonatomic,strong)NSString *CHANGEDATE;        // 修改时间
@property (nonatomic,strong)NSString *NAME3;
@property (nonatomic,strong)NSString *CHANGEBY;          // 修改人
@property (nonatomic,strong)NSString *NAME1;
@property (nonatomic,strong)NSString *JPDESC;            // 巡检标准
@property (nonatomic,strong)NSString *BRANCH;            // 中心
@property (nonatomic,strong)NSString *CREATEDATE;        // 创建时间
@property (nonatomic,strong)NSString *PRODESC;           // 项目名称
@property (nonatomic,strong)NSString *COMPTIME;          // 计划完成时间&计划完成日期
@property (nonatomic,strong)NSString *WEATHER;           // 天气
@property (nonatomic,strong)NSString *INSPODATE;
@property (nonatomic,strong)NSString *STATUS;            // 状态
@property (nonatomic,strong)NSString *DESCRIPTION;       // 描述
@property (nonatomic,strong)NSString *BRANCHDESC;
@property (nonatomic,strong)NSString *FJDESC;
@property (nonatomic,strong)NSString *INSPOBY3;
@property (nonatomic,strong)NSString *INSPOBY4;
@property (nonatomic,strong)NSString *INSPOBY5;
@property (nonatomic,strong)NSString *INSPOBY6;
@property (nonatomic,strong)NSString *JPNUM;
@property (nonatomic,strong)NSString *CHANGEBYNAME;      // 创建人
@property (nonatomic,strong)NSString *OKTIME;
@property (nonatomic,strong)NSString *PRONUM;            // 项目编号
@property (nonatomic,strong)NSString *UDINSPOID;
@property (nonatomic,strong)NSString *UDLOCNUM;
@property (nonatomic,strong)NSString *ALLTIME;
@property (nonatomic,strong)NSString *INSPOBY;
@property (nonatomic,strong)NSString *MODELTYPE;         // 风机型号
@property (nonatomic,strong)NSString *NAME2;
@property (nonatomic,strong)NSString *NAME;
@property (nonatomic,strong)NSString *RESBY;
@property (nonatomic,strong)NSString *NEXTRUNDATE;       // 下次巡查时间
@property (nonatomic,strong)NSString *INSPONUM;          // 编号
@property (nonatomic,strong)NSString *INSPOBY2;
@property (nonatomic,strong)NSString *STARTTIME;         // 计划开始日期
@end
