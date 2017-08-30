//
//  ProcessDetailsCell.m
//  intelligence
//
//  Created by  on 16/7/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProcessDetailsCell.h"
#import "LabelSize.h"

@interface ProcessDetailsCell ()
{
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIView  *bottmLine;
}


@end

@implementation ProcessDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUI];
    
}
- (void)createUI{
    leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:16.0];
    rightLabel.numberOfLines = 0;
    
    bottmLine = [[UIView alloc] init];
    
    NSArray *views = @[leftLabel,rightLabel,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_leftLabelWight)
    .heightIs(20);
    
    rightLabel.sd_layout
    .leftSpaceToView(leftLabel,margin/2)
    .rightSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .autoHeightRatio(0);
    
    bottmLine.sd_layout
    .topSpaceToView(rightLabel,0)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
}
- (void)setIndex:(NSInteger)index withModel:(ProcessModel *)process{
    self.index = index;
    self.process = process;
    
}

- (void)setProcess:(ProcessModel *)process{
    _process = process;
    leftLabel.sd_layout.widthIs( _process.leftLabelWight);
    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
    
    switch (_process.index) {
        case 0: leftLabel.text  = @"流程审批名:";
            rightLabel.text = _process.UDASSIGN01; break;
        case 1: leftLabel.text  = @"描述:";
            rightLabel.text = _process.DESCRIPTION; break;
        case 2: leftLabel.text  = @"流程发起人:";
            rightLabel.text = _process.UDASSIGN02; break;
        case 3: leftLabel.text  = @"流程发起日:";
            rightLabel.text = _process.STARTDATE; break;
            
        default:
            break;
    }
   
    if (rightLabel.text.length < 1) {
        rightLabel.text = @" ";
    }
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

- (void)setLedger:(LedgerModel *)ledger{
    _ledger = ledger;

    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
//    switch (_ledger.index) {
//        case 0: leftLabel.text  = @"项目编号:";
//            rightLabel.text = _ledger.PRONUM; break;
//        case 1: leftLabel.text  = @"项目名称:";
//            rightLabel.text = _ledger.DESCRIPTION; break;
//        case 2: leftLabel.text  = @"所属中心:";
//            rightLabel.text = _ledger.BRANCH; break;
//        case 3: leftLabel.text  = @"责任人:";
//            rightLabel.text = _ledger.RESPONS; break;
//        case 4: leftLabel.text  = @"业主单位:";
//            rightLabel.text = _ledger.OWNER; break;
//        case 5: leftLabel.text  = @"签订时间:";
//            rightLabel.text = _ledger.SIGNDATE; break;
//        case 6: leftLabel.text  = @"合同状态:";
//            rightLabel.text = _ledger.CONTRACTSTATUS; break;
//        case 7: leftLabel.text  = @"项目试点:";
//            rightLabel.text = _ledger.TESTPRO; break;
//        case 8: leftLabel.text  = @"项目当前阶段:";
//            rightLabel.text = _ledger.PROSTAGE; break;
//        case 9: leftLabel.text  = @"总厂容量(MW):";
//            rightLabel.text = _ledger.CAPACITY; break;
//        case 10: leftLabel.text  = @"保质期(年):";
//            rightLabel.text = _ledger.PERIOD; break;
//                    
//        default:
//            break;
//    }
    
    if (rightLabel.text.length < 1) {
        rightLabel.text = @"暂无数据";
        rightLabel.textColor = [UIColor grayColor];
    }else{
        rightLabel.textColor = [UIColor blackColor];
    }
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
    
}

- (void)setDaily:(DailyModel *)daily{
    _daily = daily;
    //leftLabel.sd_layout.widthIs(_daily.leftLabelWight);
    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
//    switch (_daily.index) {
//        case 0: leftLabel.text  = @"日志编号:";
//            rightLabel.text = _daily.PRORUNLOGNUM;
//            break;
//        case 1: leftLabel.text  = @"描述:";
//            rightLabel.text = _daily.DESCRIPTION;
//            break;
//        case 2: leftLabel.text  = @"项目编号:";break;
//            
//        case 3: leftLabel.text  = @"所属中心:";
//            rightLabel.text = _daily.BRANCH;
//            break;
//        case 4: leftLabel.text  = @"现场负责人:";
//            rightLabel.text = _daily.UDPRORESC;
//            break;
//        case 5: leftLabel.text  = @"现场联系人:";break;
//            
//        case 6: leftLabel.text  = @"年:";break;
//            
//        case 7: leftLabel.text  = @"月:";break;
//            
//        case 8: leftLabel.text  = @"项目阶段:";
//            rightLabel.text = _daily.PROSTAGE;
//            break;
//        case 9: leftLabel.text  = @"状态:";
//            rightLabel.text = _daily.STATUS;
//            break;
//            
//        default:
//            break;
//    }
    
    if (rightLabel.text.length < 1) {
        rightLabel.text = @"暂无数据";
    }
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProcessDetailsCell";
    
    ProcessDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProcessDetailsCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
