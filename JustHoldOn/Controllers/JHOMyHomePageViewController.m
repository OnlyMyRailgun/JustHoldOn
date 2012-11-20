//
//  JHOMyHomePageViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-18.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOMyHomePageViewController.h"

@interface JHOMyHomePageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation JHOMyHomePageViewController

@synthesize table, bgImgView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个人主页";
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x3B5998);
    // 设置table的背景，但是不属于table的subView
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -150, self.view.frame.size.width, 500)];
    bgImgView.image = [UIImage imageNamed:@"homepagebackground"];
    [self.view addSubview:bgImgView];
    
    table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    // path中用于显示刷新按钮+圆形头像+时间那部分，也可以将其作为table的cell
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.text = @"";
    header.textColor = [UIColor whiteColor];
    header.backgroundColor = [UIColor clearColor];
    table.tableHeaderView = header;
    [header release];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - Scroll view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect frame = bgImgView.frame;
    CGFloat factor;
    if (offset.y < 0) {
        // 关键在于判断如果是在table的顶部向下拉动，修改bgImgView的frame使其跟随table一起移动，只不过移动比table慢（到底多慢由你定）
        factor = 0.45;
    } else {
        factor = 1;
    }
    frame.origin.y = -150-offset.y*factor;
    bgImgView.frame = frame;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)dealloc
{
    [bgImgView release];
    [table release];
    [super dealloc];
}
@end
