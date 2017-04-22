//
//  LeftViewCell.h
//  intelligence
//
//  Created by chris on 16/7/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewCell : UITableViewCell
@property (nonatomic,strong)NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
+(instancetype)leftViewCell;
@end
