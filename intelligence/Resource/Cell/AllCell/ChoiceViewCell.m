//
//  ChoiceViewCell.m
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ChoiceViewCell.h"

@implementation ChoiceViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)choiceViewCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"ChoiceViewCell" owner:nil options:nil] lastObject];
}
-(void)setItem:(PersonalSettingItem *)item{
    _item = item;
    self.name.text = item.title;
    if ([item.content isEqualToString:@"已提交"]||[item.content isEqualToString:@"1"]) {
        self.choice.selected = YES;
    }else{
        self.choice.selected = NO;
    }
//    self.choice.enabled = item.click;
}

- (IBAction)choiceClick:(id)sender {
    if (!_item.click) {
        return;
    }
    
    if (self.choice.selected) {
        _item.content = @"0";
    }else{
        _item.content = @"1";
    }
    self.choice.selected = !self.choice.selected;
    if (self.updataChoice) {
        self.updataChoice(_item.content);
    }
}

@end
