//
//  TextViewCell.h
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface TextViewCell : UIView<SHTextViewDelegate>
/** 名字*/
@property (strong, nonatomic)  UILabel *name;
/** 内容*/
@property (strong, nonatomic)  SHTextView *content;
/** 线*/
@property (strong, nonatomic)  UIView *link;
/** 星号*/
@property (nonatomic, strong) UILabel *identify;

@property (nonatomic,strong)PersonalSettingItem *item;

@property (nonatomic,copy) void (^updata)(NSString *);
@property (nonatomic, copy) void(^executeChangeHeight)(CGFloat cellHeight);
@end
/*
  - (void)createUI{
 self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
 [self addSubview:self.name];
 //    self.content = [[SHTextView alloc] initWithFrame:CGRectMake(_name.right+2, 0, ScreenWidth - _name.right - 10, 35)];
 self.link = [[UIView alloc] init];
 self.link.backgroundColor = UIColorFromRGB(0x616161);
 [self addSubview:self.link];
 [self.link mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(self.name.mas_right).offset(2);
 make.right.equalTo(self.mas_right).offset(-10);
 make.bottom.equalTo(self.mas_bottom).offset(-3);
 make.height.mas_equalTo(1);
 }];
 
 self.content = [[SHTextView alloc] init];
 //    self.content.scrollEnabled = NO;
 self.content.font = [UIFont systemFontOfSize:16.0];
 self.content.placeholder = @"暂无数据";
 self.content.placeholderColor = UIColorFromRGB(0xF0F0F0);
 self.content.placeholderColor = [UIColor grayColor];
 self.content.isCanExtend = YES;
 self.content.extendDirection = ExtendDown;
 self.content.extendLimitRow = 4;
 [self addSubview:self.content];
 [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(self.mas_top).offset(3);
 make.left.equalTo(self.name.mas_right).offset(2);
 make.right.equalTo(self.mas_right).offset(-10);
 make.bottom.equalTo(self.link.mas_top).offset(2);
 }];
 [self addSubview:self.content];
 
 }
 
 -(void)setItem:(PersonalSettingItem *)item{
 _item = item;
 self.name.text = item.title;
 self.content.text = item.content;
 self.content.placeholder = @"暂无数据";
 self.content.delegate = self;
self.content.isCanExtend = YES;
//    self.content.scrollEnabled = NO;
self.content.extendLimitRow = 4;
self.content.extendDirection = ExtendDown;
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
//高度变化
-(void)changeheight:(BOOL)height{
    if (self.executeChangeHeight) {
        self.executeChangeHeight(self.content.height + 13);
    }
}
@end




*/