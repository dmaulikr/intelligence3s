//
//  StockQueryTableViewCell.m
//  intelligence
//
//  Created by chris on 2016/12/2.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "StockQueryTableViewCell.h"

@implementation StockQueryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bview.layer setCornerRadius:10];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStockQueryModel:(StockQuery *)stockQueryModel
{
    self.ITEMDESC.text=stockQueryModel.ITEMNUM;
    self.ITEMNUM.text=stockQueryModel.ITEMDESC.length>0?stockQueryModel.ITEMDESC:@"_";
    self.LOCATIONDESC.text=stockQueryModel.LOCATIONDESC.length>0?stockQueryModel.LOCATIONDESC:@"_";
    self.LOCATION.text=stockQueryModel.LOCATION;
    self.CURBAL.text=stockQueryModel.CURBAL;
    self.UNIT.text=stockQueryModel.ITEMUNIT.length>0?stockQueryModel.ITEMUNIT:@"_";
    self.BINNUM.text=stockQueryModel.BINNUM;
    //self.ITEMNUM.text=stockQueryModel.ITEMNUM;
}
@end
