//
//  JHOModifyUserInfoViewController.h
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/21/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboAccount.h"

@interface JHOModifyUserInfoViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *userName;
- (id) initWithWeiboAccount:(WeiboAccount* )account;
@property (retain, nonatomic) IBOutlet UIImageView *avatar;
@end
