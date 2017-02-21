//
//  BasePushViewController.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePushViewController : UIViewController
@property (nonatomic,strong)URLSessionTask *task;
@property (nonatomic,strong) __block NSMutableArray *RequiredFields;
@property (nonatomic,strong) __block NSMutableDictionary *SetingItems;
-(void)checkWFPRequiredWithAppId:(NSString*)appId objectName:(NSString*)objectName status:(NSString*)status compeletion:(void(^)(NSArray *fields))compeletion;
@end
