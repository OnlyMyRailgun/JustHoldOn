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

@interface JHOMyHabitsViewController ()
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
    [super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return 4;
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
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"JHOHabitListTableViewCell" owner:self options:nil] lastObject];
        //cell.thumbImageView.image = nil;
        if(indexPath.section == 0)
        {
            cell = [[[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addNewHabitIdentifier] autorelease];
            [cell.imageView setImage:[UIImage imageNamed:@"addnewhabit"]];
            cell.textLabel.text = @"添加新习惯";
            //cell.checkInBtn.hidden = YES;
            cell.accessoryView = nil;
        }
        else
        {
            cell = [[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:addNewHabitIdentifier];
            [cell.imageView setImage:[UIImage imageNamed:@"addnewhabit"]];
            cell.textLabel.text = @"每天八杯水";
            cell.detailTextLabel.text = @"本周已签到:";
            [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row]]];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JHODetailHabitViewController *viewController = [[JHODetailHabitViewController alloc] initWithNibName:@"JHODetailHabitViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentModalViewController:navController animated:YES];
    [viewController release];
    [navController release];
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
- (void)networkJob:(JHONetworkHelper *)helper
{
    
}

- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{
    
}

- (void)taskDidFailed:(NSString *)failedReason
{
    
}

- (void)initializeDelegateAndSoOn
{
    
}
@end
