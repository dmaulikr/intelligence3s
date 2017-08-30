//
//  TJJDRB_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/29.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "TJJDRB_ViewController.h"

@interface TJJDRB_ViewController ()

@end

@implementation TJJDRB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initData
{
    if (self.Kmodel) {
        NSArray *names = [NSArray getProperties:[self.Kmodel class]];
        
        for (NSString *name in names) {
            
            if ([self.Kmodel valueForKey:name]) {
                NSString * value = [self.Kmodel valueForKey:name];
                if (value.length>0) {
                    NSLog(@"反射值 %@   反射键 %@",value,name);
                }
                [self modifyFieldByFieldName:name newValue:value];
            }
        }
    }
}


@end
