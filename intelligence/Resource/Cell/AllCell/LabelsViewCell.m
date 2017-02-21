//
//  LabelsViewCell.m
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LabelsViewCell.h"

@implementation LabelsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(PersonalSettingItem *)item{
    _item = item;
    self.name.text = item.title;
    if([item.content isEqualToString:@"normal"]){
        self.content.text = @"正常维修";
    }else if ([item.content isEqualToString:@"maintain"]){
        self.content.text = @"事故维修";
    }else{
        self.content.text = item.content;
    }
    if (self.content.text.length ==0) {
        self.content.textColor = RGBCOLOR(193, 192, 199);
        self.content.text = @"暂无数据";
    }else{
        self.content.textColor = [UIColor blackColor];
    }
    
}

+(instancetype)labelsViewCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"LabelsViewCell" owner:nil options:nil] lastObject];
}
@end
