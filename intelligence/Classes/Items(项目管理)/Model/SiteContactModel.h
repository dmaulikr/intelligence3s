//
//  SiteContactModel.h
//  intelligence
//
//  Created by  on 16/8/12.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiteContactModel : NSObject

@property (nonatomic, copy) NSString *BRANCH;
@property (nonatomic, copy) NSString *BUKRS;
@property (nonatomic, copy) NSString *DEPARTMENT;
@property (nonatomic, copy) NSString *PRIMARYPHONE;    // 手机号
@property (nonatomic, copy) NSString *UDJBDESCRIPTION; // 职位
@property (nonatomic, copy) NSString *EMAIL;         // 邮箱
@property (nonatomic, copy) NSString *DISPLAYNAME;   // 描述
@property (nonatomic, copy) NSString *UDPRONUM;      // 项目编号
@property (nonatomic, copy) NSString *DEPARTDESC;    // 所属部门
@property (nonatomic, copy) NSString *PERSONID;      // 编号



@end
