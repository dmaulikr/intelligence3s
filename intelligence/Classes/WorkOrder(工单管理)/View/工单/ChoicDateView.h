//
//  ChoicDateView.h
//  intelligence
//
//  Created by chris on 2017/8/21.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoicDateView : UIView
@property (nonatomic,copy)void (^dateBlock)(NSDate *date);
-(id)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode;
-(void)ShowInView:(UIView *)view;
@end
