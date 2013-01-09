//
//  JHOMyFriendsViewController.h
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-15.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHOBaseWebViewController.h"

@interface JHOMyFriendsViewController : JHOBaseWebViewController<NetworkTaskDelegate>

@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (retain, nonatomic) IBOutlet UITableView *contentTableView;
@property (retain, nonatomic) IBOutlet UISearchBar *myFriendSearchBar;

@end
