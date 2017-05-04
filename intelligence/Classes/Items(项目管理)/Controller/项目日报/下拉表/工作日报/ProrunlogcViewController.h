//
//  ProrunlogcViewController.h
//  intelligence
//
//  Created by chris on 2017/4/17.
//  Copyright © 2017年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePushViewController.h"
#import "UDPRORUNLOGC.h"
#import "DailyWorkModel.h"
@interface ProrunlogcViewController : BasePushViewController

@property (nonatomic, copy) NSString *requestStr;

@property (nonatomic, copy) NSString *PRORUNLOGNUM;

@property (nonatomic, copy) NSString *RUNLOGDATE;

@property (nonatomic, strong) DailyWorkModel *dailyWork;
@end
