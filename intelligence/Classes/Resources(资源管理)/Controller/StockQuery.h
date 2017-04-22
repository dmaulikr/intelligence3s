//
//  StockQuery.h
//  intelligence
//
//  Created by chris on 2016/12/2.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockQuery : NSObject

@property(strong,nonatomic)NSString * BINNUM;
@property(strong,nonatomic)NSString * CURBAL;
@property(strong,nonatomic)NSString * ITEMNUM;
@property(strong,nonatomic)NSString * LOCATIONDESC;
@property(strong,nonatomic)NSString * LOTNUM;
@property(strong,nonatomic)NSString * ITEMDESC;
@property(strong,nonatomic)NSString * LOCATION;
@property(strong,nonatomic)NSString * ITEMUNIT;

@end
