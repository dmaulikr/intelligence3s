//
//  ProblemItemLBView.m
//  intelligence
//
//  Created by  on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemItemLBView.h"

@implementation ProblemItemLBView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chooseBtnClick:(UIButton *)sender{
    self.chooseBtn.selected = !self.chooseBtn.selected;
    
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProblemItemLBView" owner:nil options:nil] lastObject];
}

@end
