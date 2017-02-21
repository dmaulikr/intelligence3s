//
//  UIImage+Extension.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**  根据图片名自动加载适配iOS6\7的图片(项目最低iOS7)*/

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
//    if (IOS7_OR_LATER) { // 处理iOS7的情况
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        image = [UIImage imageNamed:newName];
//    }
//    
//    if (image == nil) {
//        image = [UIImage imageNamed:name];
//    }
    
    image = [UIImage imageNamed:name];
    return image;
}

/**  根据图片名返回一张能够自由拉伸的图片*/
+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


/*
 缩放图片，将图片缩放为指定尺寸大小
 */
- (UIImage*)imageWithOriginalImage:(UIImage*)originalImage scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
