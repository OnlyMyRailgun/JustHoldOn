//
//  JHOBaseWebViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-24.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "JHONetworkHelper.h"
#import "JHOAppUserInfo.h"

@interface JHOBaseWebViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    JHONetworkHelper *networkHelper;
}

- (void)showIndicator;
- (void)taskDidFailed:(NSString *)failedReason;
@end
