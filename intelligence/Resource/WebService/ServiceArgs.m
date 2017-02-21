//
//  ServiceArgs.m
//  ZOSENDA
//
//  Created by hc on 14-7-17.
//  Copyright (c) 2014年 ZOSENDA GROUP. All rights reserved.
//

#import "ServiceArgs.h"

@interface ServiceArgs()

- (NSString*)paramsFormatString:(NSArray*)params;

@end

//default url
static NSString *defaultWebServiceUrl = @"http://eamapp.mywind.com.cn/meaweb/services/WFSERVICE";

//default namespace
static NSString *defaultWebServiceNameSpace = @"http://www.ibm.com/maximo";

@implementation ServiceArgs

#pragma mark -  init
- (id)initWithMethodName:(NSString *)methodName soapParamsArray:(NSArray *)paramsArray{
    if (self = [super init]) {
        self.methodName = methodName;
        self.soapParams = paramsArray;
        self.soapMessage = [self stringSoapMessage:paramsArray];
    }
    return self;
}

#pragma mark -  setter
+ (void)setWebServiceURL:(NSString*)url
{
    if (defaultWebServiceUrl!=url) {
        [defaultWebServiceUrl release];
        defaultWebServiceUrl=[url retain];
    }
}
+ (void)setNameSapce:(NSString*)space
{
    if (defaultWebServiceNameSpace!=space) {
        [defaultWebServiceNameSpace release];
        defaultWebServiceNameSpace=[space retain];
    }
}

#pragma mark -  getter
- (NSString*)defaultSoapMesage{
    /*
    NSString *soapBody=@"<?xml version=\"1.0\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema- instance\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\" xmlns:Tuan=\"http://tempuri.org/\" xmlns:tns1=\"http://mobile.td.com\" xmlns:ns1=\"http://mobile.td.com/Imports\" xmlns:tns2=\"http://schemas.microsoft.com/2003/10/Serialization/\" xsl:version=\"1.0\">\n"
    "<soap:Body>%@</soap:Body></soap:Envelope>";
     */
    
    /*
    NSString *soapBody = @"<?xml version=\"1.0\" encoding=\"utf- 8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema- instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
    "<soap:Body>\n"
    "<getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">\n"
    "<mobileCode>%@</mobileCode>\n"
    "<userID></userID>\n"
    "</getMobileCodeInfo>\n"
    "</soap:Body>\n"
    "</soap:Envelope>\n";
    */
    NSString *soapBody = @"<?xml version=\"1.0\" encoding=\"utf- 8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema- instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
    "<soap:Body>%@</soap:Body>\n"
    "</soap:Envelope>\n";
    return soapBody;
}

- (NSURL*)webURL{
    return [NSURL URLWithString:[self serviceURL]];
}

- (NSString*)serviceURL{
    if (_serviceURL) {
        return _serviceURL;
    }
    return defaultWebServiceUrl;
}

- (NSString*)serviceNameSpace
{
    if (_serviceNameSpace) {
        return _serviceNameSpace;
    }
    return defaultWebServiceNameSpace;
}

- (NSMutableDictionary*)headers
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:[[self webURL] host] forKey:@"Host"];
    [dic setValue:@"text/xml; charset=utf- 8" forKey:@"Content- Type"];
    [dic setValue:[NSString stringWithFormat:@"%d",[[self soapMessage] length]] forKey:@"Content- Length"];
    [dic setValue:[NSString stringWithFormat:@"%@%@",[self serviceNameSpace],[self methodName]] forKey:@"SOAPAction"];
    return dic;
}

#pragma mark -  private
- (NSString*)paramsFormatString:(NSArray*)params
{
    NSMutableString *xml=[NSMutableString stringWithFormat:@""];
    for (NSDictionary *item in params) {
        NSString *key=[[item allKeys] objectAtIndex:0];
        [xml appendFormat:@"<%@>",key];
        [xml appendString:[item objectForKey:key]];
        [xml appendFormat:@"</%@>",key];
    }
    return xml;
}

- (NSString*)paramsFormatJsonString:(NSArray*)params
{
    NSMutableString *json=[NSMutableString stringWithFormat:@"{"];
    for (NSDictionary *item in params) {
        NSString *key=[[item allKeys] objectAtIndex:0];

        [json appendFormat:@"\"%@\":",key];
        //[json appendString:[item objectForKey:key]];
        [json appendFormat:@"\"%@\",",[item objectForKey:key]];
    }
    
    [json deleteCharactersInRange:NSMakeRange([json length] -  1 , 1)];
    
    [json  appendFormat:@"}"];
    
    if ([json  isEqualToString:@""])
        [json setString:@""];
    
    return json;
}

- (NSString *)generateParamsPartString:(NSArray*)params
{
    NSMutableString *paramPart=[NSMutableString string];
    for (NSDictionary *item in params) {
        NSString *key=[[item allKeys] objectAtIndex:0];
        [paramPart appendFormat:@"<%@>%@</%@>",key,[item objectForKey:key],key];
    }
    return paramPart;
}

#pragma mark -  public
- (NSString *)stringSoapMessage:(NSArray*)params
{
    if (params) {
#warning mark -  td before
        /*
        NSMutableString *soap=[NSMutableString stringWithFormat:@"<tns1:%@><tns1:jsonString>",[self methodName]];
        
        [soap appendString:[self paramsFormatJsonString:params]];
        [soap appendFormat:@"</tns1:jsonString></tns1:%@>",[self methodName]];
        */
        
        NSMutableString *soap=[NSMutableString stringWithFormat:@"<%@ xmlns=\"http://WebXml.com.cn/\">",[self methodName]];
        
        //[soap appendString:[self paramsFormatJsonString:params]];
        [soap appendString:[self generateParamsPartString:params]];
        [soap appendFormat:@"</%@>",[self methodName]];
        
        NSString *soapMsg = [NSString stringWithFormat:[self defaultSoapMesage],soap];
        return soapMsg;
    }
    
    NSString *body=[NSString stringWithFormat:@"<%@ xmlns=\"%@\" />",[self methodName],[self serviceNameSpace]];
    
    return [NSString stringWithFormat:[self defaultSoapMesage],body];
}

+ (ServiceArgs*)serviceMethodName:(NSString*)methodName
{
    return [self serviceMethodName:methodName soapMessage:nil];
}

+ (ServiceArgs*)serviceMethodName:(NSString*)name soapMessage:(NSString*)msg
{
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=name;
    if (msg&&[msg length]>0) {
        args.soapMessage=msg;
    }else{
        args.soapMessage=[args stringSoapMessage:nil];
    }
    return args;
}

@end
