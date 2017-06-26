//
//  ViewController.m
//  intelligence
//
//  Created by chris on 2017/5/4.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import "ViewController.h"
#import "TextInputViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface ViewController ()
@property(nonatomic,strong)NSCalendar * greCalendar;
@end

@implementation ViewController
-(NSCalendar*)greCalendar
{
    if (_greCalendar==nil) {
        _greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _greCalendar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//今年
-(NSString*)thisYear
{
    NSDate * today =[NSDate date];
    NSDateComponents *dateComponents = [self.greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:today];

    NSLog(@"month(月份):%li", (long)dateComponents.month);
    NSLog(@"day(日期):%li", (long)dateComponents.day);
    return [NSString stringWithFormat:@"%li", (long)dateComponents.year];
}
//本月
//今天
//是不是数字
//非空
//
-(void)popInputTextView:(id)sender title:(NSString*)title
{
    TextInputViewController *popTextView = [[TextInputViewController alloc] initWithNibName:@"TextInputViewController" bundle:[NSBundle mainBundle]];
    [self presentPopupViewController:popTextView animationType:MJPopupViewAnimationFade];
    
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell* cell=(UITableViewCell*)sender;
        popTextView.titleLabel.text=cell.textLabel.text;
        popTextView.content.text=cell.detailTextLabel.text;
        [popTextView.content becomeFirstResponder];

    }
    else if([sender isKindOfClass:[UITextField class]]||[sender isKindOfClass:[UILabel class]]||[sender isKindOfClass:[UITextView class]])
    {
        popTextView.titleLabel.text=title;
        popTextView.content.text=[sender valueForKey:@"text"];
        [popTextView.content becomeFirstResponder];
    }
    popTextView.save=^(NSString *content)
    {
        if ([sender isKindOfClass:[UITableViewCell class]])
        {
            UITableViewCell* cell=(UITableViewCell*)sender;
            cell.detailTextLabel.text=content;
        }
        else if([sender isKindOfClass:[UITextField class]]||[sender isKindOfClass:[UILabel class]]||[sender isKindOfClass:[UITextView class]])
        {
            [sender setValue:content forKey:@"text"];
        }
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    popTextView.cancel = ^{
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
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
@end
