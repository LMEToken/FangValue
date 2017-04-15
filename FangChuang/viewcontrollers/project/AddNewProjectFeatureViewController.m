//
//  AddNewProjectFeatureViewController.m
//  FangChuang
//
//  Created by omni on 14-4-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//添加项目信息
#import "AddNewProjectFeatureViewController.h"
#import "CaiWuMoXingViewController.h"
#import "FaWuViewController.h"
#import "RongZiFangAnViewController.h"
#import "FangChuangGuanDianViewController.h"
#import "ProjectBasicInfoViewController.h"
//2014.07.22 chenlihua 法务编辑
#import "FaWuBianJiViewController.h"

@interface AddNewProjectFeatureViewController ()
{
    NSArray* dataArray;
}
@end

@implementation AddNewProjectFeatureViewController

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
//    self.title = @"添加项目信息";
    self.titleLabel.text = @"添加项目信息";
    //    [self setTabBarHidden:NO];
    [self setTabBarIndex:1];
    [self addTableView];
    [self addBackButton];
    dataArray = @[@"基本信息",@"团队信息",@"财务信息",@"融资信息",@"项目图片",@"法务信息"];
}
#pragma -mark -functions
- (void)addTableView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    //[myTableView setSeparatorColor:[UIColor grayColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:myTableView];
}
#pragma -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //cell背景色
        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
        //右侧加号图标
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-20-23/2, (80-20.5)/2, 38/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"44_anniu_1"]];
        [cell.contentView addSubview:jiantouImage];
        
        //左侧的田字图标
        cell.imageView.image = [UIImage imageNamed:@"Reader-Thumbs"];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController* viewController = nil;
    switch (indexPath.row) {
        case 0:
        {
            viewController = [[ProjectBasicInfoViewController alloc] init];
        }
            break;
        case 1:
        {
         //团队信息
        }
            break;
        case 2:
        {
            viewController = [[CaiWuMoXingViewController alloc] init];
        }
            break;
        case 3:
        {
            viewController = [[RongZiFangAnViewController alloc] init];
        }
            break;
        case 4:
        {
        //项目图片
        }
            break;
        case 5:
        {
           // viewController = [[FaWuViewController alloc] init];
            //2014.07.22 chenlihua 跳转到法务编辑页面
            viewController=[[FaWuBianJiViewController alloc] init];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:viewController animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
