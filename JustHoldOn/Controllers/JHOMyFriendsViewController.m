//
//  JHOMyFriendsViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-15.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOMyFriendsViewController.h"
#import "JHOUserModel.h"
#import "JHOFriendListTableViewCell.h"

@interface JHOMyFriendsViewController ()

@end

@implementation JHOMyFriendsViewController
@synthesize contentTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的好友";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setContentTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self showIndicator];
    networkHelper.networkDelegate = self;
    NSDictionary *_dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[JHOAppUserInfo shared].userID, [NSNumber numberWithInt:0], @"20", nil] forKeys:[NSArray arrayWithObjects:@"who", @"starpos", @"maxnum", nil]];
    [networkHelper getUserFriends:_dic];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [contentTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataSourceArray)
        return _dataSourceArray.count;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FriendsTableCell";
    
    //    JHOHabitListTableViewCell *cell;
    JHOFriendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[JHOFriendListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryView = nil;
    }
    JHOUserModel *modelToDisplay = [_dataSourceArray objectAtIndex:indexPath.row];
    [cell updateCellWithUser:modelToDisplay];
    [cell.imageView setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

#pragma mark - NetworkTaskDelegate
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{
    if(tag == NEGetUserFriends)
    {
        if(_dataSourceArray && _dataSourceArray.retainCount > 0)
            [_dataSourceArray release];
        _dataSourceArray = [[networkHelper getUserFriendsResult:result] retain];
        [contentTableView reloadData];
        [HUD hide:YES];
    }
}
@end
