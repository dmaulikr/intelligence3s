//
//  FauWorkViewController.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface FauWorkViewController : BaseSearchViewController
@property (nonatomic,assign)ChoiceType Choice;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *worktype;
@property (nonatomic,strong)NSString *appid;
@property (nonatomic,strong)NSString *objectname;
@property (nonatomic,strong)NSString *orderby;
@end

