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
#import "JHOHabitsListViewController.h"
#import "SinaWeibo.h"
#import "JHOAppUserInfo.h"
#import "JHOMyHabitsViewController.h"
#import "JHOTimelineMsgViewController.h"
#import "JHOMyFriendsViewController.h"

#define kAppKey             @"1481623116"
#define kAppSecret          @"308f792a8a1f7ca244da5c81d3a8798b"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface JHOMainFrameViewController ()

@end

@implementation JHOMainFrameViewController
@synthesize sinaweibo = _sinaweibo;
- (id)init
{
    if(self = [super init])
    {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMsg:) name:@"CenterControllerChanged" object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *appUserInfo = [defaults objectForKey:@"AppUserData"];
//        if ([appUserInfo objectForKey:@"uid"] && [appUserInfo objectForKey:@"password"])
//        {
            [self initializeViewControllers];
            [self changeCenterControllerAtIndex:1];
//        }
//        else
//        {
//            JHOLoginViewController *loginViewController = [[JHOLoginViewController alloc] init];
//            [self initializeSinaWeiboWithDelegate:loginViewController];
//            loginViewController.sinaWeibo = _sinaweibo;
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//            [loginViewController release];
//            self.centerController = nav;
//            [nav release];
//            self.leftController = nil;
//            self.rightController = nil;
//        }
        //properties
        self.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
        self.leftLedge = 52;
    }
    return self;
}

- (void)initializeViewControllers
{
    //左侧View
    if(self.leftController == nil)
    {
        JHOSlideMenuViewController *slideMenuViewController = [[JHOSlideMenuViewController alloc] initWithNibName:@"JHOSlideMenuViewController" bundle:nil];
        self.leftController = slideMenuViewController;
        [slideMenuViewController release];
    }
}

- (void)receiveMsg:(NSNotification*)param
{
    NSNumber *choosedIndex = param.object;
    [self changeCenterControllerAtIndex:choosedIndex.intValue];
    [self closeLeftView];
}

- (void)changeCenterControllerAtIndex:(NSInteger) index
{
    switch (index) {
        case 0:
        {
            [self closeLeftView];
            [[JHOAppUserInfo shared] removeUserInfo];
            JHOLoginViewController *loginViewController = [[JHOLoginViewController alloc] init];
            [self initializeSinaWeiboWithDelegate:loginViewController];
            loginViewController.sinaWeibo = _sinaweibo;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            [loginViewController.sinaWeibo logOut];
            [loginViewController release];
            self.centerController = nav;
            [nav release];
            self.leftController = nil;
            self.rightController = nil;
            break;
        }
        case 1:
        {
            JHOMyHabitsViewController *myHabitsViewController = [JHOMyHabitsViewController shared];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myHabitsViewController];
            self.centerController = nav;
            [nav release];
            break;
        }
        case 2:
        {
            JHOHabitsListViewController *habitsListViewController = [JHOHabitsListViewController shared];
            self.centerController = habitsListViewController;
            break;
        }
        case 3:
        {
            JHOMyFriendsViewController *myFriendsViewController = [[JHOMyFriendsViewController alloc] initWithNibName:@"JHOMyFriendsViewController" bundle:nil];
            self.centerController = myFriendsViewController;
            [myFriendsViewController release];
        }
            break;
        case 4:
        {
            JHOTimelineMsgViewController *timelineMsgViewController = [[JHOTimelineMsgViewController alloc] initWithNibName:@"JHOTimelineMsgViewController" bundle:nil];
            self.centerController = timelineMsgViewController;
            [timelineMsgViewController release];
        }
            break;
        case 5:
            break;
        default:
            break;
    }
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
