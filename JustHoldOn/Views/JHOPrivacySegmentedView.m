//
//  JHOPrivacySegmentedView.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-22.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOPrivacySegmentedView.h"
#define PSV_TITLE_FONT [UIFont fontWithName:@"Optima-Bold" size:15]
#define PSV_TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define PSV_TITLE_COLOR [UIColor colorWithRed:153.0/255 green:188.0/255 blue:212.0/255 alpha:1.0]
#define PSV_INITIAL_SELECTED 0
@interface JHOPrivacySegmentedView ()
{
    NSArray *titlesArr;
}

@end

@implementation JHOPrivacySegmentedView

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        int i;
        UIButton *btn;
        CGFloat width = self.frame.size.width / titlesArr.count;
        _selectedIndex = PSV_INITIAL_SELECTED;
        for(i = 0; i < titlesArr.count; i++)
        {
            btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
            
            [btn setFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
            UIImage *normalImage;
            UIImage *selectedImage;
            if(i  == 0)
            {
                normalImage = [UIImage imageNamed:@"习惯定制-1-点击前"];
                selectedImage = [UIImage imageNamed:@"习惯定制-1-点击后"];
            }
            else if (i < titlesArr.count - 1)
            {
                normalImage = [UIImage imageNamed:@"习惯定制-2-点击前"];
                selectedImage = [UIImage imageNamed:@"习惯定制-2-点击后"];
            }
            else
            {
                normalImage = [UIImage imageNamed:@"习惯定制-3-点击前"];
                selectedImage = [UIImage imageNamed:@"习惯定制-3-点击后"];
            }
            [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
            [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
            [btn setTitleColor:PSV_TITLE_COLOR forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitle:[titlesArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTag:60+i];
            btn.titleLabel.font = PSV_TITLE_FONT;
            
            [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
        }
        [self setBtnSelected:PSV_INITIAL_SELECTED + 60];
    }
    return self;
}

- (void)setBtnSelected:(int) tag
{
    [((UIButton *)[self viewWithTag:_selectedIndex + 60]) setSelected:NO];
    [((UIButton *)[self viewWithTag:tag]) setSelected:YES];
    _selectedIndex = tag - 60;
}

- (void)btnPressed:(UIButton *)btn
{
    [self setBtnSelected:btn.tag];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    for(int i = 0; i < titlesArr.count; i++)
    {
        [(UIButton *)[self viewWithTag:(60+i)] release];
    }
    [titlesArr release];
    [super dealloc];
}
@end
