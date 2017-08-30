//
//  ChoicDateView.m
//  intelligence
//
//  Created by chris on 2017/8/21.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "ChoicDateView.h"
@interface ChoicDateView()
{
    UIView *backgroundView;//背景
    UIDatePicker *datePicker; //日期选择
}
@end
@implementation ChoicDateView

-(id)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode{
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        //背景颜色
        backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:96/255.00f green:96/255.00f blue:96/255.00f alpha:0.6];
        [self addSubview:backgroundView];
        //手机
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelButtonAction)];
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        //弹出框
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth - 85, 280)];
        datePicker.datePickerMode = datePickerMode;
        [datePicker setBackgroundColor:[UIColor whiteColor]];
//        workPopView.WorkBlock = ^(NSString *str){
//            if (weakSelf.WorkBlock) {
//                weakSelf.WorkBlock(str);
//            }
//            [weakSelf CancelButtonAction];
//        };

        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.center_X = self.center_X;
        [self addSubview:datePicker];
        [self initUI];
        
    }
    return self;
}
-(void)datePickerValueChanged:(id)sender
{
    NSDate * date=datePicker.date;
    if (self.dateBlock) {
        self.dateBlock(date);
        [self CancelButtonAction];
    }
}
- (void)initUI {
    
    [UIView animateWithDuration:0.25 animations:^{
        datePicker.center_Y = self.center_Y;
    } completion:^(BOOL finished) {
        
    }];
    
}

/** 展示到view上*/
-(void)ShowInView:(UIView *)view
{
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
}

/** 取消按钮动画*/
-(void)CancelButtonAction
{
    [backgroundView removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        datePicker.y_Y =  ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
