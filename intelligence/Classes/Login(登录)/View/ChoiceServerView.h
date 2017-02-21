//
//  ChoiceServerView.h
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptView.h"
@interface ChoiceServerView : UIView
@property (nonatomic,strong)PromptView *chooseView; //弹出框
@property (nonatomic,copy)void (^serverBlock)(NSString *str);
-(id)initWithFrame:(CGRect)frame withNumber:(NSInteger)number;
/** 展示到view上*/
-(void)ShowInView:(UIView *)view;
@end
