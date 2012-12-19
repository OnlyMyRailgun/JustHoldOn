//
//  JHOTimelineTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOTimelineTableCell.h"

@implementation JHOTimelineTableCell
@synthesize btnLike;
@synthesize btnComment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]];
    [btnLike setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0, 0.0)];
    [btnLike setImageEdgeInsets:UIEdgeInsetsMake(6.0, 8.0, 2.0, 31.0)];

    [btnComment setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -17, 0, 0.0)];
    [btnComment setImageEdgeInsets:UIEdgeInsetsMake(6.0, 6.0, 4.0, 33.0)];
}

- (void)dealloc {
    [btnLike release];
    [btnComment release];
    [super dealloc];
}
@end
