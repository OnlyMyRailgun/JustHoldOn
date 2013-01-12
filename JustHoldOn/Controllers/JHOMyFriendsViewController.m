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
@synthesize myFriendSearchBar;
@synthesize navBar;

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
    UIButton *addMoreFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 27)];
    [addMoreFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    [addMoreFriendBtn setBackgroundImage:[UIImage imageNamed:@"添加好友、修改资料按钮"] forState:UIControlStateNormal];
    [addMoreFriendBtn setBackgroundImage:[UIImage imageNamed:@"添加好友、修改资料按钮点击后"] forState:UIControlStateHighlighted];
    [addMoreFriendBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    UIBarButtonItem *addMoreFriend = [[UIBarButtonItem alloc] initWithCustomView:addMoreFriendBtn];
    [addMoreFriendBtn release];
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 26)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"showsidemenu"] forState:UIControlStateNormal];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"我的好友"];
    navItem.leftBarButtonItem = menuItem;
    navItem.rightBarButtonItem = addMoreFriend;
    [navBar popNavigationItemAnimated:NO];
    [navBar pushNavigationItem:navItem animated:NO];
    [addMoreFriend release];
    [menuButton release];
    [menuItem release];
    [navItem release];
}

- (void)viewDidUnload
{
    [self setContentTableView:nil];
    [self setMyFriendSearchBar:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self showIndicator];
//    networkHelper.networkDelegate = self;
//    NSDictionary *_dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[JHOAppUserInfo shared].userID, [NSNumber numberWithInt:0], @"20", nil] forKeys:[NSArray arrayWithObjects:@"who", @"starpos", @"maxnum", nil]];
//    [networkHelper getUserFriends:_dic];
    _dataSourceArray = [[NSMutableArray alloc] init];
    JHOUserModel *test1 = [[JHOUserModel alloc] init];
    test1.userName = @"hello moto";
    test1.habitNum = 6;
    
    JHOUserModel *test2 = [[JHOUserModel alloc] init];
    test2.userName = @"nokia";
    test2.habitNum = 2;
    
    JHOUserModel *test3 = [[JHOUserModel alloc] init];
    test3.userName = @"sony";
    test3.habitNum = 5;
    
    [_dataSourceArray addObject:test1];
    [_dataSourceArray addObject:test2];
    [_dataSourceArray addObject:test3];
    
    [test1 release];
    [test2 release];
    [test3 release];
    [contentTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [contentTableView release];
    [_dataSourceArray release];
    [myFriendSearchBar release];
    [navBar release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataSourceArray)
        return _dataSourceArray.count*3;
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
    JHOUserModel *modelToDisplay = [_dataSourceArray objectAtIndex:indexPath.row%_dataSourceArray.count];
    [cell updateCellWithUser:modelToDisplay];
    [cell.imageView setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
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
        [self hideIndicator];
    }
}
@end
