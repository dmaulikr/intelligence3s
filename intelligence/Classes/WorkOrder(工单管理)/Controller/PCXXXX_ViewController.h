//
//  PCXXXX_ViewController.h
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "MetaTableViewController.h"

@protocol PCXXXX_ViewControllerDelegate <NSObject>
-(void)PCXXXX_DATA:(NSMutableArray*)data;
@end

@interface PCXXXX_ViewController : MetaTableViewController
@property(nonatomic)id<PCXXXX_ViewControllerDelegate> delegate;
@property(nonatomic,strong)NSString * WONUM;
@end
