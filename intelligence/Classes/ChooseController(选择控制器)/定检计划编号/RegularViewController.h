//
//  RegularViewController.h
//  intelligence
//
//  Created by chris on 16/10/31.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "RegularModel.h"
@interface RegularViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(RegularModel *);

@end
