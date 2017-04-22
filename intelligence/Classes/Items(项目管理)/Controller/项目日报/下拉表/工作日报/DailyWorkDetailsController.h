//
//  DailyWorkDetailsController.h
//  intelligence
//
//  Created by chris on 16/9/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BasePushViewController.h"
#import "DailyWorkModel.h"

@interface DailyWorkDetailsController : BasePushViewController
@property (nonatomic, strong) DailyWorkModel *dailyWork;
@property (nonatomic, strong) NSString* PRORUNLOGNUM;
@end
