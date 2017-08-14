//
//  TypeHeader.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#ifndef TypeHeader_h
#define TypeHeader_h
typedef enum {
    /** 故障*/
    ChoiceTypeFR,
    /** 验收*/
    ChoiceTypeAA,
    /** 定检*/
    ChoiceTypeTP,
    /** 技改*/
    ChoiceTypeTPS,
    /** 排查*/
    ChoiceTypeSP,
    /** 调试*/
    ChoiceTypeDC,
    /** 巡检*/
    ChoiceTypeXJ,
    /** 关闭*/
    ChoiceTypeClose,
    /** 日报时间-年*/
    ChoiceTypeDailYear,
    /** 日报时间-月*/
    ChoiceTypeDailMonth,
    /** 故障联络单-问题类型*/
    ChoiceTypeFaultType,
    /** 故障联络单-紧急程度*/
    ChoiceTypeFaultTypeDegree,
    /** 维修类型*/
    ChoiceTypeMaintain,
    /** 油品号*/
    ChoiceTypeOil,
    /** 运维管理-提报故障单-故障类型*/
    ChoiceTypeFaultFaultType,
    /** 运维管理-提报故障单-状态*/
    ChoiceTypeFaultState,
    /** 运维管理-巡检单-全部*/
    ChoiceTypePollingAll,
    /** 运维管理-巡检单-全部*/
    ChoiceTypeCC,
    /** 排查类型*/
    ChoiceTypePai,
    /** 技改类型*/
    ChoiceTypeJiGai,
    /** 定检类型*/
    ChoiceTypeDiJian,
    /** 加油卡编号*/
    ChoiceTypeBANH,
    /** d项目当前阶段*/
    ChoiceTypeProjectPhase,
    /** 天气*/
    ChoiceTypeWeather,
    /** 工作性质*/
    ChoiceTypeNatureWork,
    /** 完成情况*/
    ChoiceTypeCompletion,
    /** 工装类型*/
    ChoiceTypeToolingType,
    
}ChoiceType;
typedef enum {
    /** 风机型号*/
    ChooseTypeFNI,
    /** 物资编码*/
    ChooseTypeWUZI,
    /** 库房*/
    ChooseTypeKUFA,
    
}ChooseType;
typedef enum {
    /** 终验收*/
    WorkTypeCheck = 1,
    /** 调试工单*/
    WorkTypeDebug = 2,
}WorkType;


typedef enum {
    /** 全部*/
    StockTypeNone,
    /** search*/
    StockTypeSearch,
    /** 多选 search*/
    MultiStockTypeSearch
    
}StockType;
#endif /* TypeHeader_h */
