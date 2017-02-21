//
//  PromptView.m
//  intelligence
//
//  Created by 光耀 on 16/7/22.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "PromptView.h"

@implementation PromptView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
}

+(instancetype)promptView{
    return [[[NSBundle mainBundle]loadNibNamed:@"PromptView" owner:nil options:nil] lastObject];
}

- (IBAction)btnClick:(id)sender {
    UIButton* button = (UIButton*)sender;
    NSLog(@"--%@",button.titleLabel.text);
    NSString *str;
    if (button.tag ==1) {
        str = @"http://eamapp.mywind.com.cn:9080";
    }else if (button.tag ==2){
        str = @"http://deveamapp.mywind.com.cn:9080";
    }else if (button.tag ==3){
        str = @"http://deveam.mywind.com.cn:7001";
    }else if (button.tag == 4){
        str = @"http://demoeamapp.mywind.com.cn";
    }
    if(self.serverBlock){
        self.serverBlock(str);
    }
}


@end
