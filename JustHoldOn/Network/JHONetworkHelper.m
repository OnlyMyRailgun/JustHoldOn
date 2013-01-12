//
//  JHONetworkHelper.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHONetworkHelper.h"
#import "JSONKit.h"
#import "JHOAppUserInfo.h"
#import "JHOAppDelegate.h"
#import "JHOTinyTools.h"
#import "JHOHabitModel.h"
#import "JHOGoalModel.h"
#import "JHOCheckIn.h"
#import "JHOBaseWebViewController.h"
#import "JHOCommentModel.h"
#import "JHOEncourageModel.h"
#import "JHOUserModel.h"

@implementation JHONetworkHelper
{
    NSURL *url;
}

#define BASESERVERURL @"http://192.168.0.113:8080/JustHoldOnServer-1.0.0/"

- (NSURL *)getCompleteURL:(NetworkRequestOperation)goal
{
    NSMutableString *str = [NSMutableString stringWithString:BASESERVERURL];
    switch (goal) {
        case NEUserSocialLogin:
            [str appendString:@"userSocialLogin"];
            break;
        case NEModifyAvatar:
            [str appendString:@"modifyAvatar"];
            break;
        case NEModifyUserInfo:
            [str appendString:@"modifyUserInfo"];
            break;
        case NEGetHabitGroup:
            [str appendString:@"getHabitGroup"];
            break;
        case NEGetHabitLib:
            [str appendString:@"getHabitlib"];
            break;
        case NEGetGoalLib:
            [str appendString:@"getGoalLib"];
            break;
        case NEChooseGoal:
            [str appendString:@"chooseGoal"];
            break;
        case NEAddHabit:
            [str appendString:@"addHabit"];
            break;
        case NEGetUserHabits:
            [str appendString:@"getUserHabits"];
            break;
        case NEToCheckIn:
            [str appendString:@"toCheckIn"];
            break;
        case NEGetCheckIns:
            [str appendString:@"getCheckIns"];
            break;
        case NEGetUserSimpleCheckIn:
            [str appendString:@"getUserSimpleCheckIn"];
            break;
        case NEGetUserFriends:
            [str appendString:@"getUserFriends"];
            break;
        case NEInviteSocialFriends:
            [str appendString:@"inviteSocialFriends"];
            break;
        case NEGetSocialFriends:
            [str appendString:@"getSocialFriends"];
            break;
        case NEDoEncourage:
            [str appendString:@"doEncourage"];
            break;
        default:
            break;
    }
    return [NSURL URLWithString:str];
}

#pragma mark - 【已测】社交帐号登录
/*4.2	社交帐号登录[done]
 method：userSocialLogin
 调用参数
 参数	描 述	格 式
 type	登录类型	“1” 新浪微博
 deviceid	设备id	字符串
 key	鉴权密钥	字符串
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”表示成功，其他为失败原因代码
 msg	消息	“成功”或者失败原因
 content	返回内容	JSONObject
 content.alreadyregist		“0” 新用户  “1”老用户
 content.uid	用户id	字符串
 content.username	用户名
 content.password	密码	字符串
 content.avatarurl	头像地址	字符串
 content.sex	性别	“f”,”m”
 content.description	描述	字符串
 */

- (void)registerWithWeiboAccessToken:(NSString *)accessToken
{
    JHOAppDelegate *appDelegate = (JHOAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *remoteToken = appDelegate.globalDeviceToken;
    ASIFormDataRequest *_formDataRequest= [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEUserSocialLogin]];
    [_formDataRequest setPostValue:@"1" forKey:@"type"];
    [_formDataRequest setPostValue:remoteToken forKey:@"deviceid"];
    [_formDataRequest setPostValue:accessToken forKey:@"key"];

    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEUserSocialLogin;
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (void)registerWithWeiboAccessTokenResult:(NSDictionary *)_dic
{
    [[JHOAppUserInfo shared] modifyUserInfo:_dic];
    [[JHOAppUserInfo shared] saveToNSDefault];
}

#pragma mark - 【已测】修改头像
/*
 * 1.4	修改头像（http Mutipart类型，按陈cc那边的来）
 Method：modifyAvatar
 
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 file	图片具体信息
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 */
- (void)uploadAvatarToServer
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyAvatar]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setFile:[JHOTinyTools getFilePathInDocument:@"userAvatar.png"]  forKey:@"file"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEModifyAvatar;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (void)uploadAvatarToServerResult
{
    //显示头像修改成功
}

#pragma mark - 【已测】修改用户信息
/*
 *1.4	修改用户信息
 *method: modifyUserInfo
 *调用参数
 *uid	用户唯一ID   必选	字符串
 *password	密码   必选	字符串
 *username	用户名
 *description	描述
 *返回项说明：
 *返回项	描 述	格 式
 *status	是否成功	0表示成功，其他为失败原因代码
 *msg	消息	“成功”，或失败原因
 *说明：调用参数部分uid 和password 是必选项，用于完成鉴权；
 *其余参数用于表示要修改的内容。
 */
- (void)updateUserInfo:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyUserInfo]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"uid"] forKey:@"uid"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"password"] forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"username"] forKey:@"username"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"description"] forKey:@"description"];
//    [_formDataRequest setPostValue:_dic forKey:@"sex"];

    _formDataRequest.tag = NEModifyUserInfo;
    _formDataRequest.delegate = self;
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (void)updateUserInfoResult
{
    //修改成功
}

#pragma mark - 【已测】获得习惯分类
/*4.2	获得习惯分类[done]
 Method：getHabitGroup
 调用参数：无
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”成功
 msg	消息	“成功”，或失败原因
 content	返回内容	JSONObject
 content.list		数组
 content.name	分类名
 content.habitnum	该分类习惯个数
 */
- (void)getHabitGroup
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetHabitGroup]];
    _formDataRequest.delegate = self;
    _formDataRequest.tag = NEGetHabitGroup;
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSArray *)getHabitGroupResult:(NSDictionary *)_dic
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    for(int i  = 0; i <  arrayFromDic.count; i++)
    {
        [resultArray addObject:[[arrayFromDic objectAtIndex:i] objectForKey:@"name"]];
    }
    return resultArray;
}

#pragma mark - 【已测】获得习惯库
/*4.3	获得习惯库[done]【习惯库】
 Method：getHabitlib
 
 调用参数
 参数	描 述	格 式
 maxnum	获取习惯最大数量	默认20
 typevalue	获取类型值	若按分类来，此处为分类名
 startpos	查找起始位	第一次请求，起始位为”0”
 
 sorttype	排序方式	“0”不排序
 “1”按参加人数
 …可扩展
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”成功
 msg	消息	“成功”，或失败原因
 content	返回内容	JSONObject
 content.resultnum	返回结果数	数字
 content.nextstartpos		下次请求起始位，数字
 content.list	习惯数组	数组
 content.id	习惯id	int
 content.name	习惯名称
 content.tag	习惯标签	逗号分割
 content.groupname	习惯分组名	字符串
 减肥等等（用这个字段来确定显示的图标，图标一期就放本地了）
 content.joinnum	全部参加人数
 content.friendjoinnum	好友参加人数
 content.isjoined	用户是否已加入	如果用户已经加入，则直接不显示，记住！
 content.description	描述
 */
- (void)getHabitLib:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetHabitLib]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"maxnum"] forKey:@"maxnum"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"typevalue"] forKey:@"typevalue"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"startpos"] forKey:@"startpos"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"sorttype"] forKey:@"sorttype"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];

    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetHabitLib;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)getHabitLibResult:(NSDictionary *)_dic
{
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *habit in arrayFromDic)
    {
        if(![[habit objectForKey:@"isjoined"] intValue])
        {
            JHOHabitModel *habitModel = [[JHOHabitModel alloc] init];
            habitModel.habitID = [habit objectForKey:@"id"];
            habitModel.habitName = [habit objectForKey:@"name"];
            habitModel.habitTag = [habit objectForKey:@"tag"];
            habitModel.groupName = [habit objectForKey:@"groupname"];
            habitModel.joinNum = [[habit objectForKey:@"joinnum"] intValue];
            habitModel.friendJoinNum = [[habit objectForKey:@"friendjionnum"] intValue];
            habitModel.habitDescription = [habit objectForKey:@"description"];
            [array addObject:habitModel];
            [habitModel release];
        }
    }
    return array;
}

#pragma mark - 获得目标库
/*5.4 获得目标库[done]
 Method：getGoalLib
 
 调用参数
 参数	描 述	格 式
 maxnum	获取目标最大数量	默认20
 gettype	获取类型	“1”按分类  “2”全部
 typevalue	获取类型值	字符串  全部此处为空  若按分类来，此处为分类名（”f”-女,”m”-男 “ALL”两者均可）这个后来再商定吧
 startpos	查找起始位	第一次请求，起始位为”0”
 sorttype	排序方式	“0”不排序  “1”按参加人数  …可扩展
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”成功
 msg	消息	字符串
 content	返回内容	JSONObject
 content.resultnum	返回结果数	数字
 content.nextstartpos		下次请求起始位，数字
 content.list	目标数组	数组
 content.id		字符串
 content.content		目标内容
 content.type		目标类型
 */
- (NSDictionary *)getGoalLib
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetGoalLib]];
    [_formDataRequest setPostValue:@"50" forKey:@"maxum"];
    [_formDataRequest setPostValue:@"1" forKey:@"gettype"];
    [_formDataRequest setPostValue:@"all" forKey:@"typevalue"];
    [_formDataRequest setPostValue:@"0" forKey:@"startpos"];
    [_formDataRequest setPostValue:@"1" forKey:@"sorttype"];

    [_formDataRequest startSynchronous];
    NSError *error = [_formDataRequest error];
    NSDictionary *parsedDic = nil;
    if (!error) {
        NSString *response = [_formDataRequest responseString];
        parsedDic = [response objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    }
    else
        NSLog(@"%@", error);
    //#warning Incomplete error handler.
    return parsedDic;
}

- (NSMutableArray *)getGoalLibResult:(NSDictionary *)_dic
{
    int num = [[_dic objectForKey:@"resultnum"] intValue];
    [_dic objectForKey:@"nextstartpos"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:num];
    for(int i = 0; i < num; i++)
    {
        NSDictionary *goals = [[_dic objectForKey:@"list"] objectAtIndex:i];
        JHOGoalModel *goalModel = [[JHOGoalModel alloc] init];
        goalModel.goalID = [goals objectForKey:@"id"];
        goalModel.goalContent = [goals objectForKey:@"content"];
        goalModel.goalType = [goals objectForKey:@"type"];
        [array addObject:goalModel];
        [goalModel release];
    }
    return array;
}

#pragma mark - 选择目标
/*5.6	cc选择目标[done]
 Method：chooseGoal
 
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 goalid	目标id	逗号分割
 habitmaxnum	返回推荐的习惯数目	字符串 默认20
 startpos	获取推荐习惯起始位	第一次请求，起始位为”0”
 之后的请求，为上一次请求的最后一个位置
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	成功”0”
 msg	消息	“成功”，或失败原因
 content	返回内容	JSONObject
 content.resultnum	返回结果数	数字
 content.nextstartpos		下次请求起始位，数字
 content.list	习惯数组	数组
 content.id	习惯id	字符串
 content.name	习惯名称
 content.creater	习惯创建者
 content.tag	习惯标签
 content.type	类型类别	数字 0-系统 1 自定义
 content.stages	阶段	字符串以逗号分割
 “11,22,33”三个阶段 一阶段11天
 二阶段22天 ；三阶段33天
 content.groupname	习惯分组名	字符串
 减肥等等
 content.joinnum	全部参加人数	数字
 content.friendjoinnum	好友参加人数	数字
 content.description	描述
 */
- (void)chooseGoal:(NSString *)goalStr
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetGoalLib]];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    [_formDataRequest setPostValue:goalStr forKey:@"goalid"];
    [_formDataRequest setPostValue:@"20" forKey:@"habimaxnum"];
    [_formDataRequest setPostValue:@"0" forKey:@"startpos"];
    
    [_formDataRequest setTag:NEChooseGoal];
    [_formDataRequest setDelegate:self];
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)chooseGoalResult:(NSDictionary *)_dic
{
    int num = [[_dic objectForKey:@"resultnum"] intValue];
    [_dic objectForKey:@"nextstartpos"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:num];
    for(int i = 0; i < num; i++)
    {
        NSDictionary *habit = [[_dic objectForKey:@"list"] objectAtIndex:i];
        JHOHabitModel *habitModel = [[JHOHabitModel alloc] init];
        habitModel.habitID = [habit objectForKey:@"id"];
        habitModel.habitName = [habit objectForKey:@"name"];
        habitModel.habitTag = [habit objectForKey:@"tag"];
        habitModel.mystages = [[habit objectForKey:@"user_stage"] intValue];
        habitModel.groupName = [habit objectForKey:@"groupname"];
        habitModel.joinNum = [[habit objectForKey:@"joinnum"] intValue];
        habitModel.friendJoinNum = [[habit objectForKey:@"friendjionnum"] intValue];
        habitModel.habitDescription = [habit objectForKey:@"description"];
        habitModel.userDescription = [habit objectForKey:@"use_description"];
        habitModel.unitcheckinnum = [[habit objectForKey:@"unitcheckinnum"] intValue];
        habitModel.habitFrequency = [[habit objectForKey:@"fre"] intValue];
        [array addObject:habitModel];
        [habitModel release];
    }
    return array;
}

#pragma mark - 【已测】定制习惯
/*
 6.3	定制习惯的[done]
 Method：addHabit
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 habitid	习惯id
 persistunit	坚持的时间单位	day = 0, week = 1, month = 2 ..
 fre	单位内希望完成的次数	int（1~7）
 persistperiod	希望坚持时间总长	Int
 privacy	权限	int  0 所有人 1仅好友  2仅自己
 goal	希望的目标	字符串
 
 服务器要记得记录加入的时间
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”表示成功，其他为失败原因代码
 msg	消息	失败时返回失败原因
*/
- (void)addHabit:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"fre"] forKey:@"fre"];
    ;
    [_formDataRequest setPostValue:[NSNumber numberWithInt:PUWEEK] forKey:@"persistunit"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"privacy"] forKey:@"privacy"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"goal"] forKey:@"goal"];
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEAddHabit;

    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (void)addHabitResult
{
    //添加成功
}

#pragma mark - 【已测】获取某个用户的所有习惯
/*3.4	获取某个用户的所有习惯
Method：getUserHabits
调用参数
参数	描 述	格 式
uid
password
who	获取谁的所有习惯
maxnum	获取习惯最大数量	默认20
gettype	获取类型	“1”仅当前正在进行的 “2”仅过去的 0 为全部

返回项说明：
返回项	描 述	格 式
status	是否成功	“0”成功
msg	消息	“成功”，或失败原因
content	返回内容	JSONObject
content.list	习惯数组	数组
content.id	习惯id	字符串
content.name	习惯名称
content.tag	习惯标签	逗号分割
content.type	类型类别	数字 0-系统 1 自定义
content.stages	阶段	字符串以逗号分割 “11,22,33”三个阶段 一阶段11天 二阶段22天 ；三阶段33天
content.groupname	习惯分组名	字符串 减肥等等
content.joinnum	全部参加人数
content.friendjoinnum	好友参加人数
content.description	描述
Content.starttime	我加入这个习惯的时间
Content.mystages	我处在这个习惯的什么阶段
Content.mycheckinnum	我已经签到过的次数
*/
- (void)getUserHabits:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetUserHabits]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"who"] forKey:@"who"];
    ;

    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetUserHabits;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)getUserHabitResult:(NSDictionary *)_dic
{
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *subArray0 = [NSMutableArray array];
    NSMutableArray *subArray1 = [NSMutableArray array];
    NSMutableArray *subArray2 = [NSMutableArray array];
    for(NSDictionary *habit in arrayFromDic)
    {
        JHOHabitModel *habitModel = [[JHOHabitModel alloc] init];
        habitModel.habitID = [habit objectForKey:@"id"];
        habitModel.habitName = [habit objectForKey:@"name"];
        habitModel.habitTag = [habit objectForKey:@"tag"];
        habitModel.mystages = [[habit objectForKey:@"user_stage"] intValue];
        habitModel.groupName = [habit objectForKey:@"groupname"];
        habitModel.joinNum = [[habit objectForKey:@"joinnum"] intValue];
        habitModel.friendJoinNum = [[habit objectForKey:@"friendjionnum"] intValue];
        habitModel.habitDescription = [habit objectForKey:@"description"];
        habitModel.userDescription = [habit objectForKey:@"use_description"];
        habitModel.unitcheckinnum = [[habit objectForKey:@"unitcheckinnum"] intValue];
        habitModel.habitFrequency = [[habit objectForKey:@"fre"] intValue];
        habitModel.hasCheckedInToday = [[habit objectForKey:@"hascheckedtoday"] boolValue];
        switch(habitModel.mystages)
        {
            case 1:
                [subArray0 addObject:habitModel];
                break;
            case 2:
                [subArray1 addObject:habitModel];
                break;
            case 3:
                [subArray2 addObject:habitModel];
                break;
            default:
                break;
        }
        [habitModel release];
    }
    [array addObject:subArray0];
    [array addObject:subArray1];
    [array addObject:subArray2];
    
    return array;
}

#pragma mark - 【已测】签到
/*
 7.1	签到
 Method：toCheckIn
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 time	签到时间
 habitid	习惯id
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content	返回内容	JSONObject
 content.checkinid	签到id	字符串
*/
- (void)toCheckIn:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEToCheckIn]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    ;
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEToCheckIn;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (void)toCheckInResult:(NSDictionary *)_dic
{
    NSLog(@"checkinid %@", [_dic objectForKey:@"checkinid"]);
}

#pragma mark - 【已测】获取签到流
/*
 6.4	获取签到流
 Method：getCheckIns
 
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 type	获取类型	1.某个习惯的(全部，权限的概念在)
                2.某个人（who）的某个习惯的
                3.当前uid的所有好友的流
                4.某人(who)的流
                5.当前uid的某个习惯的所有好友的流
                6.所有人的所有流
 who	关注用户的标识符	字符串，可以等于Uid
 type  2 3 4  时有用
 habitid	习惯标示	 type  1  2
 
 num	单页数量	数目 默认20
 startpos	签到流的起始位置	updateway=’more’传最后一次请求的最后一个事件id(第一次值为0)
 updateway=’refresh’传第一次请求的第一个id
 updateway	更新方式	‘more’ 或 ‘refresh’
 
 
 返回项说明：
 
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content	返回内容	 JSONArray
 content.resultnum	Null	应用不关心
 content.nextpos	Null	应用不关心
 content.list
 list.type
 事件类型	1签到
 2.加入该习惯
 3.养成该习惯
 （当为2.3时只有用户id、姓名、头像及content.dateline有用）
 list.usename	事件发布者用户名
 list.useravatar
 事件发布者头像地址	url
 list.dateline	事件发布时间	long
 list.eventid	事件id	字符串
 list.location	位置	字符串，事件类型不为1签到时，返回空
 list.latitude	经度	字符串，事件类型不为1签到时，返回空
 list .longitude	纬度	字符串，事件类型不为1签到时，返回空
 list.description	签到Item的文字描述	字符串
 list.picurl	签到Item对应的图片地址	url，事件类型不为1签到时，返回空
 list.commentnum	签到Item对应的评论数	int，事件类型不为1签到时，返回空
 list.comment
 
 （此处可只返回最新两个评论，可再讨论）	comment.commentid	评论id
 comment.uid	评论者id
 comment.username	评论者的名字
 comment. avatar	评论者头像
 comment.touser	评论者回复的人（一期？）cc:要加上，为用户姓名
 comment.content	评论内容
 comment.time	评论时间
 list.encouragenum	签到Item的鼓励数	int, ，事件类型不为1签到时，返回空
 list.encourage	encourage. encourage id	鼓励id
 encourage.uid	鼓励者id
 encourage.username	鼓励者的名字
 encourage. time	鼓励时间
 encourage. avatar	雪晴记得加头像！！！
 list.habitid	签到属于的习惯id
 list.habitname	签到对应的习惯的名称
 list.isencourage	当前用户是否鼓励过	0否 1 是。，事件类型不为1签到时，返回空
*/
- (void)getCheckIns:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetCheckIns]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"type"] forKey:@"type"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"num"] forKey:@"num"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"startpos"] forKey:@"startpos"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"updateway"] forKey:@"updateway"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetCheckIns;

    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSArray *)getCheckInsResult:(NSDictionary *)_dic
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    for(NSDictionary *oneCheckIn in arrayFromDic)
    {
        JHOCheckIn *aCheckIn = [[JHOCheckIn alloc] init];
        aCheckIn.msgType = [oneCheckIn objectForKey:@"type"];
        aCheckIn.ownerUid = [oneCheckIn objectForKey:@"uid"];
        aCheckIn.ownerName = [oneCheckIn objectForKey:@"usename"];
        aCheckIn.ownerPic = [oneCheckIn objectForKey:@"useravatar"];
        aCheckIn.checkInId = [oneCheckIn objectForKey:@"eventid"];
        aCheckIn.location = [oneCheckIn objectForKey:@"location"];
        aCheckIn.latitude = [oneCheckIn objectForKey:@"latitude"];
        aCheckIn.longitude = [oneCheckIn objectForKey:@"longitude"];
        aCheckIn.checkInDescription = [oneCheckIn objectForKey:@"description"];
        aCheckIn.picURL = [oneCheckIn objectForKey:@"useravatar"];
        aCheckIn.dateLine = [oneCheckIn objectForKey:@"dateline"];
        aCheckIn.habitID = [oneCheckIn objectForKey:@"habitid"];
        aCheckIn.habitName = [oneCheckIn objectForKey:@"habitname"];
        aCheckIn.hasEncouraged = [oneCheckIn objectForKey:@"isencourage"];
        aCheckIn.commentNum = [[oneCheckIn objectForKey:@"commentnum"] intValue];
        if(aCheckIn.commentNum > 0)
        {
            NSArray *preComment = [oneCheckIn objectForKey:@"comment"];
            if(aCheckIn.preComments == nil)
                aCheckIn.preComments = [NSMutableArray array];
            for(NSDictionary *oneComment in preComment)
            {
                JHOCommentModel *aComment = [[JHOCommentModel alloc] init];
                [aCheckIn.preComments addObject:aComment];
                [aComment release];
            }
        }
        aCheckIn.encourageNum = [[oneCheckIn objectForKey:@"list.encouragenum"] intValue];
        if(aCheckIn.encourageNum > 0)
        {
            NSArray *preEncourage = [oneCheckIn objectForKey:@"encourage"];
            if(aCheckIn.preEncourages == nil)
                aCheckIn.preEncourages = [NSMutableArray array];
            for(NSDictionary *oneEncourage in preEncourage)
            {
                JHOEncourageModel *aEncourage = [[JHOEncourageModel alloc] init];
                aEncourage.userID = [oneEncourage objectForKey:@"uid"];
                aEncourage.userAvatar = [oneEncourage objectForKey:@"avatar"];
                aEncourage.userName = [oneEncourage objectForKey:@"username"];
                aEncourage.eventTime = [oneEncourage objectForKey:@"time"];
                [aCheckIn.preEncourages addObject:aEncourage];
                [aEncourage release];
            }

        }
        [resultArray addObject:aCheckIn];
        [aCheckIn release];
    }
    
    return resultArray;
}

#pragma mark - 获取某用户某习惯的所有签到时间
/*
 6.9	【新增】获取某用户某习惯的所有签到时间
Method：getUserSimpleCheckIn
调用参数
参数	描 述	格 式
uid
password
who
habitid	系统习惯id

返回项说明：
返回项	描 述	格 式
status	是否成功	“0”成功
msg	消息	“成功”，或失败原因
content	返回内容	JSONObject
content.list
list.checkintime	签到时间
 */
- (void)getUserSimpleCheckIn:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"who"] forKey:@"type"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetUserSimpleCheckIn;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSArray *)getUserSimpleCheckInResult:(NSDictionary *)_dic
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    for(NSDictionary *oneDic in arrayFromDic)
    {
        [resultArray addObject:[oneDic objectForKey:@"checkintime"]];
    }
    return resultArray;
}

#pragma mark - 取得某人在本应用内的好友
/*
 取得某人在本应用内的好友：[done] 【定制习惯后推荐给好友用】
 Method：getUserFriends
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 who	取好友列表用户id
 maxnum	每次取得数目	默认20
 startpos	搜索起始位	第一次请求，起始位为“0“  之后的请求，为上一次请求的最后一个位置
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content
 content.resultnum		数字，结果总数
 content.nextstartpos		下次请求起始位，数字
 content.list
 content.uid	粉丝的id	字符串
 content. username	粉丝的用户名	字符串
 content. avatarurl	粉丝的头像	url
 content.isfriend	是否互为好友	int  I 是  0 不是 为了和应用内所有用户内容一致而加上得，终端可以不解析该字段
 content.description	个人介绍
 content.sex	性别	f  m
 content.friendnum	好友个数	int
 content.habitnum	习惯个数	int
 content.goalnum	目标个数	int
 */
- (void)getUserFriends:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetUserFriends]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"maxnum"] forKey:@"maxnum"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"who"] forKey:@"who"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"startpos"] forKey:@"startpos"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetUserFriends;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)getUserFriendsResult:(NSDictionary *)_dic
{
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *aUser in arrayFromDic)
    {
        JHOUserModel *userModel = [[JHOUserModel alloc] init];
        userModel.uid = [aUser objectForKey:@"uid"];
        userModel.userName = [aUser objectForKey:@"username"];
        userModel.avatarURL = [aUser objectForKey:@"avatarurl"];
        userModel.userGender = [aUser objectForKey:@"sex"];
        userModel.userDescription = [aUser objectForKey:@"description"];
        userModel.avatarURL = [aUser objectForKey:@"groupname"];
        userModel.friendNum = [[aUser objectForKey:@"friendnum"] intValue];
        userModel.habitNum = [[aUser objectForKey:@"habitnum"] intValue];
        userModel.goalNum = [[aUser objectForKey:@"goalnum"] intValue];
        [array addObject:userModel];
        [userModel release];
    }
    return array;
}

#pragma mark - 获取用户的所有微博好友
/*7.4 获取用户的所有微博好友（粉丝）[done]待修改，加type选择 关注，粉丝好友【定制习惯后推荐给微博关注】
 method：getSocialFriends（接口已实现）
 调用参数
 参数	描 述	格 式
 uid	用户id	字符串
 password	密码	字符串
 count	每次取得数目	默认20
 cursor	请求的起始位置
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content.resultnum		数字，结果总数
 content.nextstartpos		下次请求起始位，数字
 content.list
 content.uid	社交账号id	字符串
 content.username	社交账号用户名	字符串
 content.avatarurl	社交网络的头像	备注：这个图像url不是本地，而是社交网络上的（小头像就够了）
 content.isfriend	是否是我的应用内好友
 content.isinapp	是否已经加入该应用
 */
- (void)getSocialFriends:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetSocialFriends]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"count"] forKey:@"count"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"cursor"] forKey:@"cursor"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetSocialFriends;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSDictionary *)getSocialFriendsResult:(NSDictionary *)_dic
{
    NSArray *arrayFromDic = [_dic objectForKey:@"list"];
    NSMutableArray *inAppArray = [NSMutableArray array];
    NSMutableArray *notInAppArray = [NSMutableArray array];
    for(NSDictionary *aUser in arrayFromDic)
    {
        if(![[aUser objectForKey:@"isfriend"] boolValue])
        {
            JHOUserModel *userModel = [[JHOUserModel alloc] init];
            userModel.uid = [aUser objectForKey:@"uid"];
            userModel.userName = [aUser objectForKey:@"username"];
            userModel.avatarURL = [aUser objectForKey:@"avatarurl"];
            if([[aUser objectForKey:@"isinapp"] boolValue])
                [inAppArray addObject:userModel];
            else
                [notInAppArray addObject:userModel];
            [userModel release];
        }
    }
    return [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:inAppArray, notInAppArray, nil] forKeys:[NSArray arrayWithObjects: @"inAppArray", @"notInAppArray", nil]];
}

#pragma mark - 鼓励
/*
 8.8 鼓励
 Method：doEncourage
 
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 checkinid	鼓励的签到 id	字符串
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content	返回内容	“”
 */
- (void)doEncourage:(NSString *)_checkInID
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEDoEncourage]];
    [_formDataRequest setPostValue:_checkInID forKey:@"checkinid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEDoEncourage;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

/*
 8.9	cc提醒
 Method：doRemind
 
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 habitid	鼓励的习惯id
 who    鼓励的对象id
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content	返回内容	“”
 */
- (void)doRemind:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEDoRemind]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"who"] forKey:@"who"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEDoRemind;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

#pragma mark - ASIHTTPDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@",request.url);
    NSLog(@"%@", responseString);
    NSDictionary *parsedDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if([[parsedDic objectForKey:@"status"] isEqualToString:@"0"])
    {
        //modify userInfo success
        [_networkDelegate task:request.tag didSuccess:[parsedDic objectForKey:@"content"]];
    }
    else
    {
        //modify userInfo fail
        NSLog(@"request failed %@", [parsedDic objectForKey:@"msg"]);
        [_networkDelegate taskDidFailed:[parsedDic objectForKey:@"msg"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
    [_networkDelegate taskDidFailed:error.domain];
}

@end
