//
//  CheckWorkViewController.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "FauWorkModel.h"
#import "WfmListanceListViewController.h"
@interface CheckWorkViewController : ProfileSettingViewController
@property (nonatomic,strong)FauWorkModel *stock;
@property (nonatomic,copy)NSString *objectname;
@property (nonatomic,copy)void (^blackBlock)(NSString *);

@end
