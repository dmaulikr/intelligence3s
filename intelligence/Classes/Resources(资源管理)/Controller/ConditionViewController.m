//
//  ConditionViewController.m
//  intelligence
//
//  Created by chris on 2016/12/2.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ConditionViewController.h"
#import "ITEMNUMTableViewCell.h"
#import "ITEMDESCTableViewCell.h"
#import "LOCATIONTableViewCell.h"
#import "BINNUMTableViewCell.h"
#import "BINCell.h"
#import "DTKDropdownMenuView.h"
#import "ShareConstruction.h"
@interface ConditionViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate,BINCellDelegate>
@property(strong,nonatomic)UITableView * table;
@property(strong,nonatomic)NSMutableArray * TextFields;
@property(strong,nonatomic)NSMutableDictionary * dictonary;
@end

@implementation ConditionViewController
{
    UIPickerView*kLocationPickView;
    BOOL kLocationPickViewShow;
    UIToolbar*kToolbar;
    BOOL kToolBarShow;
    UILabel * locationLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置筛选条件";
    self.table=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.view addSubview:self.table];
    [self setupRightSaveButton];
    
    self.TextFields = [NSMutableArray array];
    self.dictonary = [NSMutableDictionary dictionary];
    
    ShareConstruction * share = [ShareConstruction sharedConstruction];
    
    if (share.stockQueryCondicitonDictionary)
    {
        self.dictonary = [NSMutableDictionary dictionaryWithDictionary:share.stockQueryCondicitonDictionary];
    }
    [self.dictonary setObject:@"无限制" forKey:@"BINNUM"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupRightSaveButton{
//    
//    WEAKSELF
//    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"清空" iconName:nil callBack:^(NSUInteger index, id info) {
//        [weakSelf clearTextFields];
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -2)] animated:YES];
//    }];
//    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"搜索" iconName:nil callBack:^(NSUInteger index, id info) {
//        [weakSelf saveCondition];
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -2)] animated:YES];
//    }];
//    
//    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 40.f, 40.f) dropdownItems:@[item0,item1] icon:@"more"];
//    
//    menuView.currentNav = self.navigationController;
//    
//    menuView.dropWidth = 130.f;
//    //    menuView.titleFont = [UIFont systemFontOfSize:18.f];
//    menuView.textColor = RGBCOLOR(0, 0, 0);
//    menuView.textFont = [UIFont systemFontOfSize:13.f];
//    menuView.cellSeparatorColor = RGBCOLOR(229, 229, 229);
//    //    menuView.textFont = [UIFont systemFontOfSize:14.f];
//    menuView.animationDuration = 0.2f;
//    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
    
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [clear setTitle:@"清空" forState:UIControlStateNormal];
    
    [clear addTarget:self action:@selector(clearTextFields) forControlEvents:UIControlEventTouchUpInside];
    
    clear.frame = CGRectMake(0, 5, 40, 30);

    UIBarButtonItem * clearItem = [[UIBarButtonItem alloc]initWithCustomView:clear];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    
    [search addTarget:self action:@selector(saveCondition) forControlEvents:UIControlEventTouchUpInside];
    
    search.frame = CGRectMake(0, 5, 40, 30);
    
    // leftItem设置
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    
    self.navigationItem.rightBarButtonItems=@[searchItem,clearItem];
}
-(void)clearTextFields
{
    if (self.TextFields) {
        
        for (id tf in self.TextFields) {
            
            if ([tf isKindOfClass:[UITextField class]]) {
                
                [tf setValue:@"" forKey:@"text"];
                
            }else if ([tf isKindOfClass:[UISegmentedControl class]]) {
                
                UISegmentedControl * sc = (UISegmentedControl*)tf;
                
                [sc setSelectedSegmentIndex:0];
                
            }else{
                [tf setValue:@"请选择仓库" forKey:@"text"];
            }
            
        }
    }
    ShareConstruction * share = [ShareConstruction sharedConstruction];
    share.stockQueryCondicitonDictionary = nil;
    self.dictonary = [NSMutableDictionary dictionary];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
/*
 ITEMNUM :
 ITEMDESC :
 LOCATIONDESC :
 LOCATION :
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareConstruction * share = [ShareConstruction sharedConstruction];
    if (indexPath.section==0)
    {
        ITEMNUMTableViewCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"ITEMNUMTableViewCell" owner:tableView options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.content.tag=101;
        if (share.stockQueryCondicitonDictionary) {
            if ([share.stockQueryCondicitonDictionary valueForKey:@"ITEMNUM"]) {
                cell.content.text = [share.stockQueryCondicitonDictionary valueForKey:@"ITEMNUM"];
            }
        }
        cell.content.delegate = self;
        [self.TextFields addObject:cell.content];
        return cell;
    }
    else if(indexPath.section==1)
    {
        ITEMDESCTableViewCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"ITEMDESCTableViewCell" owner:tableView options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.content.tag=102;
        if (share.stockQueryCondicitonDictionary) {
            if ([share.stockQueryCondicitonDictionary valueForKey:@"ITEMDESC"]) {
                cell.content.text = [share.stockQueryCondicitonDictionary valueForKey:@"ITEMDESC"];
            }
        }
        cell.content.delegate = self;
        [self.TextFields addObject:cell.content];
        return cell;
    }
    else if(indexPath.section==2)
    {
        LOCATIONTableViewCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"LOCATIONTableViewCell" owner:tableView options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.content.tag=103;
        if (share.stockQueryCondicitonDictionary) {
            if ([share.stockQueryCondicitonDictionary valueForKey:@"LOCATIONDESC"]) {
                cell.content.text = [share.stockQueryCondicitonDictionary valueForKey:@"LOCATIONDESC"];
            }
        }
        cell.content.delegate = self;
        [self.TextFields addObject:cell.content];
        return cell;

    }
    else if(indexPath.section==3)
    {
        BINNUMTableViewCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"BINNUMTableViewCell" owner:tableView options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.content.tag=104;
        //选择仓库
        if (share.stockQueryCondicitonDictionary) {
            if ([share.stockQueryCondicitonDictionary valueForKey:@"LOCATION"]) {
                cell.content.text = [share.stockQueryCondicitonDictionary valueForKey:@"LOCATION"];
            }
        }
        [cell.content setUserInteractionEnabled:YES];
        UITapGestureRecognizer *  gestureRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseLocation:)];
        [cell.content addGestureRecognizer:gestureRecognizer];
        locationLabel = cell.content;
        [self.TextFields addObject:cell.content];
        return cell;

    }
    else if(indexPath.section==4)
    {
        BINCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"BINCell" owner:tableView options:nil] firstObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //cell.content.tag=104;
        //选择BIN
        cell.delegate = self;
        [cell.content setSelectedSegmentIndex:0];
        if (share.stockQueryCondicitonDictionary) {
            
            if ([share.stockQueryCondicitonDictionary valueForKey:@"BINNUM"]) {
                
                NSString * binStirng = [share.stockQueryCondicitonDictionary valueForKey:@"BINNUM"];
                
                if (binStirng.length>0) {
                    
                    if([binStirng isEqualToString:@"返修件"])
                    {
                        [cell.content setSelectedSegmentIndex:1];
                    }
                    if([binStirng isEqualToString:@"寄存件"])
                    {
                        [cell.content setSelectedSegmentIndex:2];
                    }
                    if([binStirng isEqualToString:@"坏件"])
                    {
                        [cell.content setSelectedSegmentIndex:3];
                    }
                    if([binStirng isEqualToString:@"所有"])
                    {
                        [cell.content setSelectedSegmentIndex:4];
                    }
                }
            }
        }
        [self.TextFields addObject:cell.content];
        return cell;
        
    }
    return nil;
}
-(void)choseLocation:(UITapGestureRecognizer*)gestureRecognizer
{
    NSLog(@"选择仓库");
    CGRect rect=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-150, [UIScreen mainScreen].bounds.size.width, 150);
    
    UIPickerView*pickerView=[[UIPickerView alloc] initWithFrame:rect];
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:pickerView];
    [self showToolBarWithTitle:@""];
    kLocationPickView=pickerView;
    kLocationPickViewShow=YES;
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 10;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==4)
    {
        return 10;
    }
    return 5;
}
/*
 ITEMNUM :
 ITEMDESC :
 LOCATIONDESC :
 LOCATION :
 */
-(void)saveCondition
{
    
    [self textFieldResignFirstResponder];
    
    ShareConstruction * share = [ShareConstruction sharedConstruction];
        
    share.stockQueryCondicitonDictionary = [NSMutableDictionary dictionaryWithDictionary:self.dictonary];
    
    if ([[self.dictonary allValues] count]==0) {
        share.stockQueryCondicitonDictionary =nil;
    }
    NSLog(@"保存：：：%@",share.stockQueryCondicitonDictionary);
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -2)] animated:YES];
    
}
-(void)textFieldResignFirstResponder
{
    for (id one in self.TextFields) {
        
        if ([one isKindOfClass:[UITextField class]]) {
            
            UITextField * tf = (UITextField*)one;
            
            [tf resignFirstResponder];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length>0) {
        //物料编码
        if (textField.tag==101) {
            [self.dictonary setObject:textField.text forKey:@"ITEMNUM"];
            //物料描述
        }else if (textField.tag==102) {
            [self.dictonary setObject:textField.text forKey:@"ITEMDESC"];
            //存储仓库
        }else if (textField.tag==103) {
            [self.dictonary setObject:textField.text forKey:@"LOCATIONDESC"];
            //仓库编码
        }else if (textField.tag==104) {
            [self.dictonary setObject:textField.text forKey:@"LOCATION"];
        }
    }
    else if (textField.text.length==0)
    {
        //物料编码
        if (textField.tag==101) {
            [self.dictonary removeObjectForKey:@"ITEMNUM"];
            //物料描述
        }else if (textField.tag==102) {
            [self.dictonary removeObjectForKey:@"ITEMDESC"];
            //存储仓库
        }else if (textField.tag==103) {
            [self.dictonary removeObjectForKey:@"LOCATIONDESC"];
            //仓库编码
        }else if (textField.tag==104) {
            [self.dictonary removeObjectForKey:@"LOCATION"];
        }
    }
    
    NSLog(@"%@",self.dictonary);
    
}
-(void)BINValueCheaneBIN:(NSString*)Bin
{
    NSLog(@"BIN %@",Bin);
    
    [self.dictonary setObject:Bin forKey:@"BINNUM"];
    
    NSLog(@"%@",self.dictonary);
}
#pragma mark 选择器代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
        return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.locations count]+1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return @"不限";
    }
    else
    {
        return self.locations[row-1];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}
#pragma mark 选择器工具条
-(void)showToolBarWithTitle:(NSString*)title
{
    
    UIToolbar*toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-150-44, [UIScreen mainScreen].bounds.size.width, 44)];
    
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                   style:UIBarButtonItemStylePlain
                                   
                                                                  target:self
                                   
                                                                  action:@selector(toolBarOK)];
    
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                    
                                                                    style: UIBarButtonItemStylePlain
                                    
                                                                   target:self
                                    
                                                                   action:@selector(toolBarCAncel)];
    
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                     
                                                                                  target:nil
                                     
                                                                                  action:nil];
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
    
    [toolBar setItems:array];
    
    [self.view addSubview:toolBar];
    kToolbar=toolBar;
    kToolBarShow=YES;
}
-(void)toolBarOK
{
    NSLog(@"点击确定");
    
    //
    NSInteger  locationIndex=[kLocationPickView selectedRowInComponent:0];
    if (locationIndex==0) {
        locationLabel.text=@"不限";
         [self.dictonary removeObjectForKey:@"LOCATION"];
    }
    else
    {
        [self.dictonary setObject:[self.locations objectAtIndex:locationIndex-1] forKey:@"LOCATION"];
        locationLabel.text=[self.locations objectAtIndex:locationIndex-1];
    }
    
    if (kToolBarShow) {
        if (kToolbar) {
            [kToolbar removeFromSuperview];
            kToolbar=nil;
            kToolBarShow=NO;
        }
    }
    
    if (kLocationPickViewShow) {
        
        if (kLocationPickView) {
            
            [kLocationPickView removeFromSuperview];
            kLocationPickView=nil;
            kLocationPickViewShow=NO;
            
        }
    }
}
-(void)toolBarCAncel
{
    NSLog(@"点击取消");
    
    if (kToolBarShow) {
        
        if (kToolbar) {
            
            [kToolbar removeFromSuperview];
            kToolbar=nil;
            kToolBarShow=NO;
            
        }
    }
    if (kLocationPickViewShow) {
        
        if (kLocationPickView) {
            
            [kLocationPickView removeFromSuperview];
            kLocationPickView=nil;
            kLocationPickViewShow=NO;
            
        }
        return;
    }
}

@end
