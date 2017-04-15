//
//  MineInFoemationViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//我的资料
#import "MineInFoemationViewController.h"
#import "EditordieViewController.h"

#import "CacheImageView.h"

//2014.06.13 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

@interface MineInFoemationViewController ()

@end

@implementation MineInFoemationViewController
@synthesize dic=_dic,ismine=_ismine;

//2014.05.04 chenlihua 解决点击联系人聊天界面头像，详细信息里，头像错乱的问题。
@synthesize flagPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        self.view = nil;
    }
    
}
//-(void)loadData
//{
//    if(_ismine==YES)
//    {
//        [[NetManager sharedManager] getuserinfoWithUsername:[[UserInfo sharedManager] username]
//                                                     hudDic:nil
//                                                    success:^(id responseDic) {
//                                                        _dic=[NSDictionary dictionaryWithDictionary:responseDic];
//                                                    }
//                                                       fail:^(id errorString) {
//                                                           
//                                                       }];
//    }
//}

/*
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CacheImageView* hd = (CacheImageView*)[self.contentView viewWithTag:1001];
    
    
  //  NSLog(@"------头像的图片-----%@----",[[UserInfo sharedManager] userpicture]);
  //  [hd getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
    
    //flagPage==1.从聊天界面点击头像进入我的简介。
    //flagPage==2.从群聊界面进入我的简介。
    if ([flagPage isEqualToString:@"1"]) {
        
        NSLog(@"----从聊天界面点击头像进入我的简介----%@",[_dic objectForKey:@"picurl"]);
        [hd getImageFromURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
        
    }else if ([flagPage isEqualToString:@"2"])
    {
        NSLog(@"----从群聊界面进入我的简介----%@",[_dic objectForKey:@"picurl"]);
        [hd getImageFromURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
    }
    else
    {
        NSLog(@"------从我进入我的简介-----%@----",[[UserInfo sharedManager] userpicture]);
        NSLog(@"------%@--",[[UserInfo sharedManager]userpicture]);
        [hd getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
     }

}
 */
//2014.06.13 chenlihua 修改图片缓存的方式
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImageView* hd = (UIImageView*)[self.contentView viewWithTag:1001];
    
    
    //  NSLog(@"------头像的图片-----%@----",[[UserInfo sharedManager] userpicture]);
    //  [hd getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
    
    //flagPage==1.从聊天界面点击头像进入我的简介。
    //flagPage==2.从群聊界面进入我的简介。
    if ([flagPage isEqualToString:@"1"]) {
        
        NSLog(@"----从聊天界面点击头像进入我的简介----%@",[_dic objectForKey:@"picurl"]);
      //  [hd getImageFromURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
       // [hd setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
         //2014.07.04 chenlihua 项目团队中，查看个人信息界面上，没有显示头像
      //  [hd setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"48_touxziang_1"]];
        [hd setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];

        
    }else if ([flagPage isEqualToString:@"2"])
    {
        NSLog(@"----从群聊界面进入我的简介----%@",[_dic objectForKey:@"picurl"]);
      //  [hd getImageFromURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
      //  [hd setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
         //2014.07.04 chenlihua 项目团队中，查看个人信息界面上，没有显示头像
         [hd setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    }
    else
    {
        
        
        NSLog(@"------从我进入我的简介-----%@----",[[UserInfo sharedManager] userpicture]);
        NSLog(@"------%@--",[[UserInfo sharedManager]userpicture]);
       // [hd getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
      //  [hd setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
        //2014.07.04 chenlihua 项目团队中，查看个人信息界面上，没有显示头像
        [hd setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",_dic);
    [self setTabBarHidden:YES];
    if(_ismine==YES)
    {
    [self setTitle:@"我的资料"];
    }
    else
    [self setTitle:@"详细资料"];
    [self addBackButton];
// Do any additional setup after loading the view.
//    NSArray *array=[NSArray arrayWithObjects:[_dic objectForKey:@"usergender"],@"女", nil];
//    dataArray=[[NSMutableArray alloc]initWithObjects:
//                        [NSDictionary dictionaryWithObjectsAndKeys:array,@"key", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:[_dic objectForKey:@"duty"],@"岗位",[_dic objectForKey:@"divide"],[_dic objectForKey:@"userphone"],[_dic objectForKey:@"weixin"],[_dic objectForKey:@"useremail"], nil],@"valueKey", nil],
//                        [NSDictionary dictionaryWithObjectsAndKeys:@"撒可敬的哈伦裤是就得啦库数据狄拉克时间狄龙卡上就得啦是否vk啊可视对讲阿拉斯加刻录机 离开教室得利卡聚少离多 数据库的快乐；啊是空间的；卡死；得利卡；是爱上；的卢卡斯；打卡",@"lvli", nil],
//                        nil];
//    
    if(_ismine==YES)
    {
      //右侧编辑按钮
      [self createRightButton];
    }
    //UIScrollView
    inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentViewHeight)];
    [inforView setBackgroundColor:[UIColor clearColor]];
    [inforView setShowsVerticalScrollIndicator:YES];
    [inforView setContentSize:CGSizeMake(320, 530)];
    [inforView setDelegate:self];
    [self.contentView addSubview:inforView];
    
    //
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 305/2)];
    [imageView setImage:[UIImage imageNamed:@"60_kuang_1"]];
    [inforView addSubview:imageView];
    
    //头像Label
    UILabel *headlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 25)];
    [headlab setBackgroundColor:[UIColor clearColor]];
    [headlab setTextColor:[UIColor orangeColor]];
    [headlab setText:@"头像:"];
    
    [headlab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:headlab];
    
    //头像图片
    /*
    CacheImageView *headimageView=[[CacheImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
    [headimageView setImage:[UIImage imageNamed:@"60_touxiang_1"]];
    [headimageView.layer setCornerRadius:23.0f];
    [headimageView.layer setMasksToBounds:YES];
    [headimageView setTag:1001];
   
  //  NSLog(@"----从服务器返回的头像的信息----%@",[_dic objectForKey:@"picurl"]);
    
    //2014.05.21 chenlihua 解决同一账号换手机登陆，头像不存在的问题。
    [headimageView getImageFromURL:[NSURL URLWithString:[_dic objectForKey:@"picurl"]]];
    */
    
    //2014.06.13 chenlihua 修改图片的缓存方式
    UIImageView *headimageView=[[UIImageView alloc]initWithFrame:CGRectMake(320-55, 8, 46, 46)];
  //  [headimageView setImage:[UIImage imageNamed:@"60_touxiang_1"]];
    [headimageView.layer setCornerRadius:23.0f];
    [headimageView.layer setMasksToBounds:YES];
    [headimageView setTag:1001];
    [headimageView setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    
   // [headimageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];

    [inforView addSubview:headimageView];

    
    NSArray *basicArray=[NSArray arrayWithObjects:@"姓名:",@"性别:", nil];
    for (int i=1; i<3; i++) {
        //下划线
        image1View=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5+45*i, 300, 1)];
        [image1View setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [inforView addSubview:image1View];
        
        //姓名Label
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(image1View.frame)+10, 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[basicArray objectAtIndex:(i-1)] ];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [inforView addSubview:lab];
     }
   
    //姓名内容Label
    xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(headimageView.frame)+18, 180, 25)];
    [xingminglab setBackgroundColor:[UIColor clearColor]];
    [xingminglab setTextColor:[UIColor orangeColor]];
    [xingminglab setTextAlignment:NSTextAlignmentRight];
    [xingminglab setFont:[UIFont systemFontOfSize:15]];
    [xingminglab setFont:[UIFont fontWithName:KUIFont size:17]];
    [xingminglab setTag:10];
    NSLog(@"------我的详细界面传过来的消息-----dic--%@----",_dic);
    [xingminglab setText:_ismine==YES?[[UserInfo sharedManager]user_name]:[_dic objectForKey:@"name"]];
    [inforView addSubview:xingminglab];

    //性别右侧Label
    xingbielab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(xingminglab.frame)+23, 180, 25)];
    [xingbielab setBackgroundColor:[UIColor clearColor]];
    [xingbielab setTextColor:[UIColor orangeColor]];
    [xingbielab setTextAlignment:NSTextAlignmentRight];
    [xingbielab setFont:[UIFont systemFontOfSize:15]];
    [xingbielab setFont:[UIFont fontWithName:KUIFont size:17]];
    [xingbielab setTag:11];
    
    //2014.05.19 chenlihua 从群聊界面查看群成员时，会出现性别显示f,m的情况。让其显示“男”，“女”。点击联系人头像进入详细信息时，会有性别错乱的情况出现。
    NSLog(@"%@",[_dic objectForKey:@"gendar"]);
    NSString *SexString=[_dic objectForKey:@"gendar"];
   if ([SexString isEqualToString:@"f"]) {
        SexString=@"女";
    }else if([SexString isEqualToString:@"m"]){
        SexString=@"男";
    }else
    {
        SexString=@"";
    }
    [xingbielab setText:_ismine==YES?[[UserInfo sharedManager] usergender]:SexString];
    [xingbielab setFont:[UIFont fontWithName:KUIFont size:17]];
  //  [xingbielab setText:_ismine==YES?[[UserInfo sharedManager] usergender]:[_dic objectForKey:@"gendar"]];
    [inforView addSubview:xingbielab];

    //第二部分背景图
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, 320, 734/2)];
    [imageView1 setImage:[UIImage imageNamed:@"60_kuang_2"]];
    [inforView addSubview:imageView1];
    
    NSArray *moreArray=[NSArray arrayWithObjects:@"职位:",@"岗位:",@"分工:",@"手机:",@"微信号:",@"Email:",@"履历:", nil];
    for (int k=1 ; k<8; k++) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+20+45*(k-1), 80, 25)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor orangeColor]];
        [lab setText:[moreArray objectAtIndex:(k-1)]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [inforView addSubview:lab];
    }
    //下划线
    for (int j=1; j<7; j++) {
        UIImageView *imageViewk=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10+45*j, 300, 1)];
        [imageViewk setImage:[UIImage imageNamed:@"60_fengexian_1"]];
        [inforView addSubview:imageViewk];
    }
    
    //职位内容Label
    zhiweilab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(1-1), 180, 25)];
    [zhiweilab setBackgroundColor:[UIColor clearColor]];
    [zhiweilab setTextColor:[UIColor orangeColor]];
    [zhiweilab setTextAlignment:NSTextAlignmentRight];
    [zhiweilab setFont:[UIFont systemFontOfSize:15]];
    [zhiweilab setTag:100+0];
    [zhiweilab setText:_ismine==YES?[[UserInfo sharedManager]post]:[_dic objectForKey:@"postion"]];
    [zhiweilab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:zhiweilab];
    
    //岗位内容Label
    gangweilab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(2-1), 180, 25)];
    [gangweilab setBackgroundColor:[UIColor clearColor]];
    [gangweilab setTextColor:[UIColor orangeColor]];
    [gangweilab setTextAlignment:NSTextAlignmentRight];
    [gangweilab setFont:[UIFont systemFontOfSize:15]];
    [gangweilab setTag:100+1];
    [gangweilab setText:_ismine==YES?[[UserInfo sharedManager] duty]:[_dic objectForKey:@"duty"]];
    [gangweilab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:gangweilab];
    
    //分工内容Label
    fengonglab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(3-1), 180, 25)];
    [fengonglab setBackgroundColor:[UIColor clearColor]];
    [fengonglab setTextColor:[UIColor orangeColor]];
    [fengonglab setTextAlignment:NSTextAlignmentRight];
    [fengonglab setFont:[UIFont systemFontOfSize:15]];
    [fengonglab setTag:100+2];
    [fengonglab setText:_ismine==YES?[[UserInfo sharedManager] divide]:[_dic objectForKey:@"divide"]];
    [fengonglab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:fengonglab];

    //手机内容Label
    shoujilab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(4-1), 180, 25)];
    [shoujilab setBackgroundColor:[UIColor clearColor]];
    [shoujilab setTextColor:[UIColor orangeColor]];
    [shoujilab setTextAlignment:NSTextAlignmentRight];
    [shoujilab setFont:[UIFont systemFontOfSize:15]];
    [shoujilab setTag:100+3];
    [shoujilab setText:_ismine==YES?[[UserInfo sharedManager] userphone]:[_dic objectForKey:@"mobile"]];
    [shoujilab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:shoujilab];

    //微信内容Label
    weixinlab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(5-1), 180, 25)];
    [weixinlab setBackgroundColor:[UIColor clearColor]];
    [weixinlab setTextColor:[UIColor orangeColor]];
    [weixinlab setTextAlignment:NSTextAlignmentRight];
    [weixinlab setFont:[UIFont systemFontOfSize:15]];
    [weixinlab setTag:100+4];
    [weixinlab setText:_ismine==YES?[[UserInfo sharedManager] weixin]:[_dic objectForKey:@"weixin"]];
    [weixinlab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:weixinlab];

    //Email内容Label
    emaillab=[[UILabel alloc]initWithFrame:CGRectMake(130, CGRectGetMaxY(imageView.frame)+20+45*(6-1), 180, 25)];
    [emaillab setBackgroundColor:[UIColor clearColor]];
    [emaillab setTextColor:[UIColor orangeColor]];
    [emaillab setTextAlignment:NSTextAlignmentRight];
    [emaillab setFont:[UIFont systemFontOfSize:15]];
    [emaillab setTag:100+5];
    [emaillab setText:_ismine==YES?[[UserInfo sharedManager] useremail]:[_dic objectForKey:@"email"]];
    [emaillab setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview:emaillab];

    //履历内容
    xiatextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(imageView.frame)+15+45*(7-1), 270, 75)] ;
    [xiatextView setTextColor:[UIColor orangeColor]];
//    [xiatextView.layer setBorderWidth:1.f];
//    [xiatextView.layer setBorderColor:[UIColor colorWithRed:241/255.0 green:191/255.0 blue:172/255.0 alpha:1.0].CGColor];
    [Utils setDefaultFont:xiatextView size:14];
    [xiatextView.layer setCornerRadius:3];
    [xiatextView setDelegate:self];
    [xiatextView setBackgroundColor:[UIColor clearColor]];
//    [xiatextView setText:_ismine==YES?[[UserInfo sharedManager] record]:[_dic objectForKey:@"cv"]];
    [xiatextView setReturnKeyType:UIReturnKeyDefault];
    [xiatextView setKeyboardType:UIKeyboardTypeDefault];
    [xiatextView setScrollEnabled:YES];
    [xiatextView setEditable:NO];
    [xiatextView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [xiatextView setFont:[UIFont fontWithName:KUIFont size:17]];
    [inforView addSubview: xiatextView];
}
#pragma -mark -doClickAction
- (void)EditordEvent:(UIButton *)sender{
    NSLog(@"编辑");
    
    EditordieViewController *view=[[EditordieViewController alloc]initWithText:xingminglab.text
                                                                          Text:xingbielab.text
                                                                          Text:zhiweilab.text
                                                                          Text:gangweilab.text
                                                                          Text:fengonglab.text
                                                                          Text:shoujilab.text
                                                                          Text:weixinlab.text
                                                                          Text:emaillab.text
                                                                          Text:xiatextView.text];
    
    [view setDelegate:self];
    [self.navigationController pushViewController:view animated:YES];
    
}

#pragma -mark -functions
-(void)createRightButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(310-50, (44-25)/2, 50, 25)];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Utils setDefaultFont:rightButton size:14];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(EditordEvent:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font=[UIFont fontWithName:KUIFont size:14];
    [self addRightButton:rightButton isAutoFrame:NO];
}
//点击编辑按钮时
- (void)reloadWithText:(NSString *)text1 Text:(NSString *)text2 Text:(NSString *)text3 Text:(NSString *)text4 Text:(NSString *)text5 Text:(NSString *)text6 Text:(NSString *)text7 Text:(NSString *)text8 Text:(NSString *)text9{
    
    [xingminglab setText:text1];
    [xingbielab setText:text2];
    [zhiweilab setText:text3];
    [gangweilab setText:text4];
    [fengonglab setText:text5];
    [shoujilab setText:text6];
    [weixinlab setText:text7];
    [emaillab setText:text8];
    [xiatextView setText:text9];
}
-(void)removeEditButton
{
    [[ self.view.superview viewWithTag:rightButtonTag]removeFromSuperview];
}



@end
