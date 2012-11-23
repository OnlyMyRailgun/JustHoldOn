//
//  JHOModifyUserInfoViewController.m
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/21/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOModifyUserInfoViewController.h"
#import "JHOAlternativeTargetsViewController.h"
#import "ASIFormDataRequest.h"
#import "JHONetworkHelper.h"
#import "JHOAppUserInfo.h"

@interface JHOModifyUserInfoViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation JHOModifyUserInfoViewController
@synthesize avatar = _avatar;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize userName = _userName;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Loading";
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(showAlternativeTargets)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBarBtn release];
}

- (void)viewDidAppear:(BOOL)animated
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setAvatar:nil];
    [self setDescriptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_userName release];
    [_avatar release];
    [_descriptionTextView release];
    [super dealloc];
}

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaWeiboAuthInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    JHONetworkHelper *helper = [[JHONetworkHelper alloc] init];
    NSLog(@"%@", [sinaWeiboAuthInfo objectForKey:@"AccessTokenKey"]);
    NSDictionary *userInfo = [helper registerWithWeiboWithRemoteToken:@"" andAccessToken:[sinaWeiboAuthInfo objectForKey:@"AccessTokenKey"]];
    [helper release];
    if(userInfo != nil)
    {
        if([[userInfo objectForKey:@"status"] isEqualToString:@"成功"])
        {
            [[JHOAppUserInfo shared] saveUserInfo:[userInfo objectForKey:@"content"]];
            if (![NSThread isMainThread]) {
                [self performSelectorOnMainThread:@selector(refreshMainThreadUI) withObject:nil waitUntilDone:NO];
            }
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = [userInfo objectForKey:@"msg"];
            HUD.margin = 10.f;
            HUD.yOffset = 150.f;
            
            sleep(2);
        }
    }
    else
    {       
        // Configure for text only and offset down
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"服务器连接异常";
        HUD.margin = 10.f;
        HUD.yOffset = 150.f;
        
        sleep(2);
    }
}

- (void)refreshMainThreadUI
{
    self.title = [JHOAppUserInfo shared].userName;
    self.userName.text = [JHOAppUserInfo shared].userName;
    [self.avatar setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    self.descriptionTextView.text = [JHOAppUserInfo shared].description;
}

- (void)showAlternativeTargets
{
    [JHOAppUserInfo shared].userName = self.userName.text;
    [JHOAppUserInfo shared].description = self.descriptionTextView.text;
    [[JHOAppUserInfo shared] saveToNSDefault];
    
    JHOAlternativeTargetsViewController *alternativeTargetsHelper = [[JHOAlternativeTargetsViewController alloc] initWithNibName:@"JHOAlternativeTargetsViewController" bundle:nil];
    [self.navigationController pushViewController:alternativeTargetsHelper animated:YES];
    [alternativeTargetsHelper release];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
@end
