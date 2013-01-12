//
//  JHOHabitCategoryHeader.m
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-12.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import "JHOHabitCategoryHeader.h"

@implementation JHOHabitCategoryHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 39)];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTaped:)];
        [self addGestureRecognizer:gest];
        [gest release];
        
        UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(headerPanned:)];
        [self addGestureRecognizer:panGest];
        [panGest release];
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.frame];
        [backImageView setImage:[UIImage imageNamed:@"习惯列表12-28_02"]];
        [self addSubview:backImageView];
        
        _label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 9, 300, 34)] autorelease];
        _label.text = @"全部 习惯";
        _label.font = [UIFont systemFontOfSize:13.0f];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        
        _isOpened = NO;
    }
    return self;
}

- (void)headerTaped:(UITapGestureRecognizer *)tap
{
    if(_isOpened)
    {
        [_moveDelegate closeCategoryView];
        _isOpened = NO;
    }
    else
    {
        [_moveDelegate openCategoryView];
        _isOpened = YES;
    }
}

- (void)headerPanned:(UIPanGestureRecognizer *)pan
{
    if(pan.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [pan velocityInView:self];
        
        if(velocity.y > 0)
        {
            //NSLog(@"gesture went down");
            [_moveDelegate closeCategoryView];
            _isOpened = NO;
        }
        else
        {
            [_moveDelegate openCategoryView];
            _isOpened = YES;
            //NSLog(@"gesture went up");
        }
    }
    else
    {
        [_moveDelegate moveView:[pan locationInView:self].y];
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

@end
