//
//  MetaTableViewController.m
//  intelligence
//
//  Created by chris on 2017/6/26.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "MetaTableViewController.h"
#import "DataFactory.h"
#import "TextInputViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface MetaTableViewController ()

@end

@implementation MetaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataFactory * df = [[DataFactory alloc] init];
    
    if (self.array.count==0) {
        
        if (self.key) {
            
            self.array = [df readDataWithName:self.key];
        }else{
            self.array = [df readDataWithName:@"预警排查工单"];
        }
    }

    
    [self setTitle:self.key];
    [self.tableView reloadData];
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.dateFormtter = [[NSDateFormatter alloc] init];
    self.dateAndTimeFormtter = [[NSDateFormatter alloc] init];
    [self.dateFormtter setDateFormat:@"yyyy-MM-dd"];
    [self.dateAndTimeFormtter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.array count]-1;
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
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.title];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSMutableDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    NSString * type = [dictionary valueForKey:@"类型"];
    NSString * name = [dictionary valueForKey:@"名称"];
    NSString * value = [dictionary valueForKey:@"值"];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = value;
    cell.detailTextLabel.textColor= [UIColor blackColor];
    cell.detailTextLabel.numberOfLines=2;
    cell.detailTextLabel.adjustsFontSizeToFitWidth=YES;
    cell.textLabel.numberOfLines=3;
    cell.textLabel.adjustsFontSizeToFitWidth=YES;
    
    if ([type isEqualToString:@"标题"]) {
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setHidden:YES];
    }
    if ([type isEqualToString:@"文本"]) {
        
    }
    if ([type isEqualToString:@"选择"]) {
        
    }
    if ([type isEqualToString:@"是否"]) {
        
        if ([value isEqualToString:@"Y"]) {
            
            cell.detailTextLabel.text = @"是";
            
        }else{
            
            cell.detailTextLabel.text = @"否";
        }
    }
    if ([type isEqualToString:@"日期"]) {
        cell.detailTextLabel.text=[cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@" 00:00:00" withString:@""];
    }
    if ([type isEqualToString:@"固定"]) {
        
    }
    if ([type isEqualToString:@"日期时间"]) {
        
    }
    if ([type isEqualToString:@"跳转"]) {
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    if ([type isEqualToString:@"picker"]) {
        [self addPickerIncell:cell name:name];
    }
    if ([type isEqualToString:@"隐藏"]) {
        [cell setHidden:YES];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictionary = [self.array objectAtIndex:indexPath.row];
    NSString * type = [dictionary valueForKey:@"类型"];
    NSString * name = [dictionary valueForKey:@"名称"];
    NSString * field = [dictionary valueForKey:@"字段名"];
    NSString * value = [dictionary valueForKey:@"值"];
    NSLog(@"%@",type);
    if ([type isEqualToString:@"文本"]) {
        [self popInputTextViewContent:value title:name compeletion:^(NSString *value) {
            [self modifyField:name newValue:value];
        }];
    }
    if ([type isEqualToString:@"选择"]) {
        [self selectValue:field];
    }
    if ([type isEqualToString:@"是否"]) {
        
        if ([value isEqualToString:@"Y"]) {
            
            [self modifyField:name newValue:@"N"];
            
        }else{
            
            [self modifyField:name newValue:@"Y"];
        }
        [self.tableView reloadData];
    }
    if ([type isEqualToString:@"日期"]) {
        [self setDate:field];
    }
    if ([type isEqualToString:@"固定"]) {
        
    }
    if ([type isEqualToString:@"日期时间"]) {
       [self setDate:field];
    }
    if ([type isEqualToString:@"跳转"]) {
        [self jumpToDetial:name];
    }

}
-(void)modifyField:(NSString*) fieldName newValue:(NSString*) newValue
{
    newValue?newValue:(newValue=@"");
    
    for (NSMutableDictionary * dic in self.array) {
        NSString * name = dic[@"名称"];
        if([name isEqualToString:fieldName])
        {
        [dic setValue:newValue forKey:@"值"];
        }
    }
         [self.tableView reloadData];
}
-(void)modifyFieldByFieldName:(NSString*) fieldName newValue:(NSString*) newValue
{
    newValue?newValue:(newValue=@"");
    
    for (NSMutableDictionary * dic in self.array) {
        NSString * name = dic[@"字段名"];
        if ([name isEqualToString:fieldName])
        {
        [dic setValue:newValue forKey:@"值"];
        }
    }
        [self.tableView reloadData];
}
-(void)modifyTypeByFieldName:(NSString*) fieldName newType:(NSString*) newType
{
    newType?newType:(newType=@"固定");
    
    for (NSMutableDictionary * dic in self.array) {
        NSString * name = dic[@"字段名"];
        if ([name isEqualToString:fieldName])
        {
            [dic setValue:newType forKey:@"类型"];
        }
    }
   [self.tableView reloadData];
}
-(NSString*)valueByname:(NSString*)name
{
    NSString *value =@"";
    for (NSMutableDictionary * dic in self.array) {
        NSString * name1 = dic[@"名称"];
        if ([name1 isEqualToString:name])
        {
            value=dic[@"值"];
        }
    }
    return value;
}
//选择值
-(void)selectValue:(NSString *)fieldName
{
    
}
//跳转到子表
-(void)jumpToDetial:(NSString *)name
{
    
}
//设置日期
-(void)setDate:(NSString *)name
{
    
}
//行中添加选择器
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name
{
    
}
-(NSDictionary*)dictionaryData
{
    return nil;
}
-(void)popInputTextViewContent:(NSString*)content title:(NSString*)title  compeletion:(void(^)(NSString * value))compeletion
{
    TextInputViewController *popTextView = [[TextInputViewController alloc] initWithNibName:@"TextInputViewController" bundle:[NSBundle mainBundle]];
    [self presentPopupViewController:popTextView animationType:MJPopupViewAnimationFade];
    
    popTextView.titleLabel.text=title;
    popTextView.content.text=content;
    [popTextView.content becomeFirstResponder];
    
    popTextView.save=^(NSString *content)
    {
        compeletion(content);
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    popTextView.cancel = ^{
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
}
-(void)datePickerValueChanged:(id)sender
{
    
}
@end
