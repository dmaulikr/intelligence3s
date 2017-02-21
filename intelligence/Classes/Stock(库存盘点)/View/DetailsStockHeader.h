//
//  DetailsStockHeader.h
//  intelligence
//
//  Created by 光耀 on 16/8/8.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsStockHeader : UICollectionReusableView
//盘点单号
@property (weak, nonatomic) IBOutlet UILabel *pandian;
//描述
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;
//凭证
@property (weak, nonatomic) IBOutlet UILabel *pingzheng;
//仓库名称
@property (weak, nonatomic) IBOutlet UILabel *cangku;
//明盘
@property (weak, nonatomic) IBOutlet UIButton *mingpan;
//暗盘
@property (weak, nonatomic) IBOutlet UIButton *anping;
//创建人
@property (weak, nonatomic) IBOutlet UILabel *chuangjian;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *shijian;
//描述高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *miaoshuHeight;

+(instancetype)detailsStockHeader;


@end
