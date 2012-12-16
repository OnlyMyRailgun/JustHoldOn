//
//  JHOAlternativeTargetsViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOBaseWebViewController.h"

#define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:(x)] ofType:@"png"]])

@interface JHOAlternativeTargetsViewController : JHOBaseWebViewController<NetworkTaskDelegate>

@end
