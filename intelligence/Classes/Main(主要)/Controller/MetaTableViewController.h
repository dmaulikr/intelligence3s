//
//  MetaTableViewController.h
//  intelligence
//
//  Created by chris on 2017/6/26.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFactory.h"
@interface MetaTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)NSString * key;
@property(nonatomic,strong)NSDateFormatter *dateFormtter;
@property(nonatomic,strong)NSDateFormatter *dateAndTimeFormtter;

-(void)modifyField:(NSString*) fieldName newValue:(NSString*) newValue;
-(void)modifyFieldByFieldName:(NSString*) fieldName newValue:(NSString*) newValue;
-(void)selectValue:(NSString *)fieldName;
-(void)jumpToDetial:(NSString *)name;
-(void)setDate:(NSString *)name;
-(void)modifyTypeByFieldName:(NSString*) fieldName newType:(NSString*) newType;
-(void)addPickerIncell:(UITableViewCell* )cell name:(NSString*) name;
-(void)datePickerValueChanged:(id)sender;
-(NSString*)valueByname:(NSString*)name;
-(NSMutableDictionary*)dictionaryData;
@end
