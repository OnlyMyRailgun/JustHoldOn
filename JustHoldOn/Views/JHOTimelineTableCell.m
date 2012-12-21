//
//  JHOTimelineTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOTimelineTableCell.h"

@implementation JHOTimelineTableCell
@synthesize commentTableView;
@synthesize habitInstructionLabel;
@synthesize locationUIView;
@synthesize btnLike;
@synthesize btnComment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]];
    [btnLike setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0, 0.0)];
    [btnLike setImageEdgeInsets:UIEdgeInsetsMake(6.0, 8.0, 2.0, 31.0)];

    [btnComment setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -17, 0, 0.0)];
    [btnComment setImageEdgeInsets:UIEdgeInsetsMake(6.0, 6.0, 4.0, 33.0)];
    
}

- (void)dealloc {
    [btnLike release];
    [btnComment release];
    [habitInstructionLabel release];
    [locationUIView release];
    [commentTableView release];
    [super dealloc];
}

- (void)updateCellHeightToCheckIn:(JHOCheckIn *)checkIn
{
//    NSMutableArray *viewArrays = [NSMutableArray array];
//    switch ([checkIn.msgType intValue]) {
//        case TMCheckIn:
//            if(![checkIn.picURL isEqualToString:@""])
//            {
//                UIImageView *checkInImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
//                [checkInImageView setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
//                [viewArrays addObject:checkInImageView];
//                [checkInImageView release];
//            }
//            if(![checkIn.checkInDescription isEqualToString:@""])
//            {
//                //NSString *text = @"人体需要足够的水份补充，以维持整个生理机能正常。";
//                UILabel *checkInDescriptionLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 224, 36))];
//                CGSize constraint = CGSizeMake(224 - (5 * 2), 20000.0f);
//                
//                CGSize size = [checkIn.checkInDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//                
//                CGFloat height = MAX(size.height, 44.0f);
//                CGRect labelFrame = checkInDescriptionLabel.frame;
//                labelFrame.size.height = height;
//                checkInDescriptionLabel.frame = labelFrame;
//                [viewArrays addObject:checkInDescriptionLabel];
//            }
//            if(!checkIn.location)
//            {
//                [viewArrays addObject:locationUIView];
//            }
//            if(checkIn.commentNum > 0)
//            {
//                UIView *whoLikedMeUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 233, 44)];
//                UILabel *whoLikedMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 233, 44)];
//                whoLikedMeLabel.text = @"喵咪咪等10人赞过我";
//                [whoLikedMeUIView addSubview:whoLikedMeLabel];
//            }
//            break;
//        case TMJOIN:
//        {
//            UILabel *checkInDescriptionLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 224, 36))];
//            CGSize constraint = CGSizeMake(224 - (5 * 2), 20000.0f);
//            
//            CGSize size = [checkIn.checkInDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//            
//            CGFloat height = MAX(size.height, 44.0f);
//            CGRect labelFrame = checkInDescriptionLabel.frame;
//            labelFrame.size.height = height;
//            checkInDescriptionLabel.frame = labelFrame;
//            [viewArrays addObject:checkInDescriptionLabel];
//            if(!checkIn.location)
//            {
//                [viewArrays addObject:locationUIView];
//            }
//        }
//            break;
//        case TMComplete:
//            break;
//        default:
//            break;
//    }
//    _allViewsArray = viewArrays;
//    [commentTableView reloadData];
}

#pragma mark - UITableViewDatasource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if(_allViewsArray != nil)
//    return [_allViewsArray count];
//    else return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
//    if(_allViewsArray != nil)
//    [cell.contentView addSubview:[_allViewsArray objectAtIndex:indexPath.row]];
//    return cell;
//}
//
//#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(_allViewsArray != nil)
//    return [(UIView *)[_allViewsArray objectAtIndex:indexPath.row] frame].size.height;
//    else return 0;
//}
@end
