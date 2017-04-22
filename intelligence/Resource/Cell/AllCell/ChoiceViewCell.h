//
//  ChoiceViewCell.h
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface ChoiceViewCell : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *choice;
@property (nonatomic,copy) void (^updataChoice)(NSString *);
@property (nonatomic,strong)PersonalSettingItem *item;
+(instancetype)choiceViewCell;
@end
