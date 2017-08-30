//
//  GREASECARD_ViewController.h
//  intelligence
//
//  Created by chris on 2017/8/24.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSearchViewController.h"
#import "GREASECARD.h"
#import "StockViewCell.h"

@interface GREASECARD_ViewController : BaseSearchViewController
@property (nonatomic, copy) void(^executeCellClick)(GREASECARD *);
@property (nonatomic,assign) NSString *LICENSENUM;
@end
