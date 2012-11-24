//
//  JHOBaseWebViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-24.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOBaseWebViewController.h"
#import "JHONetworkHelper.h"

@interface JHOBaseWebViewController ()

@end

@implementation JHOBaseWebViewController

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
	// Do any additional setup after loading the view.
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	
    if(networkDelegate)
        [networkDelegate initializeDelegateAndSoOn];
    
    networkHelper = [[JHONetworkHelper alloc] init];

    if(networkDelegate)
        [HUD showWhileExecuting:@selector(myTask) onTarget:networkDelegate withObject:nil animated:YES];
}

- (void)dealloc
{
    [networkHelper.formDataRequest cancel];
    [networkHelper.httpRequest cancel];
    [networkHelper release];
    
    [super dealloc];
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

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    NSDictionary *resultDic = [networkDelegate networkJob:networkHelper];
    if(resultDic != nil)
    {
        if([[resultDic objectForKey:@"status"] intValue] == 0)
        {
            [networkDelegate taskDidSuccess:[resultDic objectForKey:@"content"]];
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = [resultDic objectForKey:@"msg"];
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

#pragma mark -
#pragma mark - MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
@end
