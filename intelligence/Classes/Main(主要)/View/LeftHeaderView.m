//
//  LeftHeaderView.m
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "LeftHeaderView.h"

@implementation LeftHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.header.layer.masksToBounds = YES;
    self.header.layer.cornerRadius = self.header.width_W *0.5;
}

+(instancetype)leftHeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:@"LeftHeaderView" owner:nil options:nil] lastObject];
}
@end
