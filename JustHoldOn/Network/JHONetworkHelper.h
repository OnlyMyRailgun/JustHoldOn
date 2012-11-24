//
//  JHONetworkHelper.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
typedef enum {
    NEUserSocialLogin = 0,
    NEModifyAvatar,
    NEModifyUserInfo,
    NEGetGoalLib,
    NEChooseGoal,
} NetworkRequestOperation;

@interface JHONetworkHelper : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, strong) ASIHTTPRequest *httpRequest;
@property (nonatomic, strong) ASIFormDataRequest *formDataRequest;

- (NSDictionary *)registerWithWeiboAccessToken:(NSString *)accessToken;
- (void)uploadAvatarToServer;
- (NSDictionary *)updateUserInfo;
- (NSDictionary *)getGoalLib;
@end
