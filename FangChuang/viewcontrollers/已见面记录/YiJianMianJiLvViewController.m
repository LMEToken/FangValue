//
//  YiJianMianJiLvViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//已见面记录
#import "YiJianMianJiLvViewController.h"
#import "YiJianMianXiangQingViewController.h"
@interface YiJianMianJiLvViewController ()

@end

@implementation YiJianMianJiLvViewController
@synthesize dataArray;
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
    
    [self.titleLabel setText:@"已见面记录"];
	[self addBackButton];
    [self setTabBarHidden:YES];
    
    //添加列表
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
//    [myTableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:myTableView];
}
#pragma -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //cell背景
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];

        //cell背景框
        UIImage* bcImg = [UIImage imageNamed:@"40_shurukuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), 190 / 2.)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];

        //投资公司:Label
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 10, 75 , 15)];
        [nameLabel setText:@"投资公司:"];
        [nameLabel setTextColor:ORANGE];
        [nameLabel setFont:[UIFont systemFontOfSize:15]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];

        //投资公司内容
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) , CGRectGetMinY(nameLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [contentLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:GRAY];
        [contentLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"inc"]];
        [cell.contentView addSubview:contentLabel];

        //投资人:Label
        UILabel* diLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(contentLabel.frame) + 4, 75 , 15)];
        [diLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [diLabel setBackgroundColor:[UIColor clearColor]];
        [diLabel setTextColor:GRAY];
        [diLabel setText:@"投 资 人 :"];
        [cell.contentView addSubview:diLabel];

        //投资人内容
        UILabel* renLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(diLabel.frame) , CGRectGetMinY(diLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [renLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [renLabel setBackgroundColor:[UIColor clearColor]];
        [renLabel setTextColor:GRAY];
        [renLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"inv"]];
        [cell.contentView addSubview:renLabel];

        //投资时间:Label
        UILabel* dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(diLabel.frame) + 4, 70 , 15)];
        [dataLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [dataLabel setBackgroundColor:[UIColor clearColor]];
        [dataLabel setTextColor:GRAY];
        [dataLabel setText:@"投资时间:"];
        [cell.contentView addSubview:dataLabel];
        
        //投资时间内容
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dataLabel.frame)+5 , CGRectGetMinY(dataLabel.frame), 320 -CGRectGetMaxX(dataLabel.frame) - 20, 15)];
        [dateLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:GRAY];
        [dateLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"rdate"]];
        [cell.contentView addSubview:dateLabel];
       
        //当前进度：Label
        UILabel* jidLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(dataLabel.frame) + 4, 70 , 15)];
        [jidLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [jidLabel setBackgroundColor:[UIColor clearColor]];
        [jidLabel setTextColor:GRAY];
        [jidLabel setText:@"当前进度:"];
        [cell.contentView addSubview:jidLabel];

        //当前进度内容
        UILabel* jdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jidLabel.frame)+5 , CGRectGetMinY(jidLabel.frame), 320 -CGRectGetMaxX(jidLabel.frame) - 20, 15)];
        [jdLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [jdLabel setBackgroundColor:[UIColor clearColor]];
        [jdLabel setTextColor:ORANGE];
        [jdLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"fbtype"]];
        [cell.contentView addSubview:jdLabel];
    }
    return cell;
}
#pragma -mark -UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiJianMianXiangQingViewController* viewController = [[YiJianMianXiangQingViewController alloc] init];
    viewController.meetid = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"meetid"];
    [self.navigationController pushViewController:viewController animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190 / 2.;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
