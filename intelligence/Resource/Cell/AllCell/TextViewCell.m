//
//  TextViewCell.m
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 105, CELLHEIGHT-1)];
    self.name.font = font(16);
    self.name.numberOfLines = 0;
    self.name.contentMode = UIViewContentModeCenter;
    [self addSubview:self.name];
    
    //*
    self.identify = [[UILabel alloc]init];
    self.identify.text = @"*";
    self.identify.font = font(16);
    self.identify.textColor = [UIColor redColor];
    self.identify.textAlignment = NSTextAlignmentCenter;
    self.identify.frame = CGRectMake(2, 0, 7, 15);
    self.identify.centerY = self.name.centerY + 2;
    [self addSubview:_identify];
    //    self.content = [[SHTextView alloc] initWithFrame:CGRectMake(_name.right+2, 0, ScreenWidth - _name.right - 10, 35)];
    self.link = [[UIView alloc] init];
    self.link.backgroundColor = UIColorFromRGB(0x616161);
    [self addSubview:self.link];
    [self.link mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(8);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
    
    self.content = [[SHTextView alloc] init];
    //    self.content.scrollEnabled = NO;
    self.content.font = [UIFont systemFontOfSize:16.0];
    self.content.placeholder = @"暂无数据";
    self.content.placeholderColor = RGBCOLOR(193, 192, 199);
    self.content.isCanExtend = YES;
    self.content.extendDirection = ExtendUp;
    self.content.delegate = self;
    self.content.extendLimitRow = 2;
    [self addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(3);
        make.left.equalTo(self.name.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.link.mas_top).offset(-3);
    }];
    [self addSubview:self.content];
    UIView *links = [[UIView alloc]initWithFrame:CGRectMake(0, CELLHEIGHT - 1, ScreenWidth, 1)];
    links.backgroundColor = RGBCOLOR(241, 241, 241);
    [self addSubview:links];
}

-(void)setItem:(PersonalSettingItem *)item{
    _item = item;
    self.name.text = item.title;
    if (!item.click) {
        self.link.hidden = YES;
    }else{
        self.link.hidden = NO;
    }
    self.content.text = item.content;
    self.content.editable  = item.click;
    self.identify.hidden = !item.isStar;
}
//结束
- (void)endChange{
    self.link.backgroundColor = RGBCOLOR(97, 97, 97);
    if (self.content.text.length > 0) {
        self.content.placeholder = @" ";
    }else{
        self.content.placeholder = @"暂无数据";
    }
    if (self.updata) {
        self.updata(self.content.text);
    }
}
//开始
-(void)beginChange{
    self.content.placeholder = @" ";
    self.link.backgroundColor = [UIColor greenColor];
}


@end
