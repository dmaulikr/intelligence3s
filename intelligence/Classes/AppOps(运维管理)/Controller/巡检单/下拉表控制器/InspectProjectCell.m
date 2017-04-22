//
//  InspectProjectCell.m
//  intelligence
//
//  Created by  on 16/8/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "InspectProjectCell.h"


@interface InspectProjectCell ()
{
    UILabel *labelFirst;
    UILabel *labelFirstAcross;
    UILabel *labelSecond;
    UILabel *labelSecondAcross;
    UILabel *labelThird;
    UILabel *labelThirdAcross;
    UIView  *bottmLine;
}

@end

@implementation InspectProjectCell

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
    
    bottmLine = [[UIView alloc] init];
    
    NSArray *views = @[labelFirst,labelFirstAcross,labelSecond,labelSecondAcross,labelThird,labelThirdAcross,bottmLine];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    CGFloat leftLabelWight = 80;
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

- (void)setInspectProject:(InspectProjectModel *)inspectProject{
    _inspectProject = inspectProject;
    labelFirst.text = @"任务:";
    labelSecond.text = @"描述:";
    labelThird.text = @"结果:";

    if (inspectProject.SERIALNUM.length > 0) {
        labelFirstAcross.text = inspectProject.SERIALNUM;
    }else{
        labelFirstAcross.text = @"暂无数据";
        labelFirstAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if (inspectProject.JO2.length > 0) {
        labelSecondAcross.text = inspectProject.JO2;
    }else{
        labelSecondAcross.text = @"暂无数据";
        labelSecondAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if ([inspectProject.OK isEqualToString:@"Y"]) {
        labelThirdAcross.text = @"合格";
    }else{
        labelThirdAcross.text = @"不合格";
    }
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

- (void)setProjectCars:(ProjectCarsModel *)projectCars{
    _projectCars = projectCars;
    labelFirst.text = @"车牌号:";
    labelSecond.text = @"司机:";
    labelThird.text = @"累计行驶里程:";
    CGFloat leftLabelWight = 110;
    labelFirst.sd_layout.widthIs(leftLabelWight);
    labelSecond.sd_layout.widthIs(leftLabelWight);
    labelThird.sd_layout.widthIs(leftLabelWight);
    
    if (projectCars.LICENSENUM.length > 0) {
        labelFirstAcross.text = projectCars.LICENSENUM;
    }else{
        labelFirstAcross.text = @"暂无数据";
        labelFirstAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if (projectCars.DRIVER.length > 0) {
        labelSecondAcross.text = projectCars.DRIVER;
    }else{
        labelSecondAcross.text = @"暂无数据";
        labelSecondAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    if (projectCars.TOTALMILEAGE.length > 0) {
        labelThirdAcross.text = projectCars.TOTALMILEAGE;
    }else{
        labelThirdAcross.text = @"暂无数据";
        labelThirdAcross.textColor = UIColorFromRGB(0xCBCBCF);
    }
    [self setupAutoHeightWithBottomView:bottmLine bottomMargin:10];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"InspectProjectCell";
    
    InspectProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"InspectProjectCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
