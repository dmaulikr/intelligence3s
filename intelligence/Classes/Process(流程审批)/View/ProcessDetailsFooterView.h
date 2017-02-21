//
//  ProcessDetailsFooterView.h
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessDetailsFooterView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *btnApproval;
@property (strong, nonatomic) IBOutlet UIButton *btnDetail;

+ (instancetype)showXibView;

@end
