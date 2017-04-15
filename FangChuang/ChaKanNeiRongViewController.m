//
//  ChaKanNeiRongViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//查看内容，日程表里的页面，暂时无用

#import "ChaKanNeiRongViewController.h"
#import "AddTimeViewController.h"

@interface ChaKanNeiRongViewController ()

@end

@implementation ChaKanNeiRongViewController
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
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [self setTabBarHidden:YES];
//    [self setTitle:@"查看内容"];
    self.titleLabel.text=@"查看内容";
    
    
	//右侧编辑按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [ rightButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:13]];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(BianJiEvent:) forControlEvents:UIControlEventTouchUpInside];
   [self addRightButton:rightButton isAutoFrame:NO];

    //cell背景图
    UIImage *imagebg=[UIImage imageNamed:@"43_shurukuang_1"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 155/2)];
    [imageView setImage:imagebg];
    [self.contentView addSubview:imageView];

    //第一行Label
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    [titleLab setTextColor:[UIColor orangeColor]];
    [Utils setDefaultFont:titleLab size:18];
    [titleLab setFont:[UIFont fontWithName:KUIFont size:18]];
    [titleLab setText:@"东方明珠开会"];
    [self.contentView addSubview:titleLab];

    //参与人Label:
    UILabel *canYuLab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame)+3, 60, 15)];
    [canYuLab setBackgroundColor:[UIColor clearColor]];
    [canYuLab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:canYuLab size:16];
    [canYuLab setFont:[UIFont fontWithName:KUIFont size:16]];
    [canYuLab setText:@"参与人:"];
    [self.contentView addSubview:canYuLab];

    //参与人内容Label
    UILabel *cYNRLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(canYuLab.frame)+3, CGRectGetMaxY(titleLab.frame), 200, 15)];
    [cYNRLab setBackgroundColor:[UIColor clearColor]];
    [cYNRLab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:cYNRLab size:16];
    [cYNRLab setFont:[UIFont fontWithName:KUIFont size:16]];
    [cYNRLab setText:@"mane+name+mane"];
    [self.contentView addSubview:cYNRLab];

    //日期Label
    UILabel *riqiLab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(canYuLab.frame)+3, 200, 15)];
    [riqiLab setBackgroundColor:[UIColor clearColor]];
    [riqiLab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:riqiLab size:16];
    [riqiLab setFont:[UIFont fontWithName:KUIFont size:16]];
    [riqiLab setText:@"2013年10月28日星期一"];
    [self.contentView addSubview:riqiLab];

    //时间Label
    UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(riqiLab.frame)+3, 200, 15)];
    [timeLab setBackgroundColor:[UIColor clearColor]];
    [timeLab setTextColor:[UIColor grayColor]];
    [Utils setDefaultFont:timeLab size:16];
    [timeLab setFont:[UIFont fontWithName:KUIFont size:16]];
    [timeLab setText:@"8:00-11:00"];
    [self.contentView addSubview:timeLab];
}
#pragma -mark -doClickAction
//编辑按钮
- (void)BianJiEvent:(UIButton*)sender{
    AddTimeViewController *vc = [[AddTimeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
