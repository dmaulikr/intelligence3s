//
//  RemedialMeasuresCell.m
//  intelligence
//
//  Created by  on 16/8/20.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "RemedialMeasuresCell.h"

@interface RemedialMeasuresCell ()
{
    UILabel *labelFirst;
    UILabel *labelFirstAcross;
    UILabel *labelSecond;
    UILabel *labelSecondAcross;
    UILabel *labelThird;
    UILabel *labelThirdAcross;
    UILabel *labelFourth;
    UILabel *labelFourthAcross;
    UIView  *bottmLine;
}


@end

@implementation RemedialMeasuresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUI];
}

- (void)createUI{
    labelFirst = [[UILabel alloc] init];
    labelFirst.font = [UIFont systemFontOfSize:16.0];
    labelFirstAcross = [[UILabel alloc] init];
    labelFirstAcross.font = [UIFont systemFontOfSize:16.0];
    
    labelSecond = [[UILabel alloc] init];
    labelSecond.font = [UIFont systemFontOfSize:16.0];
    labelSecondAcross = [[UILabel alloc] init];
    labelSecondAcross.font = [UIFont systemFontOfSize:16.0];
    
    labelThird = [[UILabel alloc] init];
    labelThird.font = [UIFont systemFontOfSize:16.0];
    labelThirdAcross = [[UILabel alloc] init];
    labelThirdAcross.font = [UIFont systemFontOfSize:16.0];
    
    labelFourth = [[UILabel alloc] init];
    labelFourth.font = [UIFont systemFontOfSize:16.0];
    labelFourthAcross = [[UILabel alloc] init];
    labelFourthAcross.font = [UIFont systemFontOfSize:16.0];
    labelFourthAcross.numberOfLines = 0;
    
    bottmLine = [[UIView alloc] init];
    
    NSArray *views = @[labelFirst,labelFirstAcross,labelSecond,labelSecondAcross,labelThird,labelThirdAcross,labelFourth,labelFourthAcross,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    CGFloat leftLabelWight = 40;
    labelFirst.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(leftLabelWight)
    .heightIs(20);
    labelFirstAcross.sd_layout
    .leftSpaceToView(labelFirst,margin/2)
    .rightSpaceToView(contentView,margin)
    .topEqualToView(labelFirst)
    .heightIs(20);
    
    labelSecond.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(labelFirst,margin)
    .widthIs(leftLabelWight)
    .heightIs(20);
    labelSecondAcross.sd_layout
    .leftSpaceToView(labelSecond,margin/2)
    .rightSpaceToView(contentView,margin)
    .topEqualToView(labelSecond)
    .heightIs(20);
    
    labelThird.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(labelSecond,margin)
    .widthIs(leftLabelWight)
    .heightIs(20);
    labelThirdAcross.sd_layout
    .leftSpaceToView(labelThird,margin/2)
    .rightSpaceToView(contentView,margin)
    .topEqualToView(labelThird)
    .heightIs(20);
    
    
    bottmLine.sd_layout
    .topSpaceToView(labelThird,0)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
}

- (void)setCauseProblemModel:(CauseProblemModel *)causeProblemModel{
    _causeProblemModel = causeProblemModel;
    labelFirst.text = @"编号:";
    labelSecond.text = @"描述:";
    labelThird.text = @"位置:";
    
    if (causeProblemModel.FAILURECODE.length > 0) {
        labelFirstAcross.text = causeProblemModel.FAILURECODE;
    }else{
        labelFirstAcross.text = @"暂无数据";
        labelFirstAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if (causeProblemModel.CODEDESC.length > 0) {
        labelSecondAcross.text = causeProblemModel.CODEDESC;
    }else{
        labelSecondAcross.text = @"暂无数据";
        labelSecondAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if (causeProblemModel.LOCDESC.length > 0) {
        labelThirdAcross.text = causeProblemModel.LOCDESC;
    }else{
        labelThirdAcross.text = @"暂无数据";
        labelThirdAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"RemedialMeasuresCell";
    
    RemedialMeasuresCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RemedialMeasuresCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
