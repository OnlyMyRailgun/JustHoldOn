//
//  JHOModifyUserInfoViewController.h
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/21/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOBaseWebViewController.h"

@interface JHOModifyUserInfoViewController : JHOBaseWebViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NetworkTaskDelegate>
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UIImageView *avatar;
@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain, nonatomic) IBOutlet UILabel *gender;
@end
