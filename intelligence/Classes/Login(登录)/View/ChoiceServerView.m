//
//  ChoiceServerView.m
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ChoiceServerView.h"


@interface ChoiceServerView()
{
    UIView *backgroundView;//背景
}

@end
@implementation ChoiceServerView

-(id)initWithFrame:(CGRect)frame withNumber:(NSInteger)number{
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        //背景颜色
        backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundView];
        //手机
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelButtonAction)];
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        //弹出框
        _chooseView = [PromptView promptView];
        if (number == 1) {
            _chooseView.btn1.selected = YES;
            _chooseView.btn2.selected = NO;
            _chooseView.btn3.selected = NO;
            _chooseView.btn4.selected = NO;
        }else if (number == 2){
            _chooseView.btn1.selected = NO;
            _chooseView.btn2.selected = YES;
            _chooseView.btn3.selected = NO;
            _chooseView.btn4.selected = NO;
        }else if (number == 3){
            _chooseView.btn1.selected = NO;
            _chooseView.btn2.selected = NO;
            _chooseView.btn3.selected = YES;
            _chooseView.btn4.selected = NO;
        }else if (number == 4){
            _chooseView.btn1.selected = NO;
            _chooseView.btn2.selected = NO;
            _chooseView.btn3.selected = NO;
            _chooseView.btn4.selected = YES;
        }
        _chooseView.serverBlock = ^(NSString *str){
            if (weakSelf.serverBlock) {
                weakSelf.serverBlock(str);
            }
            [weakSelf CancelButtonAction];
        };
        _chooseView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 40, 122);
        _chooseView.center_X = self.center_X;
        [self addSubview:_chooseView];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    [UIView animateWithDuration:0.25 animations:^{
        _chooseView.center_Y = self.center_Y;
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
        _chooseView.y_Y =  ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
