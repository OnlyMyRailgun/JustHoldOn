//
//  JHOLoginViewController.h
//  JustHoldOn
//
//  Created by Asce on 11/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOModifyUserInfoViewController.h"
#import "SinaWeibo.h"

@interface JHOLoginViewController : UIViewController
{
    NSDictionary *userInfo;
    SinaWeibo *sinaWeibo;
}
@property (nonatomic, strong) SinaWeibo *sinaWeibo;
@end
