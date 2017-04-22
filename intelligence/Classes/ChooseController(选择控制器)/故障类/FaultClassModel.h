//
//  FaultClassModel.h
//  intelligence
//
//  Created by  on 16/8/17.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaultClassModel : NSObject

@property (nonatomic, copy) NSString *PARENT;
@property (nonatomic, copy) NSString *UDDESCRIPTION;
@property (nonatomic, copy) NSString *TYPE2;
@property (nonatomic, copy) NSString *CODEDESC;    // 描述
@property (nonatomic, copy) NSString *LOCDESC;
@property (nonatomic, copy) NSString *FAILURELIST; // 故障类代码
@property (nonatomic, copy) NSString *LOCATION;
@property (nonatomic, copy) NSString *TYPE;
@property (nonatomic, copy) NSString *FAILURECODE;  // 编号
@property (nonatomic,assign)BOOL isShow;


@end
