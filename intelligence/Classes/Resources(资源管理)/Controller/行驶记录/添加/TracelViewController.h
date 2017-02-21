//
//  TracelViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/3.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"

@interface TracelViewController : ProfileSettingViewController
@property (nonatomic,copy)void (^backModel)(NSDictionary *);
@end
