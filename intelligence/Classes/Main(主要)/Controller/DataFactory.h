//
//  DataFactory.h
//  intelligence
//
//  Created by chris on 2017/6/23.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+BSJSONAdditions.h"
@interface DataFactory : NSObject
-(NSMutableArray*)readDataWithName:(NSString*) name;
-(NSArray*)arrayWithName:(NSString*) name;
@end
