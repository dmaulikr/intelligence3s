//
//  FlightNumberCell.m
//  intelligence
//
//  Created by 光耀 on 16/10/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FlightNumberCell.h"

@implementation FlightNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)flightNumberCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"FlightNumberCell" owner:nil options:nil] lastObject];
}
-(void)setModel:(FlightNoModel *)model{
    _model = model;
    self.name.text = model.MODELTYPE;
}

@end
