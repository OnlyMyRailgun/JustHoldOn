//
//  JHOCustomizeHabitViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-21.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOBaseWebViewController.h"
#import "JHOHabitModel.h"

@interface JHOCustomizeHabitViewController : JHOBaseWebViewController<NetworkTaskDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (retain, nonatomic) JHOHabitModel *habitModel;

@property (retain, nonatomic) IBOutlet UILabel *habitNameLabel;

- (void)updateHabitModelWithHabit:(JHOHabitModel *)model;
@end
