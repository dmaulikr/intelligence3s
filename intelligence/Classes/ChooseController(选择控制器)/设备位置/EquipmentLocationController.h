//
//  EquipmentLocationController.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "EquipmentLocationModel.h"

@interface EquipmentLocationController : BaseSearchViewController

@property (nonatomic, copy) void(^executeCellClick)(EquipmentLocationModel *);
@property (nonatomic, copy) NSString *requestCoding1;  // 项目编号
@property (nonatomic, copy) NSString *requestCoding2;  // 机位号

@end
