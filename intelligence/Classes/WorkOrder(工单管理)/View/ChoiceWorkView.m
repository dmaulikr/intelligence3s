//
//  ChoiceWorkView.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
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
        backgroundView.backgroundColor = [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.4];
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
        
        switch (choice) {
            case ChoiceTypeFR:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 532 < ScreenHeight - 140?532:ScreenHeight - 140);
            }break;
            case ChoiceTypeDailYear:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 290);
            }break;
            case ChoiceTypeDailMonth:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 530);
            }break;

            case ChoiceTypeTP:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 160);
            }break;
            case ChoiceTypeFaultType:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 280);
            }break;
            case ChoiceTypeFaultTypeDegree:
            case ChoiceTypeProjectPhase:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 200);
            }break;
            case ChoiceTypeMaintain:
            case ChoiceTypeCompletion:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 160);
            }break;
            case ChoiceTypeFaultFaultType:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 280< ScreenHeight - 140?280:ScreenHeight - 140);
            }break;
            case ChoiceTypeJiGai:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 160);
            }break;
            case ChoiceTypeFaultState:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 160);
            }break;
                
            case ChoiceTypeOil:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 360 < ScreenHeight - 140?360:ScreenHeight - 140);
            }break;
                
            case ChoiceTypePollingAll:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 320 < ScreenHeight - 140?320:ScreenHeight - 140);
            }break;
                
            case ChoiceTypeDiJian:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 160);
            }break;
            case ChoiceTypeBANH:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 200);
            }break;
            case ChoiceTypeWeather:
            case ChoiceTypeToolingType:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 440 < ScreenHeight - 140?440:ScreenHeight - 140);
            }break;
            case ChoiceTypeNatureWork:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 360 < ScreenHeight - 140?360:ScreenHeight - 140);
            }break;
            case ChoiceTypeDC:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 280);
            }break;
                
            default:{
                workPopView.frame = CGRectMake(0, ScreenHeight, ScreenWidth - 85, 369 < ScreenHeight - 140?369:ScreenHeight - 140);
            }break;
                
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
