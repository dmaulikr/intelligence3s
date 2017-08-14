//
//  TSGDZB_ViewController.m
//  intelligence
//
//  Created by chris on 2017/8/12.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "TSGDZB_ViewController.h"

@interface TSGDZB_ViewController ()

@end

@implementation TSGDZB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
