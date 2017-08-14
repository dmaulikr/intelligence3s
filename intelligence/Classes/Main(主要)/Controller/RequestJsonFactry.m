//
//  RequestJsonFactry.m
//  intelligence
//
//  Created by chris on 2017/8/7.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "RequestJsonFactry.h"

@implementation RequestJsonFactry
//预警排查工单
+(NSDictionary*)getRequestJsonfor_YJPCGD_With:(NSString*) search page:(NSInteger)page
{
    
    search = search.length>0?search:@"";
    NSDictionary *requestDic= @{
                      @"appid"     :@"UDWARNINGWO",
                      @"objectname":@"UDWARNINGWO",
                      @"curpage"   :@(page),
                      @"showcount" :@(20),
                      @"option"    :@"read",
                      @"orderby"   :@"UDWARNINGWOID DESC",
                      @"sinorsearch":@{@"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                      };
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//故障工单
+(NSDictionary*)getRequestJsonfor_GZGD_With:(NSString*) search page:(NSInteger)page
{
        search = search.length>0?search:@"";
        NSDictionary *requestDic = @{
                       @"appid"     :@"UDREPORTWO",
                       @"objectname":@"WORKORDER",
                       @"curpage"   :@(page),
                       @"showcount" :@(20),
                       @"option"    :@"read",
                       @"orderby"   :@"WORKORDERID desc",
                       @"condition" :@{@"WORKTYPE":@"FR",@"ISTASK":@(0),@"HISTORYFLAG":@(0)},
                       @"sinorsearch":@{@"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                       };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//调试工单
+(NSDictionary*)getRequestJsonfor_TSGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                   @"appid"     :@"DEBUGORDER",
                   @"objectname":@"DEBUGWORKORDER",
                   @"curpage"   :@(page),
                   @"showcount" :@(20),
                   @"option"    :@"read",
                   @"orderby"   :@"DEBUGWORKORDERID desc",
                   @"sinorsearch":@{@"DEBUGWORKORDERNUM":search,@"DESCRIPTION":search},
                   };
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    return dataDic;
}
//巡检工单
+(NSDictionary*)getRequestJsonfor_XJGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDINSPOAPP",
                                 @"objectname":@"UDINSPO",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDINSPOID DESC",
                                 @"sinorsearch":@{@"INSPONUM":search,@"DESCRIPTION":search,@"STATUS":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//定检工单
+(NSDictionary*)getRequestJsonfor_DJGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                   @"appid"     :@"UDDJWO",
                   @"objectname":@"WORKORDER",
                   @"curpage"   :@(page),
                   @"showcount" :@(20),
                   @"option"    :@"read",
                   @"orderby"   :@"WORKORDERID desc",
                   @"condition" :@{@"WORKTYPE":@"WS",@"ISTASK":@(0),@"HISTORYFLAG":@(0)},
                   @"sinorsearch":@{@"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                   };
    
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//排查工单
+(NSDictionary*)getRequestJsonfor_PCGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                   @"appid"     :@"UDPCWO",
                   @"objectname":@"WORKORDER",
                   @"curpage"   :@(page),
                   @"showcount" :@(20),
                   @"option"    :@"read",
                   @"orderby"   :@"WORKORDERID desc",
                   @"condition" :@{@"WORKTYPE":@"SP",@"ISTASK":@(0),@"HISTORYFLAG":@(0)},
                   @"sinorsearch":@{ @"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                   };
    
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//技改工单
+(NSDictionary*)getRequestJsonfor_JGGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                   @"appid"     :@"UDJGWO",
                   @"objectname":@"WORKORDER",
                   @"curpage"   :@(page),
                   @"showcount" :@(20),
                   @"option"    :@"read",
                   @"orderby"   :@"WORKORDERID desc",
                   @"condition" :@{@"WORKTYPE":@"TP",@"ISTASK":@(0),@"HISTORYFLAG":@(0)},
                   @"sinorsearch":@{@"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                   };
    
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//终验收工单
+(NSDictionary*)getRequestJsonfor_ZYSGD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                   @"appid"     :@"UDZYSWO",
                   @"objectname":@"WORKORDER",
                   @"curpage"   :@(page),
                   @"showcount" :@(20),
                   @"option"    :@"read",
                   @"orderby"   :@"WORKORDERID desc",
                   @"condition" :@{@"WORKTYPE":@"AA",@"ISTASK":@(0),@"HISTORYFLAG":@(0)},
                   @"sinorsearch":@{ @"WONUM":search,@"DESCRIPTION":search,@"UDSTATUS":search}
                   };
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//项目台账
+(NSDictionary*)getRequestJsonfor_XMTJ_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDPROJECT",
                                 @"objectname":@"UDPRO",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"TESTPRO,PRONUM",
                                 @"sinorsearch":@{@"PRONUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//项目日报
+(NSDictionary*)getRequestJsonfor_XMRB_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDPRORUN",
                                 @"objectname":@"UDPRORUNLOG",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"PRORUNLOGNUM desc",
                                 @"sinorsearch":@{@"PRORUNLOGNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//问题联络单
+(NSDictionary*)getRequestJsonfor_WTLLD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";

    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDFEDBKCON",
                                 @"objectname":@"UDFEEDBACK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"FEEDBACKNUM desc",
                                 @"sinorsearch":@{@"FEEDBACKNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//出差报告
+(NSDictionary*)getRequestJsonfor_CCBG_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"TRIPREPORT",
                                 @"objectname":@"UDTRIPREPORT",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDTRIPREPORTID DESC",
                                 @"sinorsearch":@{@"SERIALNUMBER":search,@"DESCRIPTION":search,@"STATUS":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//运行记录
+(NSDictionary*)getRequestJsonfor_YXJL_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDRUNLOG",
                                 @"objectname":@"UDRUNLOGR",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDRUNLOGRID DESC",
                                 @"sinorsearch":@{@"LOGNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//故障提报单
+(NSDictionary*)getRequestJsonfor_GZTBD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDREPORT",
                                 @"objectname":@"UDREPORT",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDREPORTID DESC",
                                 @"sinorsearch":@{@"REPORTNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//行驶记录
+(NSDictionary*)getRequestJsonfor_XSJL_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDCARDRIVE",
                                 @"objectname":@"UDCARDRIVELOG",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDCARDRIVELOGID DESC",
                                 @"sinorsearch":@{@"CARDRIVELOGNUM":search,@"GOREASON":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//加油记录
+(NSDictionary*)getRequestJsonfor_JYJL_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";

    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDCARFUELC",
                                 @"objectname":@"UDCARFUELCHARGE",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDCARFUELCHARGEID DESC",
                                 @"sinorsearch":@{@"CARFUELCHARGENUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//车辆维修
+(NSDictionary*)getRequestJsonfor_CLWX_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";

    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDCARMAIN",
                                 @"objectname":@"UDCARMAINLOG",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDCARMAINLOGID DESC",
                                 @"sinorsearch":@{@"MAINLOGNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//库存盘点
+(NSDictionary*)getRequestJsonfor_KCPD_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDSTOCK",
                                 @"objectname":@"UDSTOCK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDSTOCKID DESC",
                                 @"sinorsearch":@{@"STOCKNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//流程审批
+(NSDictionary*)getRequestJsonfor_LCSP_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDSTOCK",
                                 @"objectname":@"UDSTOCK",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"STOCKNUM DESC",
                                 @"sinorsearch":@{@"STOCKNUM":search,@"DESCRIPTION":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//调试工单子表
+(NSDictionary*)getRequestJsonfor_TSGDZB_With:(NSString*) search page:(NSInteger)page
{
    search = search.length>0?search:@"";
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"UDDEBUGWORKORDERLINE",
                                 @"objectname":@"UDDEBUGWORKORDERLINE",
                                 @"curpage"   :@(page),
                                 @"showcount" :@(20),
                                 @"option"    :@"read",
                                 @"orderby"   :@"UDDEBUGWORKORDERLINEID",
                                 @"sinorsearch":@{@"DEBUGWORKORDERNUM":search}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    return dataDic;
}
//人员
+(NSDictionary*)getRequestJsonfor_RY_With:(NSString*) search page:(NSInteger)page
{
    return nil;
}
//风机
+(NSDictionary*)getRequestJsonfor_FJ_With:(NSString*) search page:(NSInteger)page
{
    return nil;
}
@end
