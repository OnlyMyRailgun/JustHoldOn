//
//  JHOHabitModel.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-7.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PUDay = 0,
    PUWEEK,
    PUMonth,
} PersistUnit;

@interface JHOHabitModel : NSObject
@property (nonatomic, strong) NSString *habitID;
@property (nonatomic, strong) NSString *habitName;
@property int habitFrequency;
@property (nonatomic, strong) NSString *habitTag;//习惯标签	逗号分割
@property (nonatomic, strong) NSString *groupName;//习惯分组名	字符串 减肥等等
@property int joinNum;//全部参加人数
@property int friendJoinNum;//好友参加人数
@property (nonatomic, strong) NSString *habitDescription;//描述
@property (nonatomic, strong) NSString *userDescription;//描述
@property int mystages;//我处在这个习惯的什么阶段
@property int unitcheckinnum;//我已经签到过的次数
@property BOOL hasCheckedInToday;
@end
