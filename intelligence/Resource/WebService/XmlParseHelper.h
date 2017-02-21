//
//  XmlParseHelper.h
//  IOSWebservices
//
//  Created by rang on 13-8-8.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlNode.h"
@class GDataXMLNode;
@class GDataXMLDocument;
@interface XmlParseHelper : NSObject

@property(nonatomic,retain) GDataXMLDocument *document;
@property(nonatomic,readonly) XmlNode *xmlNode;

-(void)setDataSource:(id)data;
-(id)initWithData:(id)xml;

/**
 *  获取webservice调用返回的xml内容
 *
 *  @param methodName 调用的webservice方法名
 *
 *  @return xml内容
 */
-(NSString*)soapMessageResultXml:(NSString*)methodName;

//find
-(XmlNode*)selectSingleNode:(NSString*)xpath;
-(XmlNode*)selectSingleNode:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;

-(NSArray*)selectNodes:(NSString*)xpath;
-(NSArray*)selectNodes:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;

-(NSArray*)selectNodes:(NSString*)xpath className:(NSString*)className;
-(NSArray*)selectNodes:(NSString*)xpath nameSpaces:(NSDictionary*)spaces className:(NSString*)className;

//将某个节点下子节点转换成对象
-(id)nodeToObject:(GDataXMLNode*)node className:(NSString*)className;
//对于webservice返回soap xml内容的查询
-(XmlNode*)soapXmlSelectSingleNode:(NSString*)xpath;
-(NSArray*)soapXmlSelectNodes:(NSString*)xpath;
-(NSArray*)soapXmlSelectNodes:(NSString*)xpath className:(NSString*)className;

//取得节点属性
-(NSDictionary*)getXmlNodeAttrs:(GDataXMLNode*)node;
-(NSDictionary*)selectSingleNodeAttrs:(NSString*)xpath;
-(NSDictionary*)selectSingleNodeAttrs:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;
-(NSArray*)selectNodeAttrs:(NSString*)xpath;
-(NSArray*)selectNodeAttrs:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;

//取得节点值
-(NSString*)getXmlNodeValue:(GDataXMLNode*)node;
-(NSString*)selectSingleNodeValue:(NSString*)xpath;
-(NSString*)selectSingleNodeValue:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;
-(NSArray*)selectNodeValues:(NSString*)xpath;
-(NSArray*)selectNodeValues:(NSString*)xpath nameSpaces:(NSDictionary*)spaces;

-(NSArray*)childNodesToObject:(NSString*)className;
-(NSArray*)childNodesToArray;

#pragma mark - vendor
/**
 *  获取当前节点下的所有子节点保存到对象中
 *
 *  @param node      node
 *  @param className 对象类名
 *
 *  @return 对象
 */
-(id)childsNodeToObject:(GDataXMLNode*)node objectName:(NSString*)className;
-(NSArray*)nodesChildsNodesToObjects:(GDataXMLNode*)node objectName:(NSString*)className;

@end
