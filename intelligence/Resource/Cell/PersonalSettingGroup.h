//
//  PersonalSettingGroup.h
//  NoarterClient
//
//  Created by noarter02 on 15-2-2.
//  Copyright (c) 2015年 whj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalSettingGroup : NSObject
@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, strong) NSArray *items; // 中间的条目
@end
