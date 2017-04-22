//
//  ProblemDetailsLLICells.m
//  intelligence
//
//  Created by  on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemDetailsLLICells.h"

@interface ProblemDetailsLLICells ()
{
    UILabel *redMark;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIImageView *rightImageView;
    UIView  *bottmLine;
}

@end

@implementation ProblemDetailsLLICells

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createUI];
}

- (void)createUI{
    leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    redMark = [[UILabel alloc] init];
    redMark.text = @"*";
    redMark.textColor = [UIColor redColor];
    
    rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_next_icon"]];
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:16.0];
    rightLabel.numberOfLines = 0;
    
    bottmLine = [[UIView alloc] init];
    bottmLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    
    NSArray *views = @[leftLabel,redMark,rightImageView,rightLabel,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_leftLabelWight)
    .heightIs(20);
    
    redMark.sd_layout
    .centerYIs(leftLabel.centerY - 3)
    .rightSpaceToView(leftLabel,0);
    
    rightImageView.sd_layout
    .centerYEqualToView(leftLabel)
    .rightSpaceToView(contentView,margin)
    .widthIs(7)
    .heightIs(22);
    
    rightLabel.sd_layout
    .leftSpaceToView(leftLabel,margin/2)
    .rightSpaceToView(rightImageView,margin)
    .topSpaceToView(contentView,margin)
    .autoHeightRatio(0);
    
    bottmLine.sd_layout
    .topSpaceToView(rightLabel,margin)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
    
    redMark.hidden = YES;
}

- (void)setProblem:(ProblemModel *)problem{
    _problem = problem;
    leftLabel.sd_layout.widthIs(_problem.leftLabelWight);
    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
    switch (problem.indexPath.section) {
        case 0:{
            switch (problem.indexPath.row) {
                    // 问题联络单基本信息
                case 2: leftLabel.text = @"问题类型:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.PROBLEMTYPE; break;
                case 3: leftLabel.text = @"紧急程度:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.EMERGENCY; break;
                case 4: leftLabel.text = @"相关故障工单:";
                        rightLabel.text = problem.WORKORDERNUM; break; //.
                default:
                    break;
            }
        }break;
            
        case 1:{
            switch (problem.indexPath.row) {
                // 项目信息
                case 0: leftLabel.text = @"项目编号:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.PRONUM; break;
                default:
                    break;
            }
        }break;
            
        case 2:{
            switch (problem.indexPath.row) {
                    // 提出问题
                case 0: leftLabel.text = @"需求提出人:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.CREATENAME; break;
                default:
                    break;
            }
        }break;
            
        case 3:{
            switch (problem.indexPath.row) {
                    //支持部门
                case 0: leftLabel.text = @"支持部门:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.DEPT2; break;
                case 1: leftLabel.text = @"支持部门领导:";
                        redMark.hidden = NO;
                        rightLabel.text = problem.LEADER; break;
                case 2: leftLabel.text = @"支持部门领导:";
                        rightLabel.text = problem.LEADER;
                        rightImageView.sd_layout.widthIs(20);
                        rightImageView.image = [UIImage imageNamed:@"日历"]; break;
                default:
                    break;
            }
        }break;
            
        case 4:{
            switch (problem.indexPath.row) {
                    // 问题处理
                case 0: leftLabel.text = @"问题处理人:";   //.
                        redMark.hidden = NO;
                        rightLabel.text = problem.SOLVEDBY; break;
                default:
                    break;
            }
            
        }break;
            
        case 5:{
            switch (problem.indexPath.row) {
                    // 问题解决
                case 0: leftLabel.text = @"抵达时间:";  //.
                        redMark.hidden = NO;
                        rightLabel.text = problem.RESPONSETIME;
                        rightImageView.sd_layout.widthIs(20);
                        rightImageView.image = [UIImage imageNamed:@"日历"]; break;

                case 1: leftLabel.text = @"完成时间:";  //.
                        rightLabel.text = problem.RESPONSETIME;
                        rightImageView.sd_layout.widthIs(20);
                        rightImageView.image = [UIImage imageNamed:@"日历"]; break;

                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
    
    if (rightLabel.text.length < 1) {
        rightLabel.text = @"暂无数据";
        rightLabel.textColor = [UIColor grayColor];
    }else{
        rightLabel.textColor = [UIColor blackColor];
    }
    
    rightLabel.sd_layout.maxHeightIs(MAXFLOAT);
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:0];
}




+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProblemDetailsLLICells";
    
    ProblemDetailsLLICells *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProblemDetailsLLICells" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
