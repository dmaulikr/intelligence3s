//
//  FaultCodeModel.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaultCodeModel : NSObject

@property (nonatomic, copy) NSString *PARENT;
@property (nonatomic, copy) NSString *UDDESCRIPTION;
@property (nonatomic, copy) NSString *TYPE2;
@property (nonatomic, copy) NSString *CODEDESC;      // 描述
@property (nonatomic, copy) NSString *LOCDESC;
@property (nonatomic, copy) NSString *FAILURELIST;
@property (nonatomic, copy) NSString *LOCATION;
@property (nonatomic, copy) NSString *TYPE;
@property (nonatomic, copy) NSString *FAILURECODE;   // 故障代码


@end
