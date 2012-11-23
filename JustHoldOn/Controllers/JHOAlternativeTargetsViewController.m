//
//  JHOAlternativeTargetsViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOAlternativeTargetsViewController.h"
#import "JHOMainFrameViewController.h"

@interface JHOAlternativeTargetsViewController ()

@end

@implementation JHOAlternativeTargetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"目标";
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(showMainFrameHabits)];
        self.navigationItem.rightBarButtonItem = rightBarBtn;
        [rightBarBtn release];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showMainFrameHabits
{
    JHOMainFrameViewController *viewDeck = (JHOMainFrameViewController *)self.viewDeckController;
    [viewDeck initializeViewControllers];
    [viewDeck changeCenterControllerAtIndex:1];
}
@end
