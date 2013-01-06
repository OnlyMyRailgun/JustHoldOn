//
//  JHOFriendListTableViewCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-6.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import "JHOFriendListTableViewCell.h"
#import "JHOTinyTools.h"

@implementation JHOFriendListTableViewCell

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
               
        UIView *backgroundUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 62)];
        [backgroundUIView setBackgroundColor:[UIColor colorWithRed:246 green:246 blue:246 alpha:1.0f]];
        [backgroundUIView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]]];
        UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 2)];
        [separatorImageView setImage:[UIImage imageNamed:@"myhabit_separator"]];
        [backgroundUIView addSubview:separatorImageView];
        self.backgroundView = backgroundUIView;
        [separatorImageView release];
        [backgroundUIView release];
        
        //好友时的acessoryView
        _friendHabitsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
        _friendHabitsNumLabel.textColor = [UIColor colorWithRed:83.0/255 green:83.0/255 blue:83.0/255 alpha:1.0f];
        _friendHabitsNumLabel.text = @"参加过    习惯";
        
        _habitsNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
        _habitsNum.textColor = [UIColor colorWithRed:56.0/255 green:110.0/255 blue:149.0/255 alpha:1.0f];
        _habitsNum.text = @"86";
        
        [_friendHabitsNumLabel release];
        [_habitsNum release];
        //非好友时的acessoryView
        UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 13, 34, 34)];
        //        [checkInButton setImage:[UIImage imageNamed:@"tocheckin"] forState:UIControlStateNormal];
        //        [checkInButton setImage:[UIImage imageNamed:@"hascheckin"] forState:UIControlStateSelected];
        //        [checkInButton addTarget:self action:@selector(actionCheckIn) forControlEvents:UIControlEventTouchUpInside];
        //        self.accessoryView = checkInButton;
        [actionButton release];

    }
    
    return self;
}

- (void)updateCellWithUser:(JHOUserModel *)_model
{
    CGFloat userNameWidth = [JHOTinyTools calculateTextWidth:_model.userName withFont:self.textLabel.font];
    CGRect userNameRect = self.textLabel.frame;
    userNameRect.size.width = userNameWidth;
    self.textLabel.frame = userNameRect;
    self.textLabel.text = _model.userName;
    
    CGFloat genderStartPos = userNameRect.origin.x + userNameWidth + 10;
    _genderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(genderStartPos, 0, 0, 0)];
    if([_model.userGender isEqualToString:@"f"])
        [_genderImageView setImage:[UIImage imageNamed:@""]];
    else
        [_genderImageView setImage:[UIImage imageNamed:@""]];
    
    [self.contentView addSubview:_genderImageView];
    [_genderImageView release];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 5.0f, 50.0f,50.0f);
}
@end
