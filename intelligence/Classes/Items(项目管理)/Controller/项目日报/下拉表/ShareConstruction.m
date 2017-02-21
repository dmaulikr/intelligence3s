//
//  ShareConstruction.m
//  intelligence
//
//  Created by 丁进宇 on 16/9/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ShareConstruction.h"


@implementation ShareConstruction


+ (ShareConstruction *)sharedConstruction
{
    static ShareConstruction *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
@end
