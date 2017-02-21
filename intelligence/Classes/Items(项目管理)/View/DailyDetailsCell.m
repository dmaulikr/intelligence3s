//
//  DailyDetailsCell.m
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DailyDetailsCell.h"

@interface DailyDetailsCell ()
{
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIView  *bottmLine;
    UIImageView *rightImageView;
}


@end

@implementation DailyDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUI];
}

- (void)createUI{
    leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"more_next_icon"];
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:16.0];
    rightLabel.numberOfLines = 0;
    
    bottmLine = [[UIView alloc] init];
    
    NSArray *views = @[leftLabel,rightImageView,rightLabel,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_leftLabelWight)
    .heightIs(20);
    
    rightImageView.sd_layout
    .centerYEqualToView(contentView)
    .rightSpaceToView(contentView,margin)
    .widthIs(7)
    .heightIs(22);
    
    rightLabel.sd_layout
    .leftSpaceToView(leftLabel,margin/2)
    .rightSpaceToView(rightImageView,margin)
    .topSpaceToView(contentView,margin)
    .autoHeightRatio(0);
    
    bottmLine.sd_layout
    .topSpaceToView(rightLabel,0)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
}

- (void)setDaily:(DailyModel *)daily;{
    _daily = daily;
    leftLabel.sd_layout.widthIs(_daily.leftLabelWight);
    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
    switch (_daily.index) {
        case 0: leftLabel.text  = @"日志编号:"; break;
        case 1: leftLabel.text  = @"描述:";    break;
        case 2: leftLabel.text  = @"项目编号:";
            rightLabel.text = _daily.PRONUM; break;
            
        case 3: leftLabel.text  = @"所属中心:"; break;
        case 4: leftLabel.text  = @"现场负责人:";break;
        case 5: leftLabel.text  = @"现场联系人:";
            rightLabel.text = _daily.CONTDESC; break;
            
        case 6: leftLabel.text  = @"年:";
            rightLabel.text = _daily.YEAR; break;
            
        case 7: leftLabel.text  = @"月:";
            rightLabel.text = _daily.MONTH; break;
            
        case 8: leftLabel.text  = @"项目阶段:"; break;
        case 9: leftLabel.text  = @"状态:";    break;
            
        default:
            break;
    }
    
    if (rightLabel.text.length < 1) {
        rightLabel.text = @"暂无数据";
    }
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"DailyDetailsCell";
    
    DailyDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DailyDetailsCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
