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

@protocol NetworkTaskDelegate
@required
- (void)networkJob:(JHONetworkHelper *)helper;
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result;
- (void)taskDidFailed:(NSString *)failedReason;
- (void)initializeDelegateAndSoOn;
@end

@interface JHOBaseWebViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    id<NetworkTaskDelegate> networkDelegate;
    JHONetworkHelper *networkHelper;
}
@end
