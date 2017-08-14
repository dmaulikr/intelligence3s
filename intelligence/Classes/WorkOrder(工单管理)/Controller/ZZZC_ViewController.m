//
//  ZZZC_ViewController.m
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "ZZZC_ViewController.h"
#import "NSArray+Extension.h"
@interface ZZZC_ViewController ()
@property(nonatomic,strong)UIPickerView * BEARINGSUPPLIERPicker;
@property(nonatomic,strong)UIPickerView * SEALFORMPicker;
@property(nonatomic,strong)UIPickerView * BRANDTYPEPicker;
@property(nonatomic,strong)UIPickerView * GREASECOLORPicker;
@property(nonatomic,strong)UIPickerView * GREASEILEPicker;
@property(nonatomic,strong)UIPickerView * GREASEAMOUNTPicker;
@property(nonatomic,strong)UIPickerView * LEAKAGEPicker;
@property(nonatomic,strong)UIPickerView * GREASECOVERPicker;
@property(nonatomic,strong)UIPickerView * ROLLERWEARPicker;
@property(nonatomic,strong)UIPickerView * GROOVEWEARPicker;
@property(nonatomic,strong)UIPickerView * SPINDLEPicker;
@end

@implementation ZZZC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    CGRect pickerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    
    self.BEARINGSUPPLIERPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.SEALFORMPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.BRANDTYPEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASECOLORPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEAMOUNTPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.LEAKAGEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASECOVERPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ROLLERWEARPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GROOVEWEARPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.SPINDLEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    self.BEARINGSUPPLIERPicker.dataSource =self;self.BEARINGSUPPLIERPicker.delegate=self;
    self.SEALFORMPicker.dataSource =self;self.SEALFORMPicker.delegate=self;
    self.BRANDTYPEPicker.dataSource =self;self.BRANDTYPEPicker.delegate=self;
    self.GREASECOLORPicker.dataSource =self;self.GREASECOLORPicker.delegate=self;
    self.GREASEILEPicker.dataSource =self;self.GREASEILEPicker.delegate=self;
    self.GREASEAMOUNTPicker.dataSource =self;self.GREASEAMOUNTPicker.delegate=self;
    self.LEAKAGEPicker.dataSource =self;self.LEAKAGEPicker.delegate=self;
    self.GREASECOVERPicker.dataSource =self;self.GREASECOVERPicker.delegate=self;
    self.ROLLERWEARPicker.dataSource =self;self.ROLLERWEARPicker.delegate=self;
    self.GROOVEWEARPicker.dataSource =self;self.GROOVEWEARPicker.delegate=self;
    self.SPINDLEPicker.dataSource =self;self.SPINDLEPicker.delegate=self;

    [self.BEARINGSUPPLIERPicker setBackgroundColor:[UIColor grayColor]];
    [self.SEALFORMPicker setBackgroundColor:[UIColor grayColor]];
    [self.BRANDTYPEPicker setBackgroundColor:[UIColor grayColor]];
    [self.GREASECOLORPicker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILEPicker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEAMOUNTPicker setBackgroundColor:[UIColor grayColor]];
    [self.LEAKAGEPicker setBackgroundColor:[UIColor grayColor]];
    [self.GREASECOVERPicker setBackgroundColor:[UIColor grayColor]];
    [self.ROLLERWEARPicker setBackgroundColor:[UIColor grayColor]];
    [self.GROOVEWEARPicker setBackgroundColor:[UIColor grayColor]];
    [self.SPINDLEPicker setBackgroundColor:[UIColor grayColor]];
    

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
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
}
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    
}
-(void)addPickerIncell:(UITableViewCell* )cell fieldName:(NSString*) fieldName
{
    if ([fieldName isEqualToString:@"BEARINGSUPPLIER"]) {
        [cell addSubview:self.BEARINGSUPPLIERPicker];
    }
    if ([fieldName isEqualToString:@"SEALFORM"]) {
        [cell addSubview:self.SEALFORMPicker];
    }
    if ([fieldName isEqualToString:@"BRANDTYPE"]) {
        [cell addSubview:self.BRANDTYPEPicker];
    }
    if ([fieldName isEqualToString:@"GREASECOLOR"]) {
        [cell addSubview:self.GREASECOLORPicker];
    }
    if ([fieldName isEqualToString:@"GREASEILE"]) {
        [cell addSubview:self.GREASEILEPicker];
    }
    if ([fieldName isEqualToString:@"GREASEAMOUNT"]) {
        [cell addSubview:self.GREASEAMOUNTPicker];
    }
    if ([fieldName isEqualToString:@"LEAKAGE"]) {
        [cell addSubview:self.LEAKAGEPicker];
    }
    if ([fieldName isEqualToString:@"GREASECOVER"]) {
        [cell addSubview:self.GREASECOVERPicker];
    }
    if ([fieldName isEqualToString:@"ROLLERWEAR"]) {
        [cell addSubview:self.ROLLERWEARPicker];
    }
    if ([fieldName isEqualToString:@"GROOVEWEAR"]) {
        [cell addSubview:self.GROOVEWEARPicker];
    }
    if ([fieldName isEqualToString:@"SPINDLE"]) {
        [cell addSubview:self.SPINDLEPicker];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    
    if ([pickerView isEqual:self.BEARINGSUPPLIERPicker]) {
        array = [df arrayWithName:@"BEARINGSUPPLIER"];
    }
    if ([pickerView isEqual:self.SEALFORMPicker]) {
        array = [df arrayWithName:@"SEALFORM"];
    }

    if ([pickerView isEqual:self.BRANDTYPEPicker]) {
        array = [df arrayWithName:@"BRANDTYPE"];
    }
    
    if ([pickerView isEqual:self.GREASECOLORPicker]) {
        array = [df arrayWithName:@"GREASECOLOR"];
    }
    
    if ([pickerView isEqual:self.GREASEILEPicker]) {
        array = [df arrayWithName:@"GREASEILE"];
    }
    
    if ([pickerView isEqual:self.GREASEAMOUNTPicker]) {
        array = [df arrayWithName:@"GREASEAMOUNT"];
    }
    
    if ([pickerView isEqual:self.LEAKAGEPicker]) {
        array = [df arrayWithName:@"LEAKAGE"];
    }
    
    if ([pickerView isEqual:self.GREASECOVERPicker]) {
        array = [df arrayWithName:@"GREASECOVER"];
    }
    
    if ([pickerView isEqual:self.ROLLERWEARPicker]) {
        array = [df arrayWithName:@"ROLLERWEAR"];
    }
    
    if ([pickerView isEqual:self.GROOVEWEARPicker]) {
        array = [df arrayWithName:@"GROOVEWEAR"];
    }
    
    if ([pickerView isEqual:self.SPINDLEPicker]) {
        array = [df arrayWithName:@"SPINDLE"];
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
    if ([pickerView isEqual:self.BEARINGSUPPLIERPicker]) {
        array = [df arrayWithName:@"BEARINGSUPPLIER"];
    }
    if ([pickerView isEqual:self.SEALFORMPicker]) {
        array = [df arrayWithName:@"SEALFORM"];
    }
    
    if ([pickerView isEqual:self.BRANDTYPEPicker]) {
        array = [df arrayWithName:@"BRANDTYPE"];
    }
    
    if ([pickerView isEqual:self.GREASECOLORPicker]) {
        array = [df arrayWithName:@"GREASECOLOR"];
    }
    
    if ([pickerView isEqual:self.GREASEILEPicker]) {
        array = [df arrayWithName:@"GREASEILE"];
    }
    
    if ([pickerView isEqual:self.GREASEAMOUNTPicker]) {
        array = [df arrayWithName:@"GREASEAMOUNT"];
    }
    
    if ([pickerView isEqual:self.LEAKAGEPicker]) {
        array = [df arrayWithName:@"LEAKAGE"];
    }
    
    if ([pickerView isEqual:self.GREASECOVERPicker]) {
        array = [df arrayWithName:@"GREASECOVER"];
    }
    
    if ([pickerView isEqual:self.ROLLERWEARPicker]) {
        array = [df arrayWithName:@"ROLLERWEAR"];
    }
    
    if ([pickerView isEqual:self.GROOVEWEARPicker]) {
        array = [df arrayWithName:@"GROOVEWEAR"];
    }
    
    if ([pickerView isEqual:self.SPINDLEPicker]) {
        array = [df arrayWithName:@"SPINDLE"];
    }
    
    return [array count];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    if ([pickerView isEqual:self.BEARINGSUPPLIERPicker]) {
        array = [df arrayWithName:@"BEARINGSUPPLIER"];
        [self modifyFieldByFieldName:@"BEARINGSUPPLIER" newValue:array[row]];
        [self modifyTypeByFieldName:@"BEARINGSUPPLIER" newType:@"选择"];
    }
    if ([pickerView isEqual:self.SEALFORMPicker]) {
        array = [df arrayWithName:@"SEALFORM"];
        [self modifyFieldByFieldName:@"SEALFORM" newValue:array[row]];
        [self modifyTypeByFieldName:@"SEALFORM" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.BRANDTYPEPicker]) {
        array = [df arrayWithName:@"BRANDTYPE"];
        [self modifyFieldByFieldName:@"BEARINGSUPPLIER" newValue:array[row]];
        [self modifyTypeByFieldName:@"BEARINGSUPPLIER" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.GREASECOLORPicker]) {
        array = [df arrayWithName:@"GREASECOLOR"];
        [self modifyFieldByFieldName:@"GREASECOLOR" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASECOLOR" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.GREASEILEPicker]) {
        array = [df arrayWithName:@"GREASEILE"];
        [self modifyFieldByFieldName:@"GREASEILE" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILE" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.GREASEAMOUNTPicker]) {
        array = [df arrayWithName:@"GREASEAMOUNT"];
        [self modifyFieldByFieldName:@"GREASEAMOUNT" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEAMOUNT" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.LEAKAGEPicker]) {
        array = [df arrayWithName:@"LEAKAGE"];
        [self modifyFieldByFieldName:@"LEAKAGE" newValue:array[row]];
        [self modifyTypeByFieldName:@"LEAKAGE" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.GREASECOVERPicker]) {
        array = [df arrayWithName:@"GREASECOVER"];
        [self modifyFieldByFieldName:@"GREASECOVER" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASECOVER" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.ROLLERWEARPicker]) {
        array = [df arrayWithName:@"ROLLERWEAR"];
        [self modifyFieldByFieldName:@"ROLLERWEAR" newValue:array[row]];
        [self modifyTypeByFieldName:@"ROLLERWEAR" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.GROOVEWEARPicker]) {
        array = [df arrayWithName:@"GROOVEWEAR"];
        [self modifyFieldByFieldName:@"GROOVEWEAR" newValue:array[row]];
        [self modifyTypeByFieldName:@"GROOVEWEAR" newType:@"选择"];
    }
    
    if ([pickerView isEqual:self.SPINDLEPicker]) {
        array = [df arrayWithName:@"SPINDLE"];
        [self modifyFieldByFieldName:@"SPINDLE" newValue:array[row]];
        [self modifyTypeByFieldName:@"SPINDLE" newType:@"选择"];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate ZZZC_DATA:[self dictionaryData]];
}
@end
