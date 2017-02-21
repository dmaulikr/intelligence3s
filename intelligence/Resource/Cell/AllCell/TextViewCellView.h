//
//  TextViewCellView.h
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface TextViewCellView : UICollectionReusableView<SHTextViewDelegate>
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 内容*/
@property (weak, nonatomic) IBOutlet SHTextView *content;

/** 线*/
@property (weak, nonatomic) IBOutlet UIView *link;

@property (nonatomic,strong)PersonalSettingItem *item;

@property (nonatomic, copy) void(^executeChangeHeight)(CGFloat cellHeight);

+(instancetype)textViewCellView;
@end
