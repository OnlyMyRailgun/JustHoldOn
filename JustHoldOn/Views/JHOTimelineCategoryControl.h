//
//  JHOTimelineCategoryControl.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTimelineCategoryControl : UIControl

@property(nonatomic, readonly) int selectedIndex;

- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles;

@end
