//
//  ChoiceWorkView.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ChoiceWorkView : UIView
@property (nonatomic,copy)void (^WorkBlock)(NSString *str);
-(id)initWithFrame:(CGRect)frame choice:(ChoiceType)choice;
/** 展示到view上*/
-(void)ShowInView:(UIView *)view;
@end
