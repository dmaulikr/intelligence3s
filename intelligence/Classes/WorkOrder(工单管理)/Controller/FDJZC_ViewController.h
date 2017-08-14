//
//  FDJZC_ViewController.h
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "MetaTableViewController.h"
#import "UDWARNINGWO.h"
@protocol FDJZC_ViewControllerDelegate <NSObject>
-(void)FDJZC_DATA:(NSMutableDictionary*)data;
@end
@interface FDJZC_ViewController : MetaTableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UDWARNINGWO * Kmodel;
@property(nonatomic)id<FDJZC_ViewControllerDelegate> delegate;
@end
