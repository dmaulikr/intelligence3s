//
//  ProcessDetailsCell.h
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessModel.h" // 流程审批
#import "LedgerModel.h"  // 台账详情
#import "DailyModel.h"   // 日报详情

@interface ProcessDetailsCell : UITableViewCell

@property (nonatomic, strong) ProcessModel *process;
@property (nonatomic, strong) LedgerModel *ledger;
@property (nonatomic, strong) DailyModel *daily;




@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat leftLabelWight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
