//
//  PersonalSettingItem.m
//  NoarterClient
//
//  Created by noarter02 on 15-2-2.
//  Copyright (c) 2015年 whj. All rights reserved.
//

#import "PersonalSettingItem.h"

@implementation PersonalSettingItem
+ (id)itemWithIcon:(NSString *)icon withContent:(NSString *)content withHeight:(CGFloat)height withClick:(BOOL)click withStar:(BOOL)star title:(NSString *)title type:(PersonalSettingItemType)type
{
    __block PersonalSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    item.content = content;
    item.click = click;
    item.height = height;
    item.isStar = star;
    return item;
}
//显示
+ (id)itemWithModel:(id)model type:(PersonalSettingItemType)type{
    PersonalSettingItem *item = [[self alloc] init];
    item.problem = (ProblemModel *)model;
    item.type = type;
    return item;
}
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
