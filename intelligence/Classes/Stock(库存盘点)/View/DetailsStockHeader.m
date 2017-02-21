//
//  DetailsStockHeader.m
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
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
