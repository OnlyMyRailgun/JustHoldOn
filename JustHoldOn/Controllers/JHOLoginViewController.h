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
#import "JHOBaseWebViewController.h"

@interface JHOLoginViewController : JHOBaseWebViewController<UIScrollViewDelegate, NetworkTaskDelegate>
{
    NSDictionary *userInfo;
}
@property (nonatomic, strong) SinaWeibo *sinaWeibo;
@property (retain, nonatomic) IBOutlet UIScrollView *galleryScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *galleryPageControl;
@end
