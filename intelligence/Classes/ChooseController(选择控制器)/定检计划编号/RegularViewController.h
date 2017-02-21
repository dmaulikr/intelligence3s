//
//  RegularViewController.h
//  intelligence
//
//  Created by 光耀 on 16/10/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "RegularModel.h"
@interface RegularViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(RegularModel *);

@end
