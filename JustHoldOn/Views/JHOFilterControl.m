//
//  JHOFilterControl.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-22.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOFilterControl.h"

#define LEFT_OFFSET 25
#define RIGHT_OFFSET 25
#define TITLE_SELECTED_DISTANCE 5
#define TITLE_FADE_ALPHA .5f
#define TITLE_FONT [UIFont fontWithName:@"Optima-Bold" size:16]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor colorWithRed:153.0/255 green:188.0/255 blue:212.0/255 alpha:1.0]
#define BACKGROUND_HEIGHT 30
#define CONTROL_HEIGHT 38
#define TOP_OFFSET 2
#define INITIAL_INDEX 2
@interface JHOFilterControl ()
{
    CGPoint diffPoint;
    NSArray *titlesArr;
    UIButton *handler;
    float oneSlotSize;
}

@end

@implementation JHOFilterControl

- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CONTROL_HEIGHT)])
    {
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];

        titlesArr = [[NSArray alloc] initWithArray:titles];

        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TOP_OFFSET, frame.size.width, BACKGROUND_HEIGHT)];
        [backgroundImageView setImage:[UIImage imageNamed:@"时间条"]];
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        
        handler = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [handler setFrame:CGRectMake(0, -4, 39, 38+12)];
        [handler setImage:[UIImage imageNamed:@"时间条a"] forState:UIControlStateNormal];
        [handler setImage:[UIImage imageNamed:@"时间条a"] forState:UIControlStateHighlighted];
        CGPoint handlerCenter = [self getCenterPointForIndex:INITIAL_INDEX];
        handlerCenter.y += 1;
        handler.center = handlerCenter;
        [handler setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:handler];
        
        int i;
        NSString *title;
        UILabel *lbl;
        oneSlotSize = 1.f*(self.frame.size.width)/(titlesArr.count);
        for (i = 0; i < titlesArr.count; i++) {
            title = [titlesArr objectAtIndex:i];
            lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
            [lbl setText:title];
            [lbl setFont:TITLE_FONT];
            [lbl setShadowColor:TITLE_SHADOW_COLOR];
            if(i == INITIAL_INDEX)
                [lbl setTextColor:[UIColor blackColor]];
            else
                [lbl setTextColor:TITLE_COLOR];
            [lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            [lbl setAdjustsFontSizeToFitWidth:YES];
            [lbl setMinimumFontSize:8];
            [lbl setTextAlignment:UITextAlignmentCenter];
            [lbl setShadowOffset:CGSizeMake(0, 0)];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i+50];
            
            [lbl setCenter:[self getCenterPointForIndex:i]];
            
            [self addSubview:lbl];
            [lbl release];
        }
    }
    return self;
}

- (CGPoint)getCenterPointForIndex:(int) i
{
    return CGPointMake((2*i+1) * (self.frame.size.width)/2/(float)titlesArr.count , BACKGROUND_HEIGHT/2+TOP_OFFSET);
}

- (void)setSelectedIndex:(int)index
{
    _selectedIndex = index;
    [self animateHandlerToIndex:index];
    [self stressTitlesAtIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)itemSelected: (UITapGestureRecognizer *) tap
{
    _selectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:_selectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (int)getSelectedTitleInPoint:(CGPoint)pnt
{
    return floor(pnt.x/oneSlotSize);
}

- (void)animateHandlerToIndex:(int) index
{
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint.y += 1;
    
    [UIView beginAnimations:nil context:nil];
    [handler setCenter:toPoint];
    [UIView commitAnimations];
}

- (void)stressTitlesAtIndex:(int) index
{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (i == index) {
            [lbl setTextColor:[UIColor blackColor]];
        }else{
            [lbl setTextColor:TITLE_COLOR];
        }
        [UIView commitAnimations];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc{
    [handler release];
    [titlesArr release];
    [super dealloc];
}
@end
