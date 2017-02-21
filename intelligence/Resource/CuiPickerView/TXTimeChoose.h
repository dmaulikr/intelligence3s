//
//  TXTimeChoose.h
//  TYSubwaySystem
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 TXZhongJiaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TXTimeDelegate <NSObject>
//当时间改变时触发
- (void)changeTime:(NSDate *)date;
//确定时间
- (void)determine:(NSDate *)date;

@end

@interface TXTimeChoose : UIView
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type;
//设置初始时间
- (void)setNowTime:(NSString *)dateStr;

// NSDate --> NSString
- (NSString*)stringFromDate:(NSDate*)date;
//NSDate <-- NSString
- (NSDate*)dateFromString:(NSString*)dateString;

@property (assign,nonatomic)id<TXTimeDelegate>delegate;
@property (nonatomic,copy)void (^backString)(NSDate * data);
@end
