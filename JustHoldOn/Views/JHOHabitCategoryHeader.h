//
//  JHOHabitCategoryHeader.h
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-12.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoveViewDelegate
@required
- (void)moveView:(CGFloat) distance;
- (void)openCategoryView;
- (void)closeCategoryView;
@end

@interface JHOHabitCategoryHeader : UIControl
@property (nonatomic, retain) id<MoveViewDelegate> moveDelegate;
@property (nonatomic, retain) UILabel *label;
@property BOOL isOpened;
@end
