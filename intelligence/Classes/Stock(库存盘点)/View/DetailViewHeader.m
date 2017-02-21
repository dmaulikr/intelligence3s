//
//  DetailViewHeader.m
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
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
