//
//  JHOMsgFlowTableCell.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-16.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOMsgFlowTableCell : UITableViewCell
@property (nonatomic, retain) UILabel *msgPublisherLabel;
@property (nonatomic, retain) UILabel *msgPublishTime;
@property (nonatomic, retain) UIImageView *msgPublisherAvatarImageView;
@property (nonatomic, retain) UILabel *msgContent;
@end
