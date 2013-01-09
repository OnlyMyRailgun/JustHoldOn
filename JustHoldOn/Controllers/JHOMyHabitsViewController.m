//
//  JHOMyHabitsViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-14.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOMyHabitsViewController.h"
#import "JHOTinyTools.h"
#import "JHOHabitListTableViewCell.h"
#import "JHODetailHabitViewController.h"
#import "JHOHabitModel.h"

@interface JHOMyHabitsViewController ()
@property (nonatomic, retain) NSMutableArray *dataSourceArray0;
@property (nonatomic, retain) NSMutableArray *dataSourceArray1;
@property (nonatomic, retain) NSMutableArray *dataSourceArray2;
@end

@implementation JHOMyHabitsViewController

#pragma mark - singleton default
static JHOMyHabitsViewController *sharedMyhabitsViewController = nil;

+ (JHOMyHabitsViewController *)shared
{
    if(sharedMyhabitsViewController == nil)
    {
        sharedMyhabitsViewController = [[JHOMyHabitsViewController alloc] init];
        sharedMyhabitsViewController.title = @"我的习惯";
    }
    return sharedMyhabitsViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
        UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 26)];
        [menuButton setBackgroundImage:[UIImage imageNamed:@"showsidemenu"] forState:UIControlStateNormal];
        UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = menuItem;
        [menuButton release];
        [menuItem release];
        
        _dataSourceArray0 = [[NSMutableArray alloc] init];
        _dataSourceArray1 = [[NSMutableArray alloc] init];
        _dataSourceArray2 = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *formDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"me", nil] forKeys:[NSArray arrayWithObjects:@"who", nil]];
    [self showIndicator];
    networkHelper.networkDelegate = self;
    [networkHelper getUserHabits:formDic];
}

- (void)viewDidUnload
{
    [self setMyHabitsTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_myHabitsTableView release];
    [_dataSourceArray0 release];
    [_dataSourceArray1 release];
    [_dataSourceArray2 release];
    [super dealloc];
}

- (void)actionBtnPressed:(NSString *)habitID
{
    //签到
    [self showIndicator];
    NSDictionary *_dic = [NSDictionary dictionaryWithObject:habitID forKey:@"habitid"];
    [networkHelper toCheckIn:_dic];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
        case 1:
            return _dataSourceArray0.count;
        case 2:
            return _dataSourceArray1.count;
        case 3:
            return _dataSourceArray2.count;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addNewHabitIdentifier = @"addNewHabitCell";
    static NSString *CustomCellIdentifier = @"myHabitsCustomCell";
    
//    JHOHabitListTableViewCell *cell;
    JHOHabitListTableViewCell *cell;
    if(indexPath == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:addNewHabitIdentifier];
    }
    else
        cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if(cell == nil)
    {
        if(indexPath.section == 0)
        {
            cell = [[[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addNewHabitIdentifier] autorelease];
        }
        else
        {
            cell = [[[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:addNewHabitIdentifier] autorelease];
        }
    }
    switch (indexPath.section) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:@"addnewhabit"]];
            cell.textLabel.text = @"添加新习惯";
            cell.accessoryView = nil;
            break;
        case 1:
        {
            JHOHabitModel *habitToDisplay = [_dataSourceArray0 objectAtIndex:indexPath.row];
            cell.textLabel.text = habitToDisplay.habitName;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"本周已签到:%d次", habitToDisplay.unitcheckinnum];
            [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row]]];
            cell.callback = self;
            cell.habitID = habitToDisplay.habitID;
            [cell setChecked:habitToDisplay.hasCheckedInToday];
        }
            break;
        case 2:
        {
            JHOHabitModel *habitToDisplay = [_dataSourceArray1 objectAtIndex:indexPath.row];
            cell.textLabel.text = habitToDisplay.habitName;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"本周已签到:%d次", habitToDisplay.unitcheckinnum];
            [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row]]];
            cell.accessoryView = nil;
        }
            break;
        case 3:
        {
            JHOHabitModel *habitToDisplay = [[_dataSourceArray2 objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
            cell.textLabel.text = habitToDisplay.habitName;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"本周已签到:%d次", habitToDisplay.unitcheckinnum];
            [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row]]];
            cell.accessoryView = nil;
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1)
    {
        JHODetailHabitViewController *viewController = [[JHODetailHabitViewController alloc] initWithNibName:@"JHODetailHabitViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentModalViewController:navController animated:YES];
        [viewController release];
        [navController release];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleForSection;
    switch (section) {
        case 0:
            titleForSection = nil;
            break;
        case 1:
            titleForSection = @"正在培养的习惯";
            break;
        case 2:
            titleForSection = @"正在巩固的习惯";
            break;
        case 3:
            titleForSection = @"已完成的习惯";
            break;
        default:
            titleForSection = nil;
            break;
    }
    return titleForSection;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *titleString = [self tableView:tableView titleForHeaderInSection:section];
    
    if (!titleString)
        return nil;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 28.0f)];
    imageView.image = [[UIImage imageNamed:@"myhabit_section"] stretchableImageWithLeftCapWidth:0.0f topCapHeight:0.0f];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(imageView.frame, 10.0f, 0.0f)];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithRed:88.0f/255.0f green:88.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
//    titleLabel.shadowColor = [UIColor colorWithRed:40.0f/255.0f green:45.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
//    titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleString;
    [imageView addSubview:titleLabel];
    [titleLabel release];
    
    return [imageView autorelease];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:tableView titleForHeaderInSection:section]) {
        return 28.0f;
    } else {
        return 0.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 60;
    else
        return 62;
}

#pragma mark - NetworkTaskDelegate
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{
    if(tag == NEGetUserHabits)
    {
        NSArray *resultArray = [networkHelper getUserHabitResult:result];
        [_dataSourceArray0 removeAllObjects];
        [_dataSourceArray0 addObjectsFromArray:[resultArray objectAtIndex:0]];
        [_dataSourceArray1 removeAllObjects];
        [_dataSourceArray1 addObjectsFromArray:[resultArray objectAtIndex:1]];
        [_dataSourceArray2 removeAllObjects];
        [_dataSourceArray2 addObjectsFromArray:[resultArray objectAtIndex:2]];
        [_myHabitsTableView reloadData];
        [HUD hide:YES];
    }
    else if (tag == NEToCheckIn)
    {
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"签到成功";
        [HUD hide:YES afterDelay:1.5];
    }
}

- (void)initializeDelegateAndSoOn
{
    
}
@end
