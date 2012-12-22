//
//  JHOTimelineTableCell.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOTimelineTableCell.h"
#import "JHOLocationLabelView.h"

@implementation JHOTimelineTableCell
@synthesize commentTableView;
@synthesize btnLike;
@synthesize btnComment;
@synthesize checkInSeparator;
@synthesize verticalUIView;

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
    [super dealloc];
}
- (UIView *)getCheckInImageView:(NSString *)pic
{
    UIImageView *checkInImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 223, 228)];
    [checkInImageView setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    UIView *imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 233, 233)];
    [imageContainerView setBackgroundColor:[UIColor whiteColor]];
    [imageContainerView addSubview:checkInImageView];

    [checkInImageView release];
    return [imageContainerView autorelease];
}

- (UIView *)getCheckInContentMsgView:(NSString *)msgContent
{
    UILabel *checkInDescriptionLabel = [[UILabel alloc] initWithFrame:(CGRectMake(5, 0, 223, 36))];
    checkInDescriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    checkInDescriptionLabel.numberOfLines = 0;
    checkInDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [checkInDescriptionLabel setTag:2000];
    CGSize constraint = CGSizeMake(223, 20000.0f);
    
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
            if([checkIn.isEncouraged intValue])
            {
                UIView *whoLikedMeUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 233, 44)];
                UILabel *whoLikedMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 233, 44)];
                whoLikedMeLabel.text = @"喵咪咪等10人赞过我";
                [whoLikedMeUIView addSubview:whoLikedMeLabel];
                [whoLikedMeLabel release];
                [viewArrays addObject:whoLikedMeUIView];
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
