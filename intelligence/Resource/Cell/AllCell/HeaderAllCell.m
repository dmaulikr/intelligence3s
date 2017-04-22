//
//  HeaderAllCell.m
//  intelligence
//
//  Created by chris on 16/8/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "HeaderAllCell.h"

@implementation HeaderAllCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)headerAllCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"HeaderAllCell" owner:nil options:nil] lastObject];
}
@end
