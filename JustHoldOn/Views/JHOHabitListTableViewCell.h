//
//  JHOHabitListTableViewCell.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOHabitListTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (retain, nonatomic) IBOutlet UILabel *habitTitleLabel;
@property (retain, nonatomic) IBOutlet UIButton *checkInBtn;
@end
