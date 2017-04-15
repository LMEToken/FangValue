//
//  TouZiRenViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//投资人

#import "TouZiRenViewController.h"
#import "LunCiViewController.h"
#import "YiJianMianJiLvViewController.h"
#import "WeiJianMianJiLuViewController.h"


@interface TouZiRenViewController ()

@end

@implementation TouZiRenViewController


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
//    [self setTitle:@"投资人"];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.titleLabel setText:@"投资人"];

    //右侧按钮”每轮详情"
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-70, (44-25)/2, 80, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"每轮详情" forState:UIControlStateNormal];
    [rightButton setTitle:@"每轮详情" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(meilunxiangqingEvent:) forControlEvents:UIControlEventTouchUpInside];
   // rightButton.backgroundColor=[UIColor redColor];
    [self addRightButton:rightButton isAutoFrame:NO];

    [self loadData];
}
#pragma -mark -functions
- (void)loadData
{
    [[NetManager sharedManager]getProjectInvestorWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        NSLog(@"dataDic=%@",dataDic);
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)initContentView
{
    //第一部分背景图
    UIImage *sImage=[UIImage imageNamed:@"38_shurukuang_1"];
    UIImageView *shangImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 626/2, 202/2)];
    [shangImageView setImage:sImage];
    [self.contentView addSubview:shangImageView];
    
    //共推荐几轮Label
    UILabel *gonglab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(shangImageView.frame)+5, 300, 25)];
    [gonglab setBackgroundColor:[UIColor clearColor]];
    [gonglab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:gonglab size:18];
    //[gonglab setText:[NSString stringWithFormat:@"共推荐%@轮",@"19"]];
    [gonglab setText:[NSString stringWithFormat:@"共推荐%@轮",[dataDic objectForKey:@"invround"]]];
    [self.contentView addSubview:gonglab];

    //几家Label
    UILabel *jialab=[[UILabel alloc]initWithFrame:CGRectMake(125, CGRectGetMinY(shangImageView.frame)+5, 50, 25)];
    [jialab setBackgroundColor:[UIColor clearColor]];
    [jialab setTextColor:[UIColor orangeColor]];
    [jialab setTextAlignment:NSTextAlignmentCenter];
    [Utils setDefaultFont:jialab size:18];
    [jialab setText:[NSString stringWithFormat:@"%@家",[dataDic objectForKey:@"invnum"]]];
    [self.contentView addSubview:jialab];
    
    //已见面button
    UIButton *yiBUT=[UIButton buttonWithType:UIButtonTypeCustom];
    [yiBUT setFrame:CGRectMake(15, CGRectGetMaxY(gonglab.frame)+10, 50, 20)];
    [yiBUT setBackgroundColor:[UIColor clearColor]];
    [Utils setDefaultFont:yiBUT size:15];
    [yiBUT setTitleColor:[UIColor colorWithRed:110/255.0 green:146/255.0 blue:228/255.0 alpha:1.0] forState:UIControlStateNormal];
    [yiBUT setTitle:@"已见面" forState:UIControlStateNormal];
    [yiBUT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [yiBUT addTarget:self action:@selector(RecordsHaveBeenMet:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:yiBUT];
    
    //未见面button
    UIButton *weiBUT=[UIButton buttonWithType:UIButtonTypeCustom];
    [weiBUT setFrame:CGRectMake(15, CGRectGetMaxY(yiBUT.frame)+5, 50, 25)];
    [weiBUT setBackgroundColor:[UIColor clearColor]];
    [Utils setDefaultFont:weiBUT size:15];
    [weiBUT setTitleColor:[UIColor colorWithRed:110/255.0 green:146/255.0 blue:228/255.0 alpha:1.0] forState:UIControlStateNormal];
    [weiBUT setTitle:@"未见面" forState:UIControlStateNormal];
    [weiBUT setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [weiBUT addTarget:self action:@selector(NotMeetRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:weiBUT];
    
    //热点名单Label
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(shangImageView.frame)+20, 300, 25)];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:lab size:16];
    [lab setText:@"热点名单:"];
    [self.contentView addSubview:lab];

    //热点名单背景图
    UIImage *xImage=[UIImage imageNamed:@"38_shurukuang_2"];
    UIImageView *xiaImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(shangImageView.frame)+45, 626/2, 342/2)];
    [xiaImageView setImage:xImage];
    [self.contentView addSubview:xiaImageView];

    
    NSArray *array=[[NSArray alloc]initWithArray:[dataDic objectForKey:@"hotinv"]];
    //for (int k=0; k<2; k++) {
        UILabel *xianlab=[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(gonglab.frame)+30, 50, 1)];
        [xianlab setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:xianlab];
    
        UILabel *xianlab2=[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(gonglab.frame)+30+25, 50, 1)];
        [xianlab2 setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:xianlab2];
    
        //第1排跟进多少家
        UILabel *followLab=[[UILabel alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(gonglab.frame)+10, 80, 25)];
        [followLab setBackgroundColor:[UIColor clearColor]];
        [followLab setTextColor:[UIColor colorWithRed:66/225.0 green:70/225.0 blue:74/225.0 alpha:1.0]];
        [followLab setText:[NSString stringWithFormat:@"跟进%@家",[dataDic objectForKey:@"follow2"]]];
        [followLab setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:followLab];
    
        //第2排跟进多少家
        UILabel *followLab2=[[UILabel alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(gonglab.frame)+10+25, 80, 25)];
        [followLab2 setBackgroundColor:[UIColor clearColor]];
        [followLab2 setTextColor:[UIColor colorWithRed:66/225.0 green:70/225.0 blue:74/225.0 alpha:1.0]];
        [followLab2 setText:[NSString stringWithFormat:@"跟进%@家",[dataDic objectForKey:@"follow0"]]];
        [followLab2 setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:followLab2];

        //第一排已否决几家
        UILabel *refuseLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, CGRectGetMaxY(gonglab.frame)+10, 90, 25)];
        [refuseLabel setBackgroundColor:[UIColor clearColor]];
        [refuseLabel setTextColor:[UIColor colorWithRed:66/225.0 green:70/225.0 blue:74/225.0 alpha:1.0]];
        [refuseLabel setFont:[UIFont systemFontOfSize:15]];
        [refuseLabel setText:[NSString stringWithFormat:@"已否决%@家",[dataDic objectForKey:@"refuse2"]]];
        [self.contentView addSubview:refuseLabel];

        //第二排已否决几家
        UILabel *refuseLabel2=[[UILabel alloc]initWithFrame:CGRectMake(200, CGRectGetMaxY(gonglab.frame)+10+25, 90, 25)];
        [refuseLabel2 setBackgroundColor:[UIColor clearColor]];
        [refuseLabel2 setTextColor:[UIColor colorWithRed:66/225.0 green:70/225.0 blue:74/225.0   alpha:1.0]];
        [refuseLabel2 setFont:[UIFont systemFontOfSize:15]];
        [refuseLabel2 setText:[NSString stringWithFormat:@"已否决%@家",[dataDic objectForKey:@"refuse0"]]];
        [self.contentView addSubview:refuseLabel2];
    //}
    
    if([array count]>0)
    {
    for (int i=0; i<[array count]; i++) {
        //热点名单里的内容
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10+25*i, 300, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor colorWithRed:66/225.0 green:70/225.0 blue:74/225.0 alpha:1.0]];
        [lab setFont:[UIFont systemFontOfSize:15]];
        [lab setText:[[array objectAtIndex:i]objectForKey:@"inc"]];
        [xiaImageView addSubview:lab];
    }
    }
}
#pragma -mark -doClickAction
//已见面
- (void)RecordsHaveBeenMet:(UIButton *)sender{
    NSLog(@"已见面");
    YiJianMianJiLvViewController* viewController = [[YiJianMianJiLvViewController alloc] init];
    viewController.dataArray = [dataDic objectForKey:@"isseelist"];
    [self.navigationController pushViewController:viewController animated:YES];
}
//未见面
- (void)NotMeetRecord:(UIButton *)sender{
    NSLog(@"未见面");
    WeiJianMianJiLuViewController* viewController = [[WeiJianMianJiLuViewController alloc] init];
    viewController.dataArray = [dataDic objectForKey:@"noseelist"];
    [self.navigationController pushViewController:viewController animated:YES];
}
//第轮详情
- (void)meilunxiangqingEvent:(UIButton *)sender{
    LunCiViewController *view=[[LunCiViewController alloc]init];
    view.proid = self.proid;
    [self.navigationController pushViewController:view animated:YES];
    NSLog(@"每轮详情");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
