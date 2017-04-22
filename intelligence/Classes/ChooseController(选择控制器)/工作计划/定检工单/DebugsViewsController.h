//
//  DebugsViewsController.h
//  intelligence
//
//  Created by chris on 16/9/10.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "WorkDebugsModel.h"
@interface DebugsViewsController : ProfileSettingViewController
@property (nonatomic,strong)WorkDebugsModel *model;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)void (^backModels)(WorkDebugsModel *);
@end
