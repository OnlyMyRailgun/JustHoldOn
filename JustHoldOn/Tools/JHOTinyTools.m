//
//  JHOTinyTools.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-24.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOTinyTools.h"

@implementation JHOTinyTools
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)saveAvatarPhoto:(UIImage *)image
{
    BOOL success = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *path = [JHOTinyTools getFilePathInDocument:@"userAvatar.png"];
    if([JHOTinyTools isFileExistInDocument:@"userAvatar.png"]) {
        [fileManager removeItemAtPath:path error:&error];
    }
    
    success = [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    return success;
}

+ (NSString *)getFilePathInDocument:(NSString *)name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name];
}

+ (BOOL)isFileExistInDocument:(NSString *)name
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[JHOTinyTools getFilePathInDocument:name]];
}
@end
