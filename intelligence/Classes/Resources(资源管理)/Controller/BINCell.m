//
//  BINCell.m
//  intelligence
//
//  Created by chris on 2016/12/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BINCell.h"

@implementation BINCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectValue:(UISegmentedControl *)sender {
    
    NSString * string = @"无限制";
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            string = @"无限制";
            break;
        case 1:
            string = @"返修件";
            break;
        case 2:
            string = @"寄存件";
            break;
        case 3:
            string = @"坏件";
            break;
        case 4:
            string = @"所有";
            break;
        default:
            break;
    }
    if(self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(BINValueCheaneBIN:)]) {
            [self.delegate BINValueCheaneBIN:string];
        }
    }
}

@end
