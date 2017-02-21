//
//  FanTypeViewController.h
//  intelligence
//
//  Created by  on 16/7/26.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BasePushViewController.h"
#import "FanTypeModel.h"
@interface FanTypeViewController : BasePushViewController
@property (nonatomic,copy)void (^backModel)(FanTypeModel *fan);
@property (nonatomic, copy) NSString *requestCode;  // 项目编号
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic, assign) BOOL isribao;


@end
