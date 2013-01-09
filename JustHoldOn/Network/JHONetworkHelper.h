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
    NEGetUserSimpleCheckIn,//获取某用户某习惯的所有签到时间
    NEGetUserFriends,//取得某人在本应用内的好友
    NEInviteSocialFriends,//邀请微博好友加入本应用
    NEGetSocialFriends,//获取某个人所有微博好友（粉丝）
    NEDoEncourage,//鼓励
    NEDoRemind,//提醒
} NetworkRequestOperation;

@protocol NetworkTaskDelegate
@required
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result;
- (void)taskDidFailed:(NSString *)failedReason;
@end

@interface JHONetworkHelper : NSObject<ASIHTTPRequestDelegate>
@property (nonatomic, retain) id<NetworkTaskDelegate> networkDelegate;
- (void)registerWithWeiboAccessToken:(NSString *)accessToken;
- (void)registerWithWeiboAccessTokenResult:(NSDictionary *)_dic;
- (void)uploadAvatarToServer;
- (void)updateUserInfo:(NSDictionary *)_dic;
- (NSDictionary *)getGoalLib;
- (void)getUserHabits:(NSDictionary *)_dic;
- (NSMutableArray *)getUserHabitResult:(NSDictionary *)_dic;
- (void)getHabitGroup;
- (NSArray *)getHabitGroupResult:(NSDictionary *)_dic;
- (void)getHabitLib:(NSDictionary *)_dic;
- (NSMutableArray *)getHabitLibResult:(NSDictionary *)_dic;
- (void)addHabit:(NSDictionary *)_dic;
- (void)toCheckIn:(NSDictionary *)_dic;
- (void)getCheckIns:(NSDictionary *)_dic;
- (NSArray *)getCheckInsResult:(NSDictionary *)_dic;
- (void)getUserFriends:(NSDictionary *)_dic;
- (NSMutableArray *)getUserFriendsResult:(NSDictionary *)_dic;
@end
