//
//  DetailsStockHeader.m
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailsStockHeader.h"

@implementation DetailsStockHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)detailsStockHeader{
    return [[[NSBundle mainBundle]loadNibNamed:@"DetailsStockHeader" owner:nil options:nil] lastObject];
}
@end
