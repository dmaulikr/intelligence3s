//
//  UIImage+base64.m
//  lifesensehealth1_1
//
//  Created by chris on 14-9-25.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import "UIImage+base64.h"

@implementation UIImage (base64)
-(NSString*)imageToBase64
{
    NSData *d=UIImageJPEGRepresentation(self,0.7);
    return [[NSString alloc]initWithData:[GTMBase64 encodeData:d] encoding:NSUTF8StringEncoding];
}
+(UIImage*)base64ToImage:(NSString*)imageStr
{
    
    NSData *data=[imageStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData*decoded=[GTMBase64 decodeData:data];
    UIImage*image=[UIImage imageWithData:decoded];
    return image;
}
@end
