//
//  PCXXXX_ViewController.m
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "PCXXXX_ViewController.h"

@interface PCXXXX_ViewController ()

@end

@implementation PCXXXX_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate PCXXXX_DATA:[self arrayData]];
}
-(NSMutableDictionary*)dictionaryData
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    NSString * type = [dictionary valueForKey:@"类型"];
    if ([type isEqualToString:@"picker"]){
        return 300;
    }else if([type isEqualToString:@"隐藏"]){
        return 0;
    }
    else{
        return 64;
    }
}
-(NSMutableArray*)arrayData
{
    NSMutableArray * array2 = [NSMutableArray array];
    
    for (int i=0; i<=[self.array count]-5; i=i+5) {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        NSString * CHECKRESULT = self.array[i+2][@"值"];
        NSString * PROBLEMDESC = self.array[i+3][@"值"];
        NSString * UDWARNINGWOLINEID = self.array[i+4][@"名称"];
        
        [dic setValue:CHECKRESULT forKey:@"CHECKRESULT"];
        [dic setValue:PROBLEMDESC forKey:@"PROBLEMDESC"];
        [dic setValue:UDWARNINGWOLINEID forKey:@"UDWARNINGWOLINEID"];
        [array2 addObject:dic];
    }
    return array2;
}
@end
