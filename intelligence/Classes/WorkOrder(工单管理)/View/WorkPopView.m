//
//  WorkPopView.m
//  intelligence
//
//  Created by chris on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "WorkPopView.h"

@interface WorkPopView ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
@implementation WorkPopView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
   
}
-(void)addData:(ChoiceType)type{

    switch (type) {
        case ChoiceTypeFR:{
            _dataArray = @[
                           @"新建",@"待审批",@"进行中",@"待反馈",@"等待物料",@"已反馈",@"物料已申请",
                           @"驳回",@"已完成",@"已关闭",@"全部",@"本地记录"
                           ];
        }break;
        case ChoiceTypeAA:{
            _dataArray = @[
                           @"新建",@"待审批",@"待整改",@"已完成",@"已关闭",@"已取消",@"全部",@"本地记录"
                           ];
        }break;
        case ChoiceTypeJiGai:{
            _dataArray = @[
                           @"供应商",@"技术系统",@"运行系统",
                           ];
        }break;
        case ChoiceTypeClose:{
            _dataArray = @[
                           @"新建",@"待审批",@"待整改",@"已完成",@"已关闭",@"已取消",@"全部",@"本地记录"
                           ];
        }break;
        case ChoiceTypeMaintain:{
            _dataArray = @[
                           @"事故维修",@"保养",@"正常维修",
                           ];
        }break;
        case ChoiceTypeOil:{
            _dataArray = @[
                           @"0#柴油",@"100#汽油",@"90#汽油",@"92#汽油",@"93#汽油",@"95#汽油",@"97#汽油",@"98#汽油",
                           ];
        }break;
        case ChoiceTypeSP:{
            _dataArray = @[
                           @"新建",@"待汇报",@"已汇报",@"待整改",@"已完成",@"驳回",@"已关闭",@"全部",@"本地"
                           ];
        }break;
        case ChoiceTypeTPS:{
            _dataArray = @[
                           @"新建",@"进行中",@"已完成",@"驳回",@"已关闭",@"全部",@"本地记录",
                           ];
        }break;
        case ChoiceTypeTP:{
            _dataArray = @[
                           @"新建",@"待审批",@"进行中",@"待反馈",@"等待物料",@"已反馈",@"物料已申请",@"驳回",@"已完成",@"已关闭",@"全部",@"本地记录",
                           ];
        }break;
        case ChoiceTypeBANH:{
            _dataArray = @[
                           @"118",@"456",@"111",@"123",
                           ];
        }break;
        case ChoiceTypeDC:{
            _dataArray = @[
                           @"已审批",@"新建",@"待审批",@"已完成",@"全部",@"本地记录"
                           ];
        }break;
            
        case ChoiceTypeToolingType:{
            _dataArray = @[
                           @"1.5MW轮毂工装",@"1.5MW叶根工装",@"1.5MW叶尖工装",@"1.5MW主机工装",@"1.5MW主机工装后支撑",@"2.0MW轮毂工装",@"2.0MW叶根工装",@"2.0MW叶尖工装",@"2.0MW主机工装",@"2.0MW主机工装",@"2.0MW主机工装后支撑"
                           ];
        }break;
            
        case ChoiceTypeDailYear:{
            //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //            formatter.dateFormat = @"yyyy";
            //            NSString *str = [formatter stringFromDate:[NSDate date]];
            //            NSInteger year = [str integerValue];
            //            NSMutableArray *array = [NSMutableArray array];
            //            for (int i = 0; i < 3; i++) {
            //                switch (i) {
            //                    case 0:{
            //                        NSString *yearStr = [NSString stringWithFormat:@"%ld",year-1];
            //                        [array addObject:yearStr];
            //                    } break;
            //                    case 1:{
            //                        NSString *yearStr = [NSString stringWithFormat:@"%ld",year];
            //                        [array addObject:yearStr];
            //                    } break;
            //                    case 2:{
            //                        NSString *yearStr = [NSString stringWithFormat:@"%ld",year+1];
            //                        [array addObject:yearStr];
            //                    } break;
            //
            //                    default:
            //                        break;
            //                }
            //            }
            //            _dataArray = array;
            _dataArray = @[
                           @"2016",@"2017",@"2018",@"2019",@"2020",@"2021"
                           ];
        }
            
            break;
        case ChoiceTypeDailMonth:{
            _dataArray = @[
                           @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"
                           ];
        }break;
            
        case ChoiceTypeFaultType:{
//            _dataArray = @[@"备件", @"村民阻工", @"技术支持", @"人员", @"资料",@"车辆问题和其他问题"];
            _dataArray = @[@"备件", @"村民阻工", @"技术支持", @"人员", @"资料",@"车辆问题",@"其他问题"];
        }break;
            
        case ChoiceTypeFaultTypeDegree:{
            _dataArray = @[@"一般", @"严重", @"非常严重", @"致命"];
        }break;
            
        case ChoiceTypeFaultFaultType:{
            _dataArray = @[@"电气", @"机械", @"塔筒", @"叶片", @"液压", @"其他"];
        }break;
            
        case ChoiceTypeFaultState:{
            _dataArray = @[@"新建", @"已提报", @"已关闭"];
        }break;
            
        case ChoiceTypePollingAll:{
            _dataArray = @[@"新建", @"待执行", @"待审批", @"已完成", @"驳回", @"全部", @"本地记录"];
        }break;
        case ChoiceTypePai:{
            _dataArray = @[@"风机安全排查", @"管理质量排查"];
        }break;
        case ChoiceTypeDiJian:{
            _dataArray = @[@"半年检",@"对中",@"全年检",@"首年检"];
        }break;
        case ChoiceTypeProjectPhase:{
            _dataArray = @[@"调试期",@"前期",@"质保期",@"质保外"];
        }break;
        case ChoiceTypeWeather:{
            _dataArray = @[@"暴雪",@"大暴雨",@"大雪",@"大雨",@"多云",@"雷阵雨",@"晴",@"小雪",@"小雨",@"阴"];
        }break;
        case ChoiceTypeNatureWork:{
            _dataArray = @[@"程序刷新",@"定检",@"故障消除",@"维护",@"巡检",@"运行",@"专项技改",@"其他"];
        }break;
        case ChoiceTypeCompletion:{
            _dataArray = @[@"已完成",@"未完成"];
        }break;
            
        default:
            break;
    }
    
    [self.tableview reloadData];
}
+(instancetype)workPopView{
    return [[[NSBundle mainBundle]loadNibNamed:@"WorkPopView" owner:nil options:nil] lastObject];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = font(15);
    cell.textLabel.text = _dataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.WorkBlock) {
        self.WorkBlock(_dataArray[indexPath.section]);
    }
}


@end
