//
//  PersonalSettingCell.m
//  NoarterClient
//
//  Created by noarter02 on 15-2-2.
//  Copyright (c) 2015年 whj. All rights reserved.
//

#import "PersonalSettingCell.h"
#import "PersonalSettingItem.h"
@interface PersonalSettingCell ()
{
    UIImageView *_arrow;
    UIView *_view;
    UIButton *_button;
   
}

@end
@implementation PersonalSettingCell

/** 初始化*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addAllSubViews];
    }
    return self;
}

//先将所有控件添加进来
-(void)addAllSubViews{
    WEAKSELF
    /** textView*/
    self.textViews = [[TextViewCell alloc]init];
    self.textViews.updata = ^(NSString *str){
        if (weakSelf.updata) {
            weakSelf.updata(str);
        }
    };
    
    /** 图片(箭头)*/
    self.arrowView = [ArrowCellView arrowCellView];
    
    /** 文字*/
    self.labelView = [LabelCellView labelCellView];
    
    /** 选择*/
    self.choice = [ChoiceViewCell choiceViewCell];
    
    self.choice.updataChoice = ^(NSString *str){
        if (weakSelf.updataSelect) {
            weakSelf.updataSelect(str);
        }
    };
    self.labels = [LabelsViewCell labelsViewCell];
    
    
    
    
    
    
}

//藏隐
-(void)hidenAllSubViews{
    self.textView.hidden  = YES;
    self.arrowView.hidden = YES;
    self.labelView.hidden = YES;
    self.textViews.hidden = YES;
    self.choice.hidden    = YES;
    self.labels.hidden    = YES;
}

- (void)setItem:(PersonalSettingItem *)item
{
    _item = item;
    //隐藏
    [self hidenAllSubViews];
    
    if (item.type == PersonalSettingItemTypeArrow) {
        
        [self.contentView addSubview:_arrowView];
        [self addArrowView];
    }else if (item.type == PersonalSettingItemTypeLabel){
       
        [self.contentView addSubview:_labelView];
         [self addLabelView];
    }else if (item.type == PersonalSettingItemTypeText){
       
        [self.contentView addSubview:_textViews];
         [self addtext];
    }else if (item.type == PersonalSettingItemTypeChoice){
        
        [self.contentView addSubview:_choice];
        [self addChoice];
    }else if (item.type == PersonalSettingItemTypeLabels){
       
        [self.contentView addSubview:_labels];
         [self addLabels];
    }
}
//纯文字
-(void)addLabels{
    self.labels.hidden = NO;
    self.labels.item = _item;
    //1.添加约束
    [self.labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

//choice
-(void)addChoice{
    self.choice.hidden = NO;
    self.choice.item = _item;
    //1.添加约束
    [self.choice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

//textView
-(void)addtext{
    self.textViews.hidden = NO;
    self.textViews.item = _item;
    //1.添加约束
    [self.textViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

/** textView*/
- (void)addTextView{
    self.textView.hidden = NO;
    self.textView.item = _item;
    //1.添加约束
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

/** 图片(箭头)*/
- (void)addArrowView{
    self.arrowView.hidden = NO;
    self.arrowView.item = _item;
    //1.添加约束
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}
/** 文字*/
- (void)addLabelView{
    self.labelView.hidden = NO;
    self.labelView.item = _item;
    //1.添加约束
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    PersonalSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[PersonalSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

@end
