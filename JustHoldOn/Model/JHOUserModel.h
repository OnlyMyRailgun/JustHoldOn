//
//  JHOUserModel.h
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-6.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHOUserModel : NSObject
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *avatarURL;
@property (nonatomic, retain) NSString *userDescription;
@property (nonatomic, retain) NSString *userGender;
@property int friendNum;
@property int habitNum;
@property int goalNum;
@end
