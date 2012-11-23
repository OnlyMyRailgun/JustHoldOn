//
//  JHONetworkHelper.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NEUserSocialLogin = 0,
    NEModifyAvatar,
    NEModifyUserInfo,
    NEGetGoalLib,
} NetworkRequestOperation;

@interface JHONetworkHelper : NSObject
- (NSDictionary *)registerWithWeiboWithRemoteToken:(NSString *)remoteToken andAccessToken:(NSString *)accessToken;
@end
