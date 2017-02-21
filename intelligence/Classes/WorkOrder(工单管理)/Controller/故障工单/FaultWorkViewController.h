//
//  FaultWorkViewController.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "FauWorkModel.h"
@interface FaultWorkViewController : ProfileSettingViewController
@property void (^updataModel)();
@property (nonatomic,strong)FauWorkModel *stock;
@property (nonatomic,copy)NSString *objectname;
@end
