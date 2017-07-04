//
//  DataFactory.m
//  intelligence
//
//  Created by chris on 2017/6/23.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "DataFactory.h"

@implementation DataFactory

-(NSMutableArray*)readDataWithName:(NSString*) name
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"workOrder" ofType:@"json"]];
    
    NSString * data = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];

    NSArray * array =[[NSDictionary dictionaryWithJSONString:data] objectForKey:name];
    
    NSMutableArray *mutable = [NSMutableArray array];
    
    for (NSDictionary * dic in array) {
        
        NSMutableDictionary * mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutable addObject:mDic];
        
    }
    
    return mutable;
}

@end
