//
//  StockViewCell.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "StockViewCell.h"

@interface StockViewCell ()


@property (strong, nonatomic) IBOutlet UILabel *rightlabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomWidth;

@end
@implementation StockViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)stockViewCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"StockViewCell" owner:nil options:nil] lastObject];
}
//库存盘点
-(void)setStock:(StockModel *)stock{
    _stock = stock;
    [self clerText];
    self.topWidth.constant = 70;
    self.bottomWidth.constant = 38;
    self.topName.text = @"盘点单号:";
    self.bottomName.text = @"凭证号:";
    //self.rightlabel.text =stock.LOCDESC.length?stock.LOCDESC:@"";
    self.top.text = stock.STOCKNUM;
    self.bottom.text = stock.ZPDNUM.length?stock.ZPDNUM:@"暂无描述";;
}
//故障工单
-(void)setFauWork:(FauWorkModel *)fauWork{
    _fauWork = fauWork;
    [self clerText];
    self.topWidth.constant = 55;
    self.bottomWidth.constant = 38;
    self.topName.text = @"";
    self.bottomName.text = @"";
    self.top.text = fauWork.WONUM;
    self.bottom.text = fauWork.DESCRIPTION.length?fauWork.DESCRIPTION:@"暂无描述";
}
//调试工单
-(void)setDebug:(FauWorkModel *)debug{
    _debug = debug;
    [self clerText];
    self.topWidth.constant = 55;
    self.bottomWidth.constant = 38;
    self.topName.text = @"工单号:";
    self.bottomName.text = @"描述:";
    self.top.text = debug.DEBUGWORKORDERNUM;
    self.bottom.text = debug.DESCRIPTION.length?debug.DESCRIPTION:@"暂无描述";
}
// 流程审批
- (void)setProcess:(ProcessModel *)process{
    _process = process;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = process.WFASSIGNMENTID;
    self.bottom.text = process.DESCRIPTION.length?process.DESCRIPTION:@"暂无描述";
}
//工单任务
-(void)setWorksPlan:(WorksPlanModel *)worksPlan{
    _worksPlan = worksPlan;
    self.topName.text = @"任务号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 55;
    self.bottomWidth.constant = 38;
    self.top.text = worksPlan.TASKID;
    self.bottom.text = worksPlan.DESCRIPTION.length?worksPlan.DESCRIPTION:@"暂无描述";
}
//定检工单
-(void)setWorkDebug:(WorkDebugsModel *)workDebug{
    _workDebug = workDebug;
    self.topName.text = @"风机编号:";
    self.bottomName.text = @"调试负责人:";
    self.topWidth.constant = 100;
    self.bottomWidth.constant = 120;
    self.top.text = workDebug.WINDDRIVENGENERATORNUM.length?workDebug.WINDDRIVENGENERATORNUM:@"暂无编号";

    self.bottom.text = workDebug.RESPONSIBLEPERSON.length?workDebug.RESPONSIBLEPERSON:@"暂无描述";
}
//物料
-(void)setMateriels:(MaterielsModel *)materiels{
    _materiels = materiels;
    self.topName.text = @"物料编码:";
    self.bottomName.text = @"物料描述:";
    self.topWidth.constant = 70;
    self.bottomWidth.constant = 70;
    //    self.top.text = worksPlan.WORKORDERID;
    //    self.bottom.text = relatedRepairOrder.DESCRIPTION.length?worksPlan.DESCRIPTION:@"暂无描述";
}

// 相关故障工单
- (void)setRelatedRepairOrder:(RelatedRepairOrderModel *)relatedRepairOrder{
    _relatedRepairOrder = relatedRepairOrder;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = relatedRepairOrder.WORKORDERID;
    self.bottom.text = relatedRepairOrder.DESCRIPTION.length?relatedRepairOrder.DESCRIPTION:@"暂无描述";
}

// 支持部门
- (void)setSupportDepartment:(SupportDepartmentModel *)supportDepartment{
    _supportDepartment = supportDepartment;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = supportDepartment.DEPTNUM;
    self.bottom.text = supportDepartment.DESCRIPTION.length?supportDepartment.DESCRIPTION:@"暂无描述";
}

// 机位号
- (void)setFlightNo:(FlightNoModel *)flightNo{
    _flightNo = flightNo;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = flightNo.LOCNUM;
    self.bottom.text = flightNo.SAPDESC.length?flightNo.SAPDESC:@"暂无描述";
}
//终验收计划号
-(void)setFinal:(FinalModels *)final{
    _final = final;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = final.PLANNUM;
    self.bottom.text = final.PROJECTNUM.length?final.PROJECTNUM:@"暂无描述";
}

-(void)setRegular:(RegularModel *)regular{
    _regular = regular;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = regular.PLANNO;
    self.bottom.text = regular.PRODESC.length?regular.PRODESC:@"暂无描述";
}
-(void)setBusiness:(BusinessModel *)business{
    _business = business;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = business.NUM;
    self.bottom.text = business.DESCRIPTION.length?business.DESCRIPTION:@"暂无描述";
}

//定检编号
-(void)setCheack1:(CheackNumModel *)cheack1{
    _cheack1 = cheack1;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = cheack1.JPNUM;
    self.bottom.text = cheack1.DESCRIPTION.length?cheack1.DESCRIPTION:@"暂无描述";
}
//风机型号
-(void)setFanNum:(FanNumModle *)fanNum{
    _fanNum = fanNum;
    NSString *top;
    NSString *bottom;
    CGFloat topWidth;
    CGFloat bottomWidth;
    NSString *topStr;
    NSString *bottomStr;
    if (fanNum.types == ChooseTypeWUZI) {
        top = @"编号:";
        bottom = @"描述";
        topWidth = 38;
        bottomWidth = 38;
        topStr = fanNum.ITEMNUM;
        bottomStr = fanNum.DESCRIPTION;
    }else if (fanNum.types == ChooseTypeKUFA){
        top = @"编号:";
        bottom = @"描述";
        topWidth = 38;
        bottomWidth = 38;
        topStr = fanNum.LOCATION;
        bottomStr = fanNum.DESCRIPTION.length?fanNum.DESCRIPTION:@"暂无描述";
    }
    self.topName.text = top;
    self.bottomName.text = bottom;
    self.topWidth.constant = topWidth;
    self.bottomWidth.constant = bottomWidth;
    self.top.text = topStr;
    self.bottom.text = bottomStr;
}

// 设备位置
- (void)setEquipmentLocation:(EquipmentLocationModel *)equipmentLocation{
    _equipmentLocation = equipmentLocation;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = equipmentLocation.LOCATION;
    self.bottom.text = equipmentLocation.DESCRIPTION.length?equipmentLocation.DESCRIPTION:@"暂无描述";
}

// 故障类
- (void)setFaultClass:(FaultClassModel *)faultClass{
    _faultClass = faultClass;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    if (faultClass.isShow) {
        self.top.text = faultClass.FAILURECODE;
    }else{
        self.top.text = faultClass.FAILURELIST;
    }
    self.bottom.text = faultClass.CODEDESC.length?faultClass.CODEDESC:@"暂无描述";
}

// 故障代码
- (void)setFaultCode:(FaultCodeModel *)faultCode{
    _faultCode = faultCode;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
        self.top.text = faultCode.FAILURECODE;
        self.bottom.text = faultCode.CODEDESC.length?faultCode.CODEDESC:@"暂无描述";
}



-(void)setLedger:(LedgerModel *)ledger{
    _ledger = ledger;
    [self clerText];
    self.topName.text = @"项目编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 70;
    self.bottomWidth.constant = 38;
    self.top.text = ledger.PRONUM;
    self.bottom.text = ledger.DESCRIPTION;
}
-(void)setDaily:(DailyModel *)daily{
    _daily = daily;
    [self clerText];
    self.topName.text = @"项目编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 70;
    self.bottomWidth.constant = 38;
    self.top.text = daily.PRORUNLOGNUM;
    self.bottom.text = daily.DESCRIPTION.length?daily.DESCRIPTION:@"暂无描述";
}
-(void)setProblem:(ProblemModel *)problem{
    _problem = problem;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = problem.FEEDBACKNUM;
    self.bottom.text = problem.DESCRIPTION.length?problem.DESCRIPTION:@"暂无描述";
}
-(void)setPolling:(PollingModel *)polling{
    _polling = polling;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = polling.INSPONUM;
    self.bottom.text = polling.DESCRIPTION.length?polling.DESCRIPTION:@"暂无描述";
}
-(void)setRunlog:(RunlogModel *)runlog{
    _runlog = runlog;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = runlog.LOGNUM;
    self.bottom.text = runlog.DESCRIPTION.length?runlog.DESCRIPTION:@"暂无描述";
}
-(void)setPault:(PaultAppModel *)pault{
    _pault = pault;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = pault.REPORTNUM;
    self.bottom.text = pault.DESCRIPTION.length?pault.DESCRIPTION:@"暂无描述";
}
-(void)setTripReport:(TripReportModel *)tripReport
{
    _tripReport = tripReport;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = tripReport.SERIALNUMBER;
    self.bottom.text = tripReport.DESCRIPTION.length?tripReport.DESCRIPTION:@"暂无描述";
}
-(void)setTravel:(TravelRModel *)travel{
    _travel = travel;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"车牌号:";
    self.topWidth.constant = 65;
    self.bottomWidth.constant = 65;
    self.top.text = travel.CARDRIVELOGNUM;
    self.bottom.text = travel.DESCRIPTION;
}

-(void)setOil:(OilRModel *)oil{
    _oil = oil;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"车牌号:";
    self.topWidth.constant = 65;
    self.bottomWidth.constant = 65;
    self.top.text = oil.CARFUELCHARGENUM;
    self.bottom.text = oil.DESCRIPTION;
}
-(void)setMaters:(MaterielsModel *)maters{
    _maters = maters;
    [self clerText];
    self.topName.text = @"物资编号:";
    self.bottomName.text = @"物资描述:";
    self.topWidth.constant = 70;
    self.bottomWidth.constant = 70;
    self.top.text = maters.ITEMNUM;
    self.bottom.text = maters.ITEMDESC;
}

-(void)setMaintain:(MaintainModel *)maintain{
    _maintain = maintain;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = maintain.MAINLOGNUM;
    self.bottom.text = maintain.DESCRIPTION.length?maintain.DESCRIPTION:@"暂无描述";
}
-(void)setOptions:(OptionsMaintainModel *)options{
    _options = options;
    [self clerText];
    self.topName.text = @"编号:";
    self.bottomName.text = @"司机:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = options.LICENSENUM;
    self.bottom.text = options.DRIVER.length?options.DRIVER:@"暂无描述";
}

- (void)setChooseItemNo:(ChooseItemNoModel *)chooseItemNo{
    _chooseItemNo = chooseItemNo;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = chooseItemNo.PRONUM;
    self.bottom.text = chooseItemNo.DESCRIPTION.length?chooseItemNo.DESCRIPTION:@"暂无描述";
}

- (void)setChoosePerson:(ChoosePersonModel *)choosePerson{
    _choosePerson = choosePerson;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = choosePerson.PERSONID;
    self.bottom.text = choosePerson.DISPLAYNAME.length?choosePerson.DISPLAYNAME:@"暂无描述";
}

- (void)setFanType:(FanTypeModel *)fanType{
    _fanType = fanType;
    self.topName.text = @"编号:";
    self.bottomName.text = @"描述:";
    self.topWidth.constant = 38;
    self.bottomWidth.constant = 38;
    self.top.text = fanType.LOCNUM;
    self.bottom.text = fanType.MODELTYPE.length?fanType.MODELTYPE:@"暂无描述";
}

- (void)setDailyWork:(DailyWorkModel *)dailyWork{
    _dailyWork = dailyWork;
    self.topName.text = @"日期:";
    self.bottomName.text = @"天气:";
    self.topWidth.constant = 40;
    self.bottomWidth.constant = 40;
    self.top.text = dailyWork.RUNLOGDATE;
    self.bottom.text = dailyWork.WEATHER.length ? self.dailyWork.WEATHER : @"暂无描述";
}

- (void)setConstruction:(ConstructionModel *)construction{
    
    _construction = construction;
    self.topName.text = @"日期:";
    self.bottomName.text = @"项目负责人:";
    self.topWidth.constant = 110;
    self.bottomWidth.constant = 110;
    self.top.text = construction.CREATEDATE;
    self.bottom.text = construction.PERSONDESC.length ? self.construction.PERSONDESC : @"暂无描述";
}

- (void)setHoisting:(HoistingModel *)hoisting{
    _hoisting = hoisting;
    self.topName.text = @"日期:";
    self.bottomName.text = @"项目负责人:";
    self.topWidth.constant = 110;
    self.bottomWidth.constant = 110;
    self.top.text = hoisting.CREATEDATE;
    self.bottom.text = hoisting.NAME.length ? self.hoisting.NAME : @"暂无描述";
}

- (void)setToolingManagement:(ToolingManagementModel *)toolingManagement{
    _toolingManagement = toolingManagement;
    self.topName.text = @"日期:";
    self.bottomName.text = @"类型:";
    self.topWidth.constant = 110;
    self.bottomWidth.constant = 110;
    self.top.text = toolingManagement.RUNLOGDATE;
    self.bottom.text = toolingManagement.TYPE.length ? self.toolingManagement.TYPE : @"暂无描述";
}

-(void)clerText{
    self.topName.text = @"";
    self.bottom.text = @"";
    self.topWidth.constant = 0;
    self.bottomWidth.constant = 0;
    self.top.text = @"";
    self.bottom.text = @"";
}
-(void)setUdPRORUNLOGC:(UDPRORUNLOGC *)udPRORUNLOGC
{
    _udPRORUNLOGC = udPRORUNLOGC;
    self.topName.text = @"工作序号:";
    self.bottomName.text = @"工作性质:";
    self.topWidth.constant = 110;
    self.bottomWidth.constant = 110;
    self.top.text = udPRORUNLOGC.WORKNUM;
    self.bottom.text = udPRORUNLOGC.WORKTYPE.length?udPRORUNLOGC.WORKTYPE:@"暂无描述";
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
