//
//  LabelSize.m
//  Recreation
//
//  Created by chris on 16/5/26.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "LabelSize.h"

@implementation LabelSize


+ (CGSize)updateLabel:(UILabel *)label withText:(NSString *)string
{
    return [self updateLabel:label withText:string contstrainedSize:CGSizeMake(label.frame.size.width,MAXFLOAT)];
}

+ (CGSize)updateLabel:(UILabel *)label withText:(NSString *)string contstrainedSize:(CGSize)constrainedSize
{
    if (string!=nil) label.text = string;
    CGFloat width = constrainedSize.width;
    CGSize size = [self sizeWithString:label.text font:label.font constrainedToSize:constrainedSize lineBreakMode:label.lineBreakMode];
    CGFloat height = ceil(size.height);
    if(label.text==nil||[label.text isEqualToString:@""])
        height=0.f;
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, ceil(width), ceil(height));
    return size;
}

+ (CGFloat)updateWidthOfLabel:(UILabel *)label
{
    CGRect frame = label.frame;
    CGFloat width = [self widthOfLabel:label];
    frame.size.width = width;
    [label setFrame:frame];
    return width;
}

+ (CGFloat)widthOfLabel:(UILabel *)aLabel
{
    CGSize size = [self sizeWithString:aLabel.text font:aLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0f) lineBreakMode:aLabel.lineBreakMode];
    return size.width;
}

+ (CGFloat)heightOfLabel:(UILabel *)aLabel
{
    CGSize size = [self sizeWithString:aLabel.text font:aLabel.font constrainedToSize:CGSizeMake(aLabel.width, MAXFLOAT) lineBreakMode:aLabel.lineBreakMode];
    return size.height;
}


+ (CGSize)sizeWithString:(NSString *)aString font:(UIFont *)aFont constrainedToSize:(CGSize)aSize lineBreakMode:(NSLineBreakMode)aLineBreakMode
{
    CGSize returnSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = aLineBreakMode;
    CGSize boundedSize = [aString boundingRectWithSize:aSize options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:aFont, NSParagraphStyleAttributeName:paragraphStyle.copy} context:nil].size;
    returnSize.width = ceilf(boundedSize.width);
    returnSize.height = ceilf(boundedSize.height);
    return returnSize;
}

+ (CGPoint)centerOfView:(UIView *)aView
{
    return CGPointMake(aView.bounds.size.width/2.0f, aView.bounds.size.height/2.0f);
}

+ (void)makeCenterOfView:(UIView *)aView
{
    CGPoint center = [self centerOfView:aView.superview];
    [aView setCenter:center];
}

@end
