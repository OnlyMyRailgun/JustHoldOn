//
//  JHODetailHabitViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12/18/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHODetailHabitViewController.h"
#import "JHOTimelineTableCell.h"
@interface JHODetailHabitViewController ()

@end

@implementation JHODetailHabitViewController
@synthesize detailTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailIdentifier = @"DetailHabitCommentCell";
    JHOTimelineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
    if(cell == nil)
    {
        cell = [[[UINib nibWithNibName:@"JHOTimelineTableCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];//[[[JHOTimelineTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIdentifier] autorelease];
    }
    //cell.textLabel.text = @"test";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
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
@end
