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
    self.avatarURL = [appUserInfo objectForKey:@"avataurl"];
    self.gender = [appUserInfo objectForKey:@"sex"];
    self.userDescription = [appUserInfo objectForKey:@"description"];
    self.alreadyregist = [appUserInfo objectForKey:@"alreadyregist"];
}

- (void)modifyUserInfo:(NSDictionary *)appUserInfo
{
    self.userID = [appUserInfo objectForKey:@"uid"];
    self.userName = [appUserInfo objectForKey:@"username"];
    self.userPsw = [appUserInfo objectForKey:@"password"];
    self.avatarURL = [appUserInfo objectForKey:@"avataurl"];
    self.gender = [appUserInfo objectForKey:@"sex"];
    self.userDescription = [appUserInfo objectForKey:@"description"];
    self.alreadyregist = [appUserInfo objectForKey:@"alreadyregist"];
}

- (void)saveToNSDefault
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userID,@"uid",self.userName,@"username",self.userPsw,@"password",self.avatarURL,@"avataurl",self.gender,@"sex",self.description,@"description",self.alreadyregist,@"alreadyregist", nil];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"AppUserData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppUserData"];
}
@end
