//
//  QRCodeViewController.m
//  intelligence
//
//  Created by chris on 2017/3/1.
//  Copyright © 2017年 chris. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeItself:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
