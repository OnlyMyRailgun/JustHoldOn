//
//  JHOModifyUserInfoViewController.h
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/21/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface JHOModifyUserInfoViewController : UIViewController<MBProgressHUDDelegate>
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UIImageView *avatar;
@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@end
