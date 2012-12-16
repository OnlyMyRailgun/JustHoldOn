//
//  JHOHabitModel.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-7.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHOHabitModel : NSObject
@property (nonatomic, strong) NSString *habitID;
@property (nonatomic, strong) NSString *habitName;
@property (nonatomic, strong) NSString *createrId;
@property (nonatomic, strong) NSString *tag;//习惯标签	逗号分割
@property (nonatomic, strong) NSString *type;//类型类别	数字 0-系统 1 自定义
@property (nonatomic, strong) NSString *stages;
@property (nonatomic, strong) NSString *groupName;//习惯分组名	字符串 减肥等等
@property (nonatomic, strong) NSString *joinNum;//全部参加人数
@property (nonatomic, strong) NSString *friendJoinNum;//好友参加人数
@property (nonatomic, strong) NSString *habitDescription;//描述
@property (nonatomic, strong) NSString *starttime;//我加入这个习惯的时间
@property (nonatomic, strong) NSString *mystages;//我处在这个习惯的什么阶段
@property (nonatomic, strong) NSString *mycheckinnum;//我已经签到过的次数
@end
