//
//  LeftViewCell.m
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(NSDictionary *)data{
    self.title.text = data[@"title"];
    self.image.image = [UIImage imageNamed:data[@"icon"]];
}

+(instancetype)leftViewCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"LeftViewCell" owner:nil options:nil] lastObject];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
