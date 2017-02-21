//
//  NSDictionary+Description.m
//  WanWanEntertainment
//
//  Created by 任子丰 on 15/6/29.
//  Copyright (c) 2015年 wanwan. All rights reserved.
//

#import "NSDictionary+Description.h"

@implementation NSDictionary (Description)
/** 字典转字符串*/
- (NSString *)description
{
    NSMutableString *str = [[NSMutableString alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *tmp = [NSString stringWithFormat:@"  %@ : %@;\n",key,obj];
        [str appendString:tmp];
    }];
    return [NSString stringWithFormat:@"{\n%@\n}",str];
}
@end
