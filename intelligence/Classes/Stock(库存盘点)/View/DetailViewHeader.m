//
//  DetailViewHeader.m
//  intelligence
//
//  Created by chris on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DetailViewHeader.h"

@implementation DetailViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)detailViewHeader{
    return [[[NSBundle mainBundle]loadNibNamed:@"DetailViewHeader" owner:nil options:nil] lastObject];
}
@end
