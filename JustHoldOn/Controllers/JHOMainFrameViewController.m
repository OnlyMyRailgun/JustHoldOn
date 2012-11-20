//
//  JHOMainFrameViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOMainFrameViewController.h"
#import "JHOSlideMenuViewController.h"
#import "JHOMyHomePageViewController.h"

@interface JHOMainFrameViewController ()

@end

@implementation JHOMainFrameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //中间View
        JHOMyHomePageViewController *homePageViewController = [[JHOMyHomePageViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
        self.centerController = navController;
        [homePageViewController release];
        [navController release];
        
        //左侧View
        JHOSlideMenuViewController *slideMenuViewController = [[JHOSlideMenuViewController alloc] initWithNibName:@"JHOSlideMenuViewController" bundle:nil];
        self.leftController = slideMenuViewController;
        [slideMenuViewController release];

        //properties
        self.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
        self.leftLedge = 86;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
