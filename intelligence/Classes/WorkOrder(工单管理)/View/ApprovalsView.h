//
//  ApprovalsView.h
//  intelligence
//
//  Created by chris on 16/8/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalsView : UIView
@property (nonatomic,copy)NSString *processname;
@property (nonatomic,copy)NSString *mbo;
@property (nonatomic,copy)NSString *keyValue;
@property (nonatomic,copy)NSString *key;
@property (nonatomic,copy)void (^CloseBlick)(NSDictionary *);
- (instancetype)initWithFrame:(CGRect)frame withNumber:(BOOL)number;
- (void)show;
- (void)dismiss;
@end
