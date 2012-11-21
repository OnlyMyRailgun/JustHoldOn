//
//  JHOWeiboAuthorizationViewController.m
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/20/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOWeiboAuthorizationViewController.h"

@interface JHOWeiboAuthorizationViewController ()

@end

@implementation JHOWeiboAuthorizationViewController
@synthesize webview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        webView.delegate = self;
        
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
    [self setWebview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)load
{
}
- (void)dealloc {
    [webview release];
    [super dealloc];
}
@end
