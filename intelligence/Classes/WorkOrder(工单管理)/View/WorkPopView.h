//
//  WorkPopView.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkPopView : UICollectionReusableView
@property (nonatomic,copy)void (^WorkBlock)(NSString *str);
-(void)addData:(ChoiceType)type;
+(instancetype)workPopView;
@end
