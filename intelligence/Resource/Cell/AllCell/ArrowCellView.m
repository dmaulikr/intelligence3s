//
//  ArrowCellView.m
//  intelligence
//
//  Created by chris on 16/8/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ArrowCellView.h"

@implementation ArrowCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img.userInteractionEnabled = NO;
}
+(instancetype)arrowCellView{
    return [[[NSBundle mainBundle]loadNibNamed:@"ArrowCellView" owner:nil options:nil] lastObject];
}
-(void)setItem:(PersonalSettingItem *)item{
    _item = item;
    self.name.text = item.title;
    self.content.text = item.content;
    if (item.icon.length == 0) {
       item.icon = @"more_next_icon";
    }
    [self.img setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
    self.content.enabled = NO;
    self.identify.hidden = !item.isStar;
}
@end
