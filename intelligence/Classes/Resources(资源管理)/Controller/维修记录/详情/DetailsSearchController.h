//
//  DetailsSearchController.h
//  intelligence
//
//  Created by 光耀 on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface DetailsSearchController : BaseSearchViewController
@property (nonatomic,copy)void (^BackBlock)(id model);
@end
