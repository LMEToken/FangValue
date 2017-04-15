//
//  RongZiFangAnViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//融资信息
#import "RongZiFangAnViewController.h"
#import "RongZiBianJiViewController.h"

@interface RongZiFangAnViewController ()

@end
@implementation RongZiFangAnViewController

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
    [self setTitle:@"融资信息"];

    if (self.proid) {
        [self loadData];
    }
    //右侧编辑按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BianJiEvent:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor=[UIColor clearColor];
    //2014.08.08 chenlihua 将编辑按钮去掉。
   // [self addRightButton:rightButton isAutoFrame:NO];

    
    UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
    for (int i =0 ; i < 4; i++) {
        //cell背景色
        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10+55*i, 320, 80)];
        [bcImgV setImage:bcImg];
        [self.contentView addSubview:bcImgV];

        //融资金额Label
        NSArray *array =[NSArray arrayWithObjects:@"【融资金额】",@"【融资方式】",@"【估值方案】",@"【退出方式】", nil];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(5, 25+(55*i), 90, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont fontWithName:KUIFont size:15]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];

        //":"Label
        UILabel *maohaolab=[[UILabel alloc]initWithFrame:CGRectMake(93, 25+(55*i), 90, 25)];
        [maohaolab setBackgroundColor:[UIColor clearColor]];
        [maohaolab setFont:[UIFont fontWithName:KUIFont size:15]];
        [maohaolab setTextColor:[UIColor blackColor]];
        [maohaolab setText:@":"];
        [self.contentView addSubview:maohaolab];
    }
}
#pragma -mark -functions
- (void)loadData
{
    [[NetManager sharedManager]getFinancingPlanWithProjectid:self.proid username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        //NSLog(@"responseDic=%@",responseDic);
        dataDic = [[NSDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
        [self initContentView];
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
- (void)initContentView
{
    //融资金额内容
    rongZiJinELab=[[UILabel alloc]initWithFrame:CGRectMake(100, 25+(55*0), 200, 25)];
    [rongZiJinELab setBackgroundColor:[UIColor clearColor]];
    [rongZiJinELab setFont:[UIFont fontWithName:KUIFont size:15]];
    [rongZiJinELab setTextColor:[UIColor grayColor]];
    [rongZiJinELab setTag:1001];
    [rongZiJinELab setText:[dataDic objectForKey:@"money"]];
    [self.contentView addSubview:rongZiJinELab];

    //融资方式
    rongZiFangShiLab=[[UILabel alloc]initWithFrame:CGRectMake(100, 25+(55*1), 200, 25)];
    [rongZiFangShiLab setBackgroundColor:[UIColor clearColor]];
    [rongZiFangShiLab setFont:[UIFont fontWithName:KUIFont size:15]];
    [rongZiFangShiLab setTextColor:[UIColor grayColor]];
    [rongZiFangShiLab setTag:1002];
    [rongZiFangShiLab setText:[dataDic objectForKey:@"way"]];
    [self.contentView addSubview:rongZiFangShiLab];

    //估值方案
    guZhiFangAnLab=[[UILabel alloc]initWithFrame:CGRectMake(100, 25+(55*2), 200, 25)];
    [guZhiFangAnLab setBackgroundColor:[UIColor clearColor]];
    [guZhiFangAnLab setFont:[UIFont fontWithName:KUIFont size:15]];
    [guZhiFangAnLab setTextColor:[UIColor grayColor]];
    [guZhiFangAnLab setTag:1003];
    [guZhiFangAnLab setText:[dataDic objectForKey:@"program"]];
    [self.contentView addSubview:guZhiFangAnLab];

    //退出方式
    tuiChuFangShiLab=[[UILabel alloc]initWithFrame:CGRectMake(100, 25+(55*3), 200, 25)];
    [tuiChuFangShiLab setBackgroundColor:[UIColor clearColor]];
    [tuiChuFangShiLab setFont:[UIFont fontWithName:KUIFont size:15]];
    [tuiChuFangShiLab setTag:1004];
    [tuiChuFangShiLab setTextColor:[UIColor grayColor]];
    [tuiChuFangShiLab setText:[dataDic objectForKey:@"quit"]];
    [self.contentView addSubview:tuiChuFangShiLab];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UITextField *rzjeTextField=(UITextField *)[self.contentView viewWithTag:1001];
//    [rzjeTextField setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"key1"]];
//    
//    UITextField *rzfsTextField=(UITextField *)[self.contentView viewWithTag:1002];
//    [rzfsTextField setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"key2"]];
//    
//    UITextField *gzfaTextField=(UITextField *)[self.contentView viewWithTag:1003];
//    [gzfaTextField setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"key3"]];
//    
//    UITextField *tcfsTextField=(UITextField *)[self.contentView viewWithTag:1004];
//    [tcfsTextField setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"key4"]];
}
#pragma -mark -编辑按钮
- (void)BianJiEvent:(UIButton *)sender{
    //RongZiBianJiViewController *view=[[RongZiBianJiViewController alloc]initValueString:rongZiJinELab.text rzfsText:rongZiFangShiLab.text gzfaText:guZhiFangAnLab.text tcfsText:tuiChuFangShiLab.text];
    RongZiBianJiViewController *view = [[RongZiBianJiViewController alloc]init];
    [view setDelegate:self];
    view.dataDic = dataDic;
    NSLog(@"---dataDic=%@",view.dataDic);
    [self.navigationController pushViewController:view animated:YES];
}
#pragma -mark -functions
- (void)reloadWithText:(NSString*)text1 Text:(NSString*)text2 Text:(NSString*)text3 Text:(NSString*)text4
{
    [rongZiJinELab setText:text1];
    [rongZiFangShiLab setText:text2];
    [guZhiFangAnLab setText:text3];
    [tuiChuFangShiLab setText:text4];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
