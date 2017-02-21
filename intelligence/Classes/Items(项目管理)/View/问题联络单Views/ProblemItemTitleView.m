//
//  ProblemItemTitleView.m
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProblemItemTitleView.h"

@implementation ProblemItemTitleView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProblemItemTitleView" owner:nil options:nil] lastObject];
}

@end
