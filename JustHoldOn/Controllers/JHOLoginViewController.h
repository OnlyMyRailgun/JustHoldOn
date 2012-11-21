//
//  JHOLoginViewController.h
//  JustHoldOn
//
//  Created by Asce on 11/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboAccounts.h"
#import "WeiboAccount.h"
#import "WeiboSignIn.h"
#import "UserQuery.h"
#import "JHOModifyUserInfoViewController.h"

@interface JHOLoginViewController : UIViewController<WeiboSignInDelegate>
{
    WeiboSignIn *_weiboSignIn;
}

@end
