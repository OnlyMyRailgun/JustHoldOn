//
//  JHONetworkHelper.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHONetworkHelper.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "JHOAppUserInfo.h"

@implementation JHONetworkHelper
{
    ASIHTTPRequest *httpRequest;
    ASIFormDataRequest *formDataRequest;
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
- (NSDictionary *)registerWithWeiboWithRemoteToken:(NSString *)remoteToken andAccessToken:(NSString *)accessToken
{
    formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEUserSocialLogin]];
    [formDataRequest setPostValue:@"1" forKey:@"type"];
    [formDataRequest setPostValue:remoteToken forKey:@"deviceid"];
    [formDataRequest setPostValue:accessToken forKey:@"key"];
    
    [formDataRequest startSynchronous];
    NSError *error = [formDataRequest error];
    NSDictionary *parsedDic = nil;
    if (!error) {
        NSString *response = [formDataRequest responseString];
        NSLog(@"registerWithWeibo res:%@", response);
        parsedDic = [response objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
        NSLog(@"content:%@", [parsedDic objectForKey:@"content"]);
    }
    else
        NSLog(@"%@",error);
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
    formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyAvatar]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [formDataRequest setPostValue:infoHelper.userPsw forKey:@"password"];
    [formDataRequest setFile:@"/Users/Heartunderblade/Desktop/ben.jpg"  forKey:@"file"];
    
    [formDataRequest setDelegate:self];
    [formDataRequest startAsynchronous];
    formDataRequest.tag = NEModifyAvatar;
}

/*
 *1.4	修改用户信息
 *method: modifyUserInfo
 *调用参数
 *参数	描 述	格 式
 *uid=value	用户唯一ID	字符串
 *password=value	密码	字符串
 **=value	要修改的内容	字符串
 *返回项说明：
 *返回项	描 述	格 式
 *status	是否成功	0表示成功，其他为失败原因代码
 *msg	消息	“成功”，或失败原因
 *content	返回内容	“”
 *说明：调用参数部分uid 和password 是必选项，用于完成鉴权；
 *其余参数用于表示要修改的内容。
 */
- (void)updateUserInfo
{
    formDataRequest = [ASIFormDataRequest requestWithURL:[self getCompleteURL:NEModifyUserInfo]];
    JHOAppUserInfo *infoHelper = [JHOAppUserInfo shared];
    [formDataRequest setPostValue:infoHelper.userID forKey:@"uid"];
    [formDataRequest setPostValue:infoHelper.userID forKey:@"password"];
    [formDataRequest setPostValue:infoHelper.description forKey:@"description"];
    
    [formDataRequest setDelegate:self];
    [formDataRequest startAsynchronous];
    formDataRequest.tag = NEModifyUserInfo;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString;
//    // Use when fetching binary data
//    NSData *responseData = [request responseData];
    
    switch (request.tag) {
        case NEModifyAvatar:
            responseString = [request responseString];
            NSDictionary *parsedDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            if([[parsedDic objectForKey:@"status"] isEqualToString:@"0"])
            {
                //upload avatar success
            }
            else
            {
                //upload avatar fail
                NSLog(@"%@", [parsedDic objectForKey:@"msg"]);
            }
            break;
        case NEModifyUserInfo:
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
