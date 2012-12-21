//
//  JHOHabitListTableViewCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOHabitListTableViewCell.h"

@implementation JHOHabitListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        //        self.textLabel.shadowColor = [UIColor colorWithRed:33.0f/255.0f green:38.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
        //        self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.textLabel.backgroundColor = [UIColor clearColor];
        //        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
        
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIButton *checkInButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 13, 34, 34)];
        [checkInButton setImage:[UIImage imageNamed:@"tocheckin"] forState:UIControlStateNormal];
        [checkInButton setImage:[UIImage imageNamed:@"hascheckin"] forState:UIControlStateSelected];
        [checkInButton addTarget:self action:@selector(actionCheckIn) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = checkInButton;
        [checkInButton release];
        
        UIView *backgroundUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 62)];
        [backgroundUIView setBackgroundColor:[UIColor colorWithRed:246 green:246 blue:246 alpha:1.0f]];
        [backgroundUIView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]]];
        UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 2)];
        [separatorImageView setImage:[UIImage imageNamed:@"myhabit_separator"]];
        [backgroundUIView addSubview:separatorImageView];
        self.backgroundView = backgroundUIView;
        [separatorImageView release];
        [backgroundUIView release];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 5.0f, 50.0f,50.0f);
}

- (void)actionCheckIn
{
    UIButton *tapedBtn = (UIButton *)self.accessoryView;
    tapedBtn.selected = YES;
}
@end
