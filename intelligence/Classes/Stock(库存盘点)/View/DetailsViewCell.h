//
//  DetailsViewCell.h
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailStockModel.h"
@interface DetailsViewCell : UITableViewCell
//行项目号
@property (weak, nonatomic) IBOutlet UILabel *hangxiang;
//描述
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;
//数量
@property (weak, nonatomic) IBOutlet UILabel *number;
//模型
@property (nonatomic,strong) DetailStockModel *detail;

+(instancetype)detailsViewCell;
@end
