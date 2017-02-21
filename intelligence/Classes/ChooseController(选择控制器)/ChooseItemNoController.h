//
//  ChooseItemNoController.h
//  intelligence
//
//  Created by  on 16/8/12.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "ChooseItemNoModel.h"

@interface ChooseItemNoController : BaseSearchViewController

@property (nonatomic, copy) void(^executeClickCell)(ChooseItemNoModel *);



@end
