//
//  ViewController.h
//  intelligence
//
//  Created by chris on 2017/5/4.
//  Copyright © 2017年 Mywind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
-(NSString*)thisYear;
-(void)popInputTextView:(id)sender title:(NSString*)title;
-(void)popInputTextViewContent:(NSString*)content title:(NSString*)title  compeletion:(void(^)(NSString * value))compeletion;
@end
