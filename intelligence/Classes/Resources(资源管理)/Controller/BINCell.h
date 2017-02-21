//
//  BINCell.h
//  intelligence
//
//  Created by chris on 2016/12/9.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BINCellDelegate <NSObject>
-(void)BINValueCheaneBIN:(NSString*)Bin;
@end

@interface BINCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISegmentedControl *content;
@property (strong,nonatomic)id<BINCellDelegate> delegate;
- (IBAction)selectValue:(id)sender;
@end
