//
//  JHOHabitListTableViewCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOHabitListTableViewCell.h"

@implementation JHOHabitListTableViewCell
@synthesize thumbImageView;
@synthesize habitTitleLabel;
@synthesize checkInBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [thumbImageView release];
    [habitTitleLabel release];
    [checkInBtn release];
    [super dealloc];
}
@end
