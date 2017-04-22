//
//  DetailsSearchController.h
//  intelligence
//
//  Created by chris on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface DetailsSearchController : BaseSearchViewController
@property (nonatomic,copy)void (^BackBlock)(id model);
@end
