//
//  AddCheckViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"

@interface AddCheckViewController : ProfileSettingViewController
@property (nonatomic,copy) void (^OpenCheck)(NSDictionary *);
@end
