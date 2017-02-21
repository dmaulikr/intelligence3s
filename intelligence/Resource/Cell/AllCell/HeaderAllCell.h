//
//  HeaderAllCell.h
//  intelligence
//
//  Created by 光耀 on 16/8/5.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderAllCell : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *name;
+(instancetype)headerAllCell;
@end
