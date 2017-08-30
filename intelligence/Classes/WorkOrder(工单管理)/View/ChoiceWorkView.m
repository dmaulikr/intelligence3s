//
//  ChoiceWorkView.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ChoiceWorkView.h"
#import "WorkPopView.h"

@interface ChoiceWorkView()
{
    UIView *backgroundView;//背景
    WorkPopView *workPopView; //弹出框
}
@end
@implementation ChoiceWorkView

-(id)initWithFrame:(CGRect)frame choice:(ChoiceType)choice{
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
        workPopView = [WorkPopView workPopView];
        [workPopView addData:choice];
        workPopView.WorkBlock = ^(NSString *str){
            if (weakSelf.WorkBlock) {
                weakSelf.WorkBlock(str);
            }
            [weakSelf CancelButtonAction];
        };
        if([workPopView.dataArray count]>12){
            
            workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 480);
            
        }else{
            workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, [workPopView.dataArray count]*40+44);
        }
        
        workPopView.center_X = self.center_X;
        [self addSubview:workPopView];
        [self initUI];
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame dataArray:(NSArray*) dataArray{
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
        workPopView = [WorkPopView workPopView];
        workPopView.dataArray = dataArray;
        workPopView.WorkBlock = ^(NSString *str){
            if (weakSelf.WorkBlock) {
                weakSelf.WorkBlock(str);
            }
            [weakSelf CancelButtonAction];
        };
        if([workPopView.dataArray count]>12){
            
            workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 480);
            
        }else{
            workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, [workPopView.dataArray count]*40+44);
        }
        
        workPopView.center_X = self.center_X;
        [self addSubview:workPopView];
        [self initUI];
        
    }
    return self;
}
- (void)initUI {
    
    [UIView animateWithDuration:0.25 animations:^{
        workPopView.center_Y = self.center_Y;
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
        workPopView.y_Y =  ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
