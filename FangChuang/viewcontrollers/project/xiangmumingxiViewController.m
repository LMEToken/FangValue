//
//  xiangmumingxiViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//与投资人沟通，与企业沟通 t001
#import "xiangmumingxiViewController.h"
#import "ShangYeJiHuaViewController.h"
#import "XiangMuWenDangViewController.h"
#import "XiangMuJiDuViewController.h"
#import "TouZiRenViewController.h"
#import "RiChengBiaoViewController.h"
#import "AProjectViewController.h"
#import "ChatWithFriendViewController.h"
#import "QiYeTuanDuiViewController.h"

//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"

@interface xiangmumingxiViewController ()

@end

@implementation xiangmumingxiViewController
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
    [self setTitle:[myDic objectForKey:@"projectname"]];

    //背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 250/2)];
    [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
    [self.contentView addSubview:imageView];

    //头像
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
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 320 - 110 -20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:[myDic objectForKey:@"projectposition"]];
    [DWlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:DWlable];

    //行业内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(110, 15+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:[myDic objectForKey:@"projectname"]];
    [HYlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:HYlable];

    //融资额Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(130, 20+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:[myDic objectForKey:@"projectmoney"]];
    [RZElable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:RZElable];
    
    for (int i =0 ; i < 3; i++) {
        NSArray *array =[NSArray arrayWithObjects:@"定位:",@"行业:",@"融资额:", nil];
        //NSArray *array2 =[NSArray arrayWithObjects:@"显示",@"投资人",@"点击数", nil];
//        NSArray *iconArray=[NSArray arrayWithObjects:
//                            [UIImage imageNamed:@"57_tubiao_3"],
//                            [UIImage imageNamed:@"57_tubiao_2"],
//                            [UIImage imageNamed:@"57_tubiao_1"] , nil];
        //定位-融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+25*i, 50, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:14]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];

    }
    
    */
    //2014.06.25 chenlihua 项目列表：把行业去掉，加上名称，纵列三个项目分别是“名称、一句话定位、融资金额”；
    
    //名称内容Label
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 10, 320 - 110 -20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:[myDic objectForKey:@"projectname"]];
    [DWlable setFont:[UIFont systemFontOfSize:14]];
    [DWlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:DWlable];
    
    //一句话定位内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(160, 15+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:[myDic objectForKey:@"projectposition"]];
    [HYlable setFont:[UIFont systemFontOfSize:14]];
    [HYlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:HYlable];
    
    //融资金额Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(180, 20+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:[myDic objectForKey:@"projectmoney"]];
    [RZElable setFont:[UIFont systemFontOfSize:14]];
    [RZElable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:RZElable];
    
    for (int i =0 ; i < 3; i++) {
        NSArray *array =[NSArray arrayWithObjects:@"名称:",@"一句话定位:",@"融资金额:", nil];
        //NSArray *array2 =[NSArray arrayWithObjects:@"显示",@"投资人",@"点击数", nil];
        //        NSArray *iconArray=[NSArray arrayWithObjects:
        //                            [UIImage imageNamed:@"57_tubiao_3"],
        //                            [UIImage imageNamed:@"57_tubiao_2"],
        //                            [UIImage imageNamed:@"57_tubiao_1"] , nil];
        //定位-融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+25*i, 100, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
       // [lab setFont:[UIFont systemFontOfSize:14]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [lab setFont:[UIFont fontWithName:KUIFont size:14]];
        [self.contentView addSubview:lab];
        
    }
   
       //线
        UIImage *xianImage=[UIImage imageNamed:@"46_xian_1"];
        UIImageView *xianimage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(RZElable.frame)+10, 300, 1)];
        [xianimage setImage:xianImage];
        [self.contentView addSubview:xianimage];

       //2014.07.04 chenhua 将t001的点击数去掉
    /*
        //点击数图标
        UIImageView *countImage=[[UIImageView alloc]initWithFrame:CGRectMake(220+35, CGRectGetMaxY(RZElable.frame)+15, 26/2, 23/2)];
        [countImage setImage:[UIImage imageNamed:@"57_tubiao_1"]];
        [self.contentView addSubview:countImage];

        //点击数button
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(220+35, CGRectGetMaxY(RZElable.frame)+20, 26/2, 23/2)];
        [but setBackgroundColor:[UIColor clearColor]];
        //[but setTag:i+1000];
        [but setTag:1005];
        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
    
        //点击数Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(200+35, CGRectGetMaxY(RZElable.frame)+25, 50, 20)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont systemFontOfSize:10]];
        [lab2 setTextColor:[UIColor orangeColor]];
        [lab2 setText:@"点击数：0"];
        [lab2 setTextAlignment:NSTextAlignmentCenter];
        //[lab2 setTag:10+i];
        [lab2 setTag:15];
    
        [self.contentView addSubview:lab2];
         */
    //}
    
    //背景色
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 320,self.contentViewHeight-125)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setContentSize:CGSizeMake(320, 52*9)];
    [scrollView setDelegate:self];
    [self.contentView addSubview:scrollView];
    
    NSArray *array=[NSArray arrayWithObjects:@"商业计划",@"项目文档",@"项目进度",@"企业团队",@"投资人",@"日程表", nil];
    for (int k = 0; k < 6;  k ++) {
        //黄色背景框
        UIImage *image=[UIImage imageNamed:@"47_anniu_2"];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
        [imageview setImage:image];
        [scrollView addSubview:imageview];

        //商业计划-日程表Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont fontWithName:KUIFont size:18]];
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
    
    
   // UIImage *image1=[UIImage imageNamed:@"47_anniu_3"];
    UIImage *image1=[UIImage imageNamed:@"47_anniu_4"];
    UIImage *image2=[UIImage imageNamed:@"47_anniu_4"];
    
   // 与投资人沟通button
    UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setFrame:CGRectMake((320-507/2)/2, 330, 507/2, 66/2)];
    [but1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [but1.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [but1 setTag:1000];
    [but1 setTitle:@"与投资人沟通" forState:UIControlStateNormal];
    // but1.titleLabel.text = @"与投资人沟通";
    [but1 addTarget:self action:@selector(yufangchuangButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:but1];
    
    //与企业沟通Button
    UIButton *but2=[UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setFrame:CGRectMake((320-507/2)/2, 380, 507/2, 66/2)];
    [but2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [but2.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    [but2 setTag:1000];
    //    [but1 setTitle:@"与投资人沟通" forState:UIControlStateNormal];
  //  but2.titleLabel.text = @"与企业沟通";
   [but2 setTitle:@"与企业沟通" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(yutouzirenButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:but2];
}
#pragma -mark -functions
- (id)initSetTitle:(NSString *)title hangye:(NSString *)hangye rongzi:(NSString *)rongzi
{
    self=[super init];
    if (self) {
        titleid = [[NSString alloc] initWithFormat:@"%@",title];
        hangYe = [[NSString alloc] initWithFormat:@"%@",hangye];
        rongZi = [[NSString alloc] initWithFormat:@"%@",rongzi];
    }
    return self;
}
-(void)setViewcontrollerTalkIdwith:(NSString *)callflag
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"创建聊天成功",@"success" ,nil];
    NSLog(@"---%@--dic",dic);
    NSLog(@"----id--%@",[myDic objectForKey:@"id"]);
    NSLog(@"----callflag--%@",callflag);
    NSLog(@"-----username---%@",[[UserInfo sharedManager] username]);
    
    [[NetManager sharedManager]getcallidWithUsername:[[UserInfo sharedManager] username]
                                       withprojectid:[myDic objectForKey:@"id"]
                                     andWithCallflag:callflag
                                              hudDic:dic
                                             success:^(id responseDic) {
                                                 
                                                 NSLog(@"--responseDic--%@",responseDic);
                                                 
                                                 NSLog(@"--data-%@",[responseDic objectForKey:@"data"]);
                                                 
                                                 NSString *str=[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"data"]];
                                                 NSLog(@"---%@--str",str);
                                                 if ([str isEqualToString:@"0"]) {
                                                     
                                                     NSLog(@"---为0-----");
                                                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"此讨论组不存在" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                     [alert show];
                                                     
                                                 }else{
                                                     NSLog(@"---非0----");
                                                     ChatWithFriendViewController* viewControlelr = [[ChatWithFriendViewController alloc] init];
                                                     viewControlelr.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"dgid"];
                                                     viewControlelr.title=[[responseDic objectForKey:@"data"] objectForKey:@"dgname"];
                                                     viewControlelr.titleName=[[responseDic objectForKey:@"data"] objectForKey:@"dgname"];
                                                     
                                                     [self.navigationController pushViewController:viewControlelr animated:YES];
                                                 }
                                                 
                                                 
                                                 
                                                 
                                                 
                                             }
                                                fail:^(id errorString) {
                                                    NSLog(@"---errorString--%@",errorString);
                                                }];
    
}
#pragma  -mark -doClickAction
//点击数点击按钮

- (void)buttonEvent:(UIButton *)sender{
    
    NSLog(@"buttonEvent:sender..................................");
    [[NetManager sharedManager]sendeProjectClickWithProjectid:[myDic objectForKey:@"id"] cflag:[NSString stringWithFormat:@"%d",sender.tag-1000+1] username:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        
        NSLog(@"responseDic=%@",responseDic);
        
        UILabel *valueLab=(UILabel *)[self.contentView viewWithTag:15];
        NSDictionary *dic = [responseDic objectForKey:@"data"];
        [valueLab setFont:[UIFont fontWithName:KUIFont size:15]];
        [valueLab setText:[NSString stringWithFormat:@"点击数:%@",[dic objectForKey:@"clickid"]]];
        NSLog(@"***************dic %@************",[dic objectForKey:@"clickid"]);
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
    NSLog(@"buttonClickFinished..................................");
}


- (void)butEventTouch:(UIButton *)sender{
    if (sender.tag==100) {
        NSLog(@"1");
        ShangYeJiHuaViewController *view=[[ShangYeJiHuaViewController alloc]init];
        view.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:view animated:YES];

        
    }else if (sender.tag==101){
        NSLog(@"2");
        XiangMuWenDangViewController* viewController = [[XiangMuWenDangViewController alloc] init];
        viewController.proid = [myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

        
    }else if (sender.tag==102){
        NSLog(@"3");
        XiangMuJiDuViewController* viewController = [[XiangMuJiDuViewController alloc] init];
        viewController.ProId=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }else if (sender.tag==103){
        NSLog(@"4");
        QiYeTuanDuiViewController* viewController = [[QiYeTuanDuiViewController alloc] init];
        viewController.proid=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }else if (sender.tag==104){
        NSLog(@"4");
        TouZiRenViewController* viewController = [[TouZiRenViewController alloc] init];
        viewController.proid=[myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

        
        
    }else {
        NSLog(@"5");
        RiChengBiaoViewController* viewController = [[RiChengBiaoViewController alloc] init];
        viewController.proid=[self.myDic objectForKey:@"id"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
//与企业沟通
- (void)yufangchuangButtonEvent:(UIButton *)sender{
    [self setViewcontrollerTalkIdwith:@"i"];
}
//与投资人沟通
- (void)yutouzirenButtonEvent:(UIButton *)sender{
    [self setViewcontrollerTalkIdwith:@"p"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
