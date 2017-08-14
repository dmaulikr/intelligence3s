//
//  ProfileSettingViewController.h
//  WeiGou
//
//  Created by noarter02 on 15-3-12.
//  Copyright (c) 2015年 yike. All rights reserved.
//

#import "BasePushViewController.h"
#import "PersonalSettingGroup.h"
#import "PersonalSettingItem.h"
@interface ProfileSettingViewController : BasePushViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_allGroups; // 所有的组模型
}
@property (nonatomic, weak, readonly) UITableView *tableView;
-(void)checkWFPRequiredWithAppId:(NSString*)appId objectName:(NSString*)objectName status:(NSString*)status compeletion:(void(^)(NSArray *fields))compeletion;
@end
