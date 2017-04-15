//
//  HomeViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "HomeViewController.h"
#import "CacheImageView.h"
#import "FangChuangNeiBuViewController.h"

#import "CaiWuMoXingViewController.h"
#import "XuanZeLianXiRenViewController.h"
#import "14BianJiViewController.h"
#import "ShangYeJiHuaViewController.h"
#import "XiangMuJiDuViewController.h"

#import "XiangMuJinZhanViewController.h"
#import "JinZhanXiangQingViewController.h"
#import "FangChuangRenWuViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        self.view = nil;
    }
    
}
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
    [self addBackButton];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
	[self.titleLabel setText:@"方创"];
    [self setTabBarIndex:0];
    
    //搜索按钮
    FCSearchBar* searchBar = [[FCSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    [self.contentView addSubview:searchBar];

    //UITableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.contentViewHeight - 40) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];

}
#pragma  -mark -FCSearchBar delegate
- (void)FCSearchBarDidSearch:(FCSearchBar *)fcSearchBar text:(NSString *)text
{
    ;
}
#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //cell背景图
        UIImage* bcImg = [UIImage imageNamed:@"63_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), 55)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];

        //92 * 92
        //头像
        UIImage* headImage = [UIImage imageNamed:@"61_touxiang_1"];
        CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(10, (55 - 92 / 2) / 2, 92 / 2, 92 / 2)];
        [headImageView setImage:headImage];
        [headImageView setTag:100];
        [cell.contentView addSubview:headImageView];

        //名字Label
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, CGRectGetMinY(headImageView.frame) + 3, 320 - CGRectGetMaxX(headImageView.frame) - 20 , 15)];
        [nameLabel setText:@"冰心"];
        [nameLabel setTextColor:ORANGE];
        [nameLabel setFont:[UIFont systemFontOfSize:14]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];

        //一级Label
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame) , CGRectGetMaxY(nameLabel.frame)+ 3, CGRectGetWidth(nameLabel.frame), 10)];
        [contentLabel setFont:[UIFont systemFontOfSize:10]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:GRAY];
        [contentLabel setText:@"200米以内"];
        [cell.contentView addSubview:contentLabel];

        
        //二级Label
        UILabel* diLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame), CGRectGetMaxY(contentLabel.frame) + 3, CGRectGetWidth(nameLabel.frame), 10)];
        [diLabel setFont:[UIFont systemFontOfSize:10]];
        [diLabel setBackgroundColor:[UIColor clearColor]];
        [diLabel setTextColor:GRAY];
        [diLabel setText:@"200米以内"];
        [cell.contentView addSubview:diLabel];
 }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        FangChuangRenWuViewController * viewController = [[FangChuangRenWuViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    else if (indexPath.row == 1)
    {
        //        [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        JinZhanXiangQingViewController* vc = [[JinZhanXiangQingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (indexPath.row == 2)
    {
        //        [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        XuanZeLianXiRenViewController* vc = [[XuanZeLianXiRenViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (indexPath.row == 3)
    {
        //        [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
//        _4BianJiViewController* vc = [[_4BianJiViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        [vc release];
    }
    else if (indexPath.row == 4)
    {
        //        [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        ShangYeJiHuaViewController* vc = [[ShangYeJiHuaViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row == 5)
    {
        //        [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        XiangMuJiDuViewController* vc = [[XiangMuJiDuViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


@end
