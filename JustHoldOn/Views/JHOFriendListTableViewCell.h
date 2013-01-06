//
//  JHOFriendListTableViewCell.h
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-6.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOUserModel.h"

@interface JHOFriendListTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *genderImageView;
@property (nonatomic, retain) UILabel *friendHabitsNumLabel;
@property (nonatomic, retain) UILabel *habitsNum;

- (void)updateCellWithUser:(JHOUserModel *)_model;
@end
