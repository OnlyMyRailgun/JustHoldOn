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
#import "JHOBaseWebViewController.h"

@implementation JHONetworkHelper
{
    NSURL *url;
}

#define BASESERVERURL @"http://192.168.0.106:8080/JustHoldOnServer-1.0.0/"

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
            [str appendString:@"gethabitgroup"];
            break;
        case NEGetHabitLib:
            [str appendString:@"gethabitlib"];
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
        default:
            break;
    }
    return [NSURL URLWithString:str];
}

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
    //[_formDataRequest startAsynchronous];
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

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
- (void)updateUserInfo
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyUserInfo]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:infoHelper.userName forKey:@"username"];
    [_formDataRequest setPostValue:infoHelper.userDescription forKey:@"description"];
    [_formDataRequest setPostValue:infoHelper.gender forKey:@"sex"];
    _formDataRequest.tag = NEModifyUserInfo;
    _formDataRequest.delegate = self;
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

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
    ASIHTTPRequest *_httpRequest = [ASIHTTPRequest requestWithURL:[self getCompleteURL:NEGetHabitGroup]];
    _httpRequest.delegate = self;
    _httpRequest.tag = NEGetHabitGroup;
    [[JHOTinyTools theOperationQueue] addOperation:_httpRequest];
}

/*4.3	获得习惯库[done]
 Method：getHabitlib
 
 调用参数
 参数	描 述	格 式
 maxnum	获取习惯最大数量	默认20
 gettype	获取类型	“1”按分类  “2”全部
 typevalue	获取类型值	字符串  全部此处为空  若按分类来，此处为分类名
 startpos	查找起始位	第一次请求，起始位为”0”
 sorttype	排序方式	“0”不排序  “1”按参加人数  …可扩展
 
 返回项说明：
 返回项	描 述	格 式
 status	是否成功	“0”成功
 msg	消息	“成功”，或失败原因
 content	返回内容	JSONObject
 content.resultnum	返回结果数	数字
 content.nextstartpos		下次请求起始位，数字
 content.list	习惯数组	数组
 content.id	习惯id	字符串
 content.name	习惯名称
 content.creater	习惯创建者
 content.tag	习惯标签	逗号分割
 content.type	类型类别	数字 0-系统 1 自定义
 content.stages	阶段	字符串以逗号分割  “11,22,33”三个阶段 一阶段11天  二阶段22天 ；三阶段33天
 content.groupname	习惯分组名	字符串  减肥等等
 content.joinnum	全部参加人数
 content.friendjoinnum	好友参加人数
 content.description	描述
 */
- (void)getHabitLib:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
    [_formDataRequest setPostValue:[_dic objectForKey:@"gettype"] forKey:@"gettype"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"maxnum"] forKey:@"maxnum"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"typevalue"] forKey:@"typevalue"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"startpos"] forKey:@"startpos"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"sorttype"] forKey:@"sorttype"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetHabitLib;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)getHabitLibResult:(NSDictionary *)_dic
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
        habitModel.createrId = [habit objectForKey:@"creater"];
        habitModel.tag = [habit objectForKey:@"tag"];
        habitModel.type = [habit objectForKey:@"type"];
        habitModel.stages = [habit objectForKey:@"stages"];
        habitModel.groupName = [habit objectForKey:@"groupname"];
        habitModel.joinNum = [habit objectForKey:@"joinnum"];
        habitModel.friendJoinNum = [habit objectForKey:@"friendjionnum"];
        habitModel.habitDescription = [habit objectForKey:@"description"];
        [array addObject:habitModel];
        [habitModel release];
    }
    return array;
}

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
        habitModel.createrId = [habit objectForKey:@"creater"];
        habitModel.tag = [habit objectForKey:@"tag"];
        habitModel.type = [habit objectForKey:@"type"];
        habitModel.stages = [habit objectForKey:@"stages"];
        habitModel.groupName = [habit objectForKey:@"groupname"];
        habitModel.joinNum = [habit objectForKey:@"joinnum"];
        habitModel.friendJoinNum = [habit objectForKey:@"friendjionnum"];
        habitModel.habitDescription = [habit objectForKey:@"description"];
        [array addObject:habitModel];
        [habitModel release];
    }
    return array;
}

/*
6.3	定制习惯的
Method：addHabit
调用参数
参数	描 述	格 式
uid	用户唯一ID	字符串
password	密码	字符串
habitid	习惯id
fre	一周希望完成的次数	int（1~7）
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
    [_formDataRequest setPostValue:[_dic objectForKey:@"privacy"] forKey:@"privacy"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"goal"] forKey:@"goal"];
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEAddHabit;

    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

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
content.resultnum	返回结果数	数字
content.nextstartpos		下次请求起始位，数字
content.list	习惯数组	数组
content.id	习惯id	字符串
content.name	习惯名称
content.ifcreater	是否是该用户创建的	0 不是  1 是
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
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"who"] forKey:@"who"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"maxnum"] forKey:@"maxnum"];
    ;
    [_formDataRequest setPostValue:[_dic objectForKey:@"gettype"] forKey:@"gettype"];
    ;

    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEGetUserHabits;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

- (NSMutableArray *)getUserHabitResult:(NSDictionary *)_dic
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
        habitModel.createrId = [habit objectForKey:@"ifcreater"];
        habitModel.tag = [habit objectForKey:@"tag"];
        habitModel.type = [habit objectForKey:@"type"];
        habitModel.stages = [habit objectForKey:@"stages"];
        habitModel.groupName = [habit objectForKey:@"groupname"];
        habitModel.joinNum = [habit objectForKey:@"joinnum"];
        habitModel.friendJoinNum = [habit objectForKey:@"friendjionnum"];
        habitModel.habitDescription = [habit objectForKey:@"description"];
        habitModel.starttime = [habit objectForKey:@"starttime"];
        habitModel.mycheckinnum = habitModel.habitDescription = [habit objectForKey:@"mycheckinnum"];
        [array addObject:habitModel];
        [habitModel release];
    }
    return array;
}
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
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:[_dic objectForKey:@"habitid"] forKey:@"habitid"];
    ;
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEToCheckIn;
    
    [[JHOTinyTools theOperationQueue] addOperation:_formDataRequest];
}

/*
 6.4	获取签到流
 Method：getCheckIns
 
 调用参数
 参数	描 述	格 式
 uid	用户唯一ID	字符串
 password	密码	字符串
 type	获取类型	1.某个习惯的
 2.某个人的某个习惯的
 3.某个人的某个好友的某个习惯的
 4.某人的好友的流
 5.某人的流
 
 who	关注用户的标识符	字符串，
        type
        2 3 4 5 时有用，3 4 时标示那个好友
 habitid	习惯标示	type
            1
            2
            3 时有用
 num	单页数量	数目 默认20
 startpos	签到流的起始位置	updateway=’more’传最后一次请求的最后一个事件id(第一次值为0)
            updateway=’refresh’传第一次请求的第一个id
 updateway	更新方式	‘more’ 或 ‘refresh’
 
 
 返回项说明：
 
 status	是否成功	0表示成功，其他为失败原因代码
 msg	消息	“成功”，或失败原因
 content	返回内容	 JSONArray
    content.resultnum
    content.nextpos
    content.usename	签到item发布者用户名
    content.list
    list.uid	签到item发布者id	字符串
    list.userpic	签到item发布者头像地址	url
    list.checkinid	签到id	字符串
    list.location	位置	字符串
    list.latitude	经度	字符串
    list.longitude	纬度	字符串
    list.description	签到Item的文字描述	字符串
    list.picurl	签到Item对应的图片地址	url
    list.commentnum	签到Item对应的评论数	字符串
    list.comment
 
 （此处可只返回最新两个评论，可再讨论）	
        comment.commentid	评论id
        comment.uid	评论者id
        comment.username	评论者的名字
        comment. avatar	评论者头像
        comment.content	评论内容
        comment.time	评论时间
    list.encourage num	签到Item的文字推荐数	字符串
    content.encourage	encourage.commentid	鼓励id
            encourage.uid	鼓励者id
            encourage.username	鼓励者的名字
            encourage. time	鼓励时间
 
    content.dateline	签到Item发布时间	20120330172800
    content.isencourage	当前用户是否鼓励过	0否 1 是
*/
- (void)getCheckIns:(NSDictionary *)_dic
{
    ASIFormDataRequest *_formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEAddHabit]];
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

#pragma mark - ASIHTTPDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    id<NetworkTaskDelegate> networkDelegate = request.delegate;
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
    NSDictionary *parsedDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if([[parsedDic objectForKey:@"status"] isEqualToString:@"0"])
    {
        //modify userInfo success
        [networkDelegate task:request.tag didSuccess:[parsedDic objectForKey:@"content"]];
    }
    else
    {
        //modify userInfo fail
        NSLog(@"request failed %@", [parsedDic objectForKey:@"msg"]);
        [networkDelegate taskDidFailed:[parsedDic objectForKey:@"msg"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
}

@end
