//
//  JHOMsgFlowTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-16.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOMsgFlowTableCell.h"

@implementation JHOMsgFlowTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) init{
    [super init];
    
    if(self){
        self.backgroundColor = [UIColor lightGrayColor];
        
        _msgPublisherAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        
        _lb_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5 + height * 0 + middle_height * 0, 45, height )];
        _lb_title.backgroundColor = bgcolor;
        _lb_title.text = @"标题:";
        
        _lb_date = [[UILabel alloc] initWithFrame:CGRectMake(20, 5 + height * 1 + middle_height * 1, 45, height )];
        _lb_date.backgroundColor = bgcolor;
        _lb_date.text = @"时间:";
        
        _lb_points = [[UILabel alloc] initWithFrame:CGRectMake(20, 5 + height * 2+ middle_height * 2, 45, height)];
        _lb_points.backgroundColor = bgcolor;
        _lb_points.text = @"路标:";
        
        _lb_title_content = [[UILabel alloc] initWithFrame:CGRectMake(70, 5 + height * 0 + middle_height * 0, 240, height)];
        _lb_title_content.backgroundColor = bgcolor;
        _lb_title_content.text = @"--------------";
        
        _lb_date_content = [[UILabel alloc] initWithFrame:CGRectMake(70, 5 + height * 1 + middle_height * 1, 240, height)];
        _lb_date_content.backgroundColor = bgcolor;
        _lb_date_content.text = @"--------------";
        
        _lb_points_content = [[UILabel alloc] initWithFrame:CGRectMake(70, 5 + height * 2 + middle_height * 2, 240, height )];
        _lb_points_content.backgroundColor = bgcolor;
        _lb_points_content.text = @"--------------";
        
        
        
        [self addSubview:_lb_title];
        [self addSubview:_lb_points];
        [self addSubview:_lb_date];
        
        [self addSubview:_lb_title_content];
        [self addSubview:_lb_date_content];
        [self addSubview:_lb_points_content];
    }
    return  self ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
