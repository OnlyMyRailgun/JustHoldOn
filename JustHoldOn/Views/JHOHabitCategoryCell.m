//
//  JHOHabitCategoryCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-12.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import "JHOHabitCategoryCell.h"

@implementation JHOHabitCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        //        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
        
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIView *backgroundUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:backgroundUIView.frame];
        [backImageView setImage:[UIImage imageNamed:@"习惯列表bg"]];
        UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 320, 2)];
        [separatorImageView setImage:[UIImage imageNamed:@"习惯列表分隔线"]];
        [backgroundUIView addSubview:backImageView];
        [backgroundUIView addSubview:separatorImageView];
        self.backgroundView = backgroundUIView;
        [backImageView release];
        [separatorImageView release];
        [backgroundUIView release];
        
        UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame:self.frame];
        [selectedImageView setImage:[UIImage imageNamed:@"习惯列表选中后bg"]];
        self.selectedBackgroundView = selectedImageView;
        [selectedImageView release];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(5.0f, 5.0f, 34.0f,34.0f);
}
@end
