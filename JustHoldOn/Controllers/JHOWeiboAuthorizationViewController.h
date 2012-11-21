//
//  JHOWeiboAuthorizationViewController.h
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/20/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppKey @"3488964730"
#define kAppSecret @"c9d115f1f089e7d1024c964bbd9d2e56"
#define kAppRedirectURI @"http://10.1.69.113:9000/food/application/lib/weibov2/callback.php"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@interface JHOWeiboAuthorizationViewController : UIViewController<WeiboSignInDelegate>
{
    UIWebView *webView;
    {
        WeiboSignIn *_weiboSignIn;
    }
}

@property (retain, nonatomic) IBOutlet UIWebView *webview;

@end
