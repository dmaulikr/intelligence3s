//
//  ProblemItemLLIView.h
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProblemItemLLIViewType) {
    ProblemItemTypeDefaultLL,               // label label
    ProblemItemTypeDefaultLLI,              // label label >
    ProblemItemTypeDefaultLT,               // label textfile
    ProblemItemTypeDefaultLV,               // label textview
    ProblemDetailsTypeMustLL,               // label label 日历
    ProblemDetailsTypeMustLLI,              // label TextField
    
};


@interface ProblemItemLLIView : UICollectionReusableView

@property (nonatomic, assign) ProblemItemLLIViewType type;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, assign) BOOL isend;

@property (nonatomic, copy) void(^executeTapContentLabel)();


+ (instancetype)showXibView;





@end
