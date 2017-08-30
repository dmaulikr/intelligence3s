//
//  TravelRModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelRModel : NSObject
@property (nonatomic,strong)NSString *STANDARDFUELCONSUMPTION;    //标准油耗
@property (nonatomic,strong)NSString *DEPARTURE;                  //出发地
@property (nonatomic,strong)NSString *STARTDATE;                  //出车日期
@property (nonatomic,strong)NSString *STARTTIME;                  //出车时间
@property (nonatomic,strong)NSString *DRIVERID1;                  //司机
@property (nonatomic,strong)NSString *ENDNUMBER;                  //结束里程
@property (nonatomic,strong)NSString *GOREASON;                   //出车事由
@property (nonatomic,strong)NSString *LICENSENUM;                 //车牌号
@property (nonatomic,strong)NSString *NOWPROJECT;
@property (nonatomic,strong)NSString *CARDRIVELOGNUM;             //记录编号
@property (nonatomic,strong)NSString *WONUM;                      //业务单号
@property (nonatomic,strong)NSString *CREATEDATE;                 //创建时间
@property (nonatomic,strong)NSString *DRIVERNAME;                 //司机名称
@property (nonatomic,strong)NSString *DESTINATION;                //目的地
@property (nonatomic,strong)NSString *FEE;                        //路桥费
@property (nonatomic,strong)NSString *DRIVERID;                   //创建人
@property (nonatomic,strong)NSString *COMISORNO;                  //是否提交
@property (nonatomic,strong)NSString *PRODESC;
@property (nonatomic,strong)NSString *STARTNUMBER;                //起始里程
@property (nonatomic,strong)NSString *UDCARDRIVELOGID;
@property (nonatomic,strong)NSString *CREATEBY;                    //创建人名称
@property (nonatomic,strong)NSString *CARNAME;                     //车辆名称
@property (nonatomic,strong)NSString *WORKTYPE;                    //任务类型
@property (nonatomic,strong)NSString *BRANCHDESC;                  //所属中心
@property (nonatomic,strong)NSString *LASTFUELCONSUMPTION;         //上次油耗
@property (nonatomic,strong)NSString *DESCRIPTION;                 //描述

@end
