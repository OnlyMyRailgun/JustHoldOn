//
//  JHOAppUserInfo.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHOAppUserInfo : NSObject
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPsw;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *userDescription;
@property (nonatomic, strong) NSString *alreadyregist;

- (void)modifyUserInfo:(NSDictionary *)dic;
- (void)saveToNSDefault;
+ (JHOAppUserInfo *)shared;
- (void)removeUserInfo;
@end
