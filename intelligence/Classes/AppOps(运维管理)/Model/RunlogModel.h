//
//  RunlogModel.h
//  intelligence
//
//  Created by chris on 2016/11/21.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunlogModel : NSObject
@property (nonatomic,strong)NSString * UDRUNLOGRID;//运行记录id
@property (nonatomic,strong)NSString * LOGNUM;//运行日志编号
@property (nonatomic,strong)NSString * DESCRIPTION;//描述
@property (nonatomic,strong)NSString * BRANCH;//中心编号
@property (nonatomic,strong)NSString * BRANCHDESC;//中心描述
@property (nonatomic,strong)NSString * PRONUM;//项目编号
@property (nonatomic,strong)NSString * PRODESC;//项目描述
@property (nonatomic,strong)NSString * YEAR;//年
@property (nonatomic,strong)NSString * MONTH;//月
@property (nonatomic,strong)NSString * PROHEAD;//负责人
@property (nonatomic,strong)NSString * NAME1;//负责人描述
@property (nonatomic,strong)NSString * CREATER;//录入人编号
@property (nonatomic,strong)NSString * CREATENAME;//录入人描述
@property (nonatomic,strong)NSString * CREATETIME;//录入时间
@end
