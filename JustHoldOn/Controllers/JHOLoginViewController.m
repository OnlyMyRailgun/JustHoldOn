//
//  JHOLoginViewController.m
//  JustHoldOn
//
//  Created by Asce on 11/19/12.
//  Copyright (c) 2012 Heartunderblade. All rights reserved.
//

#import "JHOLoginViewController.h"
#import "JHOMainFrameViewController.h"
#import "JHOAppDelegate.h"
#import "JHOModifyUserInfoViewController.h"

@interface JHOLoginViewController ()
{
}
@end

@implementation JHOLoginViewController
@synthesize sinaWeibo = _sinaWeibo;
@synthesize galleryScrollView;
@synthesize galleryPageControl;
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
    // Do any additional setup after loading the view from its nib.
    [galleryScrollView setBackgroundColor:[UIColor blackColor]];
    galleryScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    galleryScrollView.clipsToBounds = YES;     // default is NO, we want to restrict drawing within our scrollview
    
    //为scrollView添加手势
    //代码来源：http://stackoverflow.com/questions/5042194/how-to-detect-touch-on-uiimageview-inside-uiscrollview
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    singleTap.cancelsTouchesInView = NO;
    [galleryScrollView addGestureRecognizer:singleTap];
    
    //向scrollView中添加imageView
    NSUInteger i;
    for (i = 1; i <= 4; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"登陆页面.jpg"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        //设置frame
        CGRect rect = imageView.frame;
        rect.size.height = 400;
        rect.size.width = 320;
        imageView.frame = rect;
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [galleryScrollView addSubview:imageView];
        [imageView release];
    }
    
    [self layoutScrollImages1]; //设置图片格式
    
    //定义pageControl
    galleryPageControl.currentPage = 0;
    galleryPageControl.numberOfPages = 4;
}

- (void)viewDidUnload
{
    [self setGalleryScrollView:nil];
    [self setGalleryPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)dealloc
{
    [galleryScrollView release];
    [galleryPageControl release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)loginWithWeibo:(UIButton *)sender {
    if(self.sinaWeibo == nil)
        NSLog(@"nil");
    [self.sinaWeibo logIn];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{   
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _sinaWeibo.accessToken, @"AccessTokenKey",
                              _sinaWeibo.expirationDate, @"ExpirationDateKey",
                              _sinaWeibo.userID, @"UserIDKey",
                              _sinaWeibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", _sinaWeibo.userID, _sinaWeibo.accessToken, _sinaWeibo.expirationDate, _sinaWeibo.refreshToken);
    [self storeAuthData];
    JHOModifyUserInfoViewController *modifyHelper = [[JHOModifyUserInfoViewController alloc] initWithNibName:@"JHOModifyUserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:modifyHelper animated:YES];
    [modifyHelper release];
    //[self presentModalViewController:modifyHelper animated:YES];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}

//设置图片的格式
//代码来源：Apple官方例子Scrolling
- (void)layoutScrollImages1
{
    UIImageView *view = nil;
    NSArray *subviews = [galleryScrollView subviews];
    
    // reposition all image subviews in a horizontal serial fashion
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (320);
        }
    }
    
    // set the content size so it can be scrollable
    [galleryScrollView setContentSize:CGSizeMake((4 * 320), [galleryScrollView bounds].size.height)];
}


//UIScrollViewDelegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
        NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
        NSLog(@"%d",index);
        [galleryPageControl setCurrentPage:index];
}



//UIScrollView响应gesture的action
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:galleryScrollView];
    NSInteger index = touchPoint.x/320;
    NSLog(@"%d selected", index);
}
@end
