//
//  ProblemDetailsLTCells.m
//  intelligence
//
//  Created by on 16/8/3.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemDetailsLTCells.h"
#import "SHTextView.h"


@interface ProblemDetailsLTCells ()
{
    UILabel *redMark;
    UILabel *leftLabel;
    SHTextView *rightTextView;
    UIView  *bottmLine;
}

@end

@implementation ProblemDetailsLTCells

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
    
    rightTextView = [[SHTextView alloc] init];
    rightTextView.font = [UIFont systemFontOfSize:16.0];
    rightTextView.placeholder = @"暂无数据";
    rightTextView.placeholderColor = [UIColor grayColor];
    rightTextView.isCanExtend = YES;
    rightTextView.extendDirection = ExtendDown;
    rightTextView.extendLimitRow = 4;
    
    bottmLine = [[UIView alloc] init];
    bottmLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    
    NSArray *views = @[leftLabel,redMark,rightTextView,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_leftLabelWight)
    .heightIs(20);
    
    redMark.sd_layout
    .centerYIs(contentView.centerY - 3)
    .rightSpaceToView(leftLabel,0);
    
    rightTextView.sd_layout
    .leftSpaceToView(leftLabel,margin/2)
    .rightSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .autoHeightRatio(20);
    
    bottmLine.sd_layout
    .topSpaceToView(rightTextView,10)
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(1);
    
    redMark.hidden = YES;
}

- (void)setProblem:(ProblemModel *)problem{
    _problem = problem;
    //leftLabel.sd_layout.widthIs(_problem.leftLabelWight);
    rightTextView.sd_layout.leftSpaceToView(leftLabel,5);
//    switch (problem.indexPath.section) {
//        case 0:{
//            switch (problem.indexPath.row) {
//            // 问题联络单基本信息
//                case 5: leftLabel.text = @"现场问题及进展情况描述:";
//                        redMark.hidden = NO;
//                         rightTextView.text = problem.PROBLEMSITUATION; break;
//                default:
//                    break;
//            }
//        }break;
//            
//        case 5:{
//            switch (problem.indexPath.row) {
//                    // 问题解决
//                case 2: leftLabel.text = @"解决问题及反馈:"; //.
//                        rightTextView.text = problem.REMARK; break;
//                    default:
//                    break;
//            }
//            
//        }break;
//            
//        case 6:{
//            switch (problem.indexPath.row) {
//                    // 问题确认
//                case 1: leftLabel.text = @"说明";  //.
//                        rightTextView.text = problem.REMARK;  break;
//                default:
//                    break;
//            }
//            
//        }break;
//            
//        default:
//            break;
//    }
    if (rightTextView.text.length < 1) {
        rightTextView.text = @"暂无数据";
        rightTextView.textColor = [UIColor grayColor];
    }else{
        rightTextView.textColor = [UIColor blackColor];
    }
    rightTextView.sd_layout.maxHeightIs(MAXFLOAT);
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:0];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProblemDetailsLTCells";
    
    ProblemDetailsLTCells *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProblemDetailsLTCells" owner:nil options:nil].lastObject;
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
