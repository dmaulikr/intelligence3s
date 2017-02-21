//
//  NSString+FindFace.h
//  LYCoreLabelDemo
//
//  Created by LYoung on 15/9/24.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FindFace)

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  返回当前时间
 *
 *  @param typeStr    显示的字体 yyyy-MM-dd HH:mm:ss
 *
 *  @return 占用的宽高
 */
+ (NSString *)getCurrentTimeWithType:(NSString *)typeStr;



@end
