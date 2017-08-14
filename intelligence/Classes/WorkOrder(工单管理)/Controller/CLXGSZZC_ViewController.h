//
//  CLXGSZZC_ViewController.h
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "MetaTableViewController.h"
#import "UDWARNINGWO.h"
@protocol CLXGSZZC_ViewControllerDelegate <NSObject>
-(void)CLXGSZZC_DATA:(NSMutableDictionary*)data;
@end
@interface CLXGSZZC_ViewController : MetaTableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UDWARNINGWO * Kmodel;
@property(nonatomic)id<CLXGSZZC_ViewControllerDelegate> delegate;
@end
