//
//  UIImage+base64.h
//  lifesensehealth1_1
//
//  Created by chris on 14-9-25.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMBase64.h"

@interface UIImage (base64)

-(NSString*)imageToBase64;
+(UIImage*)base64ToImage:(NSString*)imageStr;

@end
