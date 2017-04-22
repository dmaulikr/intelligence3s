//
//  ApprovalPopupSheetFrontView.m
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ApprovalPopupSheetFrontView.h"

@implementation ApprovalPopupSheetFrontView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ApprovalPopupSheetFrontView" owner:nil options:nil] lastObject];
}

@end
