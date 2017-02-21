//
//  PromptView.h
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptView : UICollectionReusableView
@property (nonatomic,copy)void (^serverBlock)(NSString *str);
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

+(instancetype)promptView;
@end
