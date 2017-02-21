//
//  ServiceResult.m
//  ZOSENDA
//
//  Created by hc on 14-7-17.
//  Copyright (c) 2014年 ZOSENDA GROUP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "XmlParseHelper.h"

@interface ServiceResult : NSObject

@property(nonatomic,retain) ASIHTTPRequest *request;
@property(nonatomic,readonly) NSDictionary *userInfo;
@property(nonatomic,readonly) NSString *nameSpace;
@property(nonatomic,readonly) NSString *methodName;
@property(nonatomic,readonly) NSString *xmlnsAttr;

//xml转换类
@property(nonatomic,retain) XmlParseHelper *xmlParse;
//原始返回的soap字符串
@property(nonatomic,readonly) NSString *xmlString;
//调用webservice方法里面的值
@property(nonatomic,copy) NSString *xmlValue;

+(id)requestResult:(ASIHTTPRequest*)httpRequest;

@end
