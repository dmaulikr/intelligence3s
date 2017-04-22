//
//  BusinessXViewController.h
//  intelligence
//
//  Created by chris on 16/11/10.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "BusinessModel.h"
@interface BusinessXViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(BusinessModel *);
@end
