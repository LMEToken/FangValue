//
//  XuanZeQunViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//选择一个群
#import "XuanZeQunViewController.h"
#import "CacheImageView.h"

@interface XuanZeQunViewController ()

@end

@implementation XuanZeQunViewController
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
    [self setTabBarHidden:YES];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self setTitle:@"选择一个群"];
	// Do any additional setup after loading the view.
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
//    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:myTableView];
}
#pragma  -mark -UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        [cell setBackgroundColor:[UIColor clearColor]];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //cell背景图
        UIImage* bcImg = [UIImage imageNamed:@"40_shurukuang_1"];
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        [bcImgV setImage:bcImg];
        [cell.contentView addSubview:bcImgV];
        
//        UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
//        UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//        [headerImage setImage:image];
//        [cell.contentView addSubview:headerImage];
//        [headerImage release];
       
        //头像
        CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake( 15,(55  - 81 / 2.)  / 2., 81 / 2., 81 / 2.)];
        [headImageView setImage:[UIImage imageNamed:@"71_touxiang_2"]];
        [cell.contentView addSubview:headImageView];

        //箭头
        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (60-20.5)/2, 23/2, 41/2)];
        [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
        [cell.contentView addSubview:jiantouImage];

        //群名称
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+5, 35/2, 200, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor orangeColor]];
        [Utils setDefaultFont:lab size:14];
        [lab setFont:[UIFont fontWithName:KUIFont size:14]];
        [lab setText:@"小冰火人-浙商创投-方创对接群"];
        [cell.contentView addSubview:lab];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    YiJianMianJiLvViewController* vc = [[YiJianMianJiLvViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    [vc release];
}




@end
