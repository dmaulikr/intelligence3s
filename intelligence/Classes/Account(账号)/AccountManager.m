//
//  AccountManager.m
//  Recreation
//
//  Created by  on 16/5/13.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "AccountManager.h"


#define kAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation AccountManager

/** 储存用户信息*/
+ (void)saveAccount:(AccountModel *)model{
    [NSKeyedArchiver archiveRootObject:model toFile:kAccountFilepath];
}

/** 读取用户信息*/
+ (AccountModel *)account{
    AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFilepath];
    if (!account) {
        return nil;
    }else{
        return account;
    }
    return nil;
}

/** 注销用户*/
+ (void)logOffAccount{
    AccountModel *model = [self account];
    model = nil;
    [self saveAccount:model];
}

@end
