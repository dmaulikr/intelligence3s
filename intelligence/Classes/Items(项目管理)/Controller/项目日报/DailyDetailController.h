//
//  DailyDetailController.h
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BasePushViewController.h"
#import "DailyModel.h"

@interface DailyDetailController : BasePushViewController

@property (nonatomic, strong) DailyModel *daily;

@property (nonatomic, copy) NSString *PRORUNLOGNUM;


@end
