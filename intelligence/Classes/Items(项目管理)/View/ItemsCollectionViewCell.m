//
//  ItemsCollectionViewCell.m
//  intelligence
//
//  Created by 光耀 on 16/7/23.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ItemsCollectionViewCell.h"

@interface  ItemsCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation ItemsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic{
    self.title.text = dic[@"title"];
    self.img.image = [UIImage imageNamed:dic[@"icon"]];
}

@end
