//
//  ShangYeJiHuaViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//商业计划进来页。
#import "ShangYeJiHuaViewController.h"
#import "RTLabel.h"
#import "CaiWuMoXingViewController.h"
#import "FaWuViewController.h"
#import "RongZiFangAnViewController.h"
#import "FangChuangGuanDianViewController.h"
#import "SahngYeJiHuaBianJiViewController.h"

//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"


@interface ShangYeJiHuaViewController ()

@end

@implementation ShangYeJiHuaViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadData
{
    [[NetManager sharedManager]getBusinessPlanWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"dataDic=%@",dataDic);

        //首先移除之前的subView
        [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.datas = [dataDic objectForKey:@"team"];
        
        //UITableView 团队成员与人数内容部分。
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
        [myTableView setDelegate:self];
        [myTableView setDataSource:self];
        [myTableView setBackgroundColor:[UIColor clearColor]];
        //[myTableView setSeparatorColor:[UIColor grayColor]];
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.contentView addSubview:myTableView];
        
        [self setTitle:[Utils getString:[dataDic objectForKey:@"fullname"]]];
        NSLog(@"----%@---",[dataDic objectForKey:@"fullname"]);
        //"团队与人数"Label及其上面的部分初始化
       [self initHeadView];
        //项目图片初始化
       [self initFootView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self loadData];
    //编辑按钮(暂时取消)
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BianJiEvent:) forControlEvents:UIControlEventTouchUpInside];
  //  [self addRightButton:rightButton isAutoFrame:NO];
    /*
     
     headerview
     
     cell
     
     footerView
     
     */
}
#pragma  -mark -functions
//"团队与人数"Label及其上面的部分初始化
- (void) initHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 660)];
    
    [headView setBackgroundColor:[UIColor clearColor]];
    //    //添加logo
    //    logoImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    //
    //    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    //    [headView addSubview:logoImageView];
    //    [logoImageView release];
    
    
    
    //按钮切换栏
     ButtonView* buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(10, 20, 0, 0)
                                                      delegate:self
                                                        titles:[NSArray arrayWithObjects:@"财务模型",@"融资方案",@"法务",@"方创观点", nil]];
    
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
                                        titleArray:[NSArray arrayWithObjects:@"【企业全称】:",@"【所在地区】:",@"【所在行业】:",@"【行业网址】:", nil]
                                      contentArray:[NSArray arrayWithObjects:
                                                    [Utils getString:[dataDic objectForKey:@"fullname"]],
                                                    [Utils getString:[dataDic objectForKey:@"location"]],
                                                    [Utils getString:[dataDic objectForKey:@"industry"]],
                                                    [Utils getString:[dataDic objectForKey:@"url"]], nil]
                                        titleColor:nil
                                      contentColor:nil];
    [headView addSubview:secondView];
    
    threedView = [[ModuleView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(secondView.frame) + 20, 310, 100)
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
    [headView addSubview:threedView];
    
    sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(threedView.frame) + 10, 300, 20)];
    [sectionLabel setBackgroundColor:[UIColor clearColor]];
    [sectionLabel setTextColor:ORANGE];
    [sectionLabel setText:@"团队与人数:"];
    [sectionLabel setFont:[UIFont systemFontOfSize:15.f]];
    [headView addSubview:sectionLabel];
    
    //团队与人数:下面的线
    UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
    UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionLabel.frame)+10, 320, 1)];
    [xianimage setImage:xianImage];
   [headView addSubview:xianimage];
    
    
    [headView setFrame:CGRectMake(0, 0, 320, CGRectGetMaxY(sectionLabel.frame) + 20)];
    [myTableView setTableHeaderView:headView];
}
//项目图片部分
- (void)initFootView
{
    
    //UIView
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    [footView setBackgroundColor:[UIColor clearColor]];
    [myTableView setTableFooterView:footView];
    
    //项目图片:Label
    UILabel* sectionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  10, 300, 15)];
    [sectionLabel1 setBackgroundColor:[UIColor clearColor]];
    [sectionLabel1 setTextColor:ORANGE];
    [sectionLabel1 setText:@"项目图片:"];
    [sectionLabel1 setFont:[UIFont systemFontOfSize:15.f]];
    [footView addSubview:sectionLabel1];
    
    //UIScrollView
    imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 150)];
    [imageScrollView setBounces:NO];
    [imageScrollView setShowsHorizontalScrollIndicator:NO];
    [imageScrollView setShowsVerticalScrollIndicator:NO];
    [footView addSubview:imageScrollView];
    [imageScrollView setPagingEnabled:YES];
    [imageScrollView setDelegate:self];
    
    
    NSArray *images = [NSArray arrayWithArray:[dataDic objectForKey:@"projectpic"]];
    for (int i = 0; i < images.count; i++) {
        //图片部分
        /*
        CacheImageView* imageView = [[CacheImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 150)];
        [imageView getImageFromURL:[NSURL URLWithString:[images objectAtIndex:i]]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageScrollView addSubview:imageView];
        */
        
        //2014.07.22 chenlihua 修改图片缓存方式
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 150)];
        [imageView setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i]]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageScrollView addSubview:imageView];

        
        
    }
    
    [imageScrollView setContentSize:CGSizeMake(320 * images.count, 150)];
    
    //滑动部分
    imagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, 320, 10)];
    [imagePageControl setNumberOfPages:images.count];
    //设置normal颜色
    [imagePageControl setPageIndicatorTintColor:[UIColor whiteColor]];
     //设置selected颜色
    [imagePageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
     [imagePageControl addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventValueChanged];
    [footView addSubview:imagePageControl];
    
    /*
     
     
     //NSArray* images = [NSArray arrayWithObjects:@"13_tupian_1",@"13_tupian_1",@"13_tupian_1", nil];
     
     CGFloat y = CGRectGetMaxY(sectionLabel1.frame) + 10;
     CGFloat nextY = 0.;
     NSArray *images = [NSArray arrayWithArray:[dataDic objectForKey:@"projectpic"]];
     for (int i = 0 ; i < images.count; i ++) {
     //243 * 170
     CacheImageView* imageView = [[CacheImageView alloc] initWithFrame:CGRectMake((i % 2 ?  165 : 160 - 5 - 243 / 2. ), y, 243 / 2., 170 / 2.)];
     //[imageView setImage:[UIImage imageNamed:[images objectAtIndex:i]]];
     [imageView getImageFromURL:[NSURL URLWithString:[images objectAtIndex:i]]];
     [footView addSubview:imageView];
     [imageView release];
     
     if ((i % 2) == 1) {
     
     y = CGRectGetMaxY(imageView.frame) + 10;
     }
     nextY = CGRectGetMaxY(imageView.frame) + 10;
     
     }
     
     // 508 * 66
     UIButton* diBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     
     [diBtn setBackgroundImage:[UIImage imageNamed:@"10_anniu_1"] forState:UIControlStateNormal];
     [diBtn setFrame:CGRectMake(160 - 508 / 4., nextY, 508 / 2., 66 / 2.)];
     [diBtn setTitle:@"与方创沟通" forState:UIControlStateNormal];
     [diBtn.titleLabel setFont:[UIFont systemFontOfSize:14.]];
     [diBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [diBtn addTarget:self action:@selector(talkWithFangChuang:) forControlEvents:UIControlEventTouchUpInside];
     [footView addSubview:diBtn];
     
     */
}
//滚动页滑动时
- (void)changeImage:(UIPageControl*)pageControl
{
    [imageScrollView setContentOffset:CGPointMake(320 * pageControl.currentPage, 0) animated:YES];
}
//模型选择函数
- (void)buttonViewSelectIndex:(int)index buttonView:(ButtonView *)view
{
    if (index == 0) {
        CaiWuMoXingViewController* viewController = [[CaiWuMoXingViewController alloc] init];
        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 1) {
        RongZiFangAnViewController* viewController = [[RongZiFangAnViewController alloc] init];
        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 2) {
        
        FaWuViewController* viewController = [[FaWuViewController alloc] init];
        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (index == 3) {
        FangChuangGuanDianViewController* viewController = [[FangChuangGuanDianViewController alloc] init];
        viewController.proid = self.proid;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
//暂时取消的
- (void)talkWithFangChuang:(UIButton*)button
{
    printf(__FUNCTION__);
}
#pragma  -mark -UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:imageScrollView]) {
        
        int page = imageScrollView.contentOffset.x / 320;
        [imagePageControl setCurrentPage:page];
    }
}
#pragma  -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = nil;
    NSDictionary* dic = [self.datas objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        //CacheImageView* headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
        //头像图片
        /*
        CacheImageView *headImageView = [[CacheImageView alloc]initWithImage:[UIImage imageNamed:@"61_touxiang_1"] Frame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
        [headImageView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"photourl"]]];
        [headImageView setBackgroundColor:[UIColor clearColor]];
        //[headImageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
        [cell.contentView addSubview:headImageView];
        */
        
        //2014.07.27 chenlihua 修改头像缓存，同时，当头像不存在的时候，用默认头像代码。
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 92 / 2., 92 / 2.)];
        [headImageView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"photourl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
        [headImageView setBackgroundColor:[UIColor clearColor]];
        //[headImageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
        [cell.contentView addSubview:headImageView];
        
        

        //名字Label
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, CGRectGetMinY(headImageView.frame), 320 - CGRectGetMaxX(headImageView.frame) - 20, 15)];
        [nameLabel setFont:[UIFont systemFontOfSize:13]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:nameLabel];
        
        //内容Label
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(nameLabel.frame), 50)];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:11]];
        [contentLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [contentLabel setTextColor:GRAY];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:contentLabel];
        
        [nameLabel setText:[dic objectForKey:@"tname"]];
        [contentLabel setText:[dic objectForKey:@"cv"]];
        
        //cell下侧线
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
//右上角编辑，暂时取消
- (void)BianJiEvent:(UIButton*)sender{
    SahngYeJiHuaBianJiViewController *view=[[SahngYeJiHuaBianJiViewController alloc]init];
    view.myDic = dataDic;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
