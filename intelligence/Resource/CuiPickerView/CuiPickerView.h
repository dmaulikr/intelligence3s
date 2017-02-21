//
//  CuiPickerView.h
//  CXB
//
//  Created by xutai on 16/4/15.
//  Copyright © 2016年 xutai. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CuiPickViewDelegate <NSObject>
-(void)didFinishPickView:(NSString*)date;
-(void)pickerviewbuttonclick:(UIButton *)sender;
-(void)hiddenPickerView;


@end


@interface CuiPickerView : UIView
@property (nonatomic, copy) NSString *province;
@property(nonatomic,strong)NSDate*curDate;
@property (nonatomic,strong)UITextField *myTextField;
@property(nonatomic,strong)id<CuiPickViewDelegate>delegate;
- (void)showInView:(UIView *)view;
- (void)hiddenPickerView;


//CuiPickViewDelegate

//_textField.delegate = self;
//
//_cuiPickerView = [[CuiPickerView alloc]init];
//_cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
//
////这一步很重要
//_cuiPickerView.myTextField = _textField;
//
//_cuiPickerView.delegate = self;
//_cuiPickerView.curDate=[NSDate date];
//[self.view addSubview:_cuiPickerView];

////赋值给textField
//-(void)didFinishPickView:(NSString *)date
//{
//    self.dataString = date;
//    _textField.text = date;
//}




@end

