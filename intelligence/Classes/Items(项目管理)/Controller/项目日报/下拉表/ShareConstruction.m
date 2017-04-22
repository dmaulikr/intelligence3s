//
//  ShareConstruction.m
//  intelligence
//
//  Created by chris on 16/9/5.
//  Copyright © 2016年 chris. All rights reserved.
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
