//
//  FinalNumViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/18.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "FinalModels.h"
@interface FinalNumViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(FinalModels *);
@end
