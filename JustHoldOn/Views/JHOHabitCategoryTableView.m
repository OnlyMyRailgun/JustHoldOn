//
//  JHOHabitCategoryTableView.m
//  JustHoldOn
//
//  Created by Heartunderblade on 13-1-12.
//  Copyright (c) 2013年 Heartunderblade. All rights reserved.
//

#import "JHOHabitCategoryTableView.h"
#import "JHOHabitCategoryCell.h"

@interface JHOHabitCategoryTableView ()
{
    NSMutableArray *dataSourceItems;
    NSMutableArray *dataSourceImages;
    JHOHabitCategoryHeader *headerView;
}
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation JHOHabitCategoryTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializator];
    }
    return self;
}

- (void)initializator
{
    dataSourceItems = [[NSMutableArray alloc] init];
    [dataSourceItems addObject:@"全部"];
    [dataSourceItems addObject:@"热门"];
    [dataSourceItems addObject:@"学习"];
    [dataSourceItems addObject:@"饮食"];
    [dataSourceItems addObject:@"工作"];
    [dataSourceItems addObject:@"运动"];
    [dataSourceItems addObject:@"其他"];
    
    dataSourceImages = [[NSMutableArray alloc] init];
    [dataSourceImages addObject:@"习惯列表12-28_05"];
    [dataSourceImages addObject:@"习惯列表12-28_12"];
    [dataSourceImages addObject:@"习惯列表12-28_14"];
    [dataSourceImages addObject:@"习惯列表12-28_16"];
    // UITableView properties
    self.backgroundColor = [UIColor clearColor];
    
    headerView = [[JHOHabitCategoryHeader alloc] initWithFrame:CGRectZero];
    headerView.moveDelegate = self;
    [self addSubview:headerView];
    
    CGRect frame = self.frame;
    frame.origin.y = 39;
    frame.size.height -= 39;
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"习惯列表bg"]]];
    [self addSubview:_tableView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_tableView release];
    [headerView release];
    [dataSourceItems release];
    [dataSourceImages release];
    [super dealloc];
}

#pragma mark - moveViewDelegate
- (void)moveView:(CGFloat) distance
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y += distance;
    if(viewFrame.origin.y < 460 - 39 && viewFrame.origin.y > 200)
    {
        viewFrame.size.height -= distance;
        self.frame = viewFrame;
        
        CGRect tableFrame = _tableView.frame;
        tableFrame.size.height -= distance;
        _tableView.frame = tableFrame;
    }
}

- (void)openCategoryView
{
    CGRect viewFrame = CGRectMake(0, 200, 320, 260);
    CGRect tableFrame = CGRectMake(0, 39, 320, 221);
    [UIView animateWithDuration:0.4f animations:^{
        self.frame = viewFrame;
        _tableView.frame = tableFrame;
    }];
}

- (void)closeCategoryView
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = 460-39;
    viewFrame.size.height = 39;
    
    CGRect tableFrame = _tableView.frame;
    tableFrame.size.height = 0;
    [UIView animateWithDuration:0.4f animations:^{
        self.frame = viewFrame;
        _tableView.frame = tableFrame;
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceItems.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *categoryIdentifier = @"HabitCategoryCell";
    JHOHabitCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryIdentifier];
    if(cell == nil)
    {
        cell = [[JHOHabitCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryIdentifier];
    }
    cell.textLabel.text = [dataSourceItems objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:[dataSourceImages objectAtIndex:indexPath.row%dataSourceImages.count]]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHONetworkHelper *helper = [[JHONetworkHelper alloc] init];
    helper.networkDelegate = _delegate;
    NSMutableDictionary *_dic = [NSMutableDictionary dictionary];
    [_dic setObject:@"20" forKey:@"maxnum"];
    [_dic setObject:[dataSourceItems objectAtIndex:indexPath.row] forKey:@"typevalue"];
    [_dic setObject:@"0" forKey:@"startpos"];
    [_dic setObject:@"0" forKey:@"sorttype"];
    [helper getHabitLib:_dic];
    headerView.label.text = [NSString stringWithFormat:@"%@ 习惯",[dataSourceItems objectAtIndex:(indexPath.row)]];
}
@end
