//
//  ProblemDetailsLBCells.m
//  intelligence
//
//  Created by  on 16/8/3.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "ProblemDetailsLBCells.h"

@interface ProblemDetailsLBCells ()
{
    UIButton *rightBtn;
    UILabel *leftLabel;
    UIView *bottomLine;
}

@end

@implementation ProblemDetailsLBCells

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUI];
}

- (void)createUI{
    leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"联络单未选择"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"联络单选择"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    
    NSArray *views = @[leftLabel,rightBtn,bottomLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_leftLabelWight)
    .heightIs(20);
    
    rightBtn.sd_layout
    .leftSpaceToView(leftLabel,margin)
    .centerYEqualToView(contentView)
    .widthIs(20)
    .heightIs(20);
    
    bottomLine.sd_layout
    .topSpaceToView(rightBtn,0)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
}

- (void)setProblem:(ProblemModel *)problem{
    _problem = problem;
    [self setupAutoHeightWithBottomView:bottomLine bottomMargin:10];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProblemDetailsLBCells";
    
    ProblemDetailsLBCells *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProblemDetailsLBCells" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)rightBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
