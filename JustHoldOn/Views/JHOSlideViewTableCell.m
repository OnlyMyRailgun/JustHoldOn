//
//  JHOSlideViewTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOSlideViewTableCell.h"
@implementation JHOSlideViewTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        [background setImage:[[UIImage imageNamed:@"cell_background"] stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f]];
        UIImageView *detailMark = [[UIImageView alloc] initWithFrame:CGRectMake(246.0f, 18.0f, 11.0f, 15.0f)];
        [detailMark setImage:[UIImage imageNamed:@"slide_detail"]];
        [background addSubview:detailMark];
        [detailMark release];
        self.backgroundView = background;
        [background release];
        
        UIImageView *selectedBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        [selectedBackground setImage:[[UIImage imageNamed:@"cell_selected_background"] stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f]];
        self.selectedBackgroundView = selectedBackground;
        [selectedBackground release];
        
        self.textLabel.textColor = [UIColor colorWithRed:190.0f/255.0f green:197.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.shadowColor = [UIColor colorWithRed:33.0f/255.0f green:38.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
        self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
        
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 8.0f, 33.0f, 33.0f);
    
}

@end
