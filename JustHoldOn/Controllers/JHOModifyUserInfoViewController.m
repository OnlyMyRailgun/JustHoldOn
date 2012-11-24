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
#import "JHOTinyTools.h"

@interface JHOModifyUserInfoViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation JHOModifyUserInfoViewController
@synthesize avatar = _avatar;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize gender = _gender;
@synthesize userName = _userName;
- (void)viewDidLoad
{
    networkDelegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initializeDelegateAndSoOn
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Loading";
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(nextStepPressed)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBarBtn release];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvataPressed)];
    [_avatar addGestureRecognizer:singleTap];
    [singleTap release];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setAvatar:nil];
    [self setDescriptionTextView:nil];
    [self setGender:nil];
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
    [_gender release];
    [super dealloc];
}


- (void)changeAvataPressed
{
    UIActionSheet *changePhotoSheet = [[UIActionSheet alloc] initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选取", nil];
    [changePhotoSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [changePhotoSheet showInView:self.view.window];

    [changePhotoSheet release];
}

- (void)refreshMainThreadUI
{
    self.title = [JHOAppUserInfo shared].userName;
    _userName.text = [JHOAppUserInfo shared].userName;
    [_avatar setImage:[UIImage imageNamed:@"IMG_0022.JPG"]];
    _descriptionTextView.text = [JHOAppUserInfo shared].description;
    if([[JHOAppUserInfo shared].gender isEqualToString:@"m"])
        _gender.text = @"男";
    else if ([[JHOAppUserInfo shared].gender isEqualToString:@"f"])
        _gender.text = @"女";
}

- (void)nextStepPressed
{
    [_userName resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
    [JHOAppUserInfo shared].userName = self.userName.text;
    [JHOAppUserInfo shared].userDescription = self.descriptionTextView.text;
    if(!HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Loading";
    }
    [HUD showWhileExecuting:@selector(uploadMyInfo) onTarget:self withObject:nil animated:YES];
    [self showAlternativeTargets];
}

- (void)uploadMyInfo
{
    NSDictionary *resultDic = [networkHelper updateUserInfo];
    if(resultDic != nil)
    {
        if([[resultDic objectForKey:@"status"] isEqualToString:@"0"])
        {
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            
            // Set custom view mode
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = @"Completed";
            sleep(1);
            [[JHOAppUserInfo shared] saveToNSDefault];
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

- (void)showAlternativeTargets
{
    JHOAlternativeTargetsViewController *alternativeTargetsHelper = [[JHOAlternativeTargetsViewController alloc] initWithNibName:@"JHOAlternativeTargetsViewController" bundle:nil];
    [self.navigationController pushViewController:alternativeTargetsHelper animated:YES];
    [alternativeTargetsHelper release];
}

#pragma mark -
#pragma mark - NetworkTaskDelegate
- (NSDictionary *)networkJob:(JHONetworkHelper *)helper
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaWeiboAuthInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSLog(@"%@", [sinaWeiboAuthInfo objectForKey:@"AccessTokenKey"]);
    return [networkHelper registerWithWeiboAccessToken:[sinaWeiboAuthInfo objectForKey:@"AccessTokenKey"]];
    
}

- (void)taskDidSuccess:(NSDictionary *)result
{
    [[JHOAppUserInfo shared] modifyUserInfo:result];
    [self performSelectorOnMainThread:@selector(refreshMainThreadUI) withObject:nil waitUntilDone:NO];
}

#pragma mark -
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setAllowsEditing:YES];
    
    if(buttonIndex == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [self presentModalViewController:picker animated:YES];
        }
    }
    else if (buttonIndex == 1) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:picker animated:YES];
            
        }
    }
    [picker release];
}

#pragma mark -
#pragma mark - ImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSLog(@"found an image");
        UIImage *updateImage = [JHOTinyTools scaleFromImage:image toSize:CGSizeMake(200.0f, 200.0f)];
        [self.avatar setImage:updateImage];
        [JHOTinyTools saveAvatarPhoto:updateImage];
        [self uploadPhotoAfterPick];
    }
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

//In thread
- (void) uploadPhotoAfterPick
{
    [networkHelper uploadAvatarToServer];
}
@end
