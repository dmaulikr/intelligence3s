//
//  WorkPopView.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkPopView : UICollectionReusableView
@property (nonatomic,copy)void (^WorkBlock)(NSString *str);
-(void)addData:(ChoiceType)type;
+(instancetype)workPopView;
@end
