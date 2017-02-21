//
//  UIBarButtonItem+Extension.h
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  自定义barButtonItem
 *
 *  @param imageName     图片的名字
 *  @param highImageName 高亮图片的名字
 *  @param target        目标
 *  @param action        方法
 *
 *  @return barButtonItem对象
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
