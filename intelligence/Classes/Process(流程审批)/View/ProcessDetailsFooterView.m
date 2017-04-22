//
//  ProcessDetailsFooterView.m
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProcessDetailsFooterView.h"

@implementation ProcessDetailsFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProcessDetailsFooterView" owner:nil options:nil] lastObject];
}

@end
