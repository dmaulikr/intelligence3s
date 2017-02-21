//
//  ApprovalPopupSheetBackView.m
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ApprovalPopupSheetBackView.h"

@implementation ApprovalPopupSheetBackView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    // Initialization code
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ApprovalPopupSheetBackView" owner:nil options:nil] lastObject];
}

@end
