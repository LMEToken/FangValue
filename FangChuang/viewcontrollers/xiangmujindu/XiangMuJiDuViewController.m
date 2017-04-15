//
//  XiangMuJiDuViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//项目进度
#import "XiangMuJiDuViewController.h"

@interface XiangMuJiDuViewController ()
@property(nonatomic,copy) NSString * num;
@end

@implementation XiangMuJiDuViewController
@synthesize ProId=_ProId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadData
{
    [[NetManager sharedManager]getprojectscheduleWithProjectid:_ProId
username:[[UserInfo sharedManager]username]
hudDic:nil
success:^(id responseDic) {
    NSLog(@"%@",responseDic);
    dic=[[NSDictionary alloc]init];
    dic=[responseDic objectForKey:@"data"];
    NSDictionary *dic1=[NSDictionary dictionaryWithDictionary:[dic objectForKey:@"object_score"]];
    NSLog(@"----dic1----%@",dic1);
    [self initZhuView:[NSArray arrayWithObjects:
                       [dic1 objectForKey:@"1"],
                       [dic1 objectForKey:@"2"],
                       [dic1 objectForKey:@"3"],
                       [dic1 objectForKey:@"4"],
                       [dic1 objectForKey:@"5"],
                       [dic1 objectForKey:@"6"],
                       [dic1 objectForKey:@"7"],
                       [dic1 objectForKey:@"8"],
                       [dic1 objectForKey:@"9"], nil]];
    /*-dic1----{
        1 = 0;
        2 = 102;
        3 = 41;
        4 = 0;
        5 = 50;
        6 = 0;
        7 = 0;
        8 = 0;
        9 = 15;
    }*/

    //用来控制，哪部分显示红色，哪部分不显示红色。
    self.num=[Utils getString:[dic objectForKey:@"object_plan"]];
    //self.num = [NSString stringWithFormat:@"%@",@"9"];
    //用来控制，哪部分显示红色，哪部分不显示红色。
    [self initView];

}
fail:^(id errorString) {
    
}];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:@"项目进度"];
    [self setTabBarHidden:YES];
    [self addBackButton];
    [self loadData];
    
    NSLog(@"%@",dic);
    
    //第一栏连线。
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(5, 20, 310, 10)];
    backView.tag = 200;
    [backView setBackgroundColor:ORANGE];
    //backView.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:backView];

    NSArray* array = [NSArray arrayWithObjects:@"团队组建",@"方案设定",@"融资路演",@"初步调查", nil];
    for (int i = 1 ; i < 5; i ++) {
         // 23 * 23
        //数字后，白色的圈圈背景图
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30 + (i - 1) * (240 / 3.), CGRectGetMidY(backView.frame) - 23 / 2., 23., 23 )];
        [imageView setImage:[UIImage imageNamed:@"3zhucemingpian_iconweixuanzhong02"]];
        [self.contentView addSubview:imageView];
        imageView.tag=i;
        
        //数字1,2,3,4,Label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectInset(imageView.frame, 2, 2)];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[NSString stringWithFormat:@"%d",i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:label];

       //团队组建等Label
        UILabel* titleLb= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(label.frame) - 25, CGRectGetMaxY(imageView.frame) + 10, 50, 15)];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [titleLb setFont:[UIFont systemFontOfSize:12]];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setText:[array objectAtIndex:i - 1]];
        [self.contentView addSubview:titleLb];
    }
   //第二栏连线背景
    UIView* backView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 80 , 310, 10)];
    backView1.tag = 300;
    [backView1 setBackgroundColor:ORANGE];
   // backView1.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:backView1];

    NSArray* array1 = [NSArray arrayWithObjects:@"框架协议",@"尽职调查",@"投资协议",@"法律重组",@"股份交割", nil];
    for (int i = 5 ; i < 10; i ++) {
        
        // 23 * 23
        //数字后的白色圈圈背景
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + (i - 5) * (260 / 4.), CGRectGetMidY(backView1.frame) - 23 / 2., 23., 23 )];
        [imageView setImage:[UIImage imageNamed:@"3zhucemingpian_iconweixuanzhong02"]];
       [self.contentView addSubview:imageView];

        //数字5-9Label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectInset(imageView.frame, 2, 2)];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[NSString stringWithFormat:@"%d",i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:label];

        //框架协议等Label
        UILabel* titleLb= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(label.frame) - 25, CGRectGetMaxY(imageView.frame) + 10, 50, 15)];
        [titleLb setBackgroundColor:[UIColor clearColor]];
        [titleLb setFont:[UIFont systemFontOfSize:12]];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setText:[array1 objectAtIndex:i - 5]];
        [self.contentView addSubview:titleLb];

        if (i == 3) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMinY(backView1.frame), 310 - CGRectGetMaxX(imageView.frame) + 5, CGRectGetHeight(backView1.frame))];
            [view setBackgroundColor:[UIColor grayColor]];
            [self.contentView addSubview:view];
        }
    }
    int height = 0;
    if ([[UIScreen mainScreen] bounds].size.height > 480) {
         height = 25;
    }
    //项目进度分:Label
    UILabel* typeLb  =[[UILabel alloc] initWithFrame:CGRectMake(10, 130 + height, 300, 20)];
    [typeLb setBackgroundColor:[UIColor clearColor]];
    [typeLb setTextColor:ORANGE];
    [typeLb setText:@"项目进度分:"];
    [typeLb setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:typeLb];

    //项目进度分:白色背景
    UIImageView* btmImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(typeLb.frame) + 5, 310, 120)];
    [btmImgV setImage:[UIImage imageNamed:@"46_shurukuang_1"]];
    [self.contentView addSubview:btmImgV];

    //项目进度分:内容
    NSArray* titles = [NSArray arrayWithObjects:@"团队组建",@"方案设定",@"融资路演",@"初步调查",@"框架协议",@"尽职调查",@"投资协议",@"法律重组",@"股份交割", nil];
    CGFloat y = CGRectGetMinY(btmImgV.frame) + 5;
    for (int i = 1; i <=  titles.count; i ++) {
        //1，团队组建类似Label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((i % 2) ? 10 : 170, y , 150, 15)];
        [label setText:[NSString stringWithFormat:@"%d、%@",i,[titles objectAtIndex:i - 1]]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:label];
        
        if ((i % 2) == 0) {
            y = CGRectGetMaxY(label.frame) + 3;
        }

    }
    [btmImgV setFrame:CGRectMake(5, CGRectGetMaxY(typeLb.frame) + 5, 310, y + 3 - CGRectGetMaxY(typeLb.frame) - 5 + 20)];
//    [self loadData];
//    NSDictionary *dic1=[NSDictionary dictionaryWithDictionary:[self.dic objectForKey:@"object_score"]];
//    [self initZhuView:[NSArray arrayWithObjects:
//                       [dic1 objectForKey:@"1"],
//                       [dic1 objectForKey:@"2"],
//                       [dic1 objectForKey:@"3"],
//                       [dic1 objectForKey:@"4"],
//                       [dic1 objectForKey:@"5"],
//                       [dic1 objectForKey:@"6"],
//                       [dic1 objectForKey:@"7"],
//                       [dic1 objectForKey:@"8"],
//                       [dic1 objectForKey:@"9"], nil]];
}
#pragma -mark -functins
//用来控制，哪部分显示红色，哪部分不显示红色
- (void)initView
{
    NSLog(@"------=%d",[self.num intValue]);
    int x;
    if([self.num intValue] <4)
    {
        if([self.num intValue] == 0)
        {
            x = 5;
        }
        else
        {
            x = 30 + ([self.num intValue] - 1) * (240/3)+22;
        }

        //第一行，黄色的后面的变为灰色
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(x,20 ,315-x ,10) ];
        [view setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:view];

        
        UIView *back = (UIView *)[self.contentView viewWithTag:200];
        [self.contentView insertSubview:view aboveSubview:back];
        
        UIView *sendView= [[UIView alloc] initWithFrame:CGRectMake(5,80 ,310 ,10) ];
        [sendView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:sendView];

        UIView *backView = (UIView *)[self.contentView viewWithTag:300];
        [self.contentView insertSubview:sendView aboveSubview:backView];
       // [self.contentView insertSubview:sendView atIndex:2];
    }
    else
    {
        if([self.num intValue] == 4)
        {
//            x = 5;
        }
        if([self.num intValue] == 9)
        {
            x = 315;
        }
        else
        {
            x = 20 + ([self.num intValue] - 5) * (260/4)+22;
        }
        UIView *sendView= [[UIView alloc] initWithFrame:CGRectMake(x,80 ,315-x,10) ];
        [sendView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:sendView];

        
        UIView *backView = (UIView *)[self.contentView viewWithTag:300];
        [self.contentView insertSubview:sendView aboveSubview:backView];
    }
}
- (void)initZhuView:(NSArray*)days
{

    if ([[UIScreen mainScreen] bounds].size.height > 480) {
         zhuView = [[UIView alloc] initWithFrame:CGRectMake(0, 310 - 45 + 50, 320, 150)];
    }
    else
    {
        zhuView = [[UIView alloc] initWithFrame:CGRectMake(0, 310 - 45, 320, 150)];
    }
    //柱状图所在的背景图
    //zhuView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:zhuView];
    
    //0天，50天，100天所在的竖线
    UIView* shuView = [[UIView alloc] initWithFrame:CGRectMake(55, 0, 1, 120)];
    [shuView setBackgroundColor:ORANGE];
    [zhuView addSubview:shuView];

    //0-9所在的横线
    UIView* hengView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(shuView.frame), CGRectGetMaxY(shuView.frame), 320 - CGRectGetMinX(shuView.frame) - 20, 1)];
    [hengView setBackgroundColor:ORANGE];
    [zhuView addSubview:hengView];
    
    
    NSArray* titles = [NSArray arrayWithObjects:@"100天",@"50天",@"0天", nil];
    for (int i = 0 ; i < 3; i++) {
        //天数所在Label
        UILabel* yibaiLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 + i* 50, 53, 15)];
        [yibaiLb setText:[titles objectAtIndex:i]];
        [yibaiLb setTextAlignment:NSTextAlignmentRight];
        [yibaiLb setFont:[UIFont systemFontOfSize:14]];
        [yibaiLb setBackgroundColor:[UIColor clearColor]];
        [zhuView addSubview:yibaiLb];
    }

    for (int i = 0; i < [days count]; i++) {
        
        int height = [[days objectAtIndex:i] intValue];
        if(height>=100)
            height=100;
        
        //红色的竖线的柱状图
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuView.frame) + 10 + i*25, CGRectGetMinY(hengView.frame) - height, 15, height)];
        [imageView setBackgroundColor:[UIColor redColor]];
        [zhuView addSubview:imageView];

        //柱状图上的红色的数字Label
        UILabel* dayLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) - 5, CGRectGetMinY(imageView.frame) - 10, 25, 10)];
        [dayLB setTextAlignment:NSTextAlignmentCenter];
        [dayLB setBackgroundColor:[UIColor clearColor]];
        [dayLB setFont:[UIFont systemFontOfSize:10]];
        [dayLB setText:[NSString stringWithFormat:@"%d",[[days objectAtIndex:i] intValue]]];
        [zhuView addSubview:dayLB];
        
        //1-9的数字所在的Label
        UILabel* diLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMaxY(hengView.frame) , 15, 20)];
        [diLb setText:[NSString stringWithFormat:@"%d",i+1]];
        [diLb setBackgroundColor:[UIColor clearColor]];
        [diLb setTextAlignment:NSTextAlignmentCenter];
        [diLb setFont:[UIFont systemFontOfSize:14]];
        [zhuView addSubview:diLb];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
