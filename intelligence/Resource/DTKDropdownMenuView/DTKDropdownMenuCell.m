//
//  DTKDropdownMenuCell.m
//  intelligence
//
//  Created by  on 16/8/22.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "DTKDropdownMenuCell.h"

@implementation DTKDropdownMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"DTKDropdownMenuCell";
    
    DTKDropdownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DTKDropdownMenuCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
