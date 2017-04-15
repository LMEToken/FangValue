//
//  AProjectViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
//与方创沟通，与融资人沟通 i001
#import "AProjectViewController.h"
#import "XiangMuWenDangViewController.h"
#import "xiangmuViewController.h"
#import "xiangmumingxiViewController.h"
#import "TouZiRenViewController.h"
#import "ChaKanNeiRongViewController.h"
#import "ShangYeJiHuaViewController.h"
#import "XiangMuJiDuViewController.h"
#import "RiChengBiaoViewController.h"
#import "QiYeTuanDuiViewController.h"
#import "ChatWithFriendViewController.h"
//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"
@interface AProjectViewController ()

@end

@implementation AProjectViewController
@synthesize myDic;
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
//    [self setTitle:titleid];
    
    [self setTitle:[myDic objectForKey:@"projectname"]];
	// Do any additional setup after loading the view.
    
    //cell背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 250/2)];
    [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
    [self.contentView addSubview:imageView];

    //头像按钮
    /*
    UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
    //UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    CacheImageView *headerImage = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 15, 50, 50)];
    //[headerImage setImage:image];
    [headerImage setBackgroundColor:[UIColor clearColor]];
    [headerImage getImageFromURL:[NSURL URLWithString:[myDic objectForKey:@"projectpicture"]]];
    [self.contentView addSubview:headerImage];
    */
    
    //2014.07.22 chenlihua 修改图片缓存方式
    UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    [headerImage setBackgroundColor:[UIColor clearColor]];
    [headerImage setImageWithURL:[NSURL URLWithString:[myDic objectForKey:@"projectpicture"]] placeholderImage:image];
    [self.contentView addSubview:headerImage];

    
    /*
    //定位内容Label
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10+(20*0), 320 - 110 - 20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:[myDic objectForKey:@"projectposition"]];
    [DWlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:DWlable];

    //行业内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:[myDic objectForKey:@"projectname"]];
    [HYlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:HYlable];

    //融资额内容Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(130, 10+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:[myDic objectForKey:@"projectmoney"]];
    [RZElable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:RZElable];

    
    NSArray *array =[NSArray arrayWithObjects:@"定位:",@"行业:",@"融资额:", nil];
    NSArray *array2 =[NSArray arrayWithObjects:@"喜欢",@"看看",@"不看", nil];
    //NSArray *iconArray=[NSArray arrayWithObjects:
    NSArray *iconArray = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"52xiangmumingxi_icon3"],
                          [UIImage imageNamed:@"52xiangmumingxi_icon2"],
                          [UIImage imageNamed:@"52xiangmumingxi_icon1"] , nil];
    
    NSLog(@"=====%@",iconArray);
    for (int i =0 ; i < 3; i++) {
        //定位-融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 50, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:15]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];

        //线
        UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
        UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(RZElable.frame)+10, 300, 1)];
        [xianimage setImage:xianImage];
        [self.contentView addSubview:xianimage];
        
        //喜欢，看看，不看图标
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(230+(30*i), CGRectGetMaxY(RZElable.frame)+20, 26/2, 23/2)];
        [image setImage:[iconArray objectAtIndex:i]];
        [self.contentView addSubview:image];

        //喜欢，看看，不看button
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(230+(30*i), CGRectGetMaxY(RZElable.frame)+20, 26/2, 23/2)];
        [but setBackgroundColor:[UIColor clearColor]];
        [but setTag:i+1000];
        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
        
        //喜欢，看看，不看Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(227+(30*i), CGRectGetMaxY(RZElable.frame)+30, 20, 20)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont systemFontOfSize:10]];
        [lab2 setTextColor:[UIColor orangeColor]];
        [lab2 setText:[array2 objectAtIndex:i]];
        [lab2 setTextAlignment:NSTextAlignmentCenter];
        [lab2 setTag:10+i];
        [self.contentView addSubview:lab2];

      }
       */
    
   //2014.06.25 chenlihua  项目列表：把行业去掉，加上名称，纵列三个项目分别是“名称、一句话定位、融资金额”；
    
    //名称内容Label
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10+(20*0), 320 - 110 - 20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:[myDic objectForKey:@"projectname"]];
    [DWlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:DWlable];
    
    //一句话定位内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:[myDic objectForKey:@"projectposition"]];
    [HYlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:HYlable];
    
    //融资额内容Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(180, 10+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:[myDic objectForKey:@"projectmoney"]];
    [RZElable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:RZElable];
    
    
    NSArray *array =[NSArray arrayWithObjects:@"名称:",@"一句话定位:",@"融资金额:", nil];
    NSArray *array2 =[NSArray arrayWithObjects:@"喜欢",@"看看",@"不看", nil];
    //NSArray *iconArray=[NSArray arrayWithObjects:
    NSArray *iconArray = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"52xiangmumingxi_icon3"],
                          [UIImage imageNamed:@"52xiangmumingxi_icon2"],
                          [UIImage imageNamed:@"52xiangmumingxi_icon1"] , nil];
    
    NSLog(@"=====%@",iconArray);
    for (int i =0 ; i < 3; i++) {
        //定位-融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 100, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont fontWithName:KUIFont size:15]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];
        
        //线
        UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
        UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(RZElable.frame)+10, 300, 1)];
        [xianimage setImage:xianImage];
        [self.contentView addSubview:xianimage];
        
        //喜欢，看看，不看图标
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(230+(30*i), CGRectGetMaxY(RZElable.frame)+20, 26/2, 23/2)];
        [image setImage:[iconArray objectAtIndex:i]];
        [self.contentView addSubview:image];
        
        //喜欢，看看，不看button
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(230+(30*i), CGRectGetMaxY(RZElable.frame)+20, 26/2, 23/2)];
        [but setBackgroundColor:[UIColor clearColor]];
        [but setTag:i+1000];
        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
        
        //喜欢，看看，不看Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(227+(30*i), CGRectGetMaxY(RZElable.frame)+30, 20, 20)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont fontWithName:KUIFont size:10]];
        [lab2 setTextColor:[UIColor orangeColor]];
        [lab2 setText:[array2 objectAtIndex:i]];
        [lab2 setTextAlignment:NSTextAlignmentCenter];
        [lab2 setTag:10+i];
        [self.contentView addSubview:lab2];
        
    }

        UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 320,self.contentViewHeight-125)];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsVerticalScrollIndicator:YES];
        [scrollView setContentSize:CGSizeMake(320, 52*8)];
        [scrollView setDelegate:self];
        [self.contentView addSubview:scrollView];
    
       /*
        for (int k = 0; k < 5;  k ++) {
            NSArray *array=[NSArray arrayWithObjects:@"商业计划",@"项目文档",@"项目进度",@"企业团队",@"日程表", nil];
       
            //cell背景
            UIImage *image=[UIImage imageNamed:@"47_anniu_2"];
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
            [imageview setImage:image];
            [scrollView addSubview:imageview];

            //商业计划-日程表Label
            UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
            [lab2 setBackgroundColor:[UIColor clearColor]];
            [lab2 setFont:[UIFont systemFontOfSize:18]];
            [lab2 setTextAlignment:NSTextAlignmentCenter];
            [lab2 setTextColor:[UIColor orangeColor]];
            [lab2 setText:[array objectAtIndex:k]];
            [scrollView addSubview:lab2];

            //商业计划-日程表Button
            UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
            [but setFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
            [but setTag:k+100];
            [but addTarget:self action:@selector(butEventTouch:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:but];

        }
        */
    //2014 chenlihua  i001中把项目进度去掉
    for (int k = 0; k < 4;  k ++) {
        NSArray *array=[NSArray arrayWithObjects:@"商业计划",@"项目文档",@"企业团队",@"日程表", nil];
        
        //cell背景
        UIImage *image=[UIImage imageNamed:@"47_anniu_2"];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 40+(52*k), 507/2, 84/2)];
        [imageview setImage:image];
        [scrollView addSubview:imageview];
        
        //商业计划-日程表Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake((320-507/2)/2, 40+(52*k), 507/2, 84/2)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont fontWithName:KUIFont size:18]];
        [lab2 setTextAlignment:NSTextAlignmentCenter];
        [lab2 setTextColor:[UIColor orangeColor]];
        [lab2 setText:[array objectAtIndex:k]];
        [scrollView addSubview:lab2];
        
        //商业计划-日程表Button
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake((320-507/2)/2, 40+(52*k), 507/2, 84/2)];
        [but setTag:k+100];
        [but addTarget:self action:@selector(butEventTouch:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:but];
        
    }

    
        UIImage *image1=[UIImage imageNamed:@"47_anniu_3"];
        UIImage *image2=[UIImage imageNamed:@"47_anniu_4"];
    
        //与方创沟通Button
        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        [but1 setFrame:CGRectMake((320-507/2)/2, 280, 507/2., 66/2.)];
        [but1 setBackgroundImage:image1 forState:UIControlStateNormal];
        [but1 setTag:1000];
        [but1 setTitle:@"与方创沟通" forState:UIControlStateNormal];
        [but1 addTarget:self action:@selector(yufangchuangButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:but1];
        
        //与融资人沟通Button
        UIButton *but2=[UIButton buttonWithType:UIButtonTypeCustom];
        [but2 setFrame:CGRectMake((320-507/2)/2, 330, 507/2., 66/2.)];
        [but2 setBackgroundImage:image2 forState:UIControlStateNormal];
        [but2 setTag:1000];
        [but2 setTitle:@"与融资人沟通" forState:UIControlStateNormal];
        [but2 addTarget:self action:@selector(yutouzirenButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:but2];
}
#pragma -mark -functions
- (id)initSetTitle:(NSString *)title hangye:(NSString *)hangye rongzi:(NSString *)rongzi
{
    self=[super init];
    if (self) {
        //        [self setTitle:title];
        titleid = [[NSString alloc] initWithFormat:@"%@",title];
        hangYe = [[NSString alloc] initWithFormat:@"%@",hangye];
        rongZi = [[NSString alloc] initWithFormat:@"%@",rongzi];
    }
    return self;
}
-(void)setViewcontrollerTalkIdwith:(NSString *)callflag
{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"创建聊天成功",@"success" ,nil];
    [[NetManager sharedManager]getcallidWithUsername:[[UserInfo sharedManager] username]
                                       withprojectid:[myDic objectForKey:@"id"]
                                     andWithCallflag:callflag
                                              hudDic:dic
                                             success:^(id responseDic) {
                                                 ChatWithFriendViewController* viewControlelr = [[ChatWithFriendViewController alloc] init];
                                                 viewControlelr.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"dgid"];
                                                 viewControlelr.title=[[responseDic objectForKey:@"data"] objectForKey:@"dgname"];
                                                 viewControlelr.titleName=[[responseDic objectForKey:@"data"] objectForKey:@"dgname"];
                                                 
                                                 [self.navigationController pushViewController:viewControlelr animated:YES];
                                                 
                                                 
                                             }
                                                fail:^(id errorString) {
                                                    
                                                }];
    
}



#pragma  -mark -doClickAction
- (void)buttonEvent:(UIButton *)sender{
    if (sender.tag==1000) {
        NSLog(@"xihuan");
        [[NetManager sharedManager]sendeProjectClickWithProjectid:[myDic objectForKey:@"id"] cflag:[NSString stringWithFormat:@"%d",sender.tag-1000+1] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
            NSLog(@"responseDic=%@",responseDic);
            UILabel *valueLab=(UILabel *)[self.contentView viewWithTag:10];
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            [valueLab setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"clickid"]]];
        } fail:^(id errorString) {
            [self.view showActivityOnlyLabelWithOneMiao:errorString];
        }];
        
    }else if (sender.tag==1001){
        NSLog(@"kankan");
        [[NetManager sharedManager]sendeProjectClickWithProjectid:[myDic objectForKey:@"id"] cflag:[NSString stringWithFormat:@"%d",sender.tag-1000+1] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
            NSLog(@"responseDic=%@",responseDic);
            UILabel *valueLab=(UILabel *)[self.contentView viewWithTag:11];
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            [valueLab setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"clickid"]]];
        } fail:^(id errorString) {
            [self.view showActivityOnlyLabelWithOneMiao:errorString];
        }];
        
       
    }else{
        NSLog(@"bukan");
        [[NetManager sharedManager]sendeProjectClickWithProjectid:[myDic objectForKey:@"id"] cflag:[NSString stringWithFormat:@"%d",sender.tag-1000+1] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
            NSLog(@"responseDic=%@",responseDic);
            UILabel *valueLab=(UILabel *)[self.contentView viewWithTag:12];
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            [valueLab setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"clickid"]]];
        } fail:^(id errorString) {
            [self.view showActivityOnlyLabelWithOneMiao:errorString];
        }];

    }
}

//2014.06.25 chenlihua 最最原始代码
/*
- (void)butEventTouch:(UIButton *)sender{
    if (sender.tag==100) {
        NSLog(@"1");
        ShangYeJiHuaViewController *view=[[ShangYeJiHuaViewController alloc]init];
        view.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];
        
        
    }else if (sender.tag==101){
        NSLog(@"2");
        XiangMuWenDangViewController *view=[[XiangMuWenDangViewController alloc]init];
        view.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (sender.tag==102){
        NSLog(@"3");
        XiangMuJiDuViewController *view=[[XiangMuJiDuViewController alloc]init];
        view.ProId=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (sender.tag==103){
        NSLog(@"4");
        
        QiYeTuanDuiViewController* viewController = [[QiYeTuanDuiViewController alloc] init];
        viewController.proid=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];
        
        
        //        TouZiRenViewController *view=[[TouZiRenViewController alloc]init];
        //        view.proid = [myDic objectForKey:@"id"];
        //        NSLog(@"=====%@",view.proid);
        //        [self.navigationController pushViewController:view animated:YES];
        //        [view release];
        
    }else {
        NSLog(@"5");
        RiChengBiaoViewController* viewController = [[RiChengBiaoViewController alloc] init];
        viewController.proid=[self.myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}
*/

//2014.06.25 chenlihua i001中项目进度不可见。
- (void)butEventTouch:(UIButton *)sender{
    if (sender.tag==100) {
        NSLog(@"1");
        ShangYeJiHuaViewController *view=[[ShangYeJiHuaViewController alloc]init];
        view.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];

        
    }else if (sender.tag==101){
        NSLog(@"2");
        XiangMuWenDangViewController *view=[[XiangMuWenDangViewController alloc]init];
        view.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];

    /*
    }else if (sender.tag==102){
        NSLog(@"3");
        XiangMuJiDuViewController *view=[[XiangMuJiDuViewController alloc]init];
        view.ProId=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];
    */
    }else if (sender.tag==102){
        NSLog(@"4");
        
        QiYeTuanDuiViewController* viewController = [[QiYeTuanDuiViewController alloc] init];
        viewController.proid=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

        
//        TouZiRenViewController *view=[[TouZiRenViewController alloc]init];
//        view.proid = [myDic objectForKey:@"id"];
//        NSLog(@"=====%@",view.proid);
//        [self.navigationController pushViewController:view animated:YES];
//        [view release];

    }else {
        NSLog(@"5");
        RiChengBiaoViewController* viewController = [[RiChengBiaoViewController alloc] init];
        viewController.proid=[self.myDic objectForKey:@"id"];
        viewController.flag=@"2";
        [self.navigationController pushViewController:viewController animated:YES];

    }
}
//与方创沟通
- (void)yufangchuangButtonEvent:(UIButton *)sender{
    [self setViewcontrollerTalkIdwith:@"s"];
}
//与融资人沟通
- (void)yutouzirenButtonEvent:(UIButton *)sender{
     [self setViewcontrollerTalkIdwith:@"p"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
