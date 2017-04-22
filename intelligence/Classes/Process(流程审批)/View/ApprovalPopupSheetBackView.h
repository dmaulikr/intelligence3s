//
//  ApprovalPopupSheetBackView.h
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalPopupSheetBackView : UICollectionReusableView
//否
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
//是
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

+ (instancetype)showXibView;

@end
