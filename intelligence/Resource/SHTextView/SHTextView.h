//
//  SHTextView.h
//  SHTextView
//
//  Created by 宋浩文的pro on 16/4/12.
//  Copyright © 2016年 宋浩文的pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHTextView;

typedef enum
{
    ExtendUp,
    ExtendDown
}ExtendDirection;

@protocol SHTextViewDelegate <UITextViewDelegate>

// 开始
- (void)beginChange;
// 结束编辑
- (void)endChange;
//高度变化
-(void)changeheight:(CGFloat)height;

@end

@interface SHTextView : UITextView

@property (nonatomic,copy) void (^ChangeExtend)(BOOL change);

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 占位文字的起始位置 */
@property (nonatomic, assign) CGPoint placeholderLocation;

/** textView是否可伸长 */
@property (nonatomic, assign) BOOL isCanExtend;

/** 伸长方向 */
@property (nonatomic, assign) ExtendDirection extendDirection;

/** 伸长限制行数 */
@property (nonatomic, assign) NSUInteger extendLimitRow;


@property (nonatomic, assign) id<SHTextViewDelegate> delegate;

@end
