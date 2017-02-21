//
//  ArrowCellView.h
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingItem.h"
@interface ArrowCellView : UICollectionReusableView
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 内容*/
@property (weak, nonatomic) IBOutlet UITextField *content;
/** 图片*/
@property (weak, nonatomic) IBOutlet UIButton *img;
/** 标识*/
@property (weak, nonatomic) IBOutlet UILabel *identify;

@property (nonatomic,strong)PersonalSettingItem *item;
+(instancetype)arrowCellView;
@end
