//
//  JHOAppDelegate.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOAppDelegate.h"
#import "JHOLoginViewController.h"
#import "JHOMainFrameViewController.h"
#import "ASIDownloadCache.h"
#import "SinaWeibo.h"

#define kAppKey             @"1481623116"
#define kAppSecret          @"308f792a8a1f7ca244da5c81d3a8798b"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"
#define OperationQueue_Max 6

@implementation JHOAppDelegate

@synthesize window = _window;
@synthesize downloadCache = _downloadCache;
@synthesize globalDeviceToken = _globalDeviceToken;
@synthesize viewDeck = _viewDeck;
@synthesize theOperationQueue = _theOperationQueue;
- (void)dealloc
{
    [_downloadCache release];
    [_globalDeviceToken release];
    [_viewDeck release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    _viewDeck= [[JHOMainFrameViewController alloc] init];
    self.window.rootViewController = _viewDeck;

    //设置队列
    NSOperationQueue *_queue = [[NSOperationQueue alloc] init];
	[_queue setMaxConcurrentOperationCount:OperationQueue_Max];
	self.theOperationQueue = _queue;
	[_queue release];

    //设置缓存策略
    [self setupDownloadCacheStrategy];
    
    // Let the device know we want to recieve push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupDownloadCacheStrategy
{
    //初始化ASIDownloadCache缓存对象
    
    ASIDownloadCache *cache = [[ASIDownloadCache alloc] init];
    
    self.downloadCache = cache;
    
    [cache release];
    
    
    
    //路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    
    //设置缓存存放路径
    
    [self.downloadCache setStoragePath:[documentDirectory stringByAppendingPathComponent:@"tmp"]];
    
    //设置缓存策略
    
    [self.downloadCache setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
}

- (void)createIndicator
{
	if(HUD != nil)
		return;
	
	HUD = [[MBProgressHUD alloc] initWithView: _window];
    HUD.delegate = self;
	HUD.labelText = @"正在载入";
	[_window addSubview:HUD];
}

- (void)showIndicator
{
	[self createIndicator];
	
	[_window bringSubviewToFront:HUD];
	HUD.labelText = @"正在载入...";
	[HUD show:YES];
}

- (void)hideIndicatorAfterDelay:(int)delay withStr:(NSString *)str
{
    if(str)
    {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = str;
    }
    [HUD hide:YES afterDelay:delay];
}
#pragma mark -
#pragma mark - MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.viewDeck applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.viewDeck handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.viewDeck handleOpenURL:url];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    self.globalDeviceToken = [[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"recieved remoteNotification:%@",userInfo);
    UIAlertView *reciecedNotification = [[UIAlertView alloc] initWithTitle:@"推送通知" message:[NSString stringWithFormat:@"%@", userInfo] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    if(![reciecedNotification isVisible])
    {
        [reciecedNotification show];
    }
    [reciecedNotification release];
}
@end
