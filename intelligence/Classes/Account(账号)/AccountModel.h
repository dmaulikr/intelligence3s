//
//  AccountModel.h
//  Recreation
//
//  Created by 李洋 on 16/5/12.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AccountModel : NSObject <NSCoding>
@property (nonatomic,copy)NSString *userName;     //用户名
@property (nonatomic,copy)NSString *displayName;  //昵称
@property (nonatomic,copy)NSString *insertOrg;    //组织
@property (nonatomic,copy)NSString *insertSite;   //地点
@property (nonatomic,copy)NSString *personId;     //用户ID
@property (nonatomic,copy)NSString *name;         //环境

@end
