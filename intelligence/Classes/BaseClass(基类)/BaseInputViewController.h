//
//  BaseInputViewController.h
//  intelligence
//
//  Created by chris on 2017/4/26.
//  Copyright © 2017年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalSettingItem;
@interface BaseInputViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) __block PersonalSettingItem *item;
@end
