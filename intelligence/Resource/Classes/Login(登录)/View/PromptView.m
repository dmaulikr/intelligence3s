//
//  PromptView.m
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "PromptView.h"

@implementation PromptView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)promptView{
    return [[[NSBundle mainBundle]loadNibNamed:@"PromptView" owner:nil options:nil] lastObject];
}
@end
