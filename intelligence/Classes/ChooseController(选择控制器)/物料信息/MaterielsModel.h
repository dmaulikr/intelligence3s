//
//  MaterielsModel.h
//  intelligence
//
//  Created by ;;;;; on 16/8/20.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterielsModel : NSObject
//物资编码
@property (nonatomic,copy)NSString *ITEMNUM;
//数量
@property (nonatomic,copy)NSString *ITEMQTY;
//库房
@property (nonatomic,copy)NSString *LOCATION;
//物资描述
@property (nonatomic,copy)NSString *ITEMDESC;
//订购单位
@property (nonatomic,copy)NSString *ORDERUNIT;
//库房描述
@property (nonatomic,copy)NSString *LOCDESC;
//类型
@property (nonatomic,copy)NSString *TYPE;

@property (nonatomic,copy)NSString *WPITEMID;

@property (nonatomic,copy)NSString *WPMATERIALID;


@end
