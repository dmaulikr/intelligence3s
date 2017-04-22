//
//  AddCheckViewController.h
//  intelligence
//
//  Created by chris on 16/8/9.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"

@interface AddCheckViewController : ProfileSettingViewController
@property (nonatomic,copy) void (^OpenCheck)(NSDictionary *);
@end
