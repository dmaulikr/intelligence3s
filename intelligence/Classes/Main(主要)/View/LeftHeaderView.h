//
//  LeftHeaderView.h
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *huan;
+(instancetype)leftHeaderView;
@end
