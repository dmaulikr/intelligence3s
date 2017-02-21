//
//  ProcessApprovalPopupWindowView.h
//  intelligence
//
//  Created by  on 16/7/25.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessModel.h"
@interface ProcessApprovalPopupWindowView : UIView
@property (nonatomic,strong)ProcessModel *process;
@property (nonatomic,copy)void (^CloseBlick)(NSString *);
- (void)show;
- (void)dismiss;


@end
