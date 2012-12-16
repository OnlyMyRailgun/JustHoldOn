//
//  JHOCheckIn.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-7.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHOCheckIn : NSObject
@property (nonatomic, retain) NSString *ownerUid;
@property (nonatomic, retain) NSString *ownerPic;
@property (nonatomic, retain) NSString *checkInId;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *checkInDescription;
@property (nonatomic, retain) NSString *picURL;
@property (nonatomic, retain) NSString *commentNum;
@property (nonatomic, retain) NSArray *preComments;
@property (nonatomic, retain) NSString *dateLine;
@property (nonatomic, retain) NSString *isEncouraged;
@end
