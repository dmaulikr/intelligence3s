//
//  YJPC_ViewController.h
//  intelligence
//
//  Created by chris on 2017/6/29.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import "MetaTableViewController.h"
#import "UDWARNINGWO.h"

@interface YJPC_ViewController : MetaTableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UDWARNINGWO * Kmodel;
@property(nonatomic,strong)UIPickerView *typePicker;
@property(nonatomic,strong)UIPickerView *UDLEVELPicker;
@property(nonatomic,strong)UIPickerView *PROBASEPicker;
@property(nonatomic,strong)UIPickerView *MASTERCONTROLPicker;
@property(nonatomic,strong)UIPickerView *VARIABLEPITCHPicker;
@property(nonatomic,strong)UIPickerView *FREQUENCYCONVERSIONPicker;
@property(nonatomic,strong)UIDatePicker *LIFTINGDATEDatePicker;
@property(nonatomic,strong)UIDatePicker *INTERCONNECTIONDATEDatePicker;
@property(nonatomic,strong)UIDatePicker *SCREENINGDATEDatePicker;
@end
