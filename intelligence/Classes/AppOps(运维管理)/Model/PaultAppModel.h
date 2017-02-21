//
//  PaultAppModel.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaultAppModel : NSObject
@property (nonatomic,strong)NSString *PRONUM;          // 项目编号
@property (nonatomic,strong)NSString *REPORTTIME;      // 提报时间
@property (nonatomic,strong)NSString *END_TIME;        // 故障结束时间
@property (nonatomic,strong)NSString *IS_END;
@property (nonatomic,strong)NSString *FAULT_CODE;
@property (nonatomic,strong)NSString *REPORTNUM;       // 编号
@property (nonatomic,strong)NSString *UDPBFORMNUM;
@property (nonatomic,strong)NSString *UDREPORTID;
@property (nonatomic,strong)NSString *CUDESCRIBE;
@property (nonatomic,strong)NSString *FAULT_CODEDESC;  // 故障类
@property (nonatomic,strong)NSString *FAULT_CODE1;
@property (nonatomic,strong)NSString *STATUSTYPE;      // 新建
@property (nonatomic,strong)NSString *LOCATION_CODE;   // 机位号
@property (nonatomic,strong)NSString *WONUM;
@property (nonatomic,strong)NSString *RESULT;
@property (nonatomic,strong)NSString *REMARK;
@property (nonatomic,strong)NSString *PRODESC;          // 项目名称
@property (nonatomic,strong)NSString *FAULT_CODE1DESC;  // 故障代码
@property (nonatomic,strong)NSString *ASSETLOC;         // 设备位置
@property (nonatomic,strong)NSString *CREATEBY;
@property (nonatomic,strong)NSString *HAPPEN_TIME;      // 保障时间
@property (nonatomic,strong)NSString *LOCATION;
@property (nonatomic,strong)NSString *UDGZDJ;           // 故障等级
@property (nonatomic,strong)NSString *FAULTTYPE;        // 故障类型
@property (nonatomic,strong)NSString *BRANCHDESC;       // 中心
@property (nonatomic,strong)NSString *CUISPLAN;
@property (nonatomic,strong)NSString *BRANCH;
@property (nonatomic,strong)NSString *UDGZTYPE;         
@property (nonatomic,strong)NSString *CULEVEL;
@property (nonatomic,strong)NSString *DESCRIPTION;      // 描述
@end
