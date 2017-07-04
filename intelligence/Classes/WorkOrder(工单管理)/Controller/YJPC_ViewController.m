//
//  YJPC_ViewController.m
//  intelligence
//
//  Created by chris on 2017/6/29.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "YJPC_ViewController.h"
#import "NSArray+Extension.h"
#import "ZZZC_ViewController.h"
#import "FDJZC_ViewController.h"
#import "CLXGSZZC_ViewController.h"
#import "PCXXXX_ViewController.h"
@interface YJPC_ViewController ()

@end

@implementation YJPC_ViewController
{
    NSMutableArray * UDWARNINGNORMs;
    NSMutableArray * PCXXXXs;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self queryDisplayNameByUserName:self.Kmodel.CREATEBY FieldName:@"创建人姓名"];
    [self queryDisplayNameByUserName:self.Kmodel.SCREENINGUSER FieldName:@"排查人1姓名"];
    [self queryProjectNameByProjectNum:self.Kmodel.PRONUM];
    [self queryMODELTYPEByProjectNum:self.Kmodel.PRONUM Locnum:self.Kmodel.LOCNUM];
    [self queryUDWARNINGNORM];
    
    CGRect pickerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    self.typePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.typePicker.delegate = self;
    self.typePicker.dataSource = self;
    [self.typePicker setBackgroundColor:[UIColor grayColor]];
    
    self.UDLEVELPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.UDLEVELPicker.delegate = self;
    self.UDLEVELPicker.dataSource = self;
    [self.UDLEVELPicker setBackgroundColor:[UIColor grayColor]];
    
    self.PROBASEPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.PROBASEPicker.delegate = self;
    self.PROBASEPicker.dataSource = self;
    [self.PROBASEPicker setBackgroundColor:[UIColor grayColor]];
    
    self.MASTERCONTROLPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.MASTERCONTROLPicker.delegate = self;
    self.MASTERCONTROLPicker.dataSource = self;
    [self.MASTERCONTROLPicker setBackgroundColor:[UIColor grayColor]];
    
    self.VARIABLEPITCHPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.VARIABLEPITCHPicker.delegate = self;
    self.VARIABLEPITCHPicker.dataSource = self;
    [self.VARIABLEPITCHPicker setBackgroundColor:[UIColor grayColor]];
    
    self.FREQUENCYCONVERSIONPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    self.FREQUENCYCONVERSIONPicker.delegate = self;
    self.FREQUENCYCONVERSIONPicker.dataSource = self;
    [self.FREQUENCYCONVERSIONPicker setBackgroundColor:[UIColor grayColor]];
    
    
    self.LIFTINGDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.LIFTINGDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.LIFTINGDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.INTERCONNECTIONDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.INTERCONNECTIONDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.INTERCONNECTIONDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.SCREENINGDATEDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [self.SCREENINGDATEDatePicker setBackgroundColor:[UIColor grayColor]];
    [self.SCREENINGDATEDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"发电机轴承" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"隐藏"];
    [self modifyTypeByFieldName:@"排查详细信息" newType:@"隐藏"];
    
    NSLog(@"排查类型 %@",[self valueByname:@"排查类型"]);
    
    if ([[self valueByname:@"排查类型"] isEqualToString:@"主轴轴承故障"]) {
        
        [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"跳转"];
        
    }else if([[self valueByname:@"排查类型"] isEqualToString:@"发电机轴承温度异常"]){
        
        [self modifyTypeByFieldName:@"发电机轴承" newType:@"跳转"];
    
    }else if([[self valueByname:@"排查类型"] isEqualToString:@"齿轮箱高速轴轴承温度异常"]){
        
        [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"跳转"];
    
    }else{
        [self modifyTypeByFieldName:@"排查详细信息" newType:@"跳转"];
        [self queryNORMNUMByWARNTYPE:[self valueByname:@"排查类型"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)selectValue:(NSString *)fieldName
{
    NSLog(@"子类重写 %@",fieldName);
    
    if ([fieldName isEqualToString:@"TYPE"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"UDLEVEL"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"PROBASE"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"MASTERCONTROL"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"VARIABLEPITCH"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
    if ([fieldName isEqualToString:@"FREQUENCYCONVERSION"]) {
        [self modifyTypeByFieldName:fieldName newType:@"picker"];
    }
}
-(void)jumpToDetial:(NSString *)name
{
    NSLog(@"子类重写 %@",name);
    if ([name isEqualToString:@"主轴轴承故障"]) {
        
        ZZZC_ViewController * vc = [[ZZZC_ViewController alloc] init];
        vc.key = name;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([name isEqualToString:@"发电机轴承"]) {
        
        FDJZC_ViewController * vc = [[FDJZC_ViewController alloc] init];
        vc.key = name;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([name isEqualToString:@"齿轮箱高速轴轴承"]) {
        
        CLXGSZZC_ViewController * vc = [[CLXGSZZC_ViewController alloc] init];
        vc.key = name;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        PCXXXX_ViewController * vc = [[PCXXXX_ViewController alloc] init];
        vc.key = name;
        if (PCXXXXs.count>1) {
            [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":@"-",@"值":@"请补充" ,@"类型":@"文本",@"必填":@"否",@"字段名":@"-"}]];
            vc.array = PCXXXXs;
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)setDate:(NSString *)name
{
    NSLog(@"子类设置日期 %@",name);
    if ([name isEqualToString:@"LIFTINGDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
    if ([name isEqualToString:@"INTERCONNECTIONDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
    if ([name isEqualToString:@"SCREENINGDATE"]) {
        [self modifyTypeByFieldName:name newType:@"picker"];
    }
}
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    if ([name isEqualToString:@"排查类型"]) {
        [cell addSubview:self.typePicker];
    }
    if ([name isEqualToString:@"预警等级"]) {
        [cell addSubview:self.UDLEVELPicker];
    }
    if ([name isEqualToString:@"装配基地"]) {
        [cell addSubview:self.PROBASEPicker];
    }
    if ([name isEqualToString:@"主控配置"]) {
        [cell addSubview:self.MASTERCONTROLPicker];
    }
    if ([name isEqualToString:@"变浆配置"]) {
        [cell addSubview:self.VARIABLEPITCHPicker];
    }
    if ([name isEqualToString:@"变频配置"]) {
        [cell addSubview:self.FREQUENCYCONVERSIONPicker];
    }
    if ([name isEqualToString:@"吊装时间"]) {
        [cell addSubview:self.LIFTINGDATEDatePicker];
        [self.LIFTINGDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if ([name isEqualToString:@"并网时间"]) {
        [cell addSubview:self.INTERCONNECTIONDATEDatePicker];
         [self.INTERCONNECTIONDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if ([name isEqualToString:@"排查时间"]) {
        [cell addSubview:self.SCREENINGDATEDatePicker];
         [self.SCREENINGDATEDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

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
//根据工号查人名
-(void)queryDisplayNameByUserName:(NSString*)username FieldName:(NSString*)fieldName
{
    if(username.length<=0||fieldName.length<=0)
    {
        return;
    }
    
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDPERSON",
                           @"objectname":@"PERSON",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"STATUS":@"=活动",
                                          @"PERSONID":username}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};

    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {

        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * displayName = info[@"DISPLAYNAME"];
        [self modifyField:fieldName newValue:displayName];
        
    } fail:^(NSError *error) {
        
    }];
}
//根据项目编号查项目名
-(void)queryProjectNameByProjectNum:(NSString*) projectNum
{
    if(projectNum.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDPROJECT",
                           @"objectname":@"UDPRO",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"condition":@{@"TESTPRO":@"Y",
                                          @"PRONUM":projectNum}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        NSString * DESCRIPTION = info[@"DESCRIPTION"];
        NSString * RESPONS =  info[@"RESPONS"];
        NSString * RESPONSNAME = info[@"RESPONSNAME"];
        
        [self modifyField:@"项目名称" newValue:DESCRIPTION];
        [self modifyField:@"项目负责人" newValue:RESPONS];
        [self modifyField:@"姓名" newValue:RESPONSNAME];
        
    } fail:^(NSError *error) {
        
    }];
    
}
//根据机位号查机组型号和程序版本号
-(void)queryMODELTYPEByProjectNum:(NSString*) projectNum Locnum:(NSString*) LOCNUM
{
    if(projectNum.length<=0||LOCNUM.length<=0)
    {
        return;
    }
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDFANDETAILS",
                           @"objectname":@"UDFANDETAILS",
                           @"curpage":@(1),
                           @"showcount":@(20),
                           @"option":@"read",
                           @"orderby":@"LOCNUM",
                           @"condition":@{@"LOCNUM":LOCNUM,
                                          @"PRONUM":projectNum}};
    
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSDictionary * info = response[@"result"][@"resultlist"][0];
        
        NSString * MODELTYPE = info[@"MODELTYPE"];
        NSString * UDFJAPPNUM =  info[@"UDFJAPPNUM"];
        
        [self modifyField:@"机组型号" newValue:MODELTYPE];
        [self modifyField:@"程序版本号" newValue:UDFJAPPNUM];
       
    } fail:^(NSError *error) {
        
    }];
}
-(void)queryUDWARNINGNORM
{
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNNORM",
                           @"objectname":@"UDWARNINGNORM",
                           @"curpage":@(1),
                           @"showcount":@(100),
                           @"option":@"read",
                           @"orderby":@"NORMNUM"};
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSArray * array = response[@"result"][@"resultlist"];
        UDWARNINGNORMs=[NSMutableArray array];
        [UDWARNINGNORMs addObjectsFromArray:array];
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"1",@"WARNTYPE":@"主轴轴承故障"}];
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"2",@"WARNTYPE":@"发电机轴承温度异常"}];
        [UDWARNINGNORMs addObject:@{@"NORMNUM":@"3",@"WARNTYPE":@"齿轮箱高速轴轴承温度异常"}];
        NSLog(@"预警排查类型 %@",UDWARNINGNORMs);
    } fail:^(NSError *error) {
        
    }];

}
-(void)queryUDWARNINGNORMLINE:(NSString*)NORMNUM;
{
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNINGNORMLINE",
                           @"objectname":@"UDWARNINGNORMLINE",
                           @"curpage":@(1),
                           @"showcount":@(100),
                           @"option":@"read",
                           @"orderby":@"SERIALNUM",
                           @"condition":@{@"NORMNUM":NORMNUM}};
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {

        NSArray * array =  response[@"result"][@"resultlist"];
        
        if (array.count>0) {
            PCXXXXs = [NSMutableArray array];
            NSInteger index = 1;
            for (NSDictionary * dic in array) {
                
                NSString *CHECKITEM = dic[@"CHECKITEM"]?dic[@"CHECKITEM"]:@"";
                NSString *CHECKCONTENT = dic[@"CHECKCONTENT"]?dic[@"CHECKCONTENT"]:@"";
                
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":CHECKITEM,@"值":@"" ,@"类型":@"标题",@"必填":@"否",@"字段名":@"NONAME3"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":CHECKCONTENT,@"值":@"" ,@"类型":@"标题",@"必填":@"否",@"字段名":@"NONAME3"}]];
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":[NSString stringWithFormat:@"%ld、%@",(long)index,@"排查结果(是否合格)"],@"值":@"N" ,@"类型":@"是否",@"必填":@"否",@"字段名":@"CHECKRESULT"}]];
        
                [PCXXXXs addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"名称":[NSString stringWithFormat:@"%ld、%@",(long)index,@"问题描述"],@"值":@"请补充" ,@"类型":@"文本",@"必填":@"否",@"字段名": @"PROBLEMDESC"}]];
                
                index++;
            }
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)queryNORMNUMByWARNTYPE:(NSString*)WARNTYPE
{
    NSString * url = @"/maximo/mobile/common/api";
    NSDictionary * dic = @{@"appid":@"UDWARNNORM",
                           @"objectname":@"UDWARNINGNORM",
                           @"curpage":@(1),
                           @"showcount":@(1),
                           @"option":@"read",
                           @"orderby":@"NORMNUM",
                           @"condition":@{@"WARNTYPE":WARNTYPE}};
    NSString *requestJson = kDictionaryToJson(dic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    [HTTPSessionManager getWithUrl:url params:dataDic success:^(id response) {
        
        NSString * NORMNUM = response[@"result"][@"resultlist"][0][@"NORMNUM"];
        if (NORMNUM.length>0) {
            [self queryUDWARNINGNORMLINE:NORMNUM];
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

        if ([pickerView isEqual:self.typePicker]) {
        
            return [UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"];
        
        }else if ([pickerView isEqual:self.UDLEVELPicker]) {
        
            return @[@"高",@"中",@"低"][row];
        }else if ([pickerView isEqual:self.PROBASEPicker]) {
            
            return @[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row];
        }else if ([pickerView isEqual:self.MASTERCONTROLPicker]) {
            
            return @[@"倍福主控",@"丹控主控",@"其它主控"][row];
        }else if ([pickerView isEqual:self.VARIABLEPITCHPicker]) {
            
            return @[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row];
        }else if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]) {
            
            return @[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row];
        }
        else{
            return nil;
        }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

        if ([pickerView isEqual:self.typePicker]){
        
            return [UDWARNINGNORMs count];
        
        }else if ([pickerView isEqual:self.UDLEVELPicker]){
        
            return 3;
        }else if ([pickerView isEqual:self.PROBASEPicker]){
            
            return 7;
        }else if ([pickerView isEqual:self.MASTERCONTROLPicker]){
            
            return 3;
        }else if ([pickerView isEqual:self.VARIABLEPITCHPicker]){
            
            return 6;
        }else if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]){
            
            return 9;
        }
        else{
            return 0;
        }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.typePicker]) {
        
        [self modifyTypeByFieldName:@"排查详细信息" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"发电机轴承" newType:@"隐藏"];
        [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"隐藏"];
        
        NSLog(@"你选择了 %@",[UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"]);
        [self.typePicker removeFromSuperview];
        [self modifyField:@"排查类型" newValue:[UDWARNINGNORMs objectAtIndex:row][@"WARNTYPE"]];
        NSString * NORMNUM = [UDWARNINGNORMs objectAtIndex:row][@"NORMNUM"];
        
        if ([NORMNUM isEqualToString:@"1"]) {
            
            [self modifyTypeByFieldName:@"主轴轴承故障" newType:@"跳转"];
            
        }else if([NORMNUM isEqualToString:@"2"]){
                
                [self modifyTypeByFieldName:@"发电机轴承" newType:@"跳转"];
                
        }else if([NORMNUM isEqualToString:@"3"]){
                
                [self modifyTypeByFieldName:@"齿轮箱高速轴轴承" newType:@"跳转"];
                
        }else{
                
            [self modifyTypeByFieldName:@"排查详细信息" newType:@"跳转"];
            
            [self queryUDWARNINGNORMLINE:NORMNUM];
        }
        [self modifyTypeByFieldName:@"TYPE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.UDLEVELPicker]) {
        
        NSLog(@"你选择了 %@",@[@"高",@"中",@"低"][row]);
        [self.UDLEVELPicker removeFromSuperview];
        [self modifyField:@"预警等级" newValue:@[@"高",@"中",@"低"][row]];
        [self modifyTypeByFieldName:@"UDLEVEL" newType:@"选择"];
    }
    if ([pickerView isEqual:self.PROBASEPicker]) {
        
        NSLog(@"你选择了 %@",@[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row]);
        [self.PROBASEPicker removeFromSuperview];
        [self modifyField:@"装配基地" newValue:@[@"哈密基地",@"吉林基地",@"内蒙基地",@"如东基地",@"天津基地",@"云南基地",@"中山基地"][row]];
        [self modifyTypeByFieldName:@"PROBASE" newType:@"选择"];
    }
    if ([pickerView isEqual:self.MASTERCONTROLPicker]) {
        
        NSLog(@"你选择了 %@",@[@"倍福主控",@"丹控主控",@"其它主控"][row]);
        [self.MASTERCONTROLPicker removeFromSuperview];
        [self modifyField:@"主控配置" newValue:@[@"倍福主控",@"丹控主控",@"其它主控"][row]];
        [self modifyTypeByFieldName:@"MASTERCONTROL" newType:@"选择"];
    }
    if ([pickerView isEqual:self.VARIABLEPITCHPicker]) {
        
        NSLog(@"你选择了 %@",@[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row]);
        [self.VARIABLEPITCHPicker removeFromSuperview];
        [self modifyField:@"变浆配置" newValue:@[@"LUST变浆",@"OAT变浆",@"SSB变浆",@"其它变浆",@"文创变浆",@"文度变浆"][row]];
        [self modifyTypeByFieldName:@"VARIABLEPITCH" newType:@"选择"];
    }
    if ([pickerView isEqual:self.FREQUENCYCONVERSIONPicker]) {
        
        NSLog(@"你选择了 %@",@[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row]);
        [self.FREQUENCYCONVERSIONPicker removeFromSuperview];
        [self modifyField:@"变频配置" newValue:@[@"ABB变频",@"IDS变频",@"艾默生变频",@"海德变频",@"禾望变频",@"景新变频",@"南瑞变频",@"其它变频",@"瑞能变频"][row]];
        [self modifyTypeByFieldName:@"FREQUENCYCONVERSION" newType:@"选择"];
    }
    
}
-(void)datePickerValueChanged:(id)sender
{
    NSDate * date;
    
    NSLog(@"日期改变");
    if ([sender isEqual:self.LIFTINGDATEDatePicker]) {
        [self.LIFTINGDATEDatePicker removeFromSuperview];
        date = self.LIFTINGDATEDatePicker.date;
        NSString *dateString = [self.dateFormtter stringFromDate:date];
        [self modifyField:@"吊装时间" newValue:dateString];
        [self modifyTypeByFieldName:@"LIFTINGDATE" newType:@"日期"];
    }
    if ([sender isEqual:self.INTERCONNECTIONDATEDatePicker]) {
        [self.INTERCONNECTIONDATEDatePicker removeFromSuperview];
        date = self.INTERCONNECTIONDATEDatePicker.date;
        NSString *dateString = [self.dateFormtter stringFromDate:date];
        [self modifyField:@"并网时间" newValue:dateString];
        [self modifyTypeByFieldName:@"INTERCONNECTIONDATE" newType:@"日期"];
    }
    if ([sender isEqual:self.SCREENINGDATEDatePicker]) {
        [self.SCREENINGDATEDatePicker removeFromSuperview];
        date = self.SCREENINGDATEDatePicker.date;
        NSString *dateString = [self.dateFormtter stringFromDate:date];
        [self modifyField:@"排查时间" newValue:dateString];
        [self modifyTypeByFieldName:@"SCREENINGDATE" newType:@"日期"];
    }
}
@end
