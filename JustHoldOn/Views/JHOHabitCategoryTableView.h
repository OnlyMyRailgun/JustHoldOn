//
//  JHOHabitCategoryTableView.h
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-12.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOHabitCategoryHeader.h"
#import "JHONetworkHelper.h"

@interface JHOHabitCategoryTableView : UIView<UITableViewDataSource, UITableViewDelegate, MoveViewDelegate>
@property (nonatomic, retain) id<NetworkTaskDelegate> delegate;
@end
