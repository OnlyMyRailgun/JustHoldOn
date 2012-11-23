//
//  JHOHabitsListViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"

@interface JHOHabitsListViewController : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate> {
    
    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;
    
    UILabel *_selectionItemLabel;
}

@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

+ (JHOHabitsListViewController *)shared;
@end
