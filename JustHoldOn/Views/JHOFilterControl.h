//
//  JHOFilterControl.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-22.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOFilterControl : UIControl
- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles;

@property(nonatomic, readonly) int selectedIndex;
@end
