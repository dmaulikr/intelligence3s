//
//  FooterView.h
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

+(instancetype)footerView;
@end
