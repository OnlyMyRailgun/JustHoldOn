//
//  JHOCustomizeHabitViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-21.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOCustomizeHabitViewController.h"
#import "JHOFilterControl.h"
#import "JHOPrivacySegmentedView.h"

@interface JHOCustomizeHabitViewController ()

@end

@implementation JHOCustomizeHabitViewController
@synthesize baseScrollView;
@synthesize privacySegmentedControl;

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
    JHOFilterControl *control = [[JHOFilterControl alloc] initWithFrame:CGRectMake(10, 146, 300, 38) titles:[NSArray arrayWithObjects:@"1天", @"2天", @"3天", @"4天", @"5天", @"6天", @"7天", nil]];
    [self.baseScrollView addSubview:control];
    [control release];
    
    JHOPrivacySegmentedView *segmentedView = [[JHOPrivacySegmentedView alloc] initWithFrame:CGRectMake(10, 309, 300, 27) titles:[NSArray arrayWithObjects:@"所有人", @"仅好友", @"仅自己", nil]];
    [self.baseScrollView addSubview:segmentedView];
    [segmentedView release];
    
    self.baseScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]];
}

- (void)viewDidUnload
{
    [self setPrivacySegmentedControl:nil];
    [self setBaseScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [privacySegmentedControl release];
    [baseScrollView release];
    [super dealloc];
}
@end
