//
//  DictionaryToJson.m
//  intelligence
//
//  Created by  on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DictionaryToJson.h"

@implementation DictionaryToJson

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}


@end
