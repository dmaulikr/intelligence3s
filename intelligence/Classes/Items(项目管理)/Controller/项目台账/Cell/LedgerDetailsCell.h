//
//  LedgerDetailsCell.h
//  intelligence
//
//  Created by 丁进宇 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LedgerModel.h"

@interface LedgerDetailsCell : UITableViewCell


- (void)setIndex:(NSInteger)index withModel:(LedgerModel *)ledger;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
