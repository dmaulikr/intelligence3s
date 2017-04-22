//
//  ProblemDetailsCell.m
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemDetailsCell.h"

@interface ProblemDetailsCell ()<UITextFieldDelegate>
{
    UILabel *markLabel;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UIImageView *rightImageView;
    UITextField *rightTextFidld;
    UIButton *rightBtn;
    UIView *bottmLine;
}

@end

@implementation ProblemDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

- (void)createUI{
    leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    markLabel = [[UILabel alloc] init];
    markLabel.text = @"*";
    markLabel.textColor = [UIColor redColor];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"联络单未选择"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"联络单选择"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"more_next_icon"];
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:16.0];
    rightLabel.numberOfLines = 0;
    
    rightTextFidld = [[UITextField alloc] init];
    rightTextFidld.font = [UIFont systemFontOfSize:16.0];
    rightTextFidld.delegate = self;
    
    bottmLine = [[UIView alloc] init];
    bottmLine.backgroundColor = [UIColor grayColor];
    
    NSArray *views = @[leftLabel,markLabel,rightBtn,rightImageView,rightLabel,rightTextFidld,bottmLine];
    [self.contentView sd_addSubviews:views];
    markLabel.hidden = YES;
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    leftLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(_problem.leftLabelWight)
    .heightIs(20);
    
    markLabel.sd_layout
    .centerYEqualToView(contentView)
    .rightSpaceToView(leftLabel,0);
    
    rightBtn.sd_layout
    .leftSpaceToView(leftLabel,margin)
    .centerYEqualToView(contentView)
    .widthIs(30)
    .heightIs(30);
    
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
    
    rightTextFidld.sd_layout
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

- (void)setProblem:(ProblemModel *)problem{
    _problem = problem;
    switch (problem.indexPath.section) {
        case 0:{
            switch (problem.indexPath.row) {
                // 问题联络单基本信息
                case 0:
                case 1:
                case 5:{
                    if (problem.indexPath.row == 0) {
                        leftLabel.text = @"编号:";
                        rightLabel.text = problem.PRONUM;
                    }else if (problem.indexPath.row == 1){
                        leftLabel.text = @"描述:";
                        rightLabel.text = problem.PRODESC;
                    }else if (problem.indexPath.row == 5){
                        markLabel.hidden = NO;
                        leftLabel.text = @"现场问题及进展情况描述:";
                        rightLabel.text = problem.PROBLEMSITUATION;
                    }
                    self.cellType = ProblemDetailsTypeLL;
                }break;
                
                case 2:
                case 3:
                case 4:{
                    if (problem.indexPath.row == 2) {
                        markLabel.hidden = NO;
                        leftLabel.text = @"问题类型:";
                        rightLabel.text = problem.PROBLEMTYPE;
                    }else if (problem.indexPath.row == 3){
                        markLabel.hidden = NO;
                        leftLabel.text = @"紧急程度:";
                        rightLabel.text = problem.EMERGENCY;
                    }else if (problem.indexPath.row == 4){
                        leftLabel.text = @"相关故障工单:";
                        rightLabel.text = problem.WORKORDERNUM;  //.
                    }
                    self.cellType = ProblemDetailsTypeLLV;
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        case 1:{
            switch (problem.indexPath.row) {
                // 项目信息
                case 0:{
                    markLabel.hidden = NO;
                    leftLabel.text = @"项目编号:";
                    rightLabel.text = problem.PRONUM;
                    self.cellType = ProblemDetailsTypeLLV;
                }break;
                    
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:{
                    if (problem.indexPath.row == 1) {
                        leftLabel.text = @"项目描述:";
                        rightLabel.text = problem.PRODESC;
                    }else if (problem.indexPath.row == 2){
                        leftLabel.text = @"项目负责人:";
                        rightLabel.text = problem.PRORES;
                    }else if (problem.indexPath.row == 3){
                        leftLabel.text = @"负责人电话:";
                        rightLabel.text = problem.PHONE2;  //.
                    }else if (problem.indexPath.row == 4){
                        leftLabel.text = @"所属中心:";
                        rightLabel.text = problem.BRANCH;
                    }else if (problem.indexPath.row == 5){
                        leftLabel.text = @"项目阶段:";
                        rightLabel.text = problem.PROSTAGE;
                    }
                    self.cellType = ProblemDetailsTypeLL;
                }
                    
                default:
                    break;
            }
            
        }break;
            
        case 2:{
            switch (problem.indexPath.row) {
                // 提出问题
                case 0:{
                    markLabel.hidden = NO;
                    leftLabel.text = @"需求提出人:";
                    rightLabel.text = problem.CREATENAME;
                    self.cellType = ProblemDetailsTypeLLV;
                }break;
                
                case 1:
                case 2:
                case 3:
                case 4:{
                    if (problem.indexPath.row == 1) {
                        leftLabel.text = @"提出人电话:";
                        rightLabel.text = problem.PHONE3; //.
                    }else if (problem.indexPath.row == 2){
                        leftLabel.text = @"提出人部门:";
                        rightLabel.text = problem.DEPT1;  //.
                    }else if (problem.indexPath.row == 3){
                        leftLabel.text = @"提出时间:";
                        rightLabel.text = problem.CREATEDATE;
                    }else if (problem.indexPath.row == 4){
                        leftLabel.text = @"状态:";
                        rightLabel.text = problem.STATUS;
                    }
                    self.cellType = ProblemDetailsTypeLL;
                    
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        case 3:{
            switch (problem.indexPath.row) {
                //支持部门
                case 0:
                case 1:{
                    if (problem.indexPath.row == 0) {
                        markLabel.hidden = NO;
                        leftLabel.text = @"支持部门:";   //.
                        rightLabel.text = problem.DEPT2;
                    }else if (problem.indexPath.row == 1){
                        markLabel.hidden = NO;
                        leftLabel.text = @"支持部门领导:";  //.
                        rightLabel.text = problem.LEADER;
                    }
                    self.cellType = ProblemDetailsTypeLLV;
                    
                }break;
                    
                case 2:{
                    leftLabel.text = @"需求完成时间";    //.
                    rightLabel.text = problem.RESPONSETIME;
                    self.cellType = ProblemDetailsTypeLLT;
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        case 4:{
            switch (problem.indexPath.row) {
                // 问题处理
                case 0:{
                    markLabel.hidden = NO;
                    leftLabel.text = @"问题处理人:";   //.
                    rightLabel.text = problem.SOLVEDBY;
                    self.cellType = ProblemDetailsTypeLLV;
                }break;
                
                case 1:
                case 2:{
                    if (problem.indexPath.row == 1) {
                        leftLabel.text = @"联系电话:";  //.
                        rightLabel.text = problem.PHONE3;
                    }else if (problem.indexPath.row == 2){
                        leftLabel.text = @"解决人所属部门:";  //.
                        rightLabel.text = problem.COMPTIME;
                    }
                    self.cellType = ProblemDetailsTypeLL;
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        case 5:{
            switch (problem.indexPath.row) {
                // 问题解决
                case 0:
                case 1:
                case 2:{
                    if (problem.indexPath.row == 0) {
                        markLabel.hidden = NO;
                        leftLabel.text = @"抵达时间:";  //.
                        rightLabel.text = problem.RESPONSETIME;
                    }else if (problem.indexPath.row == 1){
                        leftLabel.text = @"完成时间:";  //.
                        rightLabel.text = problem.RESPONSETIME;
                    }else if (problem.indexPath.row == 2){
//                        self.cellType = ProblemDetailsTypeLT;
                        leftLabel.text = @"解决问题及反馈:"; //.
                        rightLabel.text = problem.REMARK;
                    }
                    self.cellType = ProblemDetailsTypeLLT;
                }
                default:
                    break;
            }
            
        }break;
            
        case 6:{
            switch (problem.indexPath.row) {
                // 问题确认
                case 0:{
                    leftLabel.text = @"是否解决";  //.
                    self.cellType = ProblemDetailsTypeLR;
                }break;
                    
                case 1:{
//                    self.cellType = ProblemDetailsTypeLT;
                    leftLabel.text = @"说明";  //.
                    rightLabel.text = problem.REMARK;
                    self.cellType = ProblemDetailsTypeLL;
                }break;
                    
                default:
                    break;
            }
            
        }break;
            
        default:
            break;
    }
    
    
}

- (void)setCellType:(ProblemDetailsType)cellType{
    switch (cellType) {
        case ProblemDetailsTypeLL:{
            rightImageView.hidden = YES;
            rightBtn.hidden = YES;
            rightTextFidld.hidden = YES;
            rightLabel.sd_layout.rightSpaceToView(self.contentView,10);
            [self setupAutoWithRightLabel];
        }break;
        case ProblemDetailsTypeLLV:{
            rightBtn.hidden = YES;
            rightTextFidld.hidden = YES;
            rightImageView.image = [UIImage imageNamed:@"more_next_icon"];
            rightImageView.sd_layout.widthIs(7).heightIs(22);
            rightLabel.sd_layout.rightSpaceToView(rightImageView,10);
            [self setupAutoWithRightLabel];
        }break;
        case ProblemDetailsTypeLLT:{
            rightBtn.hidden = YES;
            rightTextFidld.hidden = YES;
            rightImageView.image = [UIImage imageNamed:@"日历"];
            rightImageView.sd_layout.widthIs(20).heightIs(20);
            rightLabel.sd_layout.rightSpaceToView(rightImageView,10);
            [self setupAutoWithRightLabel];
        }break;
        case ProblemDetailsTypeLT:{
            rightBtn.hidden = YES;
            rightLabel.hidden = YES;
            rightImageView.hidden = YES;
            [self setupAutoWithRightLabel];
        }break;
        case ProblemDetailsTypeLR:{
            rightLabel.hidden = YES;
            rightImageView.hidden = YES;
            rightTextFidld.hidden = YES;
            [self setupAutoWithRightBtn];
        }break;
            
        default:
            break;
    }
}

- (void)rightBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}




+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProblemDetailsCell";
    
    ProblemDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProblemDetailsCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setupAutoWithRightLabel{
    if (rightLabel.text.length < 1) {
        rightLabel.text = @" ";
    }
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

- (void)setupAutoWithRightBtn{
    bottmLine.sd_layout.topSpaceToView(rightBtn,0);
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
