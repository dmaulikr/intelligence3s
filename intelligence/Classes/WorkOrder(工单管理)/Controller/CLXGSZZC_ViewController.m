//
//  CLXGSZZC_ViewController.m
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "CLXGSZZC_ViewController.h"
#import "NSArray+Extension.h"
@interface CLXGSZZC_ViewController ()
@property(nonatomic,strong)UIPickerView * ROLLERWEAR2Picker;
@property(nonatomic,strong)UIPickerView * GROOVEWEAR2Picker;
@property(nonatomic,strong)UIPickerView * GEAROILPicker;
@end

@implementation CLXGSZZC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    CGRect pickerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    
    self.ROLLERWEAR2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GROOVEWEAR2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GEAROILPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    self.ROLLERWEAR2Picker.dataSource =self;self.ROLLERWEAR2Picker.delegate=self;
    self.GROOVEWEAR2Picker.dataSource =self;self.GROOVEWEAR2Picker.delegate=self;
    self.GEAROILPicker.dataSource =self;self.GEAROILPicker.delegate=self;
    
    [self.ROLLERWEAR2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GROOVEWEAR2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GEAROILPicker setBackgroundColor:[UIColor grayColor]];
    
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
-(void)selectValue:(NSString *)fieldName
{
    if ([fieldName isEqualToString:@"ROLLERWEAR2"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"GROOVEWEAR2"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"GEAROIL"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
}
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    
}
-(void)addPickerIncell:(UITableViewCell* )cell fieldName:(NSString*) fieldName
{
    if ([fieldName isEqualToString:@"ROLLERWEAR2"]) {
        [cell addSubview:self.ROLLERWEAR2Picker];
    }
    if ([fieldName isEqualToString:@"GROOVEWEAR2"]) {
        [cell addSubview:self.GROOVEWEAR2Picker];
    }
    if ([fieldName isEqualToString:@"GEAROIL"]) {
        [cell addSubview:self.GEAROILPicker];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    
    if ([pickerView isEqual:self.ROLLERWEAR2Picker]) {
        array = [df arrayWithName:@"ROLLERWEAR2"];
    }
    if ([pickerView isEqual:self.GROOVEWEAR2Picker]) {
        array = [df arrayWithName:@"GROOVEWEAR2"];
    }
    if ([pickerView isEqual:self.GEAROILPicker]) {
        array = [df arrayWithName:@"GEAROIL"];
    }
    
    return array[row];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    
    if ([pickerView isEqual:self.ROLLERWEAR2Picker]) {
        array = [df arrayWithName:@"ROLLERWEAR2"];
    }
    if ([pickerView isEqual:self.GROOVEWEAR2Picker]) {
        array = [df arrayWithName:@"GROOVEWEAR2"];
    }
    if ([pickerView isEqual:self.GEAROILPicker]) {
        array = [df arrayWithName:@"GEAROIL"];
    }
    
    return [array count];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    
    if ([pickerView isEqual:self.ROLLERWEAR2Picker]) {
        [self.ROLLERWEAR2Picker removeFromSuperview];
        array = [df arrayWithName:@"ROLLERWEAR2"];
        [self modifyFieldByFieldName:@"ROLLERWEAR2" newValue:array[row]];
        [self modifyTypeByFieldName:@"ROLLERWEAR2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GROOVEWEAR2Picker]) {
        array = [df arrayWithName:@"GROOVEWEAR2"];
        [self modifyFieldByFieldName:@"GROOVEWEAR2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GROOVEWEAR2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GEAROILPicker]) {
        array = [df arrayWithName:@"GEAROIL"];
        [self modifyFieldByFieldName:@"GEAROIL" newValue:array[row]];
        [self modifyTypeByFieldName:@"GEAROIL" newType:@"选择"];
    }
}

@end
