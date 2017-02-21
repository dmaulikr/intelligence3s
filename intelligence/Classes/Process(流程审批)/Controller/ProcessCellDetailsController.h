//
//  ProcessCellDetailsController.h
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BasePushViewController.h"
#import "ProcessModel.h"

@interface ProcessCellDetailsController : BasePushViewController

@property (nonatomic, strong) ProcessModel *process;
@property (nonatomic,copy)void (^UpdataBlock)(NSString *);

@end
