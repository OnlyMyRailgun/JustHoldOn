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

@interface JHOMyHabitsViewController ()
@property (retain, nonatomic) NSDate *date;
@end

@implementation JHOMyHabitsViewController
@synthesize dateLabel;
@synthesize myHabitsTableView;

#pragma mark - singleton default
static JHOMyHabitsViewController *sharedMyhabitsViewController = nil;

+ (JHOMyHabitsViewController *)shared
{
    if(sharedMyhabitsViewController == nil)
    {
        sharedMyhabitsViewController = [[JHOMyHabitsViewController alloc] init];
    }
    return sharedMyhabitsViewController;
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
    // Do any additional setup after loading the view from its nib.
    _date = [[NSDate alloc] init];
    [self refreshDateLabel:_date];
}

- (void)viewDidUnload
{
    [self setDateLabel:nil];
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
    [dateLabel release];
    [myHabitsTableView release];
    [super dealloc];
}

- (void)refreshDateLabel:(NSDate *)toConvertDate
{
    NSMutableString *dateLabelStr = [NSMutableString string];
    NSString *toConvertDateStr = [JHOTinyTools stringFromDate:toConvertDate];
    NSString *currentDateStr = [JHOTinyTools stringFromDate:[NSDate date]];
    if([toConvertDateStr isEqualToString:currentDateStr])
        [dateLabelStr appendString:@"TODAY  "];
    [dateLabelStr appendString:toConvertDateStr];
    dateLabel.text = dateLabelStr;
}

- (IBAction)backwardDateBtnPressed:(UIButton *)sender {
    NSDate *currentDate = [[NSDate alloc] initWithTimeInterval:(-60*60*24) sinceDate:_date];
    [_date release];
    _date = currentDate;
    [self refreshDateLabel:currentDate];
}

- (IBAction)forwardDateBtnPressed:(UIButton *)sender {
    NSDate *currentDate = [[NSDate alloc] initWithTimeInterval:(60*60*24) sinceDate:_date];
    [_date release];
    _date = currentDate;
    [self refreshDateLabel:currentDate];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"myHabitsCustomCell";
    
    JHOHabitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JHOHabitListTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
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
