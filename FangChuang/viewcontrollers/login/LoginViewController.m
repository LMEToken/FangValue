//
//  LoginViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//首页/启动页
#import "LoginViewController.h"
#import "SignInViewController.h"
#import "InformationViewController.h"
#import "BorderLabel.h"
#import "NetTest.h"

//2014.08.11 chenlihua 增加测试程序
#import "FangChuangTextViewController.h"

//2014.09.27 chenlihua 新的注册页
#import "HomeLoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
//@synthesize loginSocket;
@synthesize tokenPushString;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取apptoken
    [NetTest netTest];
}

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
-(void)execSql:(NSString *)sql
{
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != 0) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    sqlite3_close(db);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downsoket" object:nil];
//    sqlite3 *db ;
    //        sqlite3_stmt * statement;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [paths objectAtIndex:0];
//    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
//    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
//        sqlite3_close(db);
//        NSLog(@"数据库打开失败");
//    }
//    
//    NSString *deletesql =@"delete from UNREAD";
//    [self execSql:deletesql];
//    sqlite3_close(db);

    //2014-08-05  Tom一打开程序首先判断账号文件里有木有数据 有数据直接根据数据登录 没有数据则进入登录界面
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* fileName = [[paths1 objectAtIndex:0]stringByAppendingPathComponent:@"login.plist"];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]initWithContentsOfFile:fileName];
    
    if ([dict objectForKey:@"username"] != nil && [dict objectForKey:@"password"]!=nil&&[self isConnectionAvailable]) {
        [self login:[dict objectForKey:@"username"] password:[dict objectForKey:@"password"]];

    }else
    {
        //隐藏底下的栏
        [self setTabBarHidden:YES];
        //隐藏上面的栏
        [self setNavigationViewHidden:YES];
        
        self.statusBarBackgroundView.backgroundColor=[UIColor clearColor];
        
        
        //首页背景图
        // UIImage *image1=[UIImage imageNamed:@"first_bg(12-25-11-55-04)"];
        //2014.07.24 chenlihua 修改登陆背景图
        UIImage *image1=[UIImage imageNamed:@"首页背景图"];
        UIImageView *maneimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640/2, 1136/2)];
        [maneimageView setImage:image1];
        [maneimageView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:maneimageView];
        
        //注册按钮
        UIButton *RegistrationBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [RegistrationBut setFrame:CGRectMake(10, self.contentViewHeight-100, 165/2, 66/2)];
        //  [RegistrationBut setBackgroundImage:[UIImage imageNamed:@"00_anniu_2"] forState:UIControlStateNormal];
        //2014.07.24 chenlihua 修改注册按钮
        [RegistrationBut setBackgroundImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
        [RegistrationBut setTitle:@"" forState:UIControlStateNormal];
        [RegistrationBut addTarget:self action:@selector(RegistrationButEvrnt:) forControlEvents:UIControlEventTouchUpInside];
        RegistrationBut.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
        [self.contentView addSubview:RegistrationBut];
        
        //登录按钮
        UIButton *loginBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [loginBut setFrame:CGRectMake(310-165/2, self.contentViewHeight-100, 165/2, 66/2)];
        // [loginBut setBackgroundImage:[UIImage imageNamed:@"00_anniu_1"] forState:UIControlStateNormal];
        //2014.07.24 chenlihua 修改登陆按钮
        //[loginBut setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
        //2014.07.29 chenlihua 继续修改登陆的图档
        [loginBut setBackgroundImage:[UIImage imageNamed:@"注册登录"] forState:UIControlStateNormal];
        
        [loginBut setTitle:@"" forState:UIControlStateNormal];
        [loginBut addTarget:self action:@selector(loginEvrnt:) forControlEvents:UIControlEventTouchUpInside];
        loginBut.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
        [self.contentView addSubview:loginBut];
        
        
        //2014.08.11 chenlihua 增加测试按钮
        
        UIButton *testButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        testButton.frame=CGRectMake(100, 150, 100, 50);
        testButton.backgroundColor=[UIColor redColor];
        [testButton setTitle:@"测试按钮" forState:UIControlStateNormal];
        [testButton addTarget:self action:@selector(doClickTextButton:) forControlEvents:UIControlEventTouchUpInside];
        //[self.contentView addSubview:testButton];
        
    }
    
}
#pragma -mark -doClickTextButton
-(void)doClickTextButton:(UIButton *)btn
{
    FangChuangTextViewController *testViewController=[[FangChuangTextViewController alloc]init];
    [self.navigationController pushViewController:testViewController animated:YES];
}

#pragma -mark -doClickAction
//注册
- (void)RegistrationButEvrnt:(UIButton *)sender{
    
    InformationViewController *tl=[[InformationViewController alloc]init];
    
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:tl animated:YES];
    
    [UIView commitAnimations];
}
//登录
- (void)loginEvrnt:(UIButton *)sender{
    
    SignInViewController *sigInView=[[SignInViewController alloc]init];
    
    //2014.06.19 chenlihua socket
//    sigInView.signSocket=loginSocket;
//    sigInView.signSocket.delegate=sigInView;
    
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:sigInView animated:YES];
    
    [UIView commitAnimations];
}
#pragma -mark -iphone翻转
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait||toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void) login:(NSString *)username password:(NSString *)password
{
    [[NetManager sharedManager] LoginWithusername:username password:password verificationcode:@"" hudDic:nil success:^(id responseDic) {
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"%@",arr);
        
        
        
        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            //投资人
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"currency"]];//币种
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"idealsize"]];//偏好额度
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"statge"]];//投资伦次
            [[UserInfo sharedManager] setRongzi:[arr objectForKey:@"industry"]];//关注领域
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
        }else
        {
            //创业者权限
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"industry"]];
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"statge"]];
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"teamsize"]];
            [[UserInfo sharedManager] setRongzi:@""];
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
        }
        
        [[UserInfo sharedManager] setPost:[arr objectForKey:@"postion"]];
        [[UserInfo sharedManager] setComname:[arr objectForKey:@"comname"] !=nil ? [arr objectForKey:@"comname"]:@""];
        [[UserInfo sharedManager] setBase:[arr objectForKey:@"base"]
         !=nil ? [arr objectForKey:@"base"]:@""];
        [[UserInfo sharedManager] setUsertype:[arr objectForKey:@"usertype"]!=nil ? [arr objectForKey:@"usertype"]:@""];
        [[UserInfo sharedManager] setUser_name:[arr objectForKey:@"realname"]!=nil ? [arr objectForKey:@"realname"]:@""];
        [[UserInfo sharedManager] setUsername:[arr objectForKey:@"username"]!=nil ? [arr objectForKey:@"username"]:@""];
        [[UserInfo sharedManager] setUserid:[arr objectForKey:@"userid"]!=nil ? [arr objectForKey:@"userid"]:@""];
        [[UserInfo sharedManager] setUseremail:[arr objectForKey:@"email"]!=nil ? [arr objectForKey:@"email"]:@""];
        [[UserInfo sharedManager] setIslogin:YES];
        [[UserInfo sharedManager] setUserphone:[arr objectForKey:@"mobile"]!=nil ? [arr objectForKey:@"mobile"]:@""];
        [[UserInfo sharedManager] setUserpicture:[arr objectForKey:@"picurl2"]
         !=nil ? [arr objectForKey:@"picurl2"]:@""];
        NSString* xb =[arr objectForKey:@"gendar"];
        [[UserInfo sharedManager] setUsergender:xb];
        
        [[UserInfo sharedManager] setWeixin:[arr objectForKey:@"weixin"]];
        [[UserInfo sharedManager] setRecord:[arr objectForKey:@"record"]];
        
        [[UserInfo sharedManager] setDivide:[arr objectForKey:@"divide"]!=nil ? [arr objectForKey:@"divide"]:@""];
        [[UserInfo sharedManager] setDuty:[arr objectForKey:@"duty"]!=nil ? [arr objectForKey:@"duty"]:@""];
        
        
        if ([[arr objectForKey:@"isuploadpro"] isEqualToString:@"0"]) {
            [[UserInfo sharedManager] setIsUploadProject:NO];
        }else{
            [[UserInfo sharedManager] setIsUploadProject:YES];
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LogDate"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [Utils changeViewControllerWithTabbarIndex:5];
        
        NSString * tokenPushString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
        NSLog(@"----------tokenpushString-----%@----",tokenPushString);
        
        [[NetManager sharedManager] getPushTokenWithpushtoken:tokenPushString
                                                       hudDic:nil success:^(id responseDic) {
                                                           
                                                           ;
                                                           
                                                       } fail:^(id errorString) {
                                                           ;
                                                       }];
        
        
    } fail:^(id errorString) {
        
        HomeLoginViewController *rootVC=[[HomeLoginViewController alloc]init];
        [self.navigationController pushViewController:rootVC animated:NO];
        
    }];
    
}






//
//#pragma -mark -AsyncSocketDelegate
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    
//    
//    
//    [loginSocket readDataWithTimeout:-1 tag:200];
//    
//}
//
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [loginSocket readDataWithTimeout:-1 tag:200];
//    
//}
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//    
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
//    return [NSRunLoop currentRunLoop];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    
//    [loginSocket disconnect];
//    
//}
//- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
//
//    return YES;
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//}
@end
