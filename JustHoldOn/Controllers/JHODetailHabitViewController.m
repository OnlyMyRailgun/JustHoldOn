//
//  JHODetailHabitViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/18/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHODetailHabitViewController.h"
#import "JHOTimelineTableCell.h"
#import "JHOCheckIn.h"
@interface JHODetailHabitViewController ()

@end

@implementation JHODetailHabitViewController
@synthesize detailTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"习惯详情";
        
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 26)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(1.0, 4, 0, 0.0)];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        //    [backButton setTitle:@"返回" forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
        [backButton release];
        [backItem release];

        JHOCheckIn *test1 = [[JHOCheckIn alloc] init];
        test1.msgType = [NSString stringWithFormat:@"%d", TMCheckIn];
        test1.picURL = @"11";
        test1.checkInDescription = @"When I was darkness at that time, 震えてる唇 ,furueteru kuchibiru, 颤动的双唇 ,部屋の片隅で I cry, heyanokatasumide   I cry, 我在房间的角落里哭泣";
        test1.location = @"heyanokatasumide";
        
        JHOCheckIn *test2 = [[JHOCheckIn alloc] init];
        test2.msgType = [NSString stringWithFormat:@"%d", TMCheckIn];
        test2.picURL = @"11";
        test2.checkInDescription = @"When I was darkness at that time, 震えてる唇 ,furueteru kuchibiru, 颤动的双唇 ,部屋の片隅で I cry";
        test2.location = @"heyanokatasumide";
        
        JHOCheckIn *test3 = [[JHOCheckIn alloc] init];
        test3.msgType = [NSString stringWithFormat:@"%d", TMJOIN];
        test3.checkInDescription = @"When I was darkness at that time, 震えてる唇";
        test3.location = @"heyanokatasumide";
        
        _dataArray = [[NSArray alloc] initWithObjects:test1, test2, test3, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    _btnShowDetailInstruction.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _btnShowDetailInstruction.titleLabel.numberOfLines = 2;
    _btnShowMyProgress.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _btnShowMyProgress.titleLabel.numberOfLines = 2;
    _btnShowFriendIn.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _btnShowFriendIn.titleLabel.numberOfLines = 2;
}

- (void)viewDidUnload
{
    [self setBtnShowDetailInstruction:nil];
    [self setBtnShowMyProgress:nil];
    [self setBtnShowFriendIn:nil];
    [self setDetailTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataArray)
    return 20;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailIdentifier = @"DetailHabitCommentCell";
    JHOTimelineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
    if(cell == nil)
    {
        cell = [[[UINib nibWithNibName:@"JHOTimelineTableCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    }
    [cell updateCellHeightToCheckIn:[_dataArray objectAtIndex:indexPath.row%3]];
    //cell.textLabel.text = @"test";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
    [backgroundImageView setImage:[UIImage imageNamed:@"detailhabit_testLabel"]];
    [headerView addSubview:backgroundImageView];
    [backgroundImageView release];
    
    return [headerView autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [_btnShowDetailInstruction release];
    [_btnShowMyProgress release];
    [_btnShowFriendIn release];
    [detailTableView release];
    [super dealloc];
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
