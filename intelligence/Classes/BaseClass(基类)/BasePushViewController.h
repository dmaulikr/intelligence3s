//
//  BasePushViewController.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface BasePushViewController : ViewController
@property (nonatomic,strong)URLSessionTask *task;
@property (nonatomic,strong) __block NSMutableArray *RequiredFields;
@property (nonatomic,strong) __block NSMutableDictionary *SetingItems;
-(void)checkWFPRequiredWithAppId:(NSString*)appId objectName:(NSString*)objectName status:(NSString*)status compeletion:(void(^)(NSArray *fields))compeletion;
@end
