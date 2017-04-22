//
//  LabelSize.h
//  Recreation
//
//  Created by chris on 16/5/26.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelSize : NSObject
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (CGFloat)updateWidthOfLabel:(UILabel *)label;
+ (CGFloat)widthOfLabel:(UILabel *)aLabel;
+ (CGFloat)heightOfLabel:(UILabel *)aLabel;
//+ (CGSize)sizeWithString:(NSString *)aString font:(UIFont *)aFont constrainedToSize:(CGSize)aSize lineBreakMode:(NSLineBreakMode)aLineBreakMode;

+ (CGPoint)centerOfView:(UIView *)aView;
+ (void)makeCenterOfView:(UIView *)aView;
@end
