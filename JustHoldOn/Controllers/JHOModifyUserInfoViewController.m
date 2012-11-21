//
//  JHOModifyUserInfoViewController.m
//  JustHoldOn
//
//  Created by Kissshot_Acerolaorion_Heartunderblade on 11/21/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOModifyUserInfoViewController.h"

@interface JHOModifyUserInfoViewController ()
{
    WeiboAccount *userAccount;
}
@end

@implementation JHOModifyUserInfoViewController
@synthesize avatar;
@synthesize userName;

- (id) initWithWeiboAccount:(WeiboAccount *)account 
{
    self = [super init];
    if(self){
        // Custom initialization
        userAccount = account;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.title = userAccount.screenName; 
    self.userName.text = userAccount.screenName;
    NSData *avatarData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userAccount.profileImageUrl]];
    UIImage *imageAvatar = [UIImage imageWithData:avatarData];
    [self.avatar setImage:imageAvatar];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setAvatar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [userName release];
    [avatar release];
    [super dealloc];
}
@end
