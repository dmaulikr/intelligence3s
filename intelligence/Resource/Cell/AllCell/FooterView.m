//
//  FooterView.m
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = self.cancelBtn.height_H *0.5;
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = self.saveBtn.height_H * 0.5;
}
+(instancetype)footerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil] lastObject];
}
@end
