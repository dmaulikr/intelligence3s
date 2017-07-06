//
//  FDJZC_ViewController.h
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "MetaTableViewController.h"
#import "UDWARNINGWO.h"
@interface FDJZC_ViewController : MetaTableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UDWARNINGWO * Kmodel;
@end
