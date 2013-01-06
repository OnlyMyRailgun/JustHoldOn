//
//  JHODetailHabitViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12/18/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOHabitModel.h"
#import "JHOBaseWebViewController.h"

@interface JHODetailHabitViewController : JHOBaseWebViewController<UITableViewDataSource, UITableViewDelegate, NetworkTaskDelegate>
@property (retain, nonatomic) IBOutlet UITableView *detailTableView;

@property (retain, nonatomic) IBOutlet UIButton *btnShowDetailInstruction;
@property (retain, nonatomic) IBOutlet UIButton *btnShowMyProgress;
@property (retain, nonatomic) IBOutlet UIButton *btnShowFriendIn;

@property (retain, nonatomic) IBOutlet UILabel *habitNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *habitTagLabel;

@property (retain, nonatomic) NSArray *dataArray;
@property (retain, nonatomic) NSMutableArray *dataSourceArray;
@property (retain, nonatomic) JHOHabitModel *habitModel;
- (void)updateHabitModelWithHabit:(JHOHabitModel *)model;
@end
