//
//  SoapUtil.m
//  News
//
//  Created by iPolaris on 13-5-23.
//
//

#import "SoapUtil.h"

@implementation SoapUtil
@synthesize endpoint = _endpoint,nameSpace = _nameSpace;
-(id)initWithNameSpace:(NSString *)nameSpace andEndpoint:(NSString *)endpoint{
    self = [super init];
    if (self) {
        _endpoint = endpoint;
        _nameSpace = nameSpace;
    }
    return self;
}
-(NSData *)requestMethod:(NSString *)method withDate:(NSArray *)array{
    NSString *methods = [NSString stringWithFormat:@"%@ xmlns=\"http://www.ibm.com/maximo\"",method];
    return [self soapInvoke:methods params:array];
}

-(void)requestMethods:(NSString *)method withDate:(NSArray *)array{
    
    if([method isEqualToString:@"mobileserviceInsertMbo"])
    {
        NSLog(@"新增、修改 %@",array);
    }
    else if([method isEqualToString:@"wfservicewfGoOn"])
    {
        NSLog(@"审批工作流 %@",array);
    }
    else if([method isEqualToString:@"wfservicestartWF2"])
    {
        NSLog(@"启动工作流%@",array);
    }

    
   NSString *methods = [NSString stringWithFormat:@"%@ xmlns=\"http://www.ibm.com/maximo\"",method];
    NSData *data = [self soapInvoke:methods params:array];
    
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    
    [xmlParser parse];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"return"])
    {
        if(!soapResults)
        {
            soapResults = [[NSMutableString alloc]init];
        }
        recordResults = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"%@",string);
    if(recordResults)
    {
        [soapResults appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"return"] )
    {
        if (self.DicBlock) {
            self.DicBlock([self parseJSONStringToNSDictionary:soapResults]);
        }
    }
}
/** json转字典*/
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
- (NSData *) soapCall:(NSString *)method  postData:(NSString *)post
{
   
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    //[postData autorelease];
    if (![_nameSpace hasSuffix:@"/"]) {
        _nameSpace = [_nameSpace stringByAppendingString:@"/"];
    }
    NSString *soapAction = [NSString stringWithFormat:@"%@%@",_nameSpace , method  ];

    NSURL *url=[[NSURL alloc]initWithString:_endpoint];
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]init];
    
    [request setTimeoutInterval: 10 ];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setURL: url ] ;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //text/xml;charset=utf-8
    //application/soap+xml; charset=utf-8
    [request setValue:@"urn:action" forHTTPHeaderField:@"SOAPAction"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    
    NSError *err=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil
                                                   error:&err];
    return data ;
}


- (NSData *)soapInvoke:(NSString *)method params:(NSArray *)params
{
    NSMutableString * post = [[ NSMutableString alloc ] init ] ;
   // [ post autorelease ];
    
    [ post appendString:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\""
     " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
     " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
     "<soap:Body>\n" ];
    
    [ post appendString:@"<"];
    [ post appendString:method];
    [ post appendString:@">"];
//    [ post appendString:[NSString stringWithFormat:@" xmlns=\"%@\">\n",_nameSpace]];
    
    for (NSDictionary *dict in params)
    {
        NSString *value = nil;
        
        NSString *key = [[dict keyEnumerator] nextObject];
        
        if (key != nil)
        {
            value = [dict valueForKey:key];
            
            [ post appendString:@"<"];
            [ post appendString:key];
            [ post appendString:@">"];
            if( value != nil )
            {
                [ post appendString:value];
            }
            else
            {
                [ post appendString:@""];
            }
            
            [ post appendString:@"</"];
            [ post appendString:key];
            [ post appendString:@">\n"];
        }
    }
    
    [ post appendString:@"</"];
    [ post appendString:method];
    [ post appendString:@">\n"];
    
    [ post appendString:
     @"</soap:Body>\n"
     "</soap:Envelope>\n"
     ];

    //NSLog(@"request：n%@\n", post);
    
    return [self soapCall:method postData:post];
}

@end
