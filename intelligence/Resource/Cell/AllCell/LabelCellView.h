//
//  LabelCellView.h
//  intelligence
//
//  Created by chris on 16/8/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface LabelCellView : UICollectionReusableView
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *name;
//内容
@property (weak, nonatomic) IBOutlet UITextField *content;

@property (nonatomic,strong)PersonalSettingItem *item;
+(instancetype)labelCellView;
@end
