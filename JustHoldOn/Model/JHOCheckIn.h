//
//  JHOCheckIn.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-7.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    TMCheckIn = 0,//签到信息流
    TMJOIN,//加入信息流
    TMComplete,//养成信息流
}TimelineMsgType;

@interface JHOCheckIn : NSObject
@property (nonatomic, retain) NSString *ownerUid;
@property (nonatomic, retain) NSString *ownerPic;
@property (nonatomic, retain) NSString *ownerName;
@property (nonatomic, retain) NSString *checkInId;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *checkInDescription;
@property (nonatomic, retain) NSString *picURL;
@property int commentNum;
@property (nonatomic, retain) NSMutableArray *preComments;
@property (nonatomic, retain) NSString *dateLine;
@property (nonatomic, retain) NSString *hasEncouraged;
@property int encourageNum;
@property (nonatomic, retain) NSMutableArray *preEncourages;
@property (nonatomic, retain) NSString *msgType;
@property (nonatomic, retain) NSString *habitID;
@property (nonatomic, retain) NSString *habitName;
@end
