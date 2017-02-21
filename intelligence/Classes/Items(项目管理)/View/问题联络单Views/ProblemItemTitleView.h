//
//  ProblemItemTitleView.h
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemItemTitleView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) BOOL isend;



+ (instancetype)showXibView;

@end
