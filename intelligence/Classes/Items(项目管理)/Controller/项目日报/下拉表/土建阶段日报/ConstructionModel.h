//
//  ConstructionModel.h
//  intelligence
//
//  Created by chris on 16/9/5.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstructionModel : NSObject

@property (nonatomic, copy) NSString *CREATEDATE;
@property (nonatomic, copy) NSString *PERSONID;
@property (nonatomic, copy) NSString *FUNNUM;
@property (nonatomic, copy) NSString *PROPHASE;
@property (nonatomic, copy) NSString *LAND;
@property (nonatomic, copy) NSString *INSIDEROAD;
@property (nonatomic, copy) NSString *OUTSIDEROAD;
@property (nonatomic, copy) NSString *VILLAGERINVOLVED;
@property (nonatomic, copy) NSString *REMARK;
@property (nonatomic, copy) NSString *KEYPOINT;
@property (nonatomic, copy) NSString *BASESTART;
@property (nonatomic, copy) NSString *BASEPLACING;
@property (nonatomic, copy) NSString *BASEAOG;
@property (nonatomic, copy) NSString *TAMERAOG;
@property (nonatomic, copy) NSString *VEHICLERECORDS;
@property (nonatomic, copy) NSString *mboObjectName;
@property (nonatomic, copy) NSString *PERSONDESC;
@property (nonatomic, copy) NSString *UDPRORUNLOGLINE1ID;
@property (nonatomic, strong) NSDictionary *dic;

@end
