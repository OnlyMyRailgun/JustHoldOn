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
@property (nonatomic, strong) NSString *avataURL;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *description;

- (void)saveUserInfo:(NSDictionary *)dic;
- (void)saveToNSDefault;
+ (JHOAppUserInfo *)shared;
@end
