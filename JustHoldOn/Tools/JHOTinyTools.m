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

+ (JHOAppDelegate *)theDelegate
{
	return (JHOAppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (NSOperationQueue *)theOperationQueue
{
	return [[JHOTinyTools theDelegate] theOperationQueue];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter release];
    
    return destDateString;
}

+ (NSString *)caculatePublishTimeWithInterval:(NSTimeInterval) interval
{
    NSString *result;
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSLog(@"%@", publishDate.description);
    int difference = [[NSDate date] timeIntervalSince1970] - interval;
    if(difference < 60)
        result = [NSString stringWithFormat:@"%d秒前",difference];
    else if (difference < 3600)
        result = [NSString stringWithFormat:@"%d分钟前",difference/60];
    else
    {
        result = [JHOTinyTools stringFromDate:publishDate];
    }
    return result;
}

//计算 宽度
+ (CGFloat)calculateTextWidth:(NSString *)strContent withFont:(UIFont *)strFont{
    //    CGSize constraint = CGSizeMake(heightInput, heightInput);
    CGFloat constrainedSize = 26500.0f; //其他大小也行
    CGSize size = [strContent sizeWithFont:strFont constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    //    CGFloat height = MAX(size.height, 44.0f);
    return size.width;
}
@end
