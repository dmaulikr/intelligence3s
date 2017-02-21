//
//  BusinessXViewController.h
//  intelligence
//
//  Created by 光耀 on 16/11/10.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "BusinessModel.h"
@interface BusinessXViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(BusinessModel *);
@end
