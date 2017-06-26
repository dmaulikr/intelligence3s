//
//  PersonalSettingItem.h
//  NoarterClient
//
//  Created by noarter02 on 15-2-2.
//  Copyright (c) 2015年 whj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemModel.h"

typedef enum {
    PersonalSettingItemTypeNone, // 什么也没有
    PersonalSettingItemTypeArrow, // 箭头
    PersonalSettingItemTypeLabel, // 文字
    PersonalSettingItemTypeChoice, //choice
    PersonalSettingItemTypeLabels, //纯文字
    
} PersonalSettingItemType;

@interface PersonalSettingItem : NSObject
//图片
@property (nonatomic, copy) NSString *icon;
//标题
@property (nonatomic, copy) NSString *title;
//内容
@property (nonatomic, copy) NSString *content;
//内容
@property (nonatomic, copy) NSString *FieldName;
// Cell的样式
@property (nonatomic, assign) PersonalSettingItemType type;
// 点击cell后要执行的操作
@property (nonatomic, copy) void (^operation)();
/** 项目管理*/
@property (nonatomic, strong)ProblemModel *problem;
//提交 或 显示
@property (nonatomic, assign)BOOL isShow;
//是否允许点击
@property (nonatomic, assign)BOOL click;
//高度
@property (nonatomic, assign)CGFloat height;
//显示*
@property (nonatomic, assign)BOOL isStar;

//提交
+ (id)itemWithIcon:(NSString *)icon withContent:(NSString *)content withHeight:(CGFloat)height withClick:(BOOL)click withStar:(BOOL)star title:(NSString *)title type:(PersonalSettingItemType)type;
//显示
+ (id)itemWithModel:(id)model type:(PersonalSettingItemType)type;
@end
