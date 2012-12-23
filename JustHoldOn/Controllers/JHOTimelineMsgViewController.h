//
//  JHOTimelineMsgViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-21.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTimelineMsgViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *timelineTableView;

@property (retain, nonatomic) NSArray *dataArray;

@end
