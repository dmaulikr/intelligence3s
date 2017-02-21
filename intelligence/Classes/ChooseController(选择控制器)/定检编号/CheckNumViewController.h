//
//  CheckNumViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "CheackNumModel.h"
@interface CheckNumViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(CheackNumModel *);
@end
