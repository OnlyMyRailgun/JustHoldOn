//
//  JHOMainFrameViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "IIViewDeckController.h"
@class SinaWeibo;
@interface JHOMainFrameViewController : IIViewDeckController
{
    SinaWeibo *sinaweibo;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)applicationDidBecomeActive;
@end
