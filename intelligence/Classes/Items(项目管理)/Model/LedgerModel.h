//
//  LedgerModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LedgerModel : NSObject
@property (nonatomic,strong)NSString *CONTRACTSTATUS;  // 合同状态
@property (nonatomic,strong)NSString *BRANCH;          // 所属中心
@property (nonatomic,strong)NSString *CAPACITY;        // 总厂容量
@property (nonatomic,strong)NSString *RESPONSNAME;     // 责任人
@property (nonatomic,strong)NSString *DESCRIPTION;     // 项目名称
@property (nonatomic,strong)NSString *BRANCHDESC;
@property (nonatomic,strong)NSString *RESPONSPHONE;
@property (nonatomic,strong)NSString *RESPONS;
@property (nonatomic,strong)NSString *SIGNDATE;        // 签订时间
@property (nonatomic,strong)NSString *SITEID;
@property (nonatomic,strong)NSString *PRONUM;          // 项目编号
@property (nonatomic,strong)NSString *PERIOD;          // 保质期
@property (nonatomic,strong)NSString *PROSTAGE;        // 当前阶段
@property (nonatomic,strong)NSString *TESTPRO;         // 项目试点
@property (nonatomic,strong)NSString *OWNER;           // 业主单位
@property (nonatomic,strong)NSString *UDPROID;

@property (nonatomic,strong)NSString *WINDSPEED3;
@property (nonatomic,strong)NSString *WINDSPEED1;
@property (nonatomic,strong)NSString *WINDSPEED2;
@property (nonatomic,strong)NSString *TEMPERATURE1;
@property (nonatomic,strong)NSString *TEMPERATURE2;

@property (nonatomic,strong)NSString *BOND;
@property (nonatomic,strong)NSString *TRANSPORT;
@property (nonatomic,strong)NSString *ADDRESS;
@property (nonatomic,strong)NSString *EXPRESSWAY;
@property (nonatomic,strong)NSString *LOGISTICSCONT;
@property (nonatomic,strong)NSString *TPOP;

@property (nonatomic,strong)NSString *CYCLE;
@property (nonatomic,strong)NSString *REQ1;
@property (nonatomic,strong)NSString *REQ2;
@property (nonatomic,strong)NSString *UTILIZATION;
@property (nonatomic,strong)NSString *SPECIALCON;
@property (nonatomic,strong)NSString *REMARKS;
@property (nonatomic,strong)NSString *LOCDESC;
@property (nonatomic,strong)NSString *LOCATION;

@end
