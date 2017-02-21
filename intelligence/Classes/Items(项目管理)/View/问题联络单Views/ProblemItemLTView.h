//
//  ProblemItemLTView.h
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHTextView.h"


typedef NS_ENUM(NSInteger, ProblemItemLTViewType) {
    ProblemItemLTViewTypeDefault,
    ProblemItemLTViewTypeHiddenRedMark,
    
};


@interface ProblemItemLTView : UICollectionReusableView

@property (nonatomic, assign) ProblemItemLTViewType type;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contentText;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, assign) BOOL isend;


@property (nonatomic, copy) void(^executeTextHeightChage)(CGFloat textHeight);




+ (instancetype)showXibView;


@end
