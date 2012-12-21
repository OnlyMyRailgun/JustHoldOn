//
//  JHODetailHabitViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12/18/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHODetailHabitViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *detailTableView;

@property (retain, nonatomic) IBOutlet UIButton *btnShowDetailInstruction;
@property (retain, nonatomic) IBOutlet UIButton *btnShowMyProgress;
@property (retain, nonatomic) IBOutlet UIButton *btnShowFriendIn;

@property (retain, nonatomic) NSArray *dataArray;
@end
