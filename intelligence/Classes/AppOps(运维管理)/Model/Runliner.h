//
//  Runliner.h
//  intelligence
//
//  Created by chris on 2016/11/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Runliner : NSObject

@property (nonatomic,strong)NSString * UDRUNLINERID;//id
@property (nonatomic,strong)NSString * UDRUNLOGLINENUM;//
@property (nonatomic,strong)NSString * LOGDATE;//日期
@property (nonatomic,strong)NSString * NEWDESC;//描述
@property (nonatomic,strong)NSString * WEATHER;//天气
@property (nonatomic,strong)NSString * TEM;//温度℃
@property (nonatomic,strong)NSString * WINDSPEED;//平均风速(m/s)
@property (nonatomic,strong)NSString * PERSONATTNUM;//人员考勤编号
@property (nonatomic,strong)NSString * WORKNUM;//工作序号
@property (nonatomic,strong)NSString * WORKPG;//工作班成员
@property (nonatomic,strong)NSString * WORKTYPE;//工作性质
@property (nonatomic,strong)NSString * WORKCRON;//工作任务
@property (nonatomic,strong)NSString * COMPSTA;//完成情况
@property (nonatomic,strong)NSString * REMARK;//备注
@property (nonatomic,strong)NSString * TYPE;
@property (nonatomic,strong)NSString * LOGNUM;//运行日志编号

@end
