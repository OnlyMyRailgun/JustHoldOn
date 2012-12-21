//
//  JHOAppDelegate.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+CustomBackground.h"
@class ASIDownloadCache;
@class JHOMainFrameViewController;

@interface JHOAppDelegate : UIResponder <UIApplicationDelegate>
{
    JHOMainFrameViewController *viewDeck;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) ASIDownloadCache	 *downloadCache;
@property (strong, nonatomic) JHOMainFrameViewController *viewDeck;
@property (nonatomic, retain) NSString *globalDeviceToken;
@property (nonatomic, retain) NSOperationQueue* theOperationQueue;

@end
