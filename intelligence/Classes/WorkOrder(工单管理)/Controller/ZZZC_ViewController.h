//
//  ZZZC_ViewController.h
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "MetaTableViewController.h"
#import "UDWARNINGWO.h"
@protocol ZZZC_ViewControllerDelegate <NSObject>
-(void)ZZZC_DATA:(NSMutableDictionary*)data;
@end

@interface ZZZC_ViewController : MetaTableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UDWARNINGWO * Kmodel;
@property(nonatomic)id<ZZZC_ViewControllerDelegate> delegate;
@end
