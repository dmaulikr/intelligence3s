//
//  TextInputViewController.h
//  MultiFunctionCell
//
//  Created by chris on 2017/5/6.
//  Copyright © 2017年 mywind. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TextInputViewControllerDelegate <NSObject>
@end
@interface TextInputViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *content;
@property(nonatomic,strong)void (^save)(NSString *content);
@property(nonatomic,strong)void (^cancel)(void);

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
