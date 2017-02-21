//
//  FanNumModle.h
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanNumModle : NSObject
/** 物资编码*/
@property (nonatomic,copy)NSString *ITEMNUM;   //编号
@property (nonatomic,copy)NSString *DESCRIPTION; //描述
@property (nonatomic,copy)NSString *ORDERUNIT;   //订购单位

/** 库房*/
@property (nonatomic,copy)NSString *LOCATION;   //编号


/** 类型*/
@property (nonatomic,assign)ChooseType types;
@end
