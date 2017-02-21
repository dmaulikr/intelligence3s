//
//  OilRModel.h
//  intelligence
//
//  Created by 光耀 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OilRModel : NSObject
@property (nonatomic,strong)NSString *LASTNUMBER;
@property (nonatomic,strong)NSString *UDCARFUELCHARGEID;
@property (nonatomic,strong)NSString *PLACE;                        //加油地点
@property (nonatomic,strong)NSString *DRIVERID1;                    //司机
@property (nonatomic,strong)NSString *INVOICENUM;                   //发票号
@property (nonatomic,strong)NSString *LICENSENUM;                    //车牌号
@property (nonatomic,strong)NSString *NUMBER1;                       //本次加油里程表读数
@property (nonatomic,strong)NSString *CARFUELCHARGENUM;              //编号
@property (nonatomic,strong)NSString *NUMBER2;                      //上次加油里程表读数
@property (nonatomic,strong)NSString *CHARGEDATE;                   //加油日期
@property (nonatomic,strong)NSString *CREATEDATE;                   //录入日期
@property (nonatomic,strong)NSString *DRIVERNAME;
@property (nonatomic,strong)NSString *BRACHDESC;                    //所属中心
@property (nonatomic,strong)NSString *DRIVERID;                     //录入编号
@property (nonatomic,strong)NSString *COMISORNO;                    //是否提交
@property (nonatomic,strong)NSString *FUELCOST;                      //加油费
@property (nonatomic,strong)NSString *NUMBER3;                       //里程差
@property (nonatomic,strong)NSString *PRODESC;                       //所属项目
@property (nonatomic,strong)NSString *CREATEBY;                      //录入人
@property (nonatomic,strong)NSString *NUMBER4;                       //油品号
@property (nonatomic,strong)NSString *REMARK;                        //备注
@property (nonatomic,strong)NSString *RESPNAME;                      //责任人
@property (nonatomic,strong)NSString *VEHICLENAME;                    //车辆名称
@property (nonatomic,strong)NSString *NUMBER5;                        //本次加油量
@property (nonatomic,strong)NSString *RESPONSID;
@property (nonatomic,strong)NSString *LASTFUELCONSUMPTION;            //油耗
@property (nonatomic,strong)NSString *PRICE;                          //单价
@property (nonatomic,strong)NSString *DESCRIPTION;                    //描述
@end
