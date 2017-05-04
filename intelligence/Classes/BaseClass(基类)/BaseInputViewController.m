//
//  BaseInputViewController.m
//  intelligence
//
//  Created by chris on 2017/4/26.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "BaseInputViewController.h"
#import "PersonalSettingItem.h"
@interface BaseInputViewController ()

@end

@implementation BaseInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)confrim:(id)sender {
    
    if (self.item) {
        
        if (self.textView.text.length>0) {
            
            self.item.content=self.textView.text;
            
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tableviewreloaddata" object:nil];
        
    }];
}

@end
