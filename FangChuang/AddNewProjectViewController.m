//
//  AddNewProjectViewController.m
//  FangChuang
//
//  Created by omni on 14-4-1.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "AddNewProjectViewController.h"
#import "ButtonView.h"
#import "RTLabel.h"
#import "CaiWuMoXingViewController.h"
#import "FaWuViewController.h"
#import "RongZiFangAnViewController.h"
#import "FangChuangGuanDianViewController.h"
#import "SahngYeJiHuaBianJiViewController.h"

@interface AddNewProjectViewController ()

@end

@implementation AddNewProjectViewController
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

    self.title = @"欢迎添加新项目";
//    [self setTabBarHidden:NO];
    [self setTabBarIndex:1];

    //添加右边的按钮
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [rtBtn setImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];
    
    //添加切换栏
    [self addTableView];
    [self addHeadView];
    [self addFootView];
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
- (void)addHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 660)];
    [headView setBackgroundColor:[UIColor clearColor]];

    //添加按钮切换兰
    ButtonView* buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(10, 30, 0, 0)
                                                      delegate:self
                                                        titles:[NSArray arrayWithObjects:@"财务",@"估值",@"法务",@"团队信息", nil]];
    
    [headView addSubview:buttonView];
    
    firstView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(buttonView.frame) + 20, 310, 100)
                                       titleArray:[NSArray arrayWithObjects:@"【定位】:",@"【模式】:",@"【卖点】:", nil]
                                     contentArray:[NSArray arrayWithObjects:
                                                   [Utils getString:[dataDic objectForKey:@"position"]],
                                                   [Utils getString:[dataDic objectForKey:@"model"]],
                                                   [Utils getString:[dataDic objectForKey:@"factor"]], nil]
                                       titleColor:nil
                                     contentColor:nil];
    [headView addSubview:firstView];
    
    secondView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(firstView.frame) + 20, 310, 100)
                                        titleArray:[NSArray arrayWithObjects:@"【企业全称】:",@"【所在地区】:",@"【所属行业】:",@"【网址】:", nil]
                                      contentArray:[NSArray arrayWithObjects:
                                                    [Utils getString:[dataDic objectForKey:@"fullname"]],
                                                    [Utils getString:[dataDic objectForKey:@"location"]],
                                                    [Utils getString:[dataDic objectForKey:@"industry"]],
                                                    [Utils getString:[dataDic objectForKey:@"url"]], nil]
                                        titleColor:nil
                                      contentColor:nil];
    [headView addSubview:secondView];
    
    threeView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(secondView.frame) + 20, 310, 100)
                                        titleArray:[NSArray arrayWithObjects:@"【市场规模】:",@"【产品】:",@"【营销】:",@"【竞争力】:",@"【技术研发】:",@"【运营数据】:", nil]
                                      contentArray:[NSArray arrayWithObjects:
                                                    [Utils getString:[dataDic objectForKey:@"marketsize"]],
                                                    [Utils getString:[dataDic objectForKey:@"product"]],
                                                    [Utils getString:[dataDic objectForKey:@"marketing"]],
                                                    [Utils getString:[dataDic objectForKey:@"compete"]],
                                                    [Utils getString:[dataDic objectForKey:@"rd"]],
                                                    [Utils getString:[dataDic objectForKey:@"finance"]], nil]
                                        titleColor:nil
                                      contentColor:nil];
    [headView addSubview:threeView];
    
    sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(threeView.frame) + 10, 300, 20)];
    [sectionLabel setBackgroundColor:[UIColor clearColor]];
    [sectionLabel setTextColor:ORANGE];
    [sectionLabel setText:@"团队与人数:"];
    [sectionLabel setFont:[UIFont systemFontOfSize:15.f]];
    [headView addSubview:sectionLabel];
    
    UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
    UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionLabel.frame)+10, 320, 1)];
    [xianimage setImage:xianImage];
    [headView addSubview:xianimage];
    
    [headView setFrame:CGRectMake(0, 0, 320, CGRectGetMaxY(sectionLabel.frame) + 20)];
    [myTableView setTableHeaderView:headView];
}
- (void)addFootView
{
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    [footView setBackgroundColor:[UIColor clearColor]];
    [myTableView setTableFooterView:footView];
    
    UILabel* sectionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  10, 300, 15)];
    [sectionLabel1 setBackgroundColor:[UIColor clearColor]];
    [sectionLabel1 setTextColor:ORANGE];
    [sectionLabel1 setText:@"项目图片:"];
    [sectionLabel1 setFont:[UIFont fontWithName:KUIFont size:15]];
    [footView addSubview:sectionLabel1];
    
    imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 150)];
    [imageScrollView setBounces:NO];
    [imageScrollView setShowsHorizontalScrollIndicator:NO];
    [imageScrollView setShowsVerticalScrollIndicator:NO];
    [footView addSubview:imageScrollView];
    [imageScrollView setPagingEnabled:YES];
    [imageScrollView setDelegate:self];
    
    
    NSArray *images = [NSArray arrayWithArray:[dataDic objectForKey:@"projectpic"]];
    for (int i = 0; i < images.count; i++) {
        
        CacheImageView* imageView = [[CacheImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 150)];
        [imageView getImageFromURL:[NSURL URLWithString:[images objectAtIndex:i]]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageScrollView addSubview:imageView];
        
    }
    [imageScrollView setContentSize:CGSizeMake(320 * images.count, 150)];
    
    
    imagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, 320, 10)];
    [imagePageControl setNumberOfPages:images.count];
    //设置normal颜色
    [imagePageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    //设置selected颜色
    [imagePageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [imagePageControl addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventValueChanged];
    [footView addSubview:imagePageControl];
}
#pragma  -mark -UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:imageScrollView]) {
        int page = imageScrollView.contentOffset.x / 320;
        [imagePageControl setCurrentPage:page];
    }
}
#pragma  -mark -pageControl
- (void)changeImage:(UIPageControl*)pageControl
{
    [imageScrollView setContentOffset:CGPointMake(320 * pageControl.currentPage, 0) animated:YES];
}
#pragma  -mark -buttonView delegate
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonView *)view
{
    if (index == 0) {
        CaiWuMoXingViewController* viewController = [[CaiWuMoXingViewController alloc] init];
//        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 1) {
        RongZiFangAnViewController* viewController = [[RongZiFangAnViewController alloc] init];
//        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 2) {
         FaWuViewController* viewController = [[FaWuViewController alloc] init];
//        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 3) {
//        FangChuangGuanDianViewController* viewController = [[FangChuangGuanDianViewController alloc] init];
//        viewController.proid = self.proid;
//        [self.navigationController pushViewController:viewController animated:YES];
    }
}
- (void)talkWithFangChuang:(UIButton*)button
{
    printf(__FUNCTION__);
}
#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    
//    NSDictionary* dic = [self.datas objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
        CacheImageView *headImageView = [[CacheImageView alloc]initWithImage:[UIImage imageNamed:@"61_touxiang_1"] Frame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
//        [headImageView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"photourl"]]];
        
        [headImageView setBackgroundColor:[UIColor clearColor]];
        //[headImageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
        [cell.contentView addSubview:headImageView];
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, CGRectGetMinY(headImageView.frame), 320 - CGRectGetMaxX(headImageView.frame) - 20, 15)];
        [nameLabel setFont:[UIFont systemFontOfSize:13]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];
        
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(nameLabel.frame), 50)];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:11]];
        [contentLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [contentLabel setTextColor:GRAY];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:contentLabel];
        
        
//        [nameLabel setText:[dic objectForKey:@"tname"]];
//        
//        [contentLabel setText:[dic objectForKey:@"cv"]];
        
        UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
        UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+5, 320, 1)];
        [xianimage setImage:xianImage];
        [cell.contentView addSubview:xianimage];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas count];
}
#pragma -mark -doClickAction
- (void)BianJiEvent:(UIButton*)sender{
    return;
    SahngYeJiHuaBianJiViewController *view=[[SahngYeJiHuaBianJiViewController alloc]init];
    view.myDic = dataDic;
    [self.navigationController pushViewController:view animated:YES];
    
}


@end
