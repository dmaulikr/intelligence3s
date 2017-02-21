//
//  ProblemModel.m
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProblemModel.h"

@implementation ProblemModel

- (NSComparisonResult)compareParkInfo:(ProblemModel *)parkinfo{
    // 升序
    NSInteger num1 = [self.FEEDBACKNUM integerValue];
    NSInteger num2 = [parkinfo.FEEDBACKNUM integerValue];
    NSComparisonResult result = [[NSNumber numberWithInteger:num1] compare:[NSNumber numberWithInteger:num2]];
    if (result == NSOrderedSame) {
        // 可以按照其他属性进行排序
    }
    return result;
}


@end
