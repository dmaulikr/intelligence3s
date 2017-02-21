//
//  TextViewCellView.m
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "TextViewCellView.h"

@implementation TextViewCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content.font = [UIFont systemFontOfSize:16.0];
    self.content.placeholder = @"暂无数据";
    self.content.placeholderColor = UIColorFromRGB(0xF0F0F0);
    self.content.isCanExtend = YES;
    self.content.extendDirection = ExtendUp;
    self.content.extendLimitRow = 2;
    self.content.delegate = self;
    
}

+(instancetype)textViewCellView{
    return [[[NSBundle mainBundle]loadNibNamed:@"TextViewCellView" owner:nil options:nil] lastObject];
}

-(void)setItem:(PersonalSettingItem *)item{
    self.content.delegate = self;
    _item = item;
    self.name.text = item.title;
    if (!item.isShow) {
        self.content.text = item.content;
    }

    
}
//结束
- (void)endChange{
    self.link.backgroundColor = RGBCOLOR(97, 97, 97);
    if (self.content.text.length > 0) {
        self.content.placeholder = @" ";
    }else{
        self.content.placeholder = @"暂无数据";
    }
}
//开始
-(void)beginChange{
    self.content.placeholder = @" ";
    self.link.backgroundColor = RGBCOLOR(7, 62, 139);
}

@end
