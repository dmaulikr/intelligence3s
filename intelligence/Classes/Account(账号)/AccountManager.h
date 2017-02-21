//
//  AccountManager.h
//  Recreation
//
//  Created by  on 16/5/13.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface AccountManager : NSObject

/** 储存用户信息*/
+ (void)saveAccount:(AccountModel *)model;

/** 读取用户信息*/
+ (AccountModel *)account;

/** 注销用户*/
+ (void)logOffAccount;

@end
