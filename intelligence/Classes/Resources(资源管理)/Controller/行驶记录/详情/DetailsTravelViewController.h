//
//  DetailsTravelViewController.h
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "TravelRModel.h"
@interface DetailsTravelViewController : ProfileSettingViewController
/** 数据模型*/
@property (nonatomic, strong)TravelRModel *stock;
@property (nonatomic,copy)NSString *objectname;
@property (nonatomic,copy)void (^BackUpda)(NSDictionary *);
@end
