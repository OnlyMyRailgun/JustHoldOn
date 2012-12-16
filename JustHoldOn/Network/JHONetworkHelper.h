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
    NEUserSocialLogin = 0,//社交账号登陆
    NEModifyAvatar,//修改头像
    NEModifyUserInfo,//修改用户信息
    NEGetHabitGroup,//获得习惯分类
    NEGetHabitLib,//获得习惯库
    NEGetGoalLib,//获取目标库
    NEChooseGoal,//选择目标
    NEAddHabit,//提交定制习惯
    NEGetUserHabits,//获取某个用户的所有习惯
    NEToCheckIn,//签到
    NEGetCheckIns,//获得签到流
    NEGetUserFriends,//取得某人在本应用内的好友
    NEInviteSocialFriends,//邀请微博好友加入本应用
    NEGetSocialFriends,//获取某个人所有微博好友（粉丝）
} NetworkRequestOperation;

@interface JHONetworkHelper : NSObject<ASIHTTPRequestDelegate>

- (void)registerWithWeiboAccessToken:(NSString *)accessToken;
- (void)uploadAvatarToServer;
- (void)updateUserInfo;
- (NSDictionary *)getGoalLib;
@end
