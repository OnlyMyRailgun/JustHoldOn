//
//  JHOHabitsListViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOHabitsListViewController.h"
#import "JHOHabitListTableViewCell.h"
#import "JHODetailHabitViewController.h"
#import "JHOHabitModel.h"
#import "JHOHabitCategoryTableView.h"

@interface JHOHabitsListViewController ()
{
    JHOHabitCategoryTableView *habitCategoryView;
}
@end

@implementation JHOHabitsListViewController

#pragma mark - singleton default
@synthesize habitsListTableView = _habitsListTableView;
static JHOHabitsListViewController *sharedHabitsListViewController = nil;

+ (JHOHabitsListViewController *)shared
{
    if(sharedHabitsListViewController == nil)
    {
        sharedHabitsListViewController = [[JHOHabitsListViewController alloc] initWithNibName:@"JHOHabitsListViewController" bundle:nil];
    }
    return sharedHabitsListViewController;
}

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
    
    habitCategoryView = [[JHOHabitCategoryTableView alloc] initWithFrame:CGRectMake(0, 260, 320, 200)];
    habitCategoryView.delegate = self;
    [habitCategoryView closeCategoryView];
    [self.view addSubview:habitCategoryView];
    [habitCategoryView release];
}

- (void)viewDidUnload
{
    [self setHabitsListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    networkHelper.networkDelegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JHODetailHabitViewController *detailHabit = [[JHODetailHabitViewController alloc] initWithNibName:@"JHODetailHabitViewController" bundle:nil];
    JHOHabitModel *modelToDisplay = [_dataSourceArray objectAtIndex:indexPath.row];
    [detailHabit updateHabitModelWithHabit:modelToDisplay];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailHabit];
    [detailHabit release];
    [self presentModalViewController:nav animated:YES];
    [nav release];
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
    
    static NSString *CellIdentifier = @"SystemHabitsCell";
        
    //    JHOHabitListTableViewCell *cell;
    JHOHabitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryView = nil;
    }
    JHOHabitModel *modelToDisplay = [_dataSourceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = modelToDisplay.habitName;
    cell.detailTextLabel.text = modelToDisplay.habitTag;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row%4]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}


- (void)dealloc {
    [_habitsListTableView release];
    [super dealloc];
}

#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [habitCategoryView closeCategoryView];
}

#pragma mark - NetworkTaskDelegate
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{
    if(tag == NEGetHabitGroup)
    {

    }
    else if(tag == NEGetHabitLib)
    {
        if(_dataSourceArray && _dataSourceArray.retainCount > 0)
            [_dataSourceArray release];
        _dataSourceArray = [[networkHelper getHabitLibResult:result] retain];
        [_habitsListTableView reloadData];
        [self hideIndicator];
    }
}
@end
