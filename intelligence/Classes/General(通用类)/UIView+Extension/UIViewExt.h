/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
/** 矩形中心点*/
CGPoint CGRectGetCenter(CGRect rect);
/** 矩形移动去中心点*/
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
/** 中心点*/
@property CGPoint origin;
/** 矩形大小*/
@property CGSize size;
/** 左下角坐标*/
@property (readonly) CGPoint bottomLeft;
/** 右下角坐标*/
@property (readonly) CGPoint bottomRight;
/** 右上角坐标*/
@property (readonly) CGPoint topRight;
/** 高度*/
@property CGFloat height;
/** 宽度*/
@property CGFloat width;
/** 顶部y值*/
@property CGFloat top;
/** 左边x值*/
@property CGFloat left;
/** 底部y值*/
@property CGFloat bottom;
/** 右边x值*/
@property CGFloat right;
/** 移动dalta个距离*/
- (void) moveBy: (CGPoint) delta;
/** 比例放大缩小*/
- (void) scaleBy: (CGFloat) scaleFactor;
/** 变形成aSize大小*/
- (void) fitInSize: (CGSize) aSize;
@end