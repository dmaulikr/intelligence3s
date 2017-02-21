//
//  AddFaultViewController.h
//  intelligence
//
//  Created by 光耀 on 16/8/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProfileSettingViewController.h"
#import "FauWorkModel.h"
@interface AddFaultViewController : ProfileSettingViewController
@property (nonatomic,strong)FauWorkModel *stock;
@property (nonatomic,strong)NSString *worktype;
@property (nonatomic,strong)NSString *appid;
@property (nonatomic,strong)NSString *objectname;
@property (nonatomic,strong)NSString *orderby;
@property (nonatomic,copy) void (^Open)(NSDictionary *dic);
@end
