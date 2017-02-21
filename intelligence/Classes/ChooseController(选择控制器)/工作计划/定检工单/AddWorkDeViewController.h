//
//  AddWorkDeViewController.h
//  intelligence
//
//  Created by 光耀 on 16/9/10.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "WorkDebugsModel.h"
@interface AddWorkDeViewController : ProfileSettingViewController
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)void (^backModel)(WorkDebugsModel *);
@end
