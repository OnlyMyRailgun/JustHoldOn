//
//  JHOTimelineCategoryControl.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOTimelineCategoryControl.h"
#define CC_HEIGHT 37
#define CC_TITLE_FADE_ALPHA .5f
#define CC_TITLE_FONT [UIFont fontWithName:@"Optima-Bold" size:16]
#define CC_TITLE_COLOR [UIColor colorWithRed:76.0/255 green:60.0/255 blue:45.0/255 alpha:1.0]
#define CC_INITIAL_INDEX 0

@interface JHOTimelineCategoryControl ()
{
    NSArray *titlesArr;
    UIImageView *ccBackgroundView;
    CGFloat oneSlotSize;
}

@end

@implementation JHOTimelineCategoryControl

- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, CC_HEIGHT)])
    {
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];
        
        titlesArr = [[NSArray alloc] initWithArray:titles];
        
        ccBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, CC_HEIGHT)];
        NSString *initialImageName = [NSString stringWithFormat:@"timelineCategory%d-%d", titlesArr.count, CC_INITIAL_INDEX];
        [ccBackgroundView setImage:[UIImage imageNamed:initialImageName]];
        [self addSubview:ccBackgroundView];
        
        int i;
        NSString *title;
        UILabel *lbl;
        oneSlotSize = self.frame.size.width/titlesArr.count;
        for (i = 0; i < titlesArr.count; i++) {
            title = [titlesArr objectAtIndex:i];
            lbl = [[UILabel alloc]initWithFrame:CGRectMake(i*oneSlotSize, 6, oneSlotSize, 25)];
            [lbl setText:title];
            [lbl setFont:CC_TITLE_FONT];
            [lbl setTextColor:CC_TITLE_COLOR];
            if(i != CC_INITIAL_INDEX)
                [lbl setAlpha:CC_TITLE_FADE_ALPHA];
            [lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            [lbl setAdjustsFontSizeToFitWidth:YES];
            [lbl setMinimumFontSize:8];
            [lbl setTextAlignment:UITextAlignmentCenter];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i+20];
           
            [self addSubview:lbl];
            [lbl release];
        }
    }
    return self;
}

- (int)getSelectedTitleInPoint:(CGPoint)pnt
{
    return floor(pnt.x/oneSlotSize);
}

- (void)setSelectedIndex:(int)index
{
    for(int i = 0; i < titlesArr.count; i++)
    {
        UILabel *lb = (UILabel *)[self viewWithTag:i+20];
        if(i != index)
            [lb setAlpha:CC_TITLE_FADE_ALPHA];
        else
            [lb setAlpha:1.0];
    }
    NSString *imageName = [NSString stringWithFormat:@"timelineCategory%d-%d", titlesArr.count, index];
    [ccBackgroundView setImage:[UIImage imageNamed:imageName]];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)itemSelected: (UITapGestureRecognizer *) tap
{
    _selectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:_selectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc{
    [titlesArr release];
    [ccBackgroundView release];
    [super dealloc];
}
@end
