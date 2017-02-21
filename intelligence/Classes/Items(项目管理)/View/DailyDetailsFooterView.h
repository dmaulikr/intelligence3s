//
//  DailyDetailsFooterView.h
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyDetailsFooterView : UICollectionReusableView

@property (nonatomic, copy) void(^executeBtnCancelClick)();
@property (nonatomic, copy) void(^executeBtnSaveClick)();

+ (instancetype)showXibView;

@end
