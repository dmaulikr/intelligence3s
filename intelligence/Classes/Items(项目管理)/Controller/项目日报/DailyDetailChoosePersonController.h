//
//  DailyDetailChoosePersonController.h
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "ChoosePersonModel.h"

@interface DailyDetailChoosePersonController : BaseSearchViewController

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) void(^exetuceClickCell)(ChoosePersonModel *);


@end
