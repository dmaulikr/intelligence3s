//
//  MaterViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "MaterielsModel.h"
@interface MaterViewController : ProfileSettingViewController
@property (nonatomic,strong)MaterielsModel *model;
@property (nonatomic,copy)void (^backData)(MaterielsModel *model);
@property (nonatomic,copy)void (^deleteModels)(MaterielsModel *);
@end
