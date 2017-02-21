//
//  LedgerDetailsCell.m
//  intelligence
//
//  Created by 丁进宇 on 16/7/24.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "LedgerDetailsCell.h"
#import "LedgerModel.h"

@interface LedgerDetailsCell ()
{
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIView  *bottmLine;
}

@property (nonatomic, strong) LedgerModel *ledger;
@property (nonatomic, assign) NSInteger index;

@end

@implementation LedgerDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    .widthIs(110)
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

- (void)setIndex:(NSInteger)index withModel:(LedgerModel *)ledger{
    self.index = index;
    self.ledger = ledger;
    
}

- (void)setProcess:(LedgerModel *)ledger{
//    _ledger = ledger;
//    switch (_ledger.index) {
//        case 0: leftLabel.text  = @"应用程序名:";
//            rightLabel.text = _ledger.OWNERTABLE; break;
//        case 1: leftLabel.text  = @"描述:";
//            rightLabel.text = _ledger.DESCRIPTION; break;
//        case 2: leftLabel.text  = @"任务分配人:";
//            rightLabel.text = _ledger.ORIGPERSON; break;
//        case 3: leftLabel.text  = @"到期日期:";
//            rightLabel.text = _ledger.DUEDATE; break;
//        case 4: leftLabel.text  = @"过程名称:";
//            rightLabel.text = _ledger.OWNERTABLE; break;
//        case 5: leftLabel.text  = @"任务角色:";
//            rightLabel.text = _ledger.ROLEID; break;
//        case 6: leftLabel.text  = @"当前日期:";
//            rightLabel.text = _ledger.STARTDATE; break;
//            
//        default:
//            break;
//    }
    
    if (rightLabel.text.length < 1) {
        rightLabel.text = @" ";
    }
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"LedgerDetailsCell";
    
    LedgerDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"LedgerDetailsCell" owner:nil options:nil].lastObject;
    }
    return cell;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
