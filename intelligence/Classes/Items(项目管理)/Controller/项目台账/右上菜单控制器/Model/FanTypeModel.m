//
//  FanTypeModel.m
//  intelligence
//
//  Created by  on 16/8/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "FanTypeModel.h"

@implementation FanTypeModel

- (NSComparisonResult)compareParkInfo:(FanTypeModel *)parkinfo{
    // 升序
    NSString *str1 = [self.LOCNUM substringToIndex:3];
    NSString *str2 = [parkinfo.LOCNUM substringToIndex:3];
    NSInteger num1 = [str1 integerValue];
    NSInteger num2 = [str2 integerValue];
    NSComparisonResult result = [[NSNumber numberWithInteger:num1] compare:[NSNumber numberWithInteger:num2]];
    if (result == NSOrderedSame) {
        // 可以按照其他属性进行排序
    }
    return result;
}




@end
