//
//  UISearchBar+CustomBackground.m
//  JustHoldOn
//
//  Created by Heartunderblade on 1/8/13.
//  Copyright (c) 2013 Heartunderblade. All rights reserved.
//

#import "UISearchBar+CustomBackground.h"

@implementation UISearchBar (CustomBackground)
- (void)drawRect:(CGRect)rect
{
    //draw image
    [[self.subviews objectAtIndex:0]removeFromSuperview];
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGRect searchBarRect = self.frame;
    searchBarRect.origin.y = searchBarRect.size.height - 2;
    searchBarRect.size.height = 2;
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:searchBarRect];
    [separatorImageView setImage:[UIImage imageNamed:@"myhabit_separator"]];
    [self addSubview:separatorImageView];
    [separatorImageView release];
    
    [[UIImage imageNamed:@"签到流bg"] drawAsPatternInRect:rect];
}
@end
