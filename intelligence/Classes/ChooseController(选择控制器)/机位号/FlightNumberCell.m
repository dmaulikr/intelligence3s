//
//  FlightNumberCell.m
//  intelligence
//
//  Created by chris on 16/10/25.
//  Copyright © 2016年 chris. All rights reserved.
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
