//
//  StockViewCell.h
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"
#import "FauWorkModel.h"
#import "ProcessModel.h"
#import "LedgerModel.h"
#import "DailyModel.h"
#import "ProblemModel.h"
#import "PollingModel.h"
#import "PaultAppModel.h"
#import "TravelRModel.h"
#import "OilRModel.h"
#import "MaintainModel.h"
#import "OptionsMaintainModel.h"
#import "ChooseItemNoModel.h"
#import "ChoosePersonModel.h"
#import "RelatedRepairOrderModel.h"
#import "SupportDepartmentModel.h"
#import "FlightNoModel.h"
#import "EquipmentLocationModel.h"
#import "FaultClassModel.h"
#import "FaultCodeModel.h"
#import "FinalModels.h"
#import "CheackNumModel.h"
#import "FanNumModle.h"
#import "WorksPlanModel.h"
#import "MaterielsModel.h"
#import "MaterielsModel.h"
#import "FanTypeModel.h"
#import "InspectProjectModel.h"
#import "DailyWorkModel.h"
#import "ConstructionModel.h"
#import "HoistingModel.h"
#import "ToolingManagementModel.h"
#import "ProjectPersonModel.h"
#import "ProjectCarsModel.h"
#import "WorkDebugsModel.h"
#import "RegularModel.h"
#import "BusinessModel.h"
#import "RunlogModel.h"
#import "TripReportModel.h"
#import "UDPRORUNLOGC.h"
#import "Runliner.h"
#import "DetailStockModel.h"

@interface StockViewCell : UITableViewCell
@property (nonatomic,strong)RegularModel  *regular;
@property (nonatomic,strong)MaterielsModel *maters;
@property (nonatomic,strong)StockModel *stock;
/** 故障工单*/
@property (nonatomic,strong)FauWorkModel *fauWork;
@property (nonatomic,strong)BusinessModel *business;
/** 调试工单*/
@property (nonatomic,strong)FauWorkModel *debug;
@property (nonatomic,strong)WorksPlanModel *worksPlan;
@property (nonatomic,strong)MaterielsModel *materiels;
@property (nonatomic,strong)FinalModels *final;
@property (nonatomic,strong)CheackNumModel *cheack1;
@property (nonatomic,strong)FanNumModle *fanNum;
@property (nonatomic, strong)ProcessModel *process;
@property (nonatomic,strong)LedgerModel *ledger;
@property (nonatomic,strong)DailyModel *daily;
@property (nonatomic,strong)ProblemModel *problem;
@property (nonatomic,strong)PollingModel *polling;
@property (nonatomic,strong)PaultAppModel *pault;
@property (nonatomic,strong)RunlogModel *runlog;
@property (nonatomic,strong)TravelRModel *travel;
@property (nonatomic,strong)OilRModel *oil;
@property (nonatomic,strong)InspectProjectModel * inspectProject;
@property (nonatomic,strong)MaintainModel *maintain;
@property (nonatomic,strong)OptionsMaintainModel *options;
@property (nonatomic, strong) ChooseItemNoModel *chooseItemNo;
@property (nonatomic, strong) ChoosePersonModel *choosePerson;
@property (nonatomic, strong) RelatedRepairOrderModel *relatedRepairOrder;
@property (nonatomic, strong) SupportDepartmentModel *supportDepartment;
@property (nonatomic, strong) FlightNoModel *flightNo;
@property (nonatomic, strong) EquipmentLocationModel *equipmentLocation;
@property (nonatomic, strong) FaultClassModel *faultClass;
@property (nonatomic, strong) FaultCodeModel *faultCode;
@property (nonatomic, strong) FanTypeModel *fanType;
@property (nonatomic, strong) TripReportModel *tripReport;
@property (nonatomic, strong) DailyWorkModel *dailyWork;
@property (nonatomic, strong) ConstructionModel *construction;
@property (nonatomic, strong) HoistingModel *hoisting;
@property (nonatomic, strong) ToolingManagementModel *toolingManagement;

@property (nonatomic, strong) WorkDebugsModel *workDebug;
@property (nonatomic, strong) UDPRORUNLOGC *udPRORUNLOGC;
@property (weak, nonatomic) IBOutlet UILabel *top;
@property (weak, nonatomic) IBOutlet UILabel *bottom;
@property (strong, nonatomic) IBOutlet UILabel *index;
@property (weak, nonatomic) IBOutlet UILabel *topName;
@property (weak, nonatomic) IBOutlet UILabel *bottomName;
+(instancetype)stockViewCell;
@end
