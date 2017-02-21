//
//  PersonalSettingCell.h
//  NoarterClient
//
//  Created by noarter02 on 15-2-2.
//  Copyright (c) 2015年 whj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewCellView.h"
#import "ArrowCellView.h"
#import "LabelCellView.h"
#import "TextViewCell.h"
#import "ChoiceViewCell.h"
#import "LabelsViewCell.h"
@class PersonalSettingItem;
@interface PersonalSettingCell : UITableViewCell
@property (nonatomic,copy) void (^updataSelect)(NSString *);
@property (nonatomic,copy) void (^updata)(NSString *);
@property (nonatomic, strong) PersonalSettingItem *item;
//textView
@property (nonatomic, strong) TextViewCellView *textView;
//图片(箭头)
@property (nonatomic, strong) ArrowCellView *arrowView;
//文字
@property (nonatomic, strong) LabelCellView *labelView;
//textview
@property (nonatomic, strong)TextViewCell *textViews;
//选择
@property (nonatomic, strong)ChoiceViewCell *choice;
//显示Label
@property (nonatomic, strong)LabelsViewCell *labels;

+ (id)settingCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^executeSetupHeight)(CGFloat cellHeight);


@end
