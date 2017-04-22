//
//  FooterView.h
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

+(instancetype)footerView;
@end
