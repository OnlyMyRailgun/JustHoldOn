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
#import "JHOLoginViewController.h"
#import "SinaWeibo.h"


#define kAppKey             @"1481623116"
#define kAppSecret          @"308f792a8a1f7ca244da5c81d3a8798b"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface JHOMainFrameViewController ()

@end

@implementation JHOMainFrameViewController

- (id)init
{
    if(self = [super init])
    {
        // Custom initialization
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *appUserInfo = [defaults objectForKey:@"AppUserData"];
        if ([appUserInfo objectForKey:@"UserName"] && [appUserInfo objectForKey:@"UserPwd"])
        {
            [self initializeViewControllers];
        }
        else
        {
            JHOLoginViewController *loginViewController = [[JHOLoginViewController alloc] init];
            [self initializeSinaWeiboWithDelegate:loginViewController];
            loginViewController.sinaWeibo = _sinaweibo;
            if(loginViewController.sinaWeibo == nil)
                NSLog(@"MainFrame nil");
            self.centerController = loginViewController;
            self.leftController = nil;
            self.rightController = nil;
        }
    }
    return self;
}

- (void)initializeViewControllers
{
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


- (void)initializeSinaWeiboWithDelegate:(id)delegate
{
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
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

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [_sinaweibo handleOpenURL:url];
}

- (void)applicationDidBecomeActive
{
    [_sinaweibo applicationDidBecomeActive];
}
@end
