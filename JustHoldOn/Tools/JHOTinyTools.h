//
//  JHOTinyTools.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-24.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHOTinyTools : NSObject
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size;
+ (NSString *)getFilePathInDocument:(NSString *)name;
+ (BOOL)isFileExistInDocument:(NSString *)name;
+ (BOOL)saveAvatarPhoto:(UIImage *)image;
@end
