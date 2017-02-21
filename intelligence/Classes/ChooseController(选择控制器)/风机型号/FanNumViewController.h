//
//  FanNumViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FanNumModle.h"

@interface FanNumViewController : BaseSearchViewController
@property (nonatomic,assign)ChooseType type;
@property (nonatomic, copy) void(^executeCellClick)(FanNumModle *);
@end
