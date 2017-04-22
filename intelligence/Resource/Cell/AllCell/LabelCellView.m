//
//  LabelCellView.m
//  intelligence
//
//  Created by chris on 16/8/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "LabelCellView.h"

@implementation LabelCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content.enabled = NO;
}
+(instancetype)labelCellView{
    return [[[NSBundle mainBundle]loadNibNamed:@"LabelCellView" owner:nil options:nil] lastObject];
}
-(void)setItem:(PersonalSettingItem *)item{
    _item = item;
    self.name.text = item.title;
    self.content.text = item.content;
    self.content.enabled = NO;
}

@end
