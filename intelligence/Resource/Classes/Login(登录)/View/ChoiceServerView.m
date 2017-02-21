//
//  ChoiceServerView.m
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ChoiceServerView.h"
#import "PromptView.h"

@interface ChoiceServerView()
{
    UIView *backgroundView;//背景
    PromptView *chooseView; //弹出框
}

@end
@implementation ChoiceServerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景颜色
        backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundView];
        //手机
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelButtonAction)];
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        //弹出框
        chooseView = [PromptView promptView];
        chooseView.center_X = self.center_X;
        [self addSubview:chooseView];
        
        [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.height.mas_equalTo(163);
        }];
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    [UIView animateWithDuration:0.25 animations:^{
        chooseView.center_Y = self.center_Y;
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
        chooseView.y_Y =  ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
