//
//  AppDelegate.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "ContactViewController.h"
#import "ProjectViewController.h"
#import "MineViewController.h"
#import "FangChuangGuWenViewController.h"
#import "JumpControl.h"
#import "NetTest.h"
#import "UIImage+UrlRequest.h"
#import "SQLite.h"
#import "ChatWithFriendViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LookViewController.h"
#import "LogDayCheck.h"
#import "SignInViewController.h"

#import "XGPush.h"
#import "UIDevice+IdentifierAddition.h"
#import "SignInViewController.h"


#import "JinZhanXiangQingViewController.h"
#import "FangChuangRenwuOKViewController.h"

#import "JSONKit.h"
//2014.07.03 chenlihua 将异常保存到文件
#import "NdUncaughtExceptionHandler.h"

#import "AudioToolbox/AudioToolbox.h"

//#import "ProjectBasicInfoViewController.h"

//@interface UINavigationController(addRotate)
//@end
//@implementation UINavigationController(addRotate)
//- (BOOL)shouldAutorotate
//{
//    return self.topViewController.shouldAutorotate;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return self.topViewController.supportedInterfaceOrientations;
//}
//@end


//测试添加 chenlihua
#import "RegistrationViewController.h"
#import "TermsOfUseViewController.h"
#import "MineViewController.h"
#import "LianXiRenViewController.h"
#import "QiYeTuanDuiViewController.h"
#import "ContactViewController.h"
#import "ChatWithFriendViewController.h"
#import "QunLiaoViewController.h"
#import "QiYeTuanDuiViewController.h"
#import "XuanZeQunViewController.h"
#import "XuanZeLianXiRenViewController.h"
#import "HomeViewController.h"
#import "RiChengBiaoViewController.h"
#import "14BianJiViewController.h"

#import "AddNewProjectViewController.h"
#import "FangChuangGuWenViewController.h"
#import "14BianJiViewController.h"
#import "FangChuangNeiBuViewController.h"
#import "ChaKanNeiRongViewController.h"
#import "EditTimeViewController.h"

#import "RegistrationViewController.h"
//认证页面
#import "HomeApproveViewController.h"
//2014.07.02 chenlihua textlight头文件
#import "TestFlight.h"
//2014.09.27 chenlihua 新的注册页
#import "HomeLoginViewController.h"
#import "HomePersonalInformationViewController.h"
#import "HomeChooseIdentifyViewController.h"
#import "HomeEntreViewController.h"
#import "HomeInvestorViewController.h"
#import "HomeForgetPasswordViewController.h"
#import "HomePersonalInformationViewController.h"
#import "HomeEntreInstructionViewController.h"



//2014.05.09 chenlihua 模拟器时，传特定pushToken,真机时，传真机的实际pushToken
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif


NSString * HaveNewMessageFromSevers =@"HaveNewMessageFromSevers" ;
BOOL shake = NO;
BOOL sound = NO;
BOOL remind = NO;

@implementation AppDelegate

@synthesize openByString;
@synthesize arrUnSendCollection;
#pragma -mark - Tom FMDB
+ (void) showStatusWithText:(NSString *) string duration:(NSTimeInterval) duration {
    
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.statusLabel.text = string;
    [delegate.statusLabel sizeToFit];
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    CGFloat width = delegate.statusLabel.frame.size.width;
    CGFloat height = rect.size.height;
    rect.origin.x = rect.size.width - width - 5;
    rect.size.width = width;
    delegate.statusWindow.frame = rect;
    delegate.statusLabel.frame = CGRectMake(0, 0, width, height);
    
    if (duration < 1.0) {
        duration = 1.0;
    }
    if (duration > 4.0) {
        duration = 4.0;
    }
    [delegate performSelector:@selector(dismissStatus) withObject:nil afterDelay:duration];
}
#pragma -mark -网络连接不好，或错误时弹出的提示框
- (void) dismissStatus {
    CGRect rect = self.statusWindow.frame;
    rect.origin.y -= rect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.statusWindow.frame = rect;
    }];
}
- (void) hudShow
{
    //2014.05.27 chenlihua 解决每隔10s刷新下主页，以使提醒的消息数更新。为了用户体验，暂时不显示@“正在加载."字样。
    //    [self.window.rootViewController.view addSubview:myHud.view];
    //    [myHud setCaption:@"正在加载..."];
    //    [myHud setImage:nil];
    //    [myHud setActivity:YES];
    //    [myHud show];
}
- (void) hudShow : (NSString*) msg
{
    [self.window.rootViewController.view addSubview:myHud.view];
    [myHud setCaption:msg];
    [myHud setImage:nil];
    [myHud setActivity:YES];
    [myHud show];
    //     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"deviePushToken"];
}
- (void) hudSuccessHidden
{
    //2014.05.27 chenlihua 解决每隔10s刷新下主页，以使提醒的消息数更新。为了用户体验，暂时不显示@“加载完成"字样。
    [myHud setCaption:@"加载完成"];
    [myHud setActivity:NO];
    [myHud setImage:[Utils getImageFromProject:@"19-check"]];
    [myHud update];
    [self performSelector:@selector(setHudHidden) withObject:nil afterDelay:1.0f];
}
- (void) hudSuccessHidden : (NSString*) msg
{
    [myHud setCaption:msg];
    [myHud setImage:[Utils getImageFromProject:@"19-check"]];
    [myHud setActivity:NO];
    [myHud update];
    [self performSelector:@selector(setHudHidden) withObject:nil afterDelay:1.0f];
}
- (void) hudFailHidden
{
    [myHud setCaption:@"当前网络不可用..."];
    [myHud setActivity:NO];
    [myHud setImage:[Utils getImageFromProject:@"11-x"]];
    [myHud update];
    [self performSelector:@selector(setHudHidden) withObject:nil afterDelay:1.0f];
}
- (void) hudFailHidden : (NSString*) msg
{
    [myHud setCaption:msg];
    [myHud setActivity:NO];
    [myHud setImage:[Utils getImageFromProject:@"11-x"]];
    [myHud update];
    [self performSelector:@selector(setHudHidden) withObject:nil afterDelay:1.0f];
}
- (void) setHudHidden
{
    [myHud hide];
    [myHud.view removeFromSuperview];
}

#pragma -mark -跳转页面到
- (void) changeViewController : (int) _tabbarIndex
{
    @try {
        switch (_tabbarIndex) {
            case 0:
            {
                
                HomeViewController* viewController = [[HomeViewController alloc] init];
                
                
                
                UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewController] ;
                //            [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
                [self.window setRootViewController:nc];
                
                return ;
            }
                break;
                
            case 1:
            {
                [JumpControl jumpProject];
                return ;
            }
                break;
                
            case 2:
            {
                ContactViewController* viewController = [[ContactViewController alloc] init];
                
                UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewController] ;
                //            [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
                [self.window setRootViewController:nc];
                
                
                return ;
            }
                break;
                
            case 3:
            {
                //  MineViewController  *vc = [[MineViewController alloc] init];
                FvaMyVC *vc = [[FvaMyVC alloc]init];
                UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
                [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1.png"] forBarMetrics:UIBarMetricsDefault];
                [self.window setRootViewController:nc];
                return ;
            }
                break;
            case 4:
            {
             
//                 LoginViewController  *vc = [[LoginViewController alloc] init];
             //  HomeEntreViewController *vc=[[HomeEntreViewController alloc]init];
           
                //  HomeForgetPasswordViewController *vc=[[HomeForgetPasswordViewController alloc]init];
                

               HomeLoginViewController *vc=[[HomeLoginViewController alloc]init];
//              HomePersonalInformationViewController *vc=[[HomePersonalInformationViewController alloc]init];

             // HomePersonalInformationViewController *vc=[[HomePersonalInformationViewController alloc]init];

                
              // HomeEntreInstructionViewController *vc=[[HomeEntreInstructionViewController alloc]init];
                 //   HomeApproveViewController *vc=[[HomeApproveViewController alloc]init];
                // HomeInvestorViewController *vc=[[HomeInvestorViewController alloc]init];
                //2014.06.19 chenlihua
                //                vc.loginSocket=_serverSocket;
                //                vc.loginSocket.delegate=vc;
                
                
                UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
                //用竖着（拿手机）时UINavigationBar的标准的尺寸来显示UINavigationBar
                [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
                [self.window setRootViewController:nc];
                return ;
            }
                break;
            case 5:
            {
                
                //添加转到首页
                [JumpControl jumpToHome];
                
                return ;
            }
                break;
            default:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"changeViewController参数错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return ;
}
#pragma -mark -屏幕旋转

//2014.06.26 chenlihua 禁止所有的屏幕旋转
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

//2014.06.26 chenlihua 屏幕可以旋转。
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void) login:(NSString *)username password:(NSString *)password
{
    [[NetManager sharedManager] LoginWithusername:username password:password verificationcode:@"" hudDic:nil success:^(id responseDic) {
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"%@",arr);
        
        
        
        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            
            
            //投资人
            
            //币种
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"2" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setLingyu:chooseStr];//币种
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //偏好额度
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"5" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setJieduan:chooseStr];//偏好额度
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //投资轮次
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setGuimo:chooseStr];//投资伦次
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //关注领域
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"4" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setRongzi:chooseStr];//关注领域
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            

            /*
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"currency"]];//币种
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"idealsize"]];//偏好额度
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"statge"]];//投资伦次
            [[UserInfo sharedManager] setRongzi:[arr objectForKey:@"industry"]];//关注领域
             */
            [[UserInfo sharedManager] setGongsijianjie:@"pdesc"];
        }else
        {
            //创业者权限
            
            //所属领域
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"4" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setLingyu:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //阶段
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"3" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setJieduan:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //团队规模
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"6" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setGuimo:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];
            //融资状态
            [[NetManager sharedManager] getProFilterOptWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] rflag:@"1" hudDic:nil success:^(id responseDic){
                
                NSMutableArray *dataArray=[responseDic objectForKey:@"data"];
                NSLog(@"--dataArray---%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    if (!turnButtonArray) {
                        turnButtonArray=[[NSMutableArray alloc]init];
                    }
                    [turnButtonArray addObject:[dic objectForKey:@"name"]];
                }
                NSLog(@"--turnButtonArray--%@",turnButtonArray);
                
                NSArray *array=[[arr objectForKey:@"currency"] componentsSeparatedByString:@","];
                NSLog(@"---array---%@",array);
                
                for (NSString *str in array) {
                    if (!chooseArray) {
                        chooseArray=[[NSMutableArray alloc]init];
                    }
                    [chooseArray addObject:[turnButtonArray objectAtIndex:[str intValue]]];
                }
                NSLog(@"--chooseArray--%@",chooseArray);
                NSString *chooseStr=[chooseArray componentsJoinedByString:@"-"];
                NSLog(@"--chooseStr--%@",chooseStr);
                
                [[UserInfo sharedManager] setRongzi:chooseStr];
                
                [turnButtonArray removeAllObjects];
                [chooseArray removeAllObjects];
                
            }fail:^(id errorString) {
                NSLog(@"--%@----",errorString);
            }];

            /*
            [[UserInfo sharedManager] setLingyu:[arr objectForKey:@"industry"]];
            [[UserInfo sharedManager] setJieduan:[arr objectForKey:@"statge"]];
            [[UserInfo sharedManager] setGuimo:[arr objectForKey:@"teamsize"]];
            [[UserInfo sharedManager] setRongzi:@""];
             */
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

        FangChuangInsiderViewController *insideView=[[FangChuangInsiderViewController alloc]init];
        [self.naviController pushViewController:insideView animated:NO];
        
    } fail:^(id errorString) {
        
        sleep(1);
        [self.window showActivityOnlyLabel:errorString forSeconds:5];
    }];
    
    
}
#pragma -mark -系统自带函数
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lianxiren"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"fristcome"];
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    
    [MobClick startWithAppkey:@"5449a584fd98c58ea500d28d" reportPolicy:BATCH   channelId:@"Web"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSString *a=[NSString stringWithFormat:@"{\"oid\": \"%@\"}", deviceID];
    NSLog(@"%@",a);
    [[NSUserDefaults standardUserDefaults] setObject:a forKey:@"youmeng"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    UIAlertView *myview= [[ UIAlertView alloc]initWithTitle:@"你的友盟id试" message:a  delegate:self cancelButtonTitle:@"" otherButtonTitles:@"好的", nil];
//    [myview show];
    //    [self.window addSubview:homeview];
    //     _serverSocket .delegate = self;
    //    [_serverSocket disconnect];
    //    _serverSocket=[socketNet sharedSocketNet];
    
    //  [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarStyleBlackTranslucent];
    
    //    - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // [self application:application didRegisterForRemoteNotificationsWithDeviceToken: ]
    
    
    //2014.07.02 chenlihua TextFlight
    //2014.07.02 chenlihua 去掉TextFlight
    /*
     [TestFlight takeOff:@"1d661080-4689-4a03-a04b-b9bce7f7c18e"];
     
     TFLog(@"测试测试测试测试");
     */
    //20140809 tom
    //2014.08.13 chenlihua 将此注释掉
    //[application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    
    //2014.07.03 chenlihua 将异常保存到文件
    [NdUncaughtExceptionHandler setDefaultHandler];
    //    @try {
    //        _serverSocket= [[AsyncSocket alloc]initWithDelegate:self];
    //        [_serverSocket connectToHost:@"42.121.132.104" onPort:8480 error:nil];
    //    }
    //    @catch (NSException *exception) {
    //
    //    }
    //    @finally {
    //
    //    }
    
    
    
    
    
    
    //    [Crashlytics startWithAPIKey:@"4cda8d0ed0b4af09b716137caac1d807d93d7e3b"];
    
    //2014.06.26 chenlihua 启动的时候（欢迎页)强制屏幕为竖屏
    [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
    
    myHud = [[ATMHud alloc] init];
    
    //dispatch_timer 不受UI影响
    //    [self timerDispatch];
    
    
    //注册状态栏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disTouchNotiView:) name:kMPNotificationViewTapReceivedNotification object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor blackColor]];
    
    //    LoginViewController* rootVC = [[LoginViewController alloc] init];
    //    ProjectBasicInfoViewController* rootVC = [[ProjectBasicInfoViewController alloc] init];
    //2014.06.19 chenlihua
    
     
    
    
    NSString *name =[[NSUserDefaults standardUserDefaults] objectForKey:@"usernameid"];
    NSString *pwd=[[NSUserDefaults standardUserDefaults] objectForKey:@"usernamepwd"];

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int value = [userDefaults integerForKey:@"tuichudenglu"];

   

    NSLog(@"--name-%@-pwd-%@",name,pwd);
    
   if(name.length>0&&pwd.length>0&&[self isConnectionAvailable]&&value!=1)

        
    {
        
        FvalueBufferVC *buffervc = [[FvalueBufferVC alloc]init];
        self.window.rootViewController = buffervc;
        [self login:name password:pwd];
        
        
        
    }else
    {
        HomeLoginViewController *rootVC=[[HomeLoginViewController alloc]init];
        _naviController = [[UINavigationController alloc]initWithRootViewController:rootVC];
        [self.naviController.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
        [self.window setRootViewController:self.naviController];
        [self.window makeKeyAndVisible];
    }
    
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
         [[NSUserDefaults standardUserDefaults] synchronize];
    }else
    {
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        LookViewController* viewController = [[LookViewController alloc] init];
        [self.naviController presentModalViewController:viewController animated:NO];
    }
    
    [[UserInfo sharedManager] setUsertype:@"1"];
    
    
    //*****************推送通知******************************
    //iOS5.0及以上版本，程序启动时注册通知
    [self registerNofitication];
    
    //初始化push信息,access ID,access KEY.
    [XGPush startApp:2200013547 appKey:@"IR84E15J2KKD"];
    
    
    //[XGPush setAccount:@"t001"];
    //自己的APP里登陆页面的自己的账号名
    //如果你的app不用登陆，就不用理这个接口
    
    // [XGPush handleReceiveNotification:nil];
    
    //推送反馈(app不在前台运行时，点击推送激活时)
    //与[XGPush handleReceiveNotification:userInfo];一同实现推送被打开效果统计
    [XGPush handleLaunching:launchOptions];
    
    //设置图标标记
    //2014.08.06 chenlihua 将设置图标标志去掉
    // application.applicationIconBadgeNumber=1;
    
    return YES;
    
    
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
- (void)changerootview
{
    //   LoginViewController* rootVC = [[LoginViewController alloc] init];
    //2014.09.27 chenliha
    HomeLoginViewController *rootVC=[[HomeLoginViewController alloc]init];
    
    
    //    ProjectBasicInfoViewController* rootVC = [[ProjectBasicInfoViewController alloc] init];
    //2014.06.19 chenlihua
    //        rootVC.loginSocket=_serverSocket;
    //        rootVC.loginSocket.delegate=rootVC;
    
    _naviController = [[UINavigationController alloc]initWithRootViewController:rootVC];
    
    /*
     EditTimeViewController* rootVC = [[EditTimeViewController alloc] init];
     _naviController = [[UINavigationController alloc]initWithRootViewController:rootVC];
     */
    [self.naviController.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
    [self.window setRootViewController:self.naviController];
    [self.window makeKeyAndVisible];
    self.naviController=nil;
}
#pragma -mark -推送通知函数
///iOS5.0及以上版本，程序启动时注册通知
- (void) registerNofitication {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
}
//注册设备信息
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@".........信鸽注册设备信息...");
    //注册设备
    NSString * deviceTokenStr = [XGPush registerDevice: deviceToken];
    
    //打印获取的deviceToken的字符串
    NSLog(@"deviceTokenStr is %@",deviceTokenStr);
    
    
    //注意:设备的deviceToken由苹果下发，可能会产生变化。同一设备在开发环境和生产环境是不相同的。
    // 发起注册条件 1:未注册 2:account变更 3:距离上次注册成功超过15小时。达到以上条件才能向后台进行网络请求，以及触发回调函数。
    NSString* pushToken = [[[[deviceTokenStr description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"-----pushToken %@------",pushToken);
    NSLog(@"------获取pushtoken-----成功-------");
    
    // [[NSUserDefaults standardUserDefaults]setObject:pushToken forKey:@"deviePushToken"];
    //2014.05.09 chenlihua 如果是真机测试就传真实的pushToken,哪果是模拟器就传假的pushToken.
    
    // 测试：@"a54db1cbaf33fc465799bd89a0edda32972dae2d50639231f306d39f1264edd5";
    //开发：6d790469ec81815c6a0c7a53e9d320502d680fbd2b526a0c689855e5d1765177
    //
    NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
    [defauts setObject:pushToken forKey:@"devicePushToken"];
    [defauts synchronize];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSLog(@".........信鸽推送注册失败....");
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"%@",str);
    
}
//点击推送通知时实现的。
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"-----信鸽有通知来时-点击推送通知时实现的-----------------");
    
    //推送反馈(app在前台运行时)
    //与[XGPush handleLaunching:launchOptions];一同实现推送被打开效果统计
    [XGPush handleReceiveNotification:userInfo];
    
    NSLog(@"---推送时-------userInfo-----%@",userInfo);
    
    NSLog(@"------XG----%@-------",[userInfo objectForKey:@"xg"]);
    
    //
    /*
     ---推送时-------userInfo-----{
     aps =     {
     alert = "iOS push test: 2014-05-16 09:37:20";
     badge = 1;
     sound = default;
     };
     key1 = value1;
     key2 = value2;
     xg =     {
     bid = 0;
     ts = 1400204245;
     };
     }
     */
    //2014.05.17 chenlihua 推送总的跳转方式。当没有登陆的时候，若APP在前台，则点击推送通知时，不会跳转到相应的聊天界面（事实上，此时，推送横条不会出现）。若APP在后台，则跳转到登陆页面（事实上，登陆界面为默认界面），因为此时，还没有登陆。即也不跳转。当登陆的时候，若APP在后台，点击推送通知时，则跳转到相应的聊天界面。若APP在前台，则不跳转到其它的页面（事实上，此时，推送也不会出现）。
    
    //2014.05.17 chenlihua 判断是否登陆，若没有登陆，则直接在登陆界面不跳转，否则跳转到聊天界面。
    NSLog(@"-------判断有没有登陆-------%i------",[[UserInfo sharedManager] islogin]);
    if (![[UserInfo sharedManager] islogin]) {
        NSLog(@"---判断有没有登陆，没有登陆-----");
        ;
    }else
    {
        NSLog(@"-----判断有没有登陆，登陆了。-----");
        //判断是在其它页面，则有消息来什么也不执行，否则跳转到相应页面。
        NSString *pushFlagString=[[NSUserDefaults standardUserDefaults]objectForKey:@"PUSH_FLAG"];
        NSLog(@"------pushFlagSting--%@-----------",pushFlagString);
        
        if ([pushFlagString isEqualToString:@"1"]) {
            ;
        }
        else
        {
            
            
            //2014.05.14 chenlihua 点击推送，跳转到相应的页面
            
//            ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
//            
//            viewCon.entrance = @"qun";
//            viewCon.talkId=[userInfo objectForKey:@"dgid"];
//            
//            
//            viewCon.titleName=[userInfo objectForKey:@"dname"];
//            viewCon.memberCount=[userInfo objectForKey:@"mcnt"];
//            //2014.05.17 chenlihua 判断聊天界面是否是推送来的标志。
//            viewCon.isPushString=@"is";
//                    FangChuangInsiderViewController *viewCon = [[FangChuangInsiderViewController alloc]init];
//            [(UINavigationController*)self.window.rootViewController pushViewController:viewCon animated:YES];
             [Utils changeViewControllerWithTabbarIndex:5];
            
            
            //2014.05.26 chenlihua 当时项目进展的通知时，即时跳转到项目进展。
            /*
             JinZhanXiangQingViewController *JinZhanVC = [[JinZhanXiangQingViewController alloc] init];
             // vc.proid = [[array objectAtIndex:indexPath.row] objectForKey:@"plan_id"];
             JinZhanVC.proid=@"172";
             [(UINavigationController*)self.window.rootViewController pushViewController:JinZhanVC animated:YES];
             */
            
            
            
            //2014.05.26 chenlihua 当是方创任务的通知时，跳转到方创任务。
            /*
             FangChuangRenwuOKViewController* RenWuVC = [[FangChuangRenwuOKViewController alloc] init];
             //  viewController.taskid = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"plan_id"];
             RenWuVC.taskid=@"2574";
             [(UINavigationController*)self.window.rootViewController pushViewController:RenWuVC animated:YES];
             */
            
            //2014.05.26 chenlihua 当是我的日程的时候，跳转到我的日程。
            /*
             RiChengBiaoViewController *rcVC=[[RiChengBiaoViewController alloc]init];
             [(UINavigationController*)self.window.rootViewController pushViewController:rcVC animated:YES];
             */
        }
        
        //2014.05.17 chenlihua 解决从推送界面进入聊天界面在返回方创主页面的时候，消息没有清零。
        NSUserDefaults *infoPush=[NSUserDefaults standardUserDefaults];
        [infoPush setObject:userInfo forKey:@"pushInfo"];
        [infoPush synchronize];
        
    }
    
}
#pragma  -mark -数据库语句
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
    db = nil;
}
#pragma  -mark 判断数据库 是否存在该字段
-(int)getcount:(NSString *)tablename key:(NSString *)key keyvalue:(NSString *)keyvalue
{
    
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    NSString *sql1 = [NSString stringWithFormat:@"SELECT  COUNT(*)  FROM %@  WHERE  %@ ='%@' ",tablename,key,keyvalue];
    
    if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        int count = 0;
        if (sqlite3_step(statement))
        {
            count = sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return count;
        
        
        
    }
    else
    {
        sqlite3_close(db);
        sqlite3_finalize(statement);
        return 0;
        
        
        
    }
    
}
- (NSString *)getmesgid
{
    NSString *meglocaid =@"0";
    if (    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]]!=nil) {
        meglocaid =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
    }
    NSLog(@"%@",meglocaid);
    return  meglocaid;
    
}
#pragma  -mark -轮询接口
- (void)gethttpdata2
{
    
    
    NSLog(@"%@",[self getmesgid]);
    [[NetManager sharedManager] getdiscussionWithusername:[[UserInfo sharedManager] username]
                                                      did:@"0"
                                                rdatetime:@""
                                                    dflag:@"0"  //  1 向前 0 向后
                                                  perpage:@"20"
                                                   hudDic:nil
                                                    msgid:[self getmesgid]
                                                  success:^(id responseDic) {
                                                      NSLog(@"responseDic = %@",responseDic);
                                                      
                                                      NSArray*  array = [[responseDic objectForKey:@"data"] objectForKey:@"messagelist"];
                                                      if (array.count>0) {
                                                          for (int i = 0; i<array.count; i++) {
                                                              NSLog(@"%@",array);
                                                              NSString *sql1 = [NSString stringWithFormat:
                                                                                @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@')",
                                                                                @"UNREAD", @"name", @"age",@"address",@"sendname",@"msgid",
                                                                                [[array objectAtIndex:i] objectForKey:@"dgid"],
                                                                                [[array objectAtIndex:i]  objectForKey:@"msgtext"],
                                                                                [[array objectAtIndex:i]  objectForKey:@"dtype"],
                                                                                [[array objectAtIndex:i]  objectForKey:@"openby"],
                                                                                [[array objectAtIndex:i]   objectForKey:@"msgid"]];
                                                              [self execSql:sql1];
                                                              NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                                                              NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                                                              [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                                                              NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                                                              SUser * user = [SUser new];
                                                              user.titleName =   [[array objectAtIndex:i] objectForKey:@"dgid"];
                                                              user.conText =  [[array objectAtIndex:i]  objectForKey:@"msgtext"];
                                                              user.contentType =     [[array objectAtIndex:i]  objectForKey:@"dtype"];
                                                              user.username =  [[array objectAtIndex:i]  objectForKey:@"openby"];
                                                              user.msgid =[[array objectAtIndex:i]   objectForKey:@"msgid"];
                                                              user.description = datetime;
                                                              [_userDB saveUser:user];
                                                          }
                                                          
                                                      }
                                                      //存储收到的信息
                                                      [self saveChatToSqlite:array];
                                                      NSLog(@"----ARRAY----%@",array);
                                                      
                                                      
                                                      
                                                      
                                                  }
                                                     fail:^(id errorString) {
                                                         
                                                         
                                                     }];
    
    
    
    
    
    
}


//2014.04.29 chenlihua 去掉轮询消息后出现有横幅。
- (void)timerDispatch2
{
    NSLog(@"--------------timerDispatch!-------------");
    
    /*
     只要程序在进入前端就能轮询，不受其他影响，相当强大！
     */
    //2014.06.04 chenlihua GCD.
    dispatch_queue_t queue = dispatch_queue_create("timer queue", NULL);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        
        NSLog(@"zhutc go!");
        
    });
    
    dispatch_resume(timer);
    
    
    //    dispatch_release(timer);
}

#pragma mark -点击通知栏响应事件
- (void)didTapOnNotificationView:(MPNotificationView *)notificationView
{
    
}

//点击轮询消息以后的界面
- (void)disTouchNotiView:(NSNotification*)noti
{
    NSLog(@"------------------- (void)disTouchNotiView:(NSNotification*)noti---------");
    
    MPNotificationView* view = (MPNotificationView*)noti.object;
    //点击之后翻转的界面。
    if (view) {
        NSLog(@"view . label = %@",view.textLabel.text);
    }
}
#pragma  -mark -系统震动方法
- (void)getChatMessageGoToShake
{
    
    //sound = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isleft"]boolValue];
    //shake = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isleft2"]boolValue];
    // NSLog(@"----getSOUND---%i--GETsHAKE--%i",sound,shake);
    
    //新消息提醒
    //remind = [[[NSUserDefaults standardUserDefaults]objectForKey:@"isNewRemind"]boolValue];
    
    if (!shake) {
        //调用系统震动
        // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        NSLog(@"---shake--%i",shake);
        
    }
    if (!sound) {
        //调用系统声音
        // NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"received3",@"caf"];
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"sms-received3",@"caf"];
        NSLog(@"--paht---%@",path);
        //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
        //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
        if (path) {
            SystemSoundID sd;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sd);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                sd = 0;//NULL
                NSLog(@"---调用系统声音出错");
            }
            NSLog(@"---error---%u",(unsigned int)sd);
            AudioServicesPlaySystemSound(sd);
        }
    }
}
#pragma  -mark -本地时间
- (void)dealWithChatResponsedic:(NSDictionary*)responseDic
{
    // 获取最后时间
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary* dic = [responseDic objectForKey:@"data"];
        if (dic.allKeys.count) {
            
            NSArray* array = [dic objectForKey:@"messagelist"];
            NSMutableArray* times = [array mutableArrayValueForKeyPath:@"opendatetime"];
            
            if (times.count) {
                
                NSArray* sortArray =  [times sortedArrayUsingSelector:@selector(compare:)];
                NSLog(@"times = %@",sortArray);
                
                [SQLite setLastTime:[sortArray lastObject]];
                
            }
            
        }
        
    });
}
#pragma  -mark -save chat to sqlite

//2014.05.22 chenlihua 重写函数；解决本地未成功发送消息，联网重发的问题。
//- (void)saveChatToSqlite:(NSArray*)array
//{
//    for (short i = 0; i < array.count; i ++) {
//
//        NSDictionary * dic = [array objectAtIndex:i];
//
//
//        //2014.05.14 chenlihua 在发送消息时，会有openby为空的用户出现在左面，但是头像可以点击进去，显示用户名自己，刷新后，此用户名跳转到右边，显示发出消息为空。当openby为空时，把消息当做了对方发来的消息。
//        /*
//         openByString=[[NSString alloc]init];
//         openByString=[dic objectForKey:@"openby"];
//
//         if (openByString.length==0||[openByString isEqualToString:@""])
//         {
//         // openByString=[dic objectForKey:@"userId"];
//         continue;
//         }
//         if ([openByString isEqualToString:[[UserInfo sharedManager] username]]) {
//         continue ;
//         }
//         NSLog(@"---------轮询保存到本地数据库中------openby %@-------------",openByString);
//         */
//
//        //openByString 2014.05.20 chenlihua 暂时改为原来样子。
//
//        if ([[dic objectForKey:@"openby"] isEqualToString:[[UserInfo sharedManager] username]]) {
//            continue ;
//        }
//
//
//        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
//                                 talkId:[dic objectForKey:@"dgid"]
//                            contentType:[dic objectForKey:@"msgtype"]
//                               talkType:@"1"
//                              vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
//                                picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
//                                content:[dic objectForKey:@"msgtext"]
//                                   time:[dic objectForKey:@"opendatetime"]
//                                 isRead:@"0"
//                                 second:[dic objectForKey:@"vsec"]
//                                  MegId:[dic objectForKey:@"msgid"]
//                               imageUrl:[dic objectForKey:@"url"]
//                                 openBy:[dic objectForKey:@"openby"]
//                                isSend:[dic objectForKey:@"isSend"]];
//
//    }
//}
//
/*
 - (void)saveChatToSqlite:(NSArray*)array
 {
 for (short i = 0; i < array.count; i ++) {
 
 NSDictionary * dic = [array objectAtIndex:i];
 
 if ([[dic objectForKey:@"openby"] isEqualToString:[[UserInfo sharedManager] username]]) {
 continue ;
 }
 
 
 [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
 talkId:[dic objectForKey:@"dgid"]
 contentType:[dic objectForKey:@"msgtype"]
 talkType:@"1"
 vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
 picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
 content:[dic objectForKey:@"msgtext"]
 time:[dic objectForKey:@"opendatetime"]
 isRead:@"0"
 second:[dic objectForKey:@"vsec"]
 MegId:[dic objectForKey:@"msgid"]
 imageUrl:[dic objectForKey:@"url"]
 openBy:[dic objectForKey:@"openby"]];
 
 
 }
 }
 */
//NSString* tableName(NSString* userID, NSString* talkID)
//{
//    return [NSString stringWithFormat:@"chat%@%@",userID,talkID];
//}
//2014.05.26 chenlihua 重写代码 如果是自己的则不过滤掉。因为在服务器端已经进行了处理。
- (void)saveChatToSqlite:(NSArray*)array
{
    
    //2014.08.19 chenlihua 当有新消息的时候，调用系统震动。当在登陆状态时，不让其响应。
    [self getChatMessageGoToShake];
    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    dispatch_async(quueue, ^{
        for (short i = 0; i < array.count; i ++) {
            
            NSDictionary * dic = [array objectAtIndex:i];
            
            //2014.05.27 chenlihua 解决WEB端自己发送的消息，自己会收到的问题。
            //        if ([[dic objectForKey:@"openby"] isEqualToString:[[UserInfo sharedManager] username]]) {
            //            continue ;
            //        }
            NSLog(@"%@",dic);
            
            /*
             dgid = 450;
             dname = "\U957f\U6c99 \U9b45\U4e3d\U6587\U5316";
             dtype = 2;
             extension = "<null>";
             localid = 1;
             mcnt = 10;
             msgid = 76770;
             msgpath = "<null>";
             msgtext = "\U54c8\U54c8";
             msgtype = 0;
             openby = p001;
             opendatetime = "2014-08-06 15:29:18";
             vsec = 0;
             */
            NSLog(@"%@",[dic objectForKey:@"msgtext"]);
            
            [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                     talkId:[dic objectForKey:@"dgid"]
                                contentType:[dic objectForKey:@"msgtype"]
                                   talkType:@""/*[dic objectForKey:@"talkId"]*/
                                  vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
                                    picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
                                    content:[dic objectForKey:@"msgtext"]
                                       time:[dic objectForKey:@"opendatetime"]
                                     isRead:@"0"
                                     second:[dic objectForKey:@"vsec"]
                                      MegId:[dic objectForKey:@"msgid"]
                                   imageUrl:@""/*[dic objectForKey:@"url"]*/
                                     openBy:[dic objectForKey:@"openby"]];
            
            //2014.08.11 chenlihua 把接收到的最后一条消息的时间保存到本地。然后，每次用这个时间来从服务器请求数据。
            
            NSString *msgid =  [[array objectAtIndex:[array count]-1] objectForKey:@"msgid"];
            NSUserDefaults *msgidDefault=[NSUserDefaults standardUserDefaults];
            [msgidDefault setObject:msgid forKey:@"MESGID_SERVER"];
            [msgidDefault synchronize];
            
            
            //        sqlite3 *db ;
            //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            //        NSString *documents = [paths objectAtIndex:0];
            //        NSString *database_path = [documents stringByAppendingPathComponent:@"/chat.sqlite"];
            //        if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
            //            sqlite3_close(db);
            //            NSLog(@"数据库打开失败");
            //        }
            //        //        NSMutableArray *tablearr = [[NSMutableArray alloc]init];
            //        NSString *sqlQuery =[NSString stringWithFormat:@"SELECT * FROM %@", @"chattom630"];
            //        //        @"SELECT * FROM UNREAD3";tableName(userId, talkId)
            //        sqlite3_stmt * statement;
            //        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
            //            while (sqlite3_step(statement) == SQLITE_ROW) {
            //                char *n1 = (char *)sqlite3_column_text(statement, 3);
            //                NSString *l1 = [[NSString alloc]initWithUTF8String:n1] ;
            //                NSLog(@"%@",l1);
            //
            //
            //            }
            //            sqlite3_close(db);
            //        }
            
            
            
            
        }
    });
    
    //定时器继续
    
    
    
    //    NSString *time =  [[array objectAtIndex:[array count]-1] objectForKey:@"opendatetime"];
    //    NSUserDefaults *timeDefault=[NSUserDefaults standardUserDefaults];
    //    [timeDefault setObject:time forKey:@"TIME_SERVER"];
    //    [timeDefault synchronize];
    
    
}


#pragma mark - 轮询推送上面的推送框，处理不在聊天界面的情况，不在聊天界面时，显示推送
//2014.04.29去掉轮询弹出的界面。已去掉
/*
 - (void)dealWithOtherUI:(NSArray*)array
 {
 NSLog(@"----------dealWithOtherUI--------------");
 
 [UIImage imageWithUrlString:@"http://pic.5442.com/2012/1223/04/10.jpg"
 imageCallBlock:^(id image) {
 
 if ([image isKindOfClass:[UIImage class]]) {
 
 //本地通知
 [MPNotificationView notifyWithText:[[array objectAtIndex:0] objectForKey:@"openby"]
 detail:[[array objectAtIndex:0] objectForKey:@"msgtext"]
 image:image
 duration:2.f
 andTouchBlock:^(MPNotificationView* view ) {
 NSLog(@"notiView = %@",view.textLabel.text);
 
 ChatWithFriendViewController* viewController = [[ChatWithFriendViewController alloc] init];
 viewController.talkId = [[array objectAtIndex:0] objectForKey:@"dgid"];
 
 [(UINavigationController*)self.window.rootViewController pushViewController:viewController animated:YES];
 
 }];
 
 
 }
 else
 {
 NSLog(@"%@",image);
 }
 }];
 
 NSLog(@"----------dealWithOtherUI-----完成---------");
 }
 */
//2014.04.29去掉轮询弹出的界面。已去掉，将image的值改成了null
- (void)dealWithOtherUI:(NSArray*)array
{
    NSLog(@"----------dealWithOtherUI--------------");
    
    [UIImage imageWithUrlString:@"http://pic.5442.com/2012/1223/04/10.jpg"
                 imageCallBlock:^(id image) {
                     
                     if ([image isKindOfClass:[UIImage class]]) {
                         
                         //本地通知
                         [MPNotificationView notifyWithText:[[array objectAtIndex:0] objectForKey:@"openby"]
                                                     detail:[[array objectAtIndex:0] objectForKey:@"msgtext"]
                                                      image:image
                                                   duration:2.f
                                              andTouchBlock:^(MPNotificationView* view ) {
                                                  NSLog(@"notiView = %@",view.textLabel.text);
                                                  
                                                  ChatWithFriendViewController* viewController = [[ChatWithFriendViewController alloc] init];
                                                  viewController.talkId = [[array objectAtIndex:0] objectForKey:@"dgid"];
                                                  
                                                  
                                                  
                                                  [(UINavigationController*)self.window.rootViewController pushViewController:viewController animated:YES];
                                                  
                                                  
                                              }];
                         
                     }
                     else
                     {
                         NSLog(@"%@",image);
                     }
                 }];
    
    NSLog(@"----------dealWithOtherUI-----完成---------");
}
#pragma -mark -系统自带函数
//挂起
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downanimo" object:nil];
    NSLog(@"----点击home键执行1--挂起-----------");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"----点击home键执行2---程序已经进入后台--------");
    
    
    NSUserDefaults *pushFlag=[NSUserDefaults standardUserDefaults];
    [pushFlag setValue:@"0" forKey:@"PUSH_FLAG"];
    [pushFlag synchronize];
    
    NSString *pushFlagString=[[NSUserDefaults standardUserDefaults]objectForKey:@"PUSH_FLAG"];
    NSLog(@"-----pushFlagString-----%@",pushFlagString);
    
    
    
    /*
     if (chatTime) {
     [chatTime invalidate];
     chatTime = nil;
     }
     */
    
    
    //2014.06.25 chenlihua 解决在后台时，接收不到消息
    self.backgroundTaskIdentifier =[application beginBackgroundTaskWithExpirationHandler:^(void) {
        
        [self endBackgroundTask];
    }];
    
    // 模拟一个Long-Running Task
    //    self.myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f
    //                                                   target:self
    //                                                 selector:@selector(timerMethod:)     userInfo:nil
    //                                                  repeats:YES];
    
    
}
- (void) endBackgroundTask{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    AppDelegate *weakSelf = self;
    dispatch_async(mainQueue, ^(void) {
        
        AppDelegate *strongSelf = weakSelf;
        if (strongSelf != nil){
            [strongSelf.myTimer invalidate];// 停止定时器
            
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}

// 模拟的一个 Long-Running Task 方法
- (void) timerMethod:(NSTimer *)paramSender{
    NSTimeInterval backgroundTimeRemaining =[[UIApplication sharedApplication] backgroundTimeRemaining];
    
    if (backgroundTimeRemaining == DBL_MAX){
        //前台打印
        NSLog(@"Background Time Remaining = Undetermined");
    } else {
        //后台打印
        NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"----在后台后点击home键执行1----------程序即将进入前台----------");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontconnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"notConnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //2014.06.25 chenlihua 在前台时，向系统借时间的代码不在执行。
    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
        [self endBackgroundTask];
    }
    
    //2014.08.05 chenlihua 将在欢迎页中获取token,转为在程序即将进入前台时获取token.
    //获取apptoken
    [NetTest netTest];
}
-(void)connectSeverdown
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dontconnect"]isEqualToString:@"1"]) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectSeverdown" object:nil];
}


//程序重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application
{
 
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"downsoket" object:nil];
    [self connectSeverdown];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(connectSeverdown) userInfo:nil repeats:YES];
    
    NSLog(@"-----在后台后点击home键执行2-----重新激活程序------------------------");
    
    NSString *pushFlagString=@"1";
    
    NSUserDefaults *pushFlag=[NSUserDefaults standardUserDefaults];
    [pushFlag setObject:pushFlagString forKey:@"PUSH_FLAG"];
    [pushFlag synchronize];
    
    NSLog(@"------------pushFlagString---%@---",pushFlagString);
    
    
    //2014.04.23 chenlihua 消息推送
    application.applicationIconBadgeNumber = 0;
    
    
    
    //大于0，即只要超过一天，就需要重新登录
    //2014.04.16 临时屏蔽 chenlihua
    /*
     if ([LogDayCheck NumberOfDaysElapsedBetweenILastLogDate]>0) {
     
     SignInViewController* viewCon = [[SignInViewController alloc] init];
     UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewCon];
     [self.window setRootViewController:nav];
     
     }
     */
    
    //    if (chatTime) {
    //        [chatTime fire];
    //        return ;
    //    }
    //
    //初始化计时器
    // chatTime = [NSTimer scheduledTimerWithTimeInterval:12. target:self selector:@selector(getChatMessage) userInfo:nil repeats:YES];
    
    //2014.06.22 chenlihua socket去掉轮询
    
    //2014.05.26 chenlihua 改成2S.
    //2014.08.05 chenlihua 把socket重新改为轮询 轮询时间为3S
    
    //2014.08.26 chenlihua HTTP的时候执行轮询，其它的时候不执行.
    if ([messageFlag isEqualToString:@"1"]) {
        
    }else{
        ;
    }
    
    [self performSelector:@selector(startimer) withObject:nil];
    sqlite3 *db ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS UNREAD (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age TEXT, address TEXT, sendname TEXT,msgid TEXT )";
    NSString *sqlCreateTable2 = @"CREATE TABLE IF NOT EXISTS UNREAD2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age TEXT, address TEXT, sendname TEXT,msgid TEXT )";
    
    [self execSql:sqlCreateTable];
    [self execSql:sqlCreateTable2];
    sqlite3_close(db);
    
    
}
-(void)getstop
{
    [chatTime invalidate];
}
-(void)startimer
{
    //    chatTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gethttpdata2) userInfo:nil repeats:YES];
    //
    //        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getstop) userInfo:nil repeats:YES];
    
    //注册到 NSRunLoopCommonModes 模式下
    //2014.08.08 chenlihua 在项目运行阶段，按钮假死的现象。
    //    [[NSRunLoop currentRunLoop] addTimer:chatTime forMode:NSRunLoopCommonModes];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"--------applicationWillTerminate--------");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//#pragma -mark -AsyncSocketDelegate
//
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//
//    NSLog(@"收到数据成功1111111！！");
//
//    NSString *mes=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *mesDic=[mes objectFromJSONString];
//    NSDictionary *newDic=[mesDic objectForKey:@"data"];
//    NSString *newStr=[newDic objectForKey:@"newmsg"];
//
//
//    NSLog(@"-----mes---%@",mes);
//    NSLog(@"----mesArr---%@",mesDic);
//    NSLog(@"--------newStr---%@",newStr);
//
//    [_serverSocket readDataWithTimeout:-1 tag:200];
//
//}
//#pragma mark === 暂时不用清除缓存=====
////-(void)myClearCacheAction{
////    dispatch_async(
////                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
////                   , ^{
////                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
////
////                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
////                       NSLog(@"files :%lu",(unsigned long)[files count]);
////                       for (NSString *p in files) {
////                           NSError *error;
////                           NSString *path = [cachPath stringByAppendingPathComponent:p];
////                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
////                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
////                           }
////                       }
////
////
////
////                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
////}
////
////
////-(void)clearCacheSuccess
////{
////    NSLog(@"清理成功");
////    
////}
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//    [_serverSocket readDataWithTimeout:-1 tag:200];
//}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    
//    NSLog(@"111111发送数据成功");
//    
//}


@end
