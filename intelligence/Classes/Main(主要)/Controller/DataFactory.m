//
//  DataFactory.m
//  intelligence
//
//  Created by chris on 2017/6/23.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "DataFactory.h"

@implementation DataFactory
-(void)readData
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"workOrder" ofType:@"json"]];
    
    NSString * data = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    NSLog(@"data %@",data);
}

@end
