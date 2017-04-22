//
//  MaintainModel.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaintainModel : NSObject
@property (nonatomic,strong)NSString *MAINLOGNUM;          //编号
@property (nonatomic,strong)NSString *MAINNUMBER;          //维修数量
@property (nonatomic,strong)NSString *MAINPLACE;           //维修地点
@property (nonatomic,strong)NSString *STARTDATE;           //维修开始日期
@property (nonatomic,strong)NSString *TOTALPRICE;          //维修总额
@property (nonatomic,strong)NSString *MAINDATE;            //
@property (nonatomic,strong)NSString *DRIVERID1;           //司机
@property (nonatomic,strong)NSString *INVOICENUM;          //维修发票号
@property (nonatomic,strong)NSString *MAINCONTENT;         //维修,保养,更换,表读数
@property (nonatomic,strong)NSString *UDCARMAINLOGID;
@property (nonatomic,strong)NSString *LICENSENUM;          //车牌号
@property (nonatomic,strong)NSString *NUMBER1;            //本次维修里程表读数
@property (nonatomic,strong)NSString *ENDDATE;             //维修结束日期
@property (nonatomic,strong)NSString *NUMBER2;             //上次维修里程表读数
@property (nonatomic,strong)NSString *CREATEDATE;           //录入日期
@property (nonatomic,strong)NSString *DRIVERNAME;
@property (nonatomic,strong)NSString *VEHICLENAME;          //车辆名称
@property (nonatomic,strong)NSString *DRIVERID;
@property (nonatomic,strong)NSString *COMISORNO;            //是否提交
@property (nonatomic,strong)NSString *PRODESC;              //所属项目
@property (nonatomic,strong)NSString *REMARK;               //备注
@property (nonatomic,strong)NSString *RESPNAME;             //责任人
@property (nonatomic,strong)NSString *CREATEBY;             //录入人
@property (nonatomic,strong)NSString *BRANCHDESC;           //所属中心
@property (nonatomic,strong)NSString *RESPONSID;
@property (nonatomic,strong)NSString *SERVICETYPE;          //维修类型
@property (nonatomic,strong)NSString *PRICE;                //维修单价
@property (nonatomic,strong)NSString *DESCRIPTION;           //描述
@end
