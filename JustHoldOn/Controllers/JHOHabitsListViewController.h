//
//  JHOHabitsListViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+UITableViewCellExt.h"
#import "JHOBaseWebViewController.h"

@interface JHOHabitsListViewController : JHOBaseWebViewController <UITableViewDelegate, UITableViewDataSource, NetworkTaskDelegate> {

    UILabel *_selectionItemLabel;
}
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;
@property (retain, nonatomic) IBOutlet UITableView *habitsListTableView;

+ (JHOHabitsListViewController *)shared;
@end
