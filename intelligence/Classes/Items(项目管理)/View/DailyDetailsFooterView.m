//
//  DailyDetailsFooterView.m
//  intelligence
//
//  Created by  on 16/7/31.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "DailyDetailsFooterView.h"
#import "WorkPopView.h"

@interface DailyDetailsFooterView ()

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;


@end

@implementation DailyDetailsFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)btnCancelClick:(id)sender {
    if (self.executeBtnCancelClick) {
        self.executeBtnCancelClick();
    }
}

- (IBAction)btnSaveClick:(id)sender {
    if (self.executeBtnSaveClick) {
        self.executeBtnSaveClick();
    }
}


+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"DailyDetailsFooterView" owner:nil options:nil] lastObject];
}

@end
