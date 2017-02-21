//
//  NSString+FindFace.m
//  LYCoreLabelDemo
//
//  Created by LYoung on 15/9/24.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "NSString+FindFace.h"
#import <UIKit/UIKit.h>

@implementation NSString (FindFace)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

+ (NSString *)getCurrentTimeWithType:(NSString *)typeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = typeStr;
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}

@end
