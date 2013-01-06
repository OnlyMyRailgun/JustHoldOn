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
#import "JHOTimelineCategoryControl.h"
#import "JHOCustomizeHabitViewController.h"

@interface JHODetailHabitViewController ()

@end

@implementation JHODetailHabitViewController
@synthesize habitNameLabel;
@synthesize habitTagLabel;
@synthesize detailTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"习惯详情";
        
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 26)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"返回点击后"] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(1.0, 4, 0, 0.0)];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
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
        [test1 release];
        [test2 release];
        [test3 release];
        _dataSourceArray = [[NSMutableArray alloc] init];
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
    
    [detailTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]]];
    
    networkHelper.networkDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self showIndicator];
    NSDictionary *_dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", _habitModel.habitID, @"20", @"0", @"refresh", nil] forKeys:[NSArray arrayWithObjects:@"type", @"habitid", @"num", @"startpos", @"updateway", nil]];
    [networkHelper getCheckIns:_dic];
}

- (void)updateHabitModelWithHabit:(JHOHabitModel *)model
{
    _habitModel = model;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    habitNameLabel.text = _habitModel.habitName;
}

- (void)viewDidUnload
{
    [self setBtnShowDetailInstruction:nil];
    [self setBtnShowMyProgress:nil];
    [self setBtnShowFriendIn:nil];
    [self setDetailTableView:nil];
    [self setHabitNameLabel:nil];
    [self setHabitTagLabel:nil];
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
    if(_dataSourceArray)
    return _dataSourceArray.count;
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
    [cell updateCellHeightToCheckIn:[_dataSourceArray objectAtIndex:indexPath.row]];
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
    JHOTimelineCategoryControl *sectionHeader = [[JHOTimelineCategoryControl alloc] initWithFrame:CGRectMake(0, 0, 320, 37) titles:[NSArray arrayWithObjects:@"好友 (28)", @"全部 （1325）", nil]];
    
    return [sectionHeader autorelease];
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
    [_dataArray release];
    [habitNameLabel release];
    [habitTagLabel release];
    [_dataSourceArray release];
    [super dealloc];
}

- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{
    if(tag == NEGetCheckIns)
    {
        [_dataSourceArray removeAllObjects];
        [_dataSourceArray addObjectsFromArray:[networkHelper getCheckInsResult:result]];
        [detailTableView reloadData];
        [HUD hide:YES];
    }
}

- (IBAction)actionBtnPressed:(UIButton *)sender {
    JHOCustomizeHabitViewController *customHabit = [[JHOCustomizeHabitViewController alloc] initWithNibName:@"JHOCustomizeHabitViewController" bundle:nil];
    [customHabit updateHabitModelWithHabit:_habitModel];
    [self.navigationController pushViewController:customHabit animated:YES];
    [customHabit release];
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
