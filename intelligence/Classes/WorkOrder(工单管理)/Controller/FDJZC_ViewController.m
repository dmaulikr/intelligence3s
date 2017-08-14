//
//  FDJZC_ViewController.m
//  intelligence
//
//  Created by chris on 2017/7/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "FDJZC_ViewController.h"
#import "NSArray+Extension.h"
@interface FDJZC_ViewController ()
@property(nonatomic,strong)UIPickerView * POWERSUPPicker;
@property(nonatomic,strong)UIPickerView * POWERMODLEPicker;
@property(nonatomic,strong)UIPickerView * POWERSPECPicker;
@property(nonatomic,strong)UIPickerView * ISWIRINGPicker;
@property(nonatomic,strong)UIPickerView * ISFETCHPicker;
@property(nonatomic,strong)UIPickerView * UDISMODLEPicker;
@property(nonatomic,strong)UIPickerView * REPAIRDEPTPicker;
@property(nonatomic,strong)UIPickerView * ADDGRASEPicker;
@property(nonatomic,strong)UIPickerView * GREASEPicker;
@property(nonatomic,strong)UIPickerView * BRANDTYPE2Picker;
@property(nonatomic,strong)UIPickerView * GREASEAMOUNT2Picker;
@property(nonatomic,strong)UIPickerView * GREASECOLOR2Picker;
@property(nonatomic,strong)UIPickerView * GREASEILE2Picker;
@property(nonatomic,strong)UIPickerView * GREASEILEDESC1Picker;
@property(nonatomic,strong)UIPickerView * LEAKAGE2Picker;
@property(nonatomic,strong)UIPickerView * LUBRICATINGPicker;
@property(nonatomic,strong)UIPickerView * REPAIRBEFOREPicker;
@property(nonatomic,strong)UIPickerView * REPAIRAFTERPicker;
@property(nonatomic,strong)UIPickerView * REPAIRDEPT2Picker;
@property(nonatomic,strong)UIPickerView * ADDGRASE2Picker;
@property(nonatomic,strong)UIPickerView * GREASE2Picker;
@property(nonatomic,strong)UIPickerView * BRANDTYPE3Picker;
@property(nonatomic,strong)UIPickerView * GREASEAMOUNT3Picker;
@property(nonatomic,strong)UIPickerView * GREASECOLOR3Picker;
@property(nonatomic,strong)UIPickerView * GREASEILE3Picker;
@property(nonatomic,strong)UIPickerView * GREASEILEDESC2Picker;
@property(nonatomic,strong)UIPickerView * LEAKAGE3Picker;
@property(nonatomic,strong)UIPickerView * GREASECOLOR4Picker;
@property(nonatomic,strong)UIPickerView * GREASEAMOUNT4Picker;
@property(nonatomic,strong)UIPickerView * GREASEILE4Picker;
@property(nonatomic,strong)UIPickerView * ISRACEPicker;
@property(nonatomic,strong)UIPickerView * OUTERPicker;
@property(nonatomic,strong)UIPickerView * CAGEPicker;

@end

@implementation FDJZC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    CGRect pickerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    self.POWERSUPPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.POWERMODLEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.POWERSPECPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ISWIRINGPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ISFETCHPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.UDISMODLEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.REPAIRDEPTPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ADDGRASEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.BRANDTYPE2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEAMOUNT2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASECOLOR2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILE2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILEDESC1Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.LEAKAGE2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.LUBRICATINGPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.REPAIRBEFOREPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.REPAIRAFTERPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.REPAIRDEPT2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ADDGRASE2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASE2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.BRANDTYPE3Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEAMOUNT3Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASECOLOR3Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILE3Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILEDESC2Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.LEAKAGE3Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASECOLOR4Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEAMOUNT4Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.GREASEILE4Picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.ISRACEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.OUTERPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.CAGEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    self.POWERSUPPicker.dataSource = self;
    self.POWERMODLEPicker.dataSource = self;
    self.POWERSPECPicker.dataSource = self;
    self.ISWIRINGPicker.dataSource = self;
    self.ISFETCHPicker.dataSource = self;
    self.UDISMODLEPicker.dataSource = self;
    self.REPAIRDEPTPicker.dataSource = self;
    self.ADDGRASEPicker.dataSource = self;
    self.GREASEPicker.dataSource = self;
    self.BRANDTYPE2Picker.dataSource = self;
    self.GREASEAMOUNT2Picker.dataSource = self;
    self.GREASECOLOR2Picker.dataSource = self;
    self.GREASEILE2Picker.dataSource = self;
    self.GREASEILEDESC1Picker.dataSource = self;
    self.LEAKAGE2Picker.dataSource = self;
    self.LUBRICATINGPicker.dataSource = self;
    self.REPAIRBEFOREPicker.dataSource = self;
    self.REPAIRAFTERPicker.dataSource = self;
    self.REPAIRDEPT2Picker.dataSource = self;
    self.ADDGRASE2Picker.dataSource = self;
    self.GREASE2Picker.dataSource = self;
    self.BRANDTYPE3Picker.dataSource = self;
    self.GREASEAMOUNT3Picker.dataSource = self;
    self.GREASECOLOR3Picker.dataSource = self;
    self.GREASEILE3Picker.dataSource = self;
    self.GREASEILEDESC2Picker.dataSource = self;
    self.LEAKAGE3Picker.dataSource = self;
    self.GREASECOLOR4Picker.dataSource = self;
    self.GREASEAMOUNT4Picker.dataSource = self;
    self.GREASEILE4Picker.dataSource = self;
    self.ISRACEPicker.dataSource = self;
    self.OUTERPicker.dataSource = self;
    self.CAGEPicker.dataSource = self;
    
    self.POWERSUPPicker.delegate = self;
    self.POWERMODLEPicker.delegate = self;
    self.POWERSPECPicker.delegate = self;
    self.ISWIRINGPicker.delegate = self;
    self.ISFETCHPicker.delegate = self;
    self.UDISMODLEPicker.delegate = self;
    self.REPAIRDEPTPicker.delegate = self;
    self.ADDGRASEPicker.delegate = self;
    self.GREASEPicker.delegate = self;
    self.BRANDTYPE2Picker.delegate = self;
    self.GREASEAMOUNT2Picker.delegate = self;
    self.GREASECOLOR2Picker.delegate = self;
    self.GREASEILE2Picker.delegate = self;
    self.GREASEILEDESC1Picker.delegate = self;
    self.LEAKAGE2Picker.delegate = self;
    self.LUBRICATINGPicker.delegate = self;
    self.REPAIRBEFOREPicker.delegate = self;
    self.REPAIRAFTERPicker.delegate = self;
    self.REPAIRDEPT2Picker.delegate = self;
    self.ADDGRASE2Picker.delegate = self;
    self.GREASE2Picker.delegate = self;
    self.BRANDTYPE3Picker.delegate = self;
    self.GREASEAMOUNT3Picker.delegate = self;
    self.GREASECOLOR3Picker.delegate = self;
    self.GREASEILE3Picker.delegate = self;
    self.GREASEILEDESC2Picker.delegate = self;
    self.LEAKAGE3Picker.delegate = self;
    self.GREASECOLOR4Picker.delegate = self;
    self.GREASEAMOUNT4Picker.delegate = self;
    self.GREASEILE4Picker.delegate = self;
    self.ISRACEPicker.delegate = self;
    self.OUTERPicker.delegate = self;
    self.CAGEPicker.delegate = self;
    
    [self.POWERSUPPicker setBackgroundColor:[UIColor grayColor]];
    [self.POWERMODLEPicker setBackgroundColor:[UIColor grayColor]];
    [self.POWERSPECPicker setBackgroundColor:[UIColor grayColor]];
    [self.ISWIRINGPicker  setBackgroundColor:[UIColor grayColor]];
    [self.ISFETCHPicker setBackgroundColor:[UIColor grayColor]];
    [self.UDISMODLEPicker setBackgroundColor:[UIColor grayColor]];
    [self.REPAIRDEPTPicker setBackgroundColor:[UIColor grayColor]];
    [self.ADDGRASEPicker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEPicker setBackgroundColor:[UIColor grayColor]];
    [self.BRANDTYPE2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEAMOUNT2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASECOLOR2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILE2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILEDESC1Picker setBackgroundColor:[UIColor grayColor]];
    [self.LEAKAGE2Picker setBackgroundColor:[UIColor grayColor]];
    [self.LUBRICATINGPicker setBackgroundColor:[UIColor grayColor]];
    [self.REPAIRBEFOREPicker setBackgroundColor:[UIColor grayColor]];
    [self.REPAIRAFTERPicker setBackgroundColor:[UIColor grayColor]];
    [self.REPAIRDEPT2Picker setBackgroundColor:[UIColor grayColor]];
    [self.ADDGRASE2Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASE2Picker setBackgroundColor:[UIColor grayColor]];
    [self.BRANDTYPE3Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEAMOUNT3Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASECOLOR3Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILE3Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILEDESC2Picker setBackgroundColor:[UIColor grayColor]];
    [self.LEAKAGE3Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASECOLOR4Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEAMOUNT4Picker setBackgroundColor:[UIColor grayColor]];
    [self.GREASEILE4Picker setBackgroundColor:[UIColor grayColor]];
    [self.ISRACEPicker setBackgroundColor:[UIColor grayColor]];
    [self.OUTERPicker setBackgroundColor:[UIColor grayColor]];
    [self.CAGEPicker setBackgroundColor:[UIColor grayColor]];
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
-(void)selectValue:(NSString *)fieldName
{
    [self modifyTypeByFieldName:fieldName newType:@"picker"];
}
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    
}
-(void)addPickerIncell:(UITableViewCell* )cell fieldName:(NSString*) fieldName
{
    if ([fieldName isEqualToString:@"POWERSUP"]) {
        [cell addSubview:self.POWERSUPPicker];
    }
    if ([fieldName isEqualToString:@"POWERMODLE"])
    {
        [cell addSubview:self.POWERMODLEPicker];
    }
    if ([fieldName isEqualToString:@"POWERSPEC"]) {
        [cell addSubview:self.POWERSPECPicker];
    }
    if ([fieldName isEqualToString:@"ISWIRING"]) {
        [cell addSubview:self.ISWIRINGPicker];
    }
    if ([fieldName isEqualToString:@"ISFETCH"]) {
        [cell addSubview:self.ISFETCHPicker];
    }
    if ([fieldName isEqualToString:@"UDISMODLE"]) {
        [cell addSubview:self.UDISMODLEPicker];
    }
    if ([fieldName isEqualToString:@"REPAIRDEPT"]) {
        [cell addSubview:self.REPAIRDEPTPicker];
    }
    if ([fieldName isEqualToString:@"ADDGRASE"]) {
        [cell addSubview:self.ADDGRASEPicker];
    }
    if ([fieldName isEqualToString:@"GREASE"]) {
        [cell addSubview:self.GREASEPicker];
    }
    if ([fieldName isEqualToString:@"BRANDTYPE2"]) {
        [cell addSubview:self.BRANDTYPE2Picker];
    }
    if ([fieldName isEqualToString:@"GREASEAMOUNT2"]) {
        [cell addSubview:self.GREASEAMOUNT2Picker];
    }
    if ([fieldName isEqualToString:@"GREASECOLOR2"]) {
        [cell addSubview:self.GREASECOLOR2Picker];
    }
    if ([fieldName isEqualToString:@"GREASEILE2"]) {
        [cell addSubview:self.GREASEILE2Picker];
    }
    if ([fieldName isEqualToString:@"GREASEILEDESC1"]) {
        [cell addSubview:self.GREASEILEDESC1Picker];
    }
    if ([fieldName isEqualToString:@"LEAKAGE2"]) {
        [cell addSubview:self.LEAKAGE2Picker];
    }
    if ([fieldName isEqualToString:@"LUBRICATING"]) {
        [cell addSubview:self.LUBRICATINGPicker];
    }
    if ([fieldName isEqualToString:@"REPAIRBEFORE"]) {
        [cell addSubview:self.REPAIRBEFOREPicker];
    }
    if ([fieldName isEqualToString:@"REPAIRAFTER"]) {
        [cell addSubview:self.REPAIRAFTERPicker];
    }
    if ([fieldName isEqualToString:@"REPAIRDEPT2"]) {
        [cell addSubview:self.REPAIRDEPT2Picker];
    }
    if ([fieldName isEqualToString:@"ADDGRASE2"]) {
        [cell addSubview:self.ADDGRASE2Picker];
    }
    if ([fieldName isEqualToString:@"GREASE2"]) {
        [cell addSubview:self.GREASE2Picker];
    }
    if ([fieldName isEqualToString:@"BRANDTYPE3"]) {
        [cell addSubview:self.BRANDTYPE3Picker];
    }
    if ([fieldName isEqualToString:@"GREASEAMOUNT3"]) {
        [cell addSubview:self.GREASEAMOUNT3Picker];
    }
    if ([fieldName isEqualToString:@"GREASECOLOR3"]) {
        [cell addSubview:self.GREASECOLOR3Picker];
    }
    if ([fieldName isEqualToString:@"GREASEILE3"]) {
        [cell addSubview:self.GREASEILE3Picker];
    }
    if ([fieldName isEqualToString:@"GREASEILEDESC2"]) {
        [cell addSubview:self.GREASEILEDESC2Picker];
    }
    if ([fieldName isEqualToString:@"LEAKAGE3"]) {
        [cell addSubview:self.LEAKAGE3Picker];
    }
    if ([fieldName isEqualToString:@"GREASECOLOR4"]) {
        [cell addSubview:self.GREASECOLOR4Picker];
    }
    if ([fieldName isEqualToString:@"GREASEAMOUNT4"]) {
        [cell addSubview:self.GREASEAMOUNT4Picker];
    }
    if ([fieldName isEqualToString:@"GREASEILE4"]) {
        [cell addSubview:self.GREASEILE4Picker];
    }
    if ([fieldName isEqualToString:@"ISRACE"]) {
        [cell addSubview:self.ISRACEPicker];
    }
    if ([fieldName isEqualToString:@"OUTER"]) {
        [cell addSubview:self.OUTERPicker];
    }
    if ([fieldName isEqualToString:@"CAGE"]) {
        [cell addSubview:self.CAGEPicker];
    }

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    
    if ([pickerView isEqual:self.POWERSUPPicker]) {
        array = [df arrayWithName:@"POWERSUP"];
    }
    if ([pickerView isEqual:self.POWERMODLEPicker]){
        array = [df arrayWithName:@"POWERMODLE"];
    }
    if ([pickerView isEqual:self.POWERSPECPicker]){
        array = [df arrayWithName:@"POWERSPEC"];
    }
    if ([pickerView isEqual:self.ISWIRINGPicker]){
        array = [df arrayWithName:@"ISWIRING"];
    }
    if ([pickerView isEqual:self.ISFETCHPicker]){
        array = [df arrayWithName:@"ISFETCH"];
    }
    if ([pickerView isEqual:self.UDISMODLEPicker]){
        array = [df arrayWithName:@"UDISMODLE"];
    }
    if ([pickerView isEqual:self.REPAIRDEPTPicker]){
        array = [df arrayWithName:@"REPAIRDEPT"];
    }
    if ([pickerView isEqual:self.ADDGRASEPicker]){
        array = [df arrayWithName:@"ADDGRASE"];
    }
    if ([pickerView isEqual:self.GREASEPicker]){
        array = [df arrayWithName:@"GREASE"];
    }
    if ([pickerView isEqual:self.BRANDTYPE2Picker]){
        array = [df arrayWithName:@"BRANDTYPE2"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT2Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT2"];
    }
    if ([pickerView isEqual:self.GREASECOLOR2Picker]){
        array = [df arrayWithName:@"GREASECOLOR2"];
    }
    if ([pickerView isEqual:self.GREASEILE2Picker]){
        array = [df arrayWithName:@"GREASEILE2"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC1Picker]){
        array = [df arrayWithName:@"GREASEILEDESC1"];
    }
    if ([pickerView isEqual:self.LEAKAGE2Picker]){
        array = [df arrayWithName:@"LEAKAGE2"];
    }
    if ([pickerView isEqual:self.LUBRICATINGPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
    }
    if ([pickerView isEqual:self.REPAIRBEFOREPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
    }
    if ([pickerView isEqual:self.REPAIRAFTERPicker]){
        array = [df arrayWithName:@"REPAIRAFTER"];
    }
    if ([pickerView isEqual:self.REPAIRDEPT2Picker]){
        array = [df arrayWithName:@"REPAIRDEPT2"];
    }
    if ([pickerView isEqual:self.ADDGRASE2Picker]){
        array = [df arrayWithName:@"ADDGRASE2"];
    }
    if ([pickerView isEqual:self.GREASE2Picker]){
        array = [df arrayWithName:@"GREASE2"];
    }
    if ([pickerView isEqual:self.BRANDTYPE3Picker]){
        array = [df arrayWithName:@"BRANDTYPE3"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT3Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT3"];
    }
    if ([pickerView isEqual:self.GREASECOLOR3Picker]){
        array = [df arrayWithName:@"GREASECOLOR3"];
    }
    if ([pickerView isEqual:self.GREASEILE3Picker]){
        array = [df arrayWithName:@"GREASEILE3"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC2Picker]){
        array = [df arrayWithName:@"GREASEILEDESC2"];
    }
    if ([pickerView isEqual:self.LEAKAGE3Picker]){
        array = [df arrayWithName:@"LEAKAGE3"];
    }
    if ([pickerView isEqual:self.GREASECOLOR4Picker]){
        array = [df arrayWithName:@"GREASECOLOR4"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT4Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT4"];
    }
    if ([pickerView isEqual:self.GREASEILE4Picker]){
        array = [df arrayWithName:@"GREASEILE4"];
    }
    if ([pickerView isEqual:self.ISRACEPicker]){
        array = [df arrayWithName:@"ISRACE"];
    }
    if ([pickerView isEqual:self.OUTERPicker]){
        array = [df arrayWithName:@"OUTER"];
    }
    if ([pickerView isEqual:self.CAGEPicker]){
        array = [df arrayWithName:@"CAGE"];
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
    
    if ([pickerView isEqual:self.POWERSUPPicker]) {
        array = [df arrayWithName:@"POWERSUP"];
    }
    if ([pickerView isEqual:self.POWERMODLEPicker]){
        array = [df arrayWithName:@"POWERMODLE"];
    }
    if ([pickerView isEqual:self.POWERSPECPicker]){
        array = [df arrayWithName:@"POWERSPEC"];
    }
    if ([pickerView isEqual:self.ISWIRINGPicker]){
        array = [df arrayWithName:@"ISWIRING"];
    }
    if ([pickerView isEqual:self.ISFETCHPicker]){
        array = [df arrayWithName:@"ISFETCH"];
    }
    if ([pickerView isEqual:self.UDISMODLEPicker]){
        array = [df arrayWithName:@"UDISMODLE"];
    }
    if ([pickerView isEqual:self.REPAIRDEPTPicker]){
        array = [df arrayWithName:@"REPAIRDEPT"];
    }
    if ([pickerView isEqual:self.ADDGRASEPicker]){
        array = [df arrayWithName:@"ADDGRASE"];
    }
    if ([pickerView isEqual:self.GREASEPicker]){
        array = [df arrayWithName:@"GREASE"];
    }
    if ([pickerView isEqual:self.BRANDTYPE2Picker]){
        array = [df arrayWithName:@"BRANDTYPE2"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT2Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT2"];
    }
    if ([pickerView isEqual:self.GREASECOLOR2Picker]){
        array = [df arrayWithName:@"GREASECOLOR2"];
    }
    if ([pickerView isEqual:self.GREASEILE2Picker]){
        array = [df arrayWithName:@"GREASEILE2"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC1Picker]){
        array = [df arrayWithName:@"GREASEILEDESC1"];
    }
    if ([pickerView isEqual:self.LEAKAGE2Picker]){
        array = [df arrayWithName:@"LEAKAGE2"];
    }
    if ([pickerView isEqual:self.LUBRICATINGPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
    }
    if ([pickerView isEqual:self.REPAIRBEFOREPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
    }
    if ([pickerView isEqual:self.REPAIRAFTERPicker]){
        array = [df arrayWithName:@"REPAIRAFTER"];
    }
    if ([pickerView isEqual:self.REPAIRDEPT2Picker]){
        array = [df arrayWithName:@"REPAIRDEPT2"];
    }
    if ([pickerView isEqual:self.ADDGRASE2Picker]){
        array = [df arrayWithName:@"ADDGRASE2"];
    }
    if ([pickerView isEqual:self.GREASE2Picker]){
        array = [df arrayWithName:@"GREASE2"];
    }
    if ([pickerView isEqual:self.BRANDTYPE3Picker]){
        array = [df arrayWithName:@"BRANDTYPE3"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT3Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT3"];
    }
    if ([pickerView isEqual:self.GREASECOLOR3Picker]){
        array = [df arrayWithName:@"GREASECOLOR3"];
    }
    if ([pickerView isEqual:self.GREASEILE3Picker]){
        array = [df arrayWithName:@"GREASEILE3"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC2Picker]){
        array = [df arrayWithName:@"GREASEILEDESC2"];
    }
    if ([pickerView isEqual:self.LEAKAGE3Picker]){
        array = [df arrayWithName:@"LEAKAGE3"];
    }
    if ([pickerView isEqual:self.GREASECOLOR4Picker]){
        array = [df arrayWithName:@"GREASECOLOR4"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT4Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT4"];
    }
    if ([pickerView isEqual:self.GREASEILE4Picker]){
        array = [df arrayWithName:@"GREASEILE4"];
    }
    if ([pickerView isEqual:self.ISRACEPicker]){
        array = [df arrayWithName:@"ISRACE"];
    }
    if ([pickerView isEqual:self.OUTERPicker]){
        array = [df arrayWithName:@"OUTER"];
    }
    if ([pickerView isEqual:self.CAGEPicker]){
        array = [df arrayWithName:@"CAGE"];
    }
    return [array count];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView removeFromSuperview];
    DataFactory * df = [[DataFactory alloc] init];
    NSArray * array = nil;
    if ([pickerView isEqual:self.POWERSUPPicker]) {
        array = [df arrayWithName:@"POWERSUP"];
        [self modifyFieldByFieldName:@"POWERSUP" newValue:array[row]];
        [self modifyTypeByFieldName:@"POWERSUP" newType:@"选择"];
    }

    if ([pickerView isEqual:self.POWERMODLEPicker]){
        array = [df arrayWithName:@"POWERMODLE"];
        [self modifyFieldByFieldName:@"POWERMODLE" newValue:array[row]];
        [self modifyTypeByFieldName:@"POWERMODLE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.POWERSPECPicker]){
        array = [df arrayWithName:@"POWERSPEC"];
        [self modifyFieldByFieldName:@"POWERSPEC" newValue:array[row]];
        [self modifyTypeByFieldName:@"POWERSPEC" newType:@"选择"];
    }
    if ([pickerView isEqual:self.ISWIRINGPicker]){
        array = [df arrayWithName:@"ISWIRING"];
        [self modifyFieldByFieldName:@"ISWIRING" newValue:array[row]];
        [self modifyTypeByFieldName:@"ISWIRING" newType:@"选择"];
    }
    if ([pickerView isEqual:self.ISFETCHPicker]){
        array = [df arrayWithName:@"ISFETCH"];
        [self modifyFieldByFieldName:@"ISFETCH" newValue:array[row]];
        [self modifyTypeByFieldName:@"ISFETCH" newType:@"选择"];
    }
    if ([pickerView isEqual:self.UDISMODLEPicker]){
        array = [df arrayWithName:@"UDISMODLE"];
        [self modifyFieldByFieldName:@"UDISMODLE" newValue:array[row]];
        [self modifyTypeByFieldName:@"UDISMODLE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.REPAIRDEPTPicker]){
        array = [df arrayWithName:@"REPAIRDEPT"];
        [self modifyFieldByFieldName:@"REPAIRDEPT" newValue:array[row]];
        [self modifyTypeByFieldName:@"REPAIRDEPT" newType:@"选择"];
    }
    if ([pickerView isEqual:self.ADDGRASEPicker]){
        array = [df arrayWithName:@"ADDGRASE"];
        [self modifyFieldByFieldName:@"ADDGRASE" newValue:array[row]];
        [self modifyTypeByFieldName:@"ADDGRASE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEPicker]){
        array = [df arrayWithName:@"GREASE"];
        [self modifyFieldByFieldName:@"GREASE" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.BRANDTYPE2Picker]){
        array = [df arrayWithName:@"BRANDTYPE2"];
        [self modifyFieldByFieldName:@"BRANDTYPE2" newValue:array[row]];
        [self modifyTypeByFieldName:@"BRANDTYPE2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT2Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT2"];
        [self modifyFieldByFieldName:@"GREASEAMOUNT2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEAMOUNT2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASECOLOR2Picker]){
        array = [df arrayWithName:@"GREASECOLOR2"];
        [self modifyFieldByFieldName:@"GREASECOLOR2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASECOLOR2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEILE2Picker]){
        array = [df arrayWithName:@"GREASEILE2"];
        [self modifyFieldByFieldName:@"GREASEILE2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILE2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC1Picker]){
        array = [df arrayWithName:@"GREASEILEDESC1"];
        [self modifyFieldByFieldName:@"GREASEILEDESC1" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILEDESC1" newType:@"选择"];
    }
    if ([pickerView isEqual:self.LEAKAGE2Picker]){
        array = [df arrayWithName:@"LEAKAGE2"];
        [self modifyFieldByFieldName:@"LEAKAGE2" newValue:array[row]];
        [self modifyTypeByFieldName:@"LEAKAGE2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.LUBRICATINGPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
        [self modifyFieldByFieldName:@"REPAIRBEFORE" newValue:array[row]];
        [self modifyTypeByFieldName:@"REPAIRBEFORE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.REPAIRBEFOREPicker]){
        array = [df arrayWithName:@"REPAIRBEFORE"];
        [self modifyFieldByFieldName:@"REPAIRBEFORE" newValue:array[row]];
        [self modifyTypeByFieldName:@"REPAIRBEFORE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.REPAIRAFTERPicker]){
        array = [df arrayWithName:@"REPAIRAFTER"];
        [self modifyFieldByFieldName:@"REPAIRAFTER" newValue:array[row]];
        [self modifyTypeByFieldName:@"REPAIRAFTER" newType:@"选择"];
    }
    if ([pickerView isEqual:self.REPAIRDEPT2Picker]){
        array = [df arrayWithName:@"REPAIRDEPT2"];
        [self modifyFieldByFieldName:@"REPAIRDEPT2" newValue:array[row]];
        [self modifyTypeByFieldName:@"REPAIRDEPT2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.ADDGRASE2Picker]){
        array = [df arrayWithName:@"ADDGRASE2"];
        [self modifyFieldByFieldName:@"ADDGRASE2" newValue:array[row]];
        [self modifyTypeByFieldName:@"ADDGRASE2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASE2Picker]){
        array = [df arrayWithName:@"GREASE2"];
        [self modifyFieldByFieldName:@"GREASE2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASE2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.BRANDTYPE3Picker]){
        array = [df arrayWithName:@"BRANDTYPE3"];
        [self modifyFieldByFieldName:@"BRANDTYPE3" newValue:array[row]];
        [self modifyTypeByFieldName:@"BRANDTYPE3" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT3Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT3"];
        [self modifyFieldByFieldName:@"GREASEAMOUNT3" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEAMOUNT3" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASECOLOR3Picker]){
        array = [df arrayWithName:@"GREASECOLOR3"];
        [self modifyFieldByFieldName:@"GREASECOLOR3" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASECOLOR3" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEILE3Picker]){
        array = [df arrayWithName:@"GREASEILE3"];
        [self modifyFieldByFieldName:@"GREASEILE3" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILE3" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEILEDESC2Picker]){
        array = [df arrayWithName:@"GREASEILEDESC2"];
        [self modifyFieldByFieldName:@"GREASEILEDESC2" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILEDESC2" newType:@"选择"];
    }
    if ([pickerView isEqual:self.LEAKAGE3Picker]){
        array = [df arrayWithName:@"LEAKAGE3"];
        [self modifyFieldByFieldName:@"LEAKAGE3" newValue:array[row]];
        [self modifyTypeByFieldName:@"LEAKAGE3" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASECOLOR4Picker]){
        array = [df arrayWithName:@"GREASECOLOR4"];
        [self modifyFieldByFieldName:@"GREASECOLOR4" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASECOLOR4" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEAMOUNT4Picker]){
        array = [df arrayWithName:@"GREASEAMOUNT4"];
        [self modifyFieldByFieldName:@"GREASEAMOUNT4" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEAMOUNT4" newType:@"选择"];
    }
    if ([pickerView isEqual:self.GREASEILE4Picker]){
        array = [df arrayWithName:@"GREASEILE4"];
        [self modifyFieldByFieldName:@"GREASEILE4" newValue:array[row]];
        [self modifyTypeByFieldName:@"GREASEILE4" newType:@"选择"];
    }
    if ([pickerView isEqual:self.ISRACEPicker]){
        array = [df arrayWithName:@"ISRACE"];
        [self modifyFieldByFieldName:@"ISRACE" newValue:array[row]];
        [self modifyTypeByFieldName:@"ISRACE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.OUTERPicker]){
        array = [df arrayWithName:@"OUTER"];
        [self modifyFieldByFieldName:@"OUTER" newValue:array[row]];
        [self modifyTypeByFieldName:@"OUTER" newType:@"选择"];
    }
    if ([pickerView isEqual:self.CAGEPicker]){
        array = [df arrayWithName:@"CAGE"];
        [self modifyFieldByFieldName:@"CAGE" newValue:array[row]];
        [self modifyTypeByFieldName:@"CAGE" newType:@"选择"];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate FDJZC_DATA:[self dictionaryData]];
}
@end
