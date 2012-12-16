//
//  JHOMyHabitsViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOBaseWebViewController.h"

@interface JHOMyHabitsViewController : JHOBaseWebViewController<UITableViewDataSource, UITableViewDelegate, NetworkTaskDelegate>

@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UITableView *myHabitsTableView;

+ (JHOMyHabitsViewController *)shared;
@end
