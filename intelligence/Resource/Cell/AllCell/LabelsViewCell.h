//
//  LabelsViewCell.h
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface LabelsViewCell : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, strong)PersonalSettingItem *item;
+(instancetype)labelsViewCell;
@end
