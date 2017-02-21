//
//  DetailsMaintainViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "MaintainModel.h"
@interface DetailsMaintainViewController : ProfileSettingViewController
@property (nonatomic,strong)MaintainModel *maintain;
@property (nonatomic,copy)NSString *objectname;
@property (nonatomic,copy)void (^BackUpda)(NSDictionary *);
@end
