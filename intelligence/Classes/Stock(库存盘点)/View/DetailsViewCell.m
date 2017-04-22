//
//  DetailsViewCell.m
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailsViewCell.h"

@implementation DetailsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)detailsViewCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"DetailsViewCell" owner:nil options:nil] lastObject];
}

-(void)setDetail:(DetailStockModel *)detail{
    _detail = detail;
    self.hangxiang.text = detail.ZPDROW;
    self.miaoshu.text = detail.MAKTX;
    self.number.text = detail.ACTUALQTY;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
