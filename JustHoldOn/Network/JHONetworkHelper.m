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

@implementation JHONetworkHelper
{
    NSURL *url;
}

#define BASESERVERURL @"http://192.168.0.137:8080/JustHoldOnServer-1.0.0/"

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
        case NEGetGoalLib:
            [str appendString:@"getGoalLib"];
            break;
        case NEChooseGoal:
            [str appendString:@"chooseGoal"];
            break;
        default:
            break;
    }
    return [NSURL URLWithString:str];
}

/*
 * 1.2	社交帐号登录   11-22
 method：userSocialLogin
 调用参数
 参数	描 述	格 式
 type	登录类型	数字
 1：新浪微博账号
 2：人人账号
 deviceid	设备id	字符串
 key	鉴权密钥	字符串
 
 返回项说明：
 返回项	描 述	格 式
 statuscode	是否成功	数字
 0表示成功，其他为失败原因代码
 statustext	消息	字符串
 content	返回内容	JSONObject
 content.uid	用户名	字符串
 content.password	密码	字符串
 content.avatarurl	头像	字符串
 content.sex	性别	字符串
 content.description	描述	字符串
 */

- (NSDictionary *)registerWithWeiboAccessToken:(NSString *)accessToken
{
    JHOAppDelegate *appDelegate = (JHOAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *remoteToken = appDelegate.globalDeviceToken;
    _formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEUserSocialLogin]];
    [_formDataRequest setPostValue:@"1" forKey:@"type"];
    [_formDataRequest setPostValue:remoteToken forKey:@"deviceid"];
    [_formDataRequest setPostValue:accessToken forKey:@"key"];
    
    [_formDataRequest startSynchronous];
    NSError *error = [_formDataRequest error];
    NSDictionary *parsedDic = nil;
    if (!error) {
        NSString *response = [_formDataRequest responseString];
        NSLog(@"registerWithWeibo res:%@", response);
        parsedDic = [response objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    }
    else
        [JHONetworkHelper showAlertView:error];
//#warning Incomplete error handler.
    return parsedDic;
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
    _formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyAvatar]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setFile:[JHOTinyTools getFilePathInDocument:@"userAvatar.png"]  forKey:@"file"];
    
    [_formDataRequest setDelegate:self];
    _formDataRequest.tag = NEModifyAvatar;
    [_formDataRequest startAsynchronous];
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
- (NSDictionary *)updateUserInfo
{
    _formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyUserInfo]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [_formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [_formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [_formDataRequest setPostValue:infoHelper.userName forKey:@"username"];
    [_formDataRequest setPostValue:infoHelper.userDescription forKey:@"description"];
    [_formDataRequest setPostValue:infoHelper.gender forKey:@"sex"];
    _formDataRequest.tag = NEModifyUserInfo;

    [_formDataRequest startSynchronous];
    NSError *error = [_formDataRequest error];
    NSDictionary *parsedDic = nil;
    if (!error) {
        NSString *response = [_formDataRequest responseString];
        NSLog(@"updateUserInfo res:%@", response);
        parsedDic = [response objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    }
    else
        [JHONetworkHelper showAlertView:error];
    return parsedDic;
}

/*2.3	获得目标库
 *Method：getGoalLib

 *调用参数
 *参数	描 述	格 式
 *maxnum	获取目标最大数量	默认20
 *gettype	获取类型	“1”按分类 “2”全部
 *typevalue	获取类型值	字符串 全部此处为空 若按分类来，此处为分类名（”f”-女,”m”-男）
 *startpos	查找起始位	第一次请求，起始位为”0” 之后的请求，为上一次请求的最后一个位置
 *sorttype	排序方式	“0”不排序 “1”按参加人数 …可扩展

 *返回项说明：
 *返回项	描 述	格 式
 *status	是否成功	“0”成功
 *msg	消息	字符串
 *content	返回内容	JSONObject
 *content.resultnum	返回结果数	数字
 *content.list	目标数组	数组
 *list.id		字符串
 *list.content
 *list.type
 */
- (NSDictionary *)getGoalLib
{
    _formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetGoalLib]];
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
        [JHONetworkHelper showAlertView:error];
    //#warning Incomplete error handler.
    return parsedDic;
}

/*
2.4	选择目标
Method：chooseGoal

调用参数
参数	描 述	格 式
uid	用户唯一ID	字符串
password	密码	字符串
goalid	目标id	逗号分割
habitmaxnum	返回推荐的习惯数目	字符串 默认20
startpos	获取推荐习惯起始位	第一次请求，起始位为”0” 之后的请求，为上一次请求的最后一个位置

返回项说明：
返回项	描 述	格 式
status	是否成功	成功”0”
msg	消息	“成功”，或失败原因
content	返回内容	JSONObject
content.resultnum	返回结果数	数字
content.list	习惯数组	数组
list.id	习惯id	字符串
list.name	习惯名称
list.creater	习惯创建者
list.tag	习惯标签
list.type	类型类别	数字 0-系统 1 自定义
list.stages	阶段	字符串以逗号分割 “11,22,33”三个阶段 一阶段11天 二阶段22天 ；三阶段33天
list.groupname	习惯分组名	字符串 减肥等等
list.joinnum	全部参加人数	数字
list.friendjoinnum	好友参加人数	数字
list.description	描述
 */
- (NSDictionary *)chooseGoal:(NSString *)goalStr
{
    _formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEGetGoalLib]];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userID forKey:@"uid"];
    [_formDataRequest setPostValue:[JHOAppUserInfo shared].userPsw forKey:@"password"];
    [_formDataRequest setPostValue:goalStr forKey:@"goalid"];
    [_formDataRequest setPostValue:@"20" forKey:@"habimaxnum"];
    [_formDataRequest setPostValue:@"0" forKey:@"startpos"];
    
    [_formDataRequest startSynchronous];
    NSError *error = [_formDataRequest error];
    NSDictionary *parsedDic = nil;
    if (!error) {
        NSString *response = [_formDataRequest responseString];
        parsedDic = [response objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    }
    else
        [JHONetworkHelper showAlertView:error];
    //#warning Incomplete error handler.
    return parsedDic;
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString;
    NSDictionary *parsedDic;
//    // Use when fetching binary data
//    NSData *responseData = [request responseData];
    
    switch (request.tag) {
        case NEModifyAvatar:
            responseString = [request responseString];
            parsedDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            if([[parsedDic objectForKey:@"status"] isEqualToString:@"0"])
            {
                //upload avatar success
            }
            else
            {
                //upload avatar fail
                NSLog(@"upload avatar fail %@", [parsedDic objectForKey:@"msg"]);
            }
            break;
        case NEModifyUserInfo:
            responseString = [request responseString];
            parsedDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            if([[parsedDic objectForKey:@"status"] isEqualToString:@"0"])
            {
                //modify userInfo success
            }
            else
            {
                //modify userInfo fail
                NSLog(@"modify userInfo fail %@", [parsedDic objectForKey:@"msg"]);
            }
            break;
        default:
            break;
    }    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
}

+ (void)showAlertView:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"Well" otherButtonTitles:nil];
    [errorAlert show];
    [errorAlert release];
}
@end
