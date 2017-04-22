//
//  RunlineCell.m
//  intelligence
//
//  Created by chris on 2016/11/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "RunlineCell.h"

@implementation RunlineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)clearText
{
    self.one.text=@"";
    self.two.text=@"";
    self.three.text=@"";
    self.four.text=@"";
}
-(void)setRunlineModel:(Runliner *)runlineModel
{
    _runlineModel=runlineModel;
    self.one.text=runlineModel.LOGDATE;
    self.two.text=runlineModel.WORKNUM;
    self.three.text=runlineModel.WORKPG;
    self.four.text=runlineModel.WORKCRON;
}
@end
