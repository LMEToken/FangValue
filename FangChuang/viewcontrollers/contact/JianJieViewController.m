//
//  JianJieViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//
//个人简介

#import "JianJieViewController.h"
#import "CacheImageView.h"
#import "ChatWithFriendViewController.h"
//2014.07.23 chenlihua 修改图片的缓存方式
#import "UIImageView+WebCache.h"
@interface JianJieViewController ()

@end

@implementation JianJieViewController
@synthesize myDiction;
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
    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	[self addBackButton];
    [self setTabBarHidden:YES];
//    [self setTitle:@"简介"];
    _dataDic = [[NSDictionary alloc] init];
//    [self loadData];
    
    //背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 245)];
    [imageView setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [self.contentView addSubview:imageView];
 
    //头像:Label
    UILabel *headlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 25)];
    [headlab setBackgroundColor:[UIColor clearColor]];
    [headlab setTextColor:[UIColor orangeColor]];
    [headlab setFont:[UIFont systemFontOfSize:15]];
    [headlab setText:@"头像:"];
    [headlab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:headlab];

    //头像图片
    //2014.07.23 chenlihua 修改头像
    /*
    UIImage *image=[UIImage imageNamed:@"chatHeadImage"];
    //CacheImageView *headimageView=[[CacheImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
    CacheImageView *headimageView = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(320-55, 8, 46, 46)];
    [headimageView setBackgroundColor:[UIColor clearColor]];
    //[headimageView setImage:[UIImage imageNamed:@"61_touxiang_1"]];
    [headimageView getImageFromURL:[NSURL URLWithString:[myDiction objectForKey:@"picurl"]]];
    [self.contentView addSubview:headimageView];
    */
    
    
    //2014.07.23 chenlihua 修改头像
//    UIImage *image=[UIImage imageNamed:@"chatHeadImage"];
    UIImageView *headimageView = [[UIImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
    [headimageView setBackgroundColor:[UIColor clearColor]];
    NSLog(@"%@",myDiction);
//    [headimageView setImageWithURL:[NSURL URLWithString:[myDiction objectForKey:@"username"]] placeholderImage:image];
    
    NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
    
    NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[myDiction objectForKey:@"username"],   [[UserInfo sharedManager]username]]];
    [headimageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    
    [headimageView.layer setCornerRadius:8.0f];
    [headimageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:headimageView];
    

    for (int i=1; i<5; i++) {
        //分割线
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5+45*i, 300, 1)];
        [imageView setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [self.contentView addSubview:imageView];

        //手机等字的Label
        NSArray *array=[NSArray arrayWithObjects:@"手机:",@"职务:",@"邮箱:",@"责任:", nil];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setFont:[UIFont systemFontOfSize:15]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[array objectAtIndex:(i-1)]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [self.contentView addSubview:lab];
    }
    //手机内容Label
    UILabel *shoujilab=[[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(imageView.frame)-35-45*3, 190, 25)];
    [shoujilab setBackgroundColor:[UIColor clearColor]];
    [shoujilab setTextColor:[UIColor orangeColor]];
    [shoujilab setTextAlignment:NSTextAlignmentRight];
    [shoujilab setFont:[UIFont systemFontOfSize:15]];
    [shoujilab setText:[myDiction objectForKey:@"mobile"]];
    [shoujilab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:shoujilab];

    //职务内容Label
    UILabel *zhiwulab=[[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(imageView.frame)-35-45*2, 190, 25)];
    [zhiwulab setBackgroundColor:[UIColor clearColor]];
    [zhiwulab setTextColor:[UIColor orangeColor]];
    [zhiwulab setTextAlignment:NSTextAlignmentRight];
    [zhiwulab setFont:[UIFont systemFontOfSize:15]];
    [zhiwulab setText:[myDiction objectForKey:@"postion"]];
    [zhiwulab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:zhiwulab];

    //email内容Label
    UILabel *youxinaglab=[[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(imageView.frame)-35-45*1, 190, 25)];
    [youxinaglab setBackgroundColor:[UIColor clearColor]];
    [youxinaglab setTextColor:[UIColor orangeColor]];
    [youxinaglab setTextAlignment:NSTextAlignmentRight];
    [youxinaglab setFont:[UIFont systemFontOfSize:15]];
    [youxinaglab setText:[myDiction objectForKey:@"email"]];
    [youxinaglab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:youxinaglab];

    //责任内容Label
    UILabel *fuzelab=[[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(imageView.frame)-35-45*0, 190, 25)];
    [fuzelab setBackgroundColor:[UIColor clearColor]];
    [fuzelab setTextColor:[UIColor orangeColor]];
    [fuzelab setTextAlignment:NSTextAlignmentRight];
    [fuzelab setFont:[UIFont systemFontOfSize:15]];
    [fuzelab setText:[myDiction objectForKey:@"division"]];
    [fuzelab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:fuzelab];
 
    //发送消息button(暂时取消)
    //2014.05.05 chenlihua 联系人1对1发消息不成功，在简介页面增加发送消息按钮
    UIImage *image2=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(imageView.frame)+40, 508/2, 66/2)];
    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发送消息" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendValueEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:button];
}
#pragma -mark -doClickAction
//2014.05.05 chenlihua 联系人1对1发消息不成功，在简介页面增加发送消息按钮
- (void)sendValueEvent:(UIButton *)sender{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"成功创建聊天",@"success", nil];
    
    NSLog(@"%@",[myDiction objectForKey:@"username"] );
    [[NetManager sharedManager]getdid_by121Withusername:[[UserInfo sharedManager] username] sendto:[myDiction objectForKey:@"username"] hudDic:dic success:^(id responseDic) {
       /* data =     {
            did = 1123;
            dname = t003;
            dpicurl = "http://fcapp.favalue.com/data/upload/1/201408/28/28162507081333en.jpg";
            dpicurl1 = "http://fcapp.favalue.com/data/upload/1/201408/09/09100442012192p4.jpg";
            mcnt = 2;
        };
        msg = "\U6210\U529f";
        status = 0;
       */
        NSLog(@"%@",responseDic);
        ChatWithFriendViewController *cfVc=[[ChatWithFriendViewController alloc]init];
        NSLog(@"--------从联系人点击后的个人简介页面发送消息--跳转到聊天界面----responseDic--%@",responseDic);
        cfVc.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"did"];
        NSLog(@"--------did----%@",cfVc.talkId);
        cfVc.titleName=[myDiction objectForKey:@"username"];
        cfVc.entrance = @"contact";
        cfVc.memberCount=
        [NSString stringWithFormat:@"%@",[[responseDic objectForKey:@"data"] objectForKey:@"dname"]];
//         ,[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"]];
        cfVc.flagContact=@"2";
        NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
        
         [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
          [self.navigationController pushViewController:cfVc animated:YES];
        
    }
                                                   fail:^(id errorString) {
                                                       
                                                       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"该投资人尚未开通账号，不能发送消息！您可以要求其开通！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                       [alert show];
                                                       
                                                   } ];
}
#pragma -mark -functions
//暂时取消
//- (void)loadData
//{
//    
//    // zhutc 注释， 列表页返回了所有的信息，不需要再调详情借口
//    
//    /*
//     [[NetManager sharedManager] contactlistdetail:[myDiction objectForKey:@"id"] username:[[UserInfo sharedManager] username] hudDic:nil success:^(id responseDic) {
//     NSLog(@"------>%@", responseDic);
//     self.dataDic = [responseDic objectForKey:@""];
//     } fail:^(id errorString) {
//     [ShowBox showError:errorString];
//     }];
//     */
//}


@end
