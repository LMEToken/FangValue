//
//  MineViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "MineViewController.h"
#import "MineInFoemationViewController.h"
#import "EditordieViewController.h"
#import "GuanYuViewController.h"
#import "GengXinViewController.h"
#import "HuanyingViewController.h"
#import "TongyongViewController.h"
#import "passwdViewController.h"
#import "NewViewController.h"
#import "CacheImageView.h"
#import "LoginViewController.h"


//2014.06.13 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

//2014.09.04 chenlihua 解决本地保存方创号
#import "Reachability.h"


//我
@interface MineViewController ()
{
    NSTimer *Sokettimer;
}
//@property(nonatomic,retain) AsyncSocket *socketUpdate;
@end

@implementation MineViewController
//@synthesize socketUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        if ([self isConnectionAvailable]) {
//             socketUpdate=[socketNet sharedSocketNet];
//        }
//       
//        socketUpdate.delegate=self;
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //更新本地头像
    /*
    CacheImageView* hd = (CacheImageView*)[self.contentView viewWithTag:1001];
    [hd getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
    */
    
    //2014.06.13 chenlihua 修改图片缓存的方式
    UIImageView* hd = (UIImageView*)[self.contentView viewWithTag:1001];
    [hd setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    
}
//2014.05.20 chenlihua 判断网络是否连接,解决联系人保存在本地的问题。
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    /*
     if (!isExistenceNetwork) {
     
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
     }
     */
    return isExistenceNetwork;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [Sokettimer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];


//    Sokettimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ConSocket3) userInfo:nil repeats:YES];
    [self.titleLabel setText:@"我"];
    [self setTabBarIndex:3];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
    
    NSLog(@"------------进入详细页面---------");
    NSLog(@"userDic = %@",[[UserInfo sharedManager] username]);
    
    //头像背景图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 205/2.)];
    [imageView setImage:[UIImage imageNamed:@"59_kuang_1"]];
    [self.contentView addSubview:imageView];
    
    //头像背景图
    /*
    CacheImageView *headImage=[[CacheImageView alloc]initWithFrame:CGRectMake(30, 15, 145/2, 145/2.)];
    [headImage setImage:[UIImage imageNamed:@"59_touxiang_1"]];
    [headImage.layer setCornerRadius:35.0f];
    [headImage.layer setMasksToBounds:YES];
    [headImage setTag:1001];
    [headImage getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
    [self.contentView addSubview:headImage];
    */
    
    //2014.06.13 chenlihua 修改图片缓存的方式
    UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 145/2, 145/2.)];
    [headImage.layer setCornerRadius:35.0f];
    [headImage.layer setMasksToBounds:YES];
    [headImage setTag:1001];
    [headImage setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    [self.contentView addSubview:headImage];
    
    

    //方创号Label
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, 30, 180, 25)];
    [lab setBackgroundColor:[UIColor clearColor]];
  //  [lab setText:[[UserInfo sharedManager] user_name]];
    if ([self isConnectionAvailable]) {
          [lab setText:[[UserInfo sharedManager] user_name]];
       
         NSUserDefaults *fangChuang=[NSUserDefaults standardUserDefaults];
         [fangChuang setObject:[[UserInfo sharedManager] user_name] forKey:@"ME"];
         [fangChuang synchronize];
        
        NSString *title=[[NSUserDefaults standardUserDefaults]objectForKey:@"ME"];
        NSLog(@"----title--%@----",title);

    }else{
        NSString *title=[[NSUserDefaults standardUserDefaults]objectForKey:@"ME"];
        if (!title) {
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }else{
             [lab setText:title];
          }
    }
    
    
    
    [lab setFont:[UIFont fontWithName:KUIFont size:17]];
    lab.adjustsFontSizeToFitWidth = YES;
    [lab setTextColor:[UIColor orangeColor]];
    [self.contentView addSubview:lab];

    //方创号Label
    UILabel *titlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, 55, 50, 25)];
    [titlab setBackgroundColor:[UIColor clearColor]];
    [titlab setText:@"方创号:"];
    [titlab setFont:[UIFont fontWithName:KUIFont size:14]];
    [titlab setTextColor:[UIColor orangeColor]];
    [self.contentView addSubview:titlab];
    
    //方创号右边的Label
    UILabel *tellab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlab.frame)+0, 55, 150, 25)];
    [tellab setBackgroundColor:[UIColor clearColor]];
  //  [tellab setText:[[UserInfo sharedManager] username]];
    if ([self isConnectionAvailable]) {
        [tellab setText:[[UserInfo sharedManager] username]];
        
        NSUserDefaults *fangChuang=[NSUserDefaults standardUserDefaults];
        [fangChuang setObject:[[UserInfo sharedManager] user_name] forKey:@"ME"];
        [fangChuang synchronize];
        
        NSString *title=[[NSUserDefaults standardUserDefaults]objectForKey:@"ME"];
        NSLog(@"----title--%@----",title);
        
    }else{
        NSString *title=[[NSUserDefaults standardUserDefaults]objectForKey:@"ME"];
        if (!title) {
            /*
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
             */
        }else{
            [tellab setText:title];
        }
    }
    [tellab setTextColor:[UIColor orangeColor]];
    [self.contentView addSubview:tellab];

    //scrollView
  //  UIScrollView *inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(15/2, CGRectGetMaxY(imageView.frame)+10, 607/2, 658/2)];
    UIScrollView *inforView=[[UIScrollView alloc]initWithFrame:CGRectMake(15/2, CGRectGetMaxY(imageView.frame)+10, 607/2, 658/2)];
    [inforView setBackgroundColor:[UIColor clearColor]];
    [inforView setShowsVerticalScrollIndicator:YES];
  //  [inforView setContentSize:CGSizeMake(607/2, 47*9 + 50)];
    //2014.04.21 新消息提醒去掉，界面修改
   // [inforView setContentSize:CGSizeMake(607/2, 47*9 + 50-47)];
    [inforView setContentSize:CGSizeMake(607/2, 47*9 + 50-47)];
    [inforView setDelegate:self];
    [self.contentView addSubview:inforView];

    //退出登录按钮
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
   // [but setFrame:CGRectMake((305-507/2.)/2., CGRectGetMaxY(inforView.frame)-75, 507/2., 66/2.)];
   // [but setFrame:CGRectMake((305-507/2.)/2., CGRectGetMaxY(inforView.frame)-75-47, 507/2., 66/2.)];
    //2014.09.05 chenlihua 退出登陆，往上移。去除通用以后
    [but setFrame:CGRectMake((305-507/2.)/2., CGRectGetMaxY(inforView.frame)-75-47-47, 507/2., 66/2.)];
    //2014.07.29 chenlihua 修改“退出登陆"按钮
    [but setBackgroundImage:[UIImage imageNamed:@"退出登录|下一步"] forState:UIControlStateNormal];
    
  //  [but setBackgroundImage:[UIImage imageNamed:@"47_anniu_3"] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"47_anniu_4"] forState:UIControlStateHighlighted];
    [but setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(tuichudenglu:) forControlEvents:UIControlEventTouchUpInside];
    [inforView addSubview:but];

    //似TableView的边框
    //   BJImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 607/2, 658/2)];
    //2014.04.21 新消息提醒去掉，界面修改
   // BJImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 607/2, 658/2-47)];
    //2014.09.05 chenlihua 通用去掉，修改。
    BJImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 607/2, 658/2-47-47)];
    [BJImage setImage:[UIImage imageNamed:@"59_kuang_2"]];
    [inforView addSubview:BJImage];
    
    /*
    NSArray *array=[NSArray arrayWithObjects:@"我的资料",@"修改密码",@"新消息提醒",@"通用",@"欢迎页",@"软件更新",@"关于方创", nil];
    NSArray *iconArray = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"59_tubiao_7"],
                          [UIImage imageNamed:@"59_tubiao_6"],
                          [UIImage imageNamed:@"59_tubiao_5"],
                          [UIImage imageNamed:@"59_tubiao_4"],
                          [UIImage imageNamed:@"59_tubiao_3"],
                          [UIImage imageNamed:@"59_tubiao_2"],
                          [UIImage imageNamed:@"59_tubiao_1"],
                          nil];
    */
    /*
    NSArray *array=[NSArray arrayWithObjects:@"我的资料",@"修改密码",@"通用",@"欢迎页",@"软件更新",@"关于方创", nil];
    NSArray *iconArray = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"59_tubiao_7"],
                          [UIImage imageNamed:@"59_tubiao_6"],
                          [UIImage imageNamed:@"59_tubiao_4"],
                          [UIImage imageNamed:@"59_tubiao_3"],
                          [UIImage imageNamed:@"59_tubiao_2"],
                          [UIImage imageNamed:@"59_tubiao_1"],
                          nil];

    for (int i=0; i < 6; i++) {
        //字
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(35,  27+47*i, 100, 15)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor grayColor]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [lab setText:[array objectAtIndex:i]];
        [inforView addSubview:lab];
        //图片
        UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(15,  27+47*(i-0)                                                                                                                                                                                           , 15, 15)];
        [iconImage setImage:[iconArray objectAtIndex:i]];
        [inforView addSubview:iconImage];
        //向右的箭头
        UIImage *image2=[UIImage imageNamed:@"59_jiantou_1"];
        UIImageView *iconImage2=[[UIImageView alloc]initWithFrame:CGRectMake(320-25-7.5,  27+47*i                                                                                                                                                                                           , 15/2, 26/2)];
        [iconImage2 setImage:image2];
        [inforView addSubview:iconImage2];

        //似触碰区
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setBackgroundColor:[UIColor clearColor]];
        [but setTag:1000+i];
        [but setFrame:CGRectMake(15/2,  10+47*i, 320-17, 47)];
        [but addTarget:self action:@selector(butEventTouch:) forControlEvents:UIControlEventTouchUpInside];
        [inforView addSubview:but];

    }
    
//    for (int j=1; j<8; j++) {
////        UIImage *image=[iconArray objectAtIndex:j];
//        
//
//    }
    
    for (int k=1; k<6; k++) {
        //灰色的线
        UIImage *image=[UIImage imageNamed:@"59_fengexian_1"];
        UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(15/2,  10+47*k                                                                                                                                                                                           , 607/2, 1)];
        [iconImage setImage:image];
        [inforView addSubview:iconImage];
    }*/
    
    //2014.09.05 chenlihua 将通用部分去掉
    NSArray *array=[NSArray arrayWithObjects:@"我的资料",@"修改密码",@"欢迎页",@"软件更新",@"关于方创", nil];
    NSArray *iconArray = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"59_tubiao_7"],
                          [UIImage imageNamed:@"59_tubiao_6"],
                          [UIImage imageNamed:@"59_tubiao_3"],
                          [UIImage imageNamed:@"59_tubiao_2"],
                          [UIImage imageNamed:@"59_tubiao_1"],
                          nil];
    
    for (int i=0; i < 5; i++) {
        //字
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(35,  27+47*i, 100, 15)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextColor:[UIColor grayColor]];
        [lab setFont:[UIFont fontWithName:KUIFont size:17]];
        [lab setText:[array objectAtIndex:i]];
        [inforView addSubview:lab];
        //图片
        UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(15,  27+47*(i-0)                                                                                                                                                                                           , 15, 15)];
        [iconImage setImage:[iconArray objectAtIndex:i]];
        [inforView addSubview:iconImage];
        //向右的箭头
        UIImage *image2=[UIImage imageNamed:@"59_jiantou_1"];
        UIImageView *iconImage2=[[UIImageView alloc]initWithFrame:CGRectMake(320-25-7.5,  27+47*i                                                                                                                                                                                           , 15/2, 26/2)];
        [iconImage2 setImage:image2];
        [inforView addSubview:iconImage2];
        
        //似触碰区
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setBackgroundColor:[UIColor clearColor]];
        [but setTag:1000+i];
        [but setFrame:CGRectMake(15/2,  10+47*i, 320-17, 47)];
        [but addTarget:self action:@selector(butEventTouch:) forControlEvents:UIControlEventTouchUpInside];
        [inforView addSubview:but];
        
    }
    
    //    for (int j=1; j<8; j++) {
    ////        UIImage *image=[iconArray objectAtIndex:j];
    //
    //
    //    }
    
    for (int k=1; k<5; k++) {
        //灰色的线
        UIImage *image=[UIImage imageNamed:@"59_fengexian_1"];
        UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(15/2,  10+47*k                                                                                                                                                                                           , 607/2, 1)];
        [iconImage setImage:image];
        [inforView addSubview:iconImage];
    }

}

#pragma -mark -doClickAction
//类tableView推出按钮
- (void)butEventTouch:(UIButton *)sender{
    
    if (sender.tag==1000) {
        MineInFoemationViewController *view=[[MineInFoemationViewController alloc]init];
        view.ismine=YES;
        [self.navigationController pushViewController:view animated:YES];
        
        NSLog(@" 第1行");
    }else if (sender.tag==1001){
        passwdViewController *view=[[passwdViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];

        NSLog(@" 第2行");
    }else if (sender.tag==1002)/*{
        TongyongViewController *view=[[TongyongViewController alloc]init];
           [self.navigationController pushViewController:view animated:YES];

        NSLog(@" 第4行");
        
    }else if (sender.tag==1003)*/{
        HuanyingViewController *view=[[HuanyingViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
        
        NSLog(@" 第5行");
     }else if (sender.tag==1003){
        GengXinViewController *view=[[GengXinViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
        
        NSLog(@" 第6行");
        
    }else if (sender.tag==1004){
        GuanYuViewController *view=[[GuanYuViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
        
        NSLog(@" 第7行");
    }
}
//退出登录
- (void)tuichudenglu:(UIButton*)sender{
    
//    [socketUpdate disconnect ];
//    socketUpdate.delegate = nil;
//    socketUpdate =nil;

    // 2014-08-05 Tom 退出登录是删除账号记录
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths1 objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *MapLayerDataPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];
    BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath];
    
    if (bRet) {
        //
        NSError *err;
        [fileMgr removeItemAtPath:MapLayerDataPath error:&err];
    }
    
    [Utils changeViewControllerWithTabbarIndex:4];
    //消除本地所存信息
    
    
    //2014.05.17 chenlihua 退出登陆时标志位，解决当退出后，标志位还为0的情况，点击推送消息时，会跳转到聊天界面。
    [[UserInfo sharedManager] setIslogin:NO];
    
   
}
- (void)mineInformationView{

   
}
//#pragma -mark -AsyncSocketDelegate
//
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//    
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//    
//}
////2014.06.26 chenlihua sokcet断开后无法连接的问题
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//    
//    
//    // [chatSocket connectToHost:@"42.121.132.104" onPort:8480 error:nil];
//}
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [socketUpdate readDataWithTimeout:-1 tag:200];
//    
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    
//    [socketUpdate disconnect];
//    
//}
//- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
//    if (![self isConnectionAvailable])
//    {
//        return NO;
//    }
//    if ([socketUpdate isConnected]) {
//        return NO;
//    }
//    return YES;
//}
//#pragma mark - 封装返回数据最后一条MESGID
//- (NSString *)getmesgid
//{
//    NSString *meglocaid =@"0";
//    if (    [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"]!=nil) {
//        meglocaid =  [[NSUserDefaults standardUserDefaults] objectForKey:@"lastmegid"];
//    }
//    NSLog(@"%@",meglocaid);
//    return  meglocaid;
//    
//}
//-(void)ConSocket3
//{
//    if ([self isConnectionAvailable])
//    {
//    if (![socketUpdate isConnected]) {
//        //
//        //        static BOOL connectOK;
//        //            connectOK =  [chatSocket connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
//        //
//        //        if (connectOK ==YES) {
//        //            [self connectsoket];
//        socketUpdate = [socketNet sharedSocketNet];
//        socketUpdate .delegate = self;
//        //2014.07.29 chenlihua 发送给socket的数据给加上标识,dev:iOS 或者 dev:android.
//        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
//        NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
//        NSString *jsonString=[jsonDic JSONString];
//        NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
//        
//        
//        //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
//        NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
//        NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
//        NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
//        NSLog(@"-----------newJson-------%@",newJson);
//        
//        
//        NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [socketUpdate writeData:data withTimeout:-1 tag:1000];
//        //            sokectsuccessful = 0;
//        //            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(connectagain)  userInfo:nil repeats:NO];
//        
//        
//        
//    }else{
//        
//    }
//    }
//    
//}
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
