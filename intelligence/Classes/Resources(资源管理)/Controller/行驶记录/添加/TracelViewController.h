//
//  TracelViewController.h
//  intelligence
//
//  Created by chris on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"

@interface TracelViewController : ProfileSettingViewController
@property (nonatomic,copy)void (^backModel)(NSDictionary *);
@end
