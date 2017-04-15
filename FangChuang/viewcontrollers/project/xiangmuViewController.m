//
//  xiangmuViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//项目列表详细信息，与方创沟通，与投资人沟通。 p001
#import "xiangmuViewController.h"

#import "ShangYeJiHuaViewController.h"
#import "XiangMuWenDangViewController.h"
#import "XiangMuJiDuViewController.h"
#import "TouZiRenViewController.h"
#import "RiChengBiaoViewController.h"
#import "ChatWithFriendViewController.h"
#import "CacheImageView.h"
#import "AddNewProjectViewController.h"

//2014.07.22 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface xiangmuViewController ()
{
    NSMutableArray* dataArray;
    NSDictionary* myDic;
    CacheImageView *headerImage;
}
@end

@implementation xiangmuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    dispatch_async(kBgQueue, ^{
        [self loadData];
    });
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:17]];
//    [self setTitle:@"项目详细信息"];
    self.titleLabel.text = @"项目详细信息";
    [self setTabBarHidden:NO];
    [self setTitle:titleid];
    [self setTabBarIndex:1];
	// Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc] init];
    [self addViewElement];
}
#pragma -mark -functions
- (void)loadData
{
    [[NetManager sharedManager]getProjectListWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {


        [dataArray addObjectsFromArray:[[responseDic objectForKey:@"data"] objectForKey:@"projectlist"]];
        
        myDic = [[NSDictionary alloc] initWithDictionary:[dataArray objectAtIndex:0]];
        
        [DWlable setText:[myDic objectForKey:@"projectposition"]];
        [HYlable setText:[myDic objectForKey:@"projectindustry"]];
        [RZElable setText:[myDic objectForKey:@"projectmoney"]];
        
       // [headerImage getImageFromURL:[NSURL URLWithString:[myDic objectForKey:@"projectpicture"]]];
        //2014.07.22 chenlihua 修改图片缓存方式
        [headerImage setImageWithURL:[NSURL URLWithString:[myDic objectForKey:@"projectpicture"]]];

//        if ([[[UserInfo sharedManager] username] isEqualToString:[myDic objectForKey:@"projectname"]]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                AddNewProjectViewController* viewController = [[AddNewProjectViewController alloc] init];
//                [self.navigationController pushViewController:viewController animated:YES];
//            
//            });
//            
////            [self addNewProjectView];
//        }
        
    } fail:^(id errorString) {
        [self.view showActivityOnlyLabelWithOneMiao:errorString];
    }];
}
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

- (void)addNewProjectView{
    
    //直接跳转到下一页
    
}
- (void)addViewElement{
    
//    [self setTitle:[myDic objectForKey:@"projectname"]];

    //cell背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 80)];
    [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
    [self.contentView addSubview:imageView];
    
    //头像
    UIImage *image=[UIImage imageNamed:@"47_anniu_1"];
    headerImage=[[CacheImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    [headerImage setImage:image];
    [self.contentView addSubview:headerImage];
  
    
    //2014.07.27 chenlihua 修改头像
    
    
    /*
    //定位内容Label
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(120, 10+(20*0), 320 - 120 - 20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:titleid];
    [DWlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:DWlable];
    
    //行业内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(120, 10+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:hangYe];
    [HYlable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:HYlable];
    
    //融资额内容Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(130, 10+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:rongZi];
    [RZElable setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:RZElable];
    
    for (int i =0 ; i < 3; i++) {
        NSArray *array =[NSArray arrayWithObjects:@"定位:",@"行业:",@"融资额:", nil];
        //定位，行业，融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 50, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:14]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];
        
    }
    */
    
    //2014.06.25 chenlihua 项目列表：把行业去掉，加上名称，纵列三个项目分别是“名称、一句话定位、融资金额”；
    
    //名称内容Label
    DWlable=[[UILabel alloc]initWithFrame:CGRectMake(170, 10+(20*0), 320 - 120 - 20, 20)];
    [DWlable setBackgroundColor:[UIColor clearColor]];
    [DWlable setText:titleid];
    [DWlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:DWlable];
    
    //一句话定位内容Label
    HYlable=[[UILabel alloc]initWithFrame:CGRectMake(170, 10+(20*1), 150, 20)];
    [HYlable setBackgroundColor:[UIColor clearColor]];
    [HYlable setText:hangYe];
    [HYlable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:HYlable];
    
    //融资金额内容Label
    RZElable=[[UILabel alloc]initWithFrame:CGRectMake(180, 10+(20*2), 150, 20)];
    [RZElable setBackgroundColor:[UIColor clearColor]];
    [RZElable setTextColor:[UIColor orangeColor]];
    [RZElable setText:rongZi];
    [RZElable setFont:[UIFont fontWithName:KUIFont size:14]];
    [self.contentView addSubview:RZElable];
    
    for (int i =0 ; i < 3; i++) {
        NSArray *array =[NSArray arrayWithObjects:@"名称:",@"一句话定位:",@"融资金额:", nil];
        //定位，行业，融资额Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)+10, 10+(20*i), 100, 20)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont fontWithName:KUIFont size:14]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:i]];
        [self.contentView addSubview:lab];
        
    }

    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 320,self.contentViewHeight-80)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setContentSize:CGSizeMake(320, 52*8)];
    [scrollView setDelegate:self];
    [self.contentView addSubview:scrollView];
    
     NSArray *array=[NSArray arrayWithObjects:@"融资方案",@"项目文档",@"项目进度",@"投资人",@"日程表", nil];
    for (int k = 0; k < 5;  k ++) {
        //黄色背景框
        UIImage *image=[UIImage imageNamed:@"47_anniu_2"];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
        [imageview setImage:image];
        [scrollView addSubview:imageview];
        
        //融资方案-日程表 Label
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
        [lab2 setBackgroundColor:[UIColor clearColor]];
        [lab2 setFont:[UIFont fontWithName:KUIFont size:18]];
        [lab2 setTextAlignment:NSTextAlignmentCenter];
        [lab2 setTextColor:[UIColor orangeColor]];
        [lab2 setText:[array objectAtIndex:k]];
        [scrollView addSubview:lab2];
        
        //button按钮
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake((320-507/2)/2, 10+(52*k), 507/2, 84/2)];
        [but setTag:k+100];
        [but addTarget:self action:@selector(butEventTouch:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:but];
    }
    
    UIImage *image1=[UIImage imageNamed:@"47_anniu_3"];
    UIImage *image2=[UIImage imageNamed:@"47_anniu_4"];
    
    //与方创沟通Button
    UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setFrame:CGRectMake((320-507/2)/2, 280, 507/2, 66/2)];
    [but1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [but1 setTag:1000];
    [but1.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
//    [but1 setTitle:@"与方创沟通" forState:UIControlStateNormal];
    but1.titleLabel.text = @"与方创沟通";
    [but1 addTarget:self action:@selector(yufangchuangButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:but1];
    
    //与投资人沟通Button
    UIButton *but2=[UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setFrame:CGRectMake((320-507/2)/2, 330, 507/2, 66/2)];
    [but2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [but2 setTag:1000];
//    [but2 setTitle:@"与投资人沟通" forState:UIControlStateNormal];
    [but2.titleLabel setFont:[UIFont fontWithName:KUIFont size:14]];
    //    [but1 setTitle:@"与方创沟通" forState:UIControlStateNormal];
    but2.titleLabel.text = @"与投资人沟通";
    [but2 addTarget:self action:@selector(yutouzirenButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:but2];
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
    }else if (sender.tag==1001){
        NSLog(@"kankan");
    }else{
        NSLog(@"bukan");
    }
}
- (void)butEventTouch:(UIButton *)sender{
    if (sender.tag==100) {
        NSLog(@"1");
         ShangYeJiHuaViewController *view=[[ShangYeJiHuaViewController alloc]init];
        [view setProid:[myDic objectForKey:@"id"]];
        [self.navigationController pushViewController:view animated:YES];

    }else if (sender.tag==101){
        NSLog(@"2");
        XiangMuWenDangViewController* viewController = [[XiangMuWenDangViewController alloc] init];
        [viewController setProid:[myDic objectForKey:@"id"]];

        [self.navigationController pushViewController:viewController animated:YES];

        
    }else if (sender.tag==102){
        NSLog(@"3");
        XiangMuJiDuViewController* viewController = [[XiangMuJiDuViewController alloc] init];
        [viewController setProId:[myDic objectForKey:@"id"]];

        [self.navigationController pushViewController:viewController animated:YES];


    }else if (sender.tag==103){
        NSLog(@"4");
        TouZiRenViewController* viewController = [[TouZiRenViewController alloc] init];
        [viewController setProid:[myDic objectForKey:@"id"]];

        [self.navigationController pushViewController:viewController animated:YES];


    }else {
        NSLog(@"5");
        RiChengBiaoViewController* viewController = [[RiChengBiaoViewController alloc] init];
        [viewController setProid:[myDic objectForKey:@"id"]];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    
}
//p:企业方
//s:方创
//i:投资人
//与方创沟通
- (void)yufangchuangButtonEvent:(UIButton *)sender{
    
    [self setViewcontrollerTalkIdwith:@"s"];
    
}
//与投资人沟通
- (void)yutouzirenButtonEvent:(UIButton *)sender{
    
    [self setViewcontrollerTalkIdwith:@"i"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
