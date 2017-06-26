//
//  TextInputViewController.m
//  MultiFunctionCell
//
//  Created by chris on 2017/5/6.
//  Copyright © 2017年 mywind. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController ()

@end

@implementation TextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    [self.content resignFirstResponder];
    if (self.save) {
            self.save(self.content.text);
    }
}
- (IBAction)cancel:(id)sender {
     [self.content resignFirstResponder];
    if (self.cancel) {
            self.cancel();
    }
}

@end
