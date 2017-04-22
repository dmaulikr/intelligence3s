//
//  FanTypeModel.h
//  intelligence
//
//  Created by  on 16/8/23.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanTypeModel : NSObject

@property (nonatomic, copy) NSString *PRONUM;
@property (nonatomic, copy) NSString *TJDATE;
@property (nonatomic, copy) NSString *XJDATE;
@property (nonatomic, copy) NSString *TSDATE;
@property (nonatomic, copy) NSString *SAPDESC;
@property (nonatomic, copy) NSString *DJDATE4;
@property (nonatomic, copy) NSString *MODELTYPE;
@property (nonatomic, copy) NSString *DJDATE5;
@property (nonatomic, copy) NSString *DZDATE;
@property (nonatomic, copy) NSString *JDDATE3;
@property (nonatomic, copy) NSString *UDFANDETAILSID;
@property (nonatomic, copy) NSString *LOCNUM;
@property (nonatomic, copy) NSString *EMPST;
@property (nonatomic, copy) NSString *XJDATE2;
@property (nonatomic, copy) NSString *YYSDATE;
@property (nonatomic, copy) NSString *SAPNUM;
@property (nonatomic, copy) NSString *STATUS;
@property (nonatomic, copy) NSString *DJDATE1;
@property (nonatomic, copy) NSString *SITEID;
@property (nonatomic, copy) NSString *BWDATE;
@property (nonatomic, copy) NSString *ZYYDATE;
@property (nonatomic, copy) NSString *DJDATE2;

- (NSComparisonResult)compareParkInfo:(FanTypeModel *)parkinfo;

@end
