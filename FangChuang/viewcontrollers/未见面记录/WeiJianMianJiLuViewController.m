//
//  WeiJianMianJiLuViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//未见面记录
#import "WeiJianMianJiLuViewController.h"

@interface WeiJianMianJiLuViewController ()

@end

@implementation WeiJianMianJiLuViewController
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
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.titleLabel setText:@"未见面记录"];
	[self addBackButton];
    [self setTabBarHidden:YES];
    
    //添加列表
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];
}
#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //cell背景框
        UIImage* bcImg = [UIImage imageNamed:@"63_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), 55)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        //投资公司:Label
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 10, 70 , 15)];
        [nameLabel setText:@"投资公司:"];
        [nameLabel setTextColor:ORANGE];
        [nameLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];
        
        //投资公司内容Label
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) , CGRectGetMinY(nameLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [contentLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:GRAY];
        [contentLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"inc"]];
        [cell.contentView addSubview:contentLabel];
        
        //投资人:Label
        UILabel* diLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(contentLabel.frame) + 4, 60 , 15)];
        [diLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [diLabel setBackgroundColor:[UIColor clearColor]];
        [diLabel setTextColor:GRAY];
        [diLabel setText:@"投 资 人:"];
        [cell.contentView addSubview:diLabel];
        
        //投资人内容Label
        UILabel* renLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(diLabel.frame)+10 , CGRectGetMinY(diLabel.frame), 320 -CGRectGetMaxX(nameLabel.frame) - 20, 15)];
        [renLabel setFont:[UIFont fontWithName:KUIFont size:15]];
        [renLabel setBackgroundColor:[UIColor clearColor]];
        [renLabel setTextColor:GRAY];
        [renLabel setText:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"inv"]];
        [cell.contentView addSubview:renLabel];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.;
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
