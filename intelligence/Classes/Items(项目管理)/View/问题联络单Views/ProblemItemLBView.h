//
//  ProblemItemLBView.h
//  intelligence
//
//  Created by  on 16/8/8.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemItemLBView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

+ (instancetype)showXibView;

@end
