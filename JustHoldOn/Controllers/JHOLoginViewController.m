//
//  JHOLoginViewController.m
//  JustHoldOn
//
//  Created by Asce on 11/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOLoginViewController.h"

@interface JHOLoginViewController ()

@end

@implementation JHOLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _weiboSignIn = [[WeiboSignIn alloc] init];
        _weiboSignIn.delegate = self;
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

- (void)dealloc
{
    [_weiboSignIn release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)finishedWithAuth:(WeiboAuthentication *)auth error:(NSError *)error {
    if (error) {
        NSLog(@"failed to auth: %@", error);
    }
    else {
        NSLog(@"Success to auth: %@", auth.userId);
        [[WeiboAccounts shared] addAccountWithAuthentication:auth];
        WeiboAccount *account = [[[WeiboAccounts shared] accounts] objectAtIndex:0];
        JHOModifyUserInfoViewController *modifyHelper = [[JHOModifyUserInfoViewController alloc] initWithWeiboAccount:account];
        [self.navigationController pushViewController:modifyHelper animated:YES];
        [modifyHelper release];
    }
}

- (IBAction)loginWithWeibo:(UIButton *)sender {
    [_weiboSignIn signInOnViewController:self];
}

@end
