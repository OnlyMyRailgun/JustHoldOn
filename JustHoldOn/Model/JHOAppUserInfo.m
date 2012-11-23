//
//  JHOAppUserInfo.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOAppUserInfo.h"

@implementation JHOAppUserInfo

#pragma mark - singleton default
static JHOAppUserInfo *sharedAppUserInfo = nil;

+ (JHOAppUserInfo *)shared
{
    if(sharedAppUserInfo == nil)
    {
        sharedAppUserInfo = [[JHOAppUserInfo alloc] init];
        [sharedAppUserInfo loadUserInfo];
    }
    return sharedAppUserInfo;
}

- (void)loadUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appUserInfo = [defaults objectForKey:@"AppUserData"];
    self.userID = [appUserInfo objectForKey:@"uid"];
    self.userName = [appUserInfo objectForKey:@"username"];
    self.userPsw = [appUserInfo objectForKey:@"password"];
    self.avataURL = [appUserInfo objectForKey:@"avataurl"];
    self.gender = [appUserInfo objectForKey:@"sex"];
    self.description = [appUserInfo objectForKey:@"description"];
}

- (void)saveUserInfo:(NSDictionary *)dic
{
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"AppUserData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveToNSDefault
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userID,@"uid",self.userName,@"username",self.userPsw,@"password",self.avataURL,@"avataurl",self.gender,@"sex",self.description,@"description", nil];
    [self saveUserInfo:dic];
}

@end
