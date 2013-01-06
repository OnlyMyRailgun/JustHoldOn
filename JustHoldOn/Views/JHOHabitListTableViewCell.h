//
//  JHOHabitListTableViewCell.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOHabitListTableViewCell : UITableViewCell
@property (nonatomic, retain) id callback;
@property (nonatomic, retain) NSString *habitID;

- (void)setChecked:(BOOL)checked;
@end
