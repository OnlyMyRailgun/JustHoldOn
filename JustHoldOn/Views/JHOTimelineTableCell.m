//
//  JHOTimelineTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOTimelineTableCell.h"
#import "JHOLocationLabelView.h"
#import "JHOTinyTools.h"

#define TLC_WIDTH 235
@implementation JHOTimelineTableCell
@synthesize commentTableView;
@synthesize btnLike;
@synthesize btnComment;
@synthesize checkInSeparator;
@synthesize verticalUIView;
@synthesize checkInPublisherLabel;
@synthesize checkInPublishTimeLabel;

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
    [commentTableView release];
    [checkInSeparator release];
    [verticalUIView release];
    [checkInPublisherLabel release];
    [checkInPublishTimeLabel release];
    [super dealloc];
}

- (UIView *)getCheckInImageView:(NSString *)pic
{
    UIImageView *checkInImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, TLC_WIDTH - 10, 228)];
    [checkInImageView setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    UIView *imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TLC_WIDTH, TLC_WIDTH)];
    [imageContainerView setBackgroundColor:[UIColor whiteColor]];
    [imageContainerView addSubview:checkInImageView];

    [checkInImageView release];
    return [imageContainerView autorelease];
}

- (UIView *)getCheckInContentMsgView:(NSString *)msgContent
{
    UILabel *checkInDescriptionLabel = [[UILabel alloc] initWithFrame:(CGRectMake(5, 0, TLC_WIDTH - 10, 36))];
    checkInDescriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    checkInDescriptionLabel.numberOfLines = 0;
    checkInDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [checkInDescriptionLabel setTag:2000];
    CGSize constraint = CGSizeMake(TLC_WIDTH - 10, 20000.0f);
    
    CGSize size = [msgContent sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    CGRect labelFrame = checkInDescriptionLabel.frame;
    labelFrame.size.height = height;
    checkInDescriptionLabel.frame = labelFrame;
    checkInDescriptionLabel.text = msgContent;
    
    CGRect containerFrame = checkInDescriptionLabel.frame;
    containerFrame.origin.x = 0;
    containerFrame.size.width += 10;
    UIView *labelContainerView = [[UIView alloc] initWithFrame:containerFrame];
    [labelContainerView setBackgroundColor:[UIColor whiteColor]];
    [labelContainerView addSubview:checkInDescriptionLabel];
    [checkInDescriptionLabel release];
    
    return [labelContainerView autorelease];
}

- (void)updateCellHeightToCheckIn:(JHOCheckIn *)checkIn
{
    checkInPublisherLabel.text = checkIn.ownerName;
    checkInPublishTimeLabel.text = [JHOTinyTools caculatePublishTimeWithInterval:[checkIn.dateLine doubleValue]/1000];
    NSMutableArray *viewArrays = [NSMutableArray array];
    switch ([checkIn.msgType intValue]) {
        case TMCheckIn:
            if(![checkIn.picURL isEqualToString:@""])
            {
                [viewArrays addObject:[self getCheckInImageView:checkIn.picURL]];
            }
            if(![checkIn.checkInDescription isEqualToString:@""])
            {
                //NSString *text = @"人体需要足够的水份补充，以维持整个生理机能正常。";
                [viewArrays addObject:[self getCheckInContentMsgView:checkIn.checkInDescription]];
            }
            if(checkIn.location)
            {
                UIView *locationLabel = [[[UINib nibWithNibName:@"JHOLocationLabelView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                [viewArrays addObject:locationLabel];
            }
            if(checkIn.encourageNum)
            {
                int avatarOffset = 5;
                int encourageCount = checkIn.encourageNum;
                UIView *whoLikedMeUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TLC_WIDTH, 62)];
                whoLikedMeUIView.backgroundColor = [UIColor colorWithRed:238.0/255 green:232.0/255 blue:228.0/255 alpha:1.0];
                UILabel *whoLikedMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarOffset, 0, 226, 25)];
                whoLikedMeLabel.backgroundColor = [UIColor clearColor];
                whoLikedMeLabel.font = [UIFont systemFontOfSize:15];
                whoLikedMeLabel.text = [NSString stringWithFormat:@"Mika等%d人赞过我", encourageCount];
                [whoLikedMeUIView addSubview:whoLikedMeLabel];
                [whoLikedMeLabel release];

                for(int i = 0; i < encourageCount && i < 6;i++)
                {
                    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(i*30 + avatarOffset*(i+1), 26, 30, 30)];
                    [avatar setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
                    [whoLikedMeUIView addSubview:avatar];
                    [avatar release];
                }
                UIImageView *showMore = [[UIImageView alloc] initWithFrame:CGRectMake(217, 37, 10, 11)];
                [showMore setImage:[UIImage imageNamed:@"赞more"]];
                [whoLikedMeUIView addSubview:showMore];
                [showMore release];
                
                [viewArrays addObject:whoLikedMeUIView];
                [whoLikedMeUIView release];
                
            }
            if(checkIn.commentNum > 0)
            {
                //UIView
                int commentViewHeight = (checkIn.commentNum > 2)?98:64;
                UIView *commentContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TLC_WIDTH, commentViewHeight)];
                commentContainer.backgroundColor = [UIColor colorWithRed:238.0/255 green:232.0/255 blue:228.0/255 alpha:1.0];
                //分割线
                UIImageView *upperCommentSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TLC_WIDTH, 2)];
                [upperCommentSeparator setImage:[UIImage imageNamed:@"评论，赞分隔线"]];
                [commentContainer addSubview:upperCommentSeparator];
                [upperCommentSeparator release];
                //至多两条最新的评论
                int avatarOffset = 5;
                for(int i = 0; i < checkIn.commentNum && i < 2; i++)
                {
                    UIImageView *commentAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(avatarOffset, 5*(i+1)+2+i*30, 30, 30)];
                    [commentAvatar setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
                    [commentContainer addSubview:commentAvatar];
                    [commentAvatar release];
                    
                    UILabel *commentUserName = [[UILabel alloc] initWithFrame:CGRectMake(43, 5*(i+1)+2+i*30, 130, 16)];
                    commentUserName.text = @"Chantilly";
                    commentUserName.backgroundColor = [UIColor clearColor];
                    commentUserName.font = [UIFont systemFontOfSize:15];
                    [commentContainer addSubview:commentUserName];
                    [commentUserName release];
                    
                    UILabel *commentMsg = [[UILabel alloc] initWithFrame:CGRectMake(43, 5*(i+1)+2+i*30+16, TLC_WIDTH - 43, 14)];
                    commentMsg.text = @"好样的!";
                    commentMsg.backgroundColor = [UIColor clearColor];
                    commentMsg.textColor = [UIColor colorWithRed:73.0/255 green:72.0/255 blue:68.0/255 alpha:1.0f];
                    commentMsg.font = [UIFont systemFontOfSize:14];
                    [commentContainer addSubview:commentMsg];
                    [commentMsg release];
                }
                //分割线
                UIImageView *lowerCommentSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, commentViewHeight - 20, TLC_WIDTH, 2)];
                [lowerCommentSeparator setImage:[UIImage imageNamed:@"评论，赞分隔线"]];
                [commentContainer addSubview:lowerCommentSeparator];
                [lowerCommentSeparator release];
                //查看所有评论
                UILabel *showAllComment = [[UILabel alloc] initWithFrame:CGRectMake(avatarOffset, commentViewHeight - 18, TLC_WIDTH, 18)];
                showAllComment.backgroundColor = [UIColor clearColor];
                showAllComment.font = [UIFont systemFontOfSize:12];
                showAllComment.textColor = [UIColor colorWithRed:73.0/255 green:72.0/255 blue:68.0/255 alpha:1.0f];
                showAllComment.text = [NSString stringWithFormat:@"查看所有%d条评论", checkIn.commentNum];
                [commentContainer addSubview:showAllComment];
                [showAllComment release];
                
                [viewArrays addObject:commentContainer];
                [commentContainer release];
            }
            break;
        case TMJOIN:
        {
            [viewArrays addObject:[self getCheckInContentMsgView:checkIn.checkInDescription]];
            if(!checkIn.location)
            {
                UIView *locationLabel = [[[UINib nibWithNibName:@"JHOLocationLabelView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                [viewArrays addObject:locationLabel];
            }
        }
            break;
        case TMComplete:
            break;
        default:
            break;
    }
    _allViewsArray = [[NSArray alloc] initWithArray: viewArrays];
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    [commentTableView reloadData];
    
    CGRect cellFrame = self.frame;
    cellFrame.size.height -= 358;
    cellFrame.size.height += commentTableView.contentSize.height;
    self.frame = cellFrame;
    
    CGRect separatorFrame = checkInSeparator.frame;
    separatorFrame.origin.y = self.frame.size.height - 2;
    checkInSeparator.frame = separatorFrame;
    
    CGRect verticalUIViewFrame = verticalUIView.frame;
    verticalUIViewFrame.size.height = separatorFrame.origin.y;
    verticalUIView.frame = verticalUIViewFrame;
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allViewsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    if(_allViewsArray != nil)
    {
        [cell.contentView addSubview:[_allViewsArray objectAtIndex:indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_allViewsArray != nil)
    return [(UIView *)[_allViewsArray objectAtIndex:indexPath.row] frame].size.height;
    else return 0;
}
@end
