//
//  RunlineCell.h
//  intelligence
//
//  Created by chris on 2016/11/24.
//  Copyright © 2016年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Runliner.h"
@interface RunlineCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *one;
@property (strong, nonatomic) IBOutlet UILabel *two;
@property (strong, nonatomic) IBOutlet UILabel *three;
@property (strong, nonatomic) IBOutlet UILabel *four;
@property(strong,nonatomic)Runliner * runlineModel;
-(void)clearText;
@end
