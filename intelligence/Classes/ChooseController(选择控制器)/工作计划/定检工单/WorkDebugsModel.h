//
//  WorkDebugsModel.h
//  intelligence
//
//  Created by chris on 16/9/10.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkDebugsModel : NSObject
@property (nonatomic,copy)NSString *WINDDRIVENGENERATORNUM; //风机编码
@property (nonatomic,copy)NSString *REMARK;
@property (nonatomic,copy)NSString *DISPOSE;                   //处理过程
@property (nonatomic,copy)NSString *QUESTION;                  //问题记录
@property (nonatomic,copy)NSString *SYNCHRONIZATIONDEBUGDATE;  //并网运行日期
@property (nonatomic,copy)NSString *DEBUGWORKORDERNUM;
@property (nonatomic,copy)NSString *CREW3;                     //调试工程师2
@property (nonatomic,copy)NSString *VESION;                    //程序版本号
@property (nonatomic,copy)NSString *DYNAMICDEBUGDATE;          //调试日期
@property (nonatomic,copy)NSString *DEBUGLEADER;               //调试组长
@property (nonatomic,copy)NSString *FJLOCATION;                //机台号
@property (nonatomic,copy)NSString *RESPONSIBLEPERSON;         //调试负责人
@property (nonatomic,copy)NSString *CREW2;                     //调试工程师2
@property (nonatomic,copy)NSString *UDDEBUGWORKORDERLINEID;
@property (nonatomic,copy)NSString *TIME1;                     //静态调试日期
@property (nonatomic,copy)NSString *TIME2;                     //动态调试日期
@property (nonatomic,copy)NSString *CREW;                      //调试工程师1
@property (nonatomic,assign)NSInteger isnumber;
@end
