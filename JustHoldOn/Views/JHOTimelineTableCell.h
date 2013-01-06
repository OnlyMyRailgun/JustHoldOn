//
//  JHOTimelineTableCell.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOCheckIn.h"

@interface JHOTimelineTableCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *commentTableView;

@property (retain, nonatomic) IBOutlet UIButton *btnLike;
@property (retain, nonatomic) IBOutlet UIButton *btnComment;

@property (retain, nonatomic) IBOutlet UIImageView *checkInSeparator;
@property (retain, nonatomic) IBOutlet UIView *verticalUIView;

@property (retain, nonatomic) IBOutlet UILabel *checkInPublisherLabel;
@property (retain, nonatomic) IBOutlet UILabel *checkInPublishTimeLabel;

@property (retain, nonatomic) NSArray *allViewsArray;

- (void)updateCellHeightToCheckIn:(JHOCheckIn *)checkIn;
@end
