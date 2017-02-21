//
//  ApprovalPopupSheetFrontView.h
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalPopupSheetFrontView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;

@property (weak, nonatomic) IBOutlet UIButton *noBtn;

+ (instancetype)showXibView;

@end
