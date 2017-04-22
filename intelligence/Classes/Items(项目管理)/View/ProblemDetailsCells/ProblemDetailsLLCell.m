//
//  ProblemDetailsLLCell.m
//  intelligence
//
//  Created by on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemDetailsLLCell.h"

@interface ProblemDetailsLLCell ()
{
    UILabel *redMark;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIView  *bottmLine;
}

@end

@implementation ProblemDetailsLLCell

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
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:16.0];
    rightLabel.numberOfLines = 0;
    
    bottmLine = [[UIView alloc] init];
    bottmLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    
    NSArray *views = @[leftLabel,redMark,rightLabel,bottmLine];
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
    
    rightLabel.sd_layout
    .leftSpaceToView(leftLabel,margin/2)
    .rightSpaceToView(contentView,margin)
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
    leftLabel.sd_layout.widthIs(problem.leftLabelWight);
    rightLabel.sd_layout.leftSpaceToView(leftLabel,5);
    switch (problem.indexPath.section) {
        case 0:{
            switch (problem.indexPath.row) {
                    // 问题联络单基本信息
                case 0: leftLabel.text = @"编号:";
                        rightLabel.text = problem.PRONUM; break;
                case 1: leftLabel.text = @"描述:";
                        rightLabel.text = problem.PRODESC; break;
                default:
                    break;
            }
            
        }break;
            
        case 1:{
            switch (problem.indexPath.row) {
                case 1: leftLabel.text = @"项目描述:";
                        rightLabel.text = problem.PRODESC; break;
                case 2: leftLabel.text = @"项目负责人:";
                        rightLabel.text = problem.PRORES; break;
                case 3: leftLabel.text = @"负责人电话:";
                        rightLabel.text = problem.PHONE2; break;//.
                case 4: leftLabel.text = @"所属中心:";
                        rightLabel.text = problem.BRANCH; break;
                case 5: leftLabel.text = @"项目阶段:";
                        rightLabel.text = problem.PROSTAGE; break;
                default:
                    break;
            }
            
        }break;
            
        case 2:{
            switch (problem.indexPath.row) {
              // 提出问题
                case 1: leftLabel.text = @"提出人电话:";
                        rightLabel.text = problem.PHONE3; break;//.
                case 2: leftLabel.text = @"提出人部门:";
                        rightLabel.text = problem.DEPT1; break; //.
                case 3: leftLabel.text = @"提出时间:";
                        rightLabel.text = problem.CREATEDATE; break;
                case 4: leftLabel.text = @"状态:";
                        rightLabel.text = problem.STATUS; break;
                default:
                    break;
            }
            
        }break;
            
        case 4:{
            switch (problem.indexPath.row) {
                    // 问题处理
                case 1:  leftLabel.text = @"联系电话:";  //.
                         rightLabel.text = problem.PHONE3; break;
                case 2:  leftLabel.text = @"解决人所属部门:";  //.
                         rightLabel.text = problem.COMPTIME; break;
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
    static NSString *ID = @"ProblemDetailsLLCell";
    ProblemDetailsLLCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProblemDetailsLLCell" owner:nil options:nil].lastObject;
    }
    return cell;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
