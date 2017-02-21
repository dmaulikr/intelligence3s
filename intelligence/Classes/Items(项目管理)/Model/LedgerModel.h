//
//  LedgerModel.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
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

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger leftLabelWight;


@end
