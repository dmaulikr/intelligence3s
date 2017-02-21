//
//  AddMaterielsViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "MaterielsModel.h"
@interface AddMaterielsViewController : ProfileSettingViewController
@property (nonatomic,copy)void (^backMater)(MaterielsModel *);
@end
