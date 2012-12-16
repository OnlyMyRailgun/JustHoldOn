//
//  UITableViewCell+UITableViewCellExt.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-30.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "UITableViewCell+UITableViewCellExt.h"

@implementation UITableViewCell (UITableViewCellExt)

- (void)setBackgroundImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    self.backgroundView = imageView;
    [imageView release];
}

- (void)setBackgroundImageByName:(NSString*)imageName
{
    [self setBackgroundImage:[UIImage imageNamed:imageName]];
}

@end
