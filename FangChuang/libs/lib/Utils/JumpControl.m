//
//  JumpControl.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "JumpControl.h"
#import "AppDelegate.h"
#import "FangChuangGuWenViewController.h"
#import "FangChuangNeiBuViewController.h"
#import "xiangmuViewController.h"
/*
 项目
 */
#import "ProjectViewController.h"
#import "AProjectViewController.h"
#import "xiangmuViewController.h"
#import "xiangmumingxiViewController.h"
#import "AddNewProjectViewController.h"


//实验聊天
#import "ChatWithFriendViewController.h"
#import "ContactViewController.h"

// 方创下的栏目：分为：方创人、项目方、投资方与对接群。 2014.04.24 chenlihua
#import "FangChuangInsiderViewController.h"

#import "FvalueIndexVC.h"
#import "ProjectMainTableViewController.h"
#import "ProjectFinanceTabelViewController.h"
#import "HomeLoginViewController.h"
#import "HomePersonalInformationViewController.h"

@implementation JumpControl

+ (void)jumpToHome
{
    UIViewController* viewController = nil;
    
    if ([[[UserInfo sharedManager] usertype] isEqualToString:@"2"]) {
        
      //  viewController = [[FangChuangNeiBuViewController alloc] init];
        
       // 方创下的栏目：分为：方创人、项目方、投资方与对接群。 2014.04.24 chenlihua
        viewController = [[FangChuangInsiderViewController alloc] init];
        
    }
    else
    {
        viewController = [[FangChuangInsiderViewController alloc] init];
    }
    
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewController];
    [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nc];
    
}





+ (void)jumpProject
{
    
    /*
     
     zhutc 2014 - 1 - 8 确认按照UE做
     注释下面的代码
     
     */
//    ProjectViewController  *vc = [[[ProjectViewController alloc] init] autorelease];
//    
//    UINavigationController *nc = [[[UINavigationController alloc]initWithRootViewController:vc] autorelease];
//    [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
//    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nc];
//
//    return;
    
    /*
     
     UI 与 UE 不符合 ， 暂时return UE 逻辑
     
     */
    /*
    
    if (![[UserInfo sharedManager] isUploadProject]){
        
        //融资者
        
//        AddNewProjectViewController  *vc = [[AddNewProjectViewController alloc] init];
        xiangmuViewController* vc = [[xiangmuViewController alloc] init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
//        [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nc];
        
    }
    else
    {
     */
        //投资 其他

   //ProjectViewController  *vc = [[ProjectViewController alloc] init];

    //2014.09.11 chenlihua 写项目新分新页面，暂时将此部分去掉

   ProjectMainTableViewController *vc=[[ProjectMainTableViewController alloc]init];
    
    //2014.09.27 chenlihua 写注册与启动
  // HomeLoginViewController *vc=[[HomeLoginViewController alloc] init];

 //  ProjectFinanceTabelViewController *vc=[[ProjectFinanceTabelViewController alloc] init];

  //  HomePersonalInformationViewController *vc=[[HomePersonalInformationViewController alloc]init];
    
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
//        [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
    
        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nc];
        
//    }
    
}



+ (void)project:(UIViewController*)nav dictionary:(NSDictionary*)dic
{
    
    if ([[[UserInfo sharedManager] usertype] isEqualToString:@"0"]) {
        
        //融资
        
        xiangmuViewController  *viewController = [[xiangmuViewController alloc] init];
        [nav.navigationController pushViewController:viewController animated:YES];
        
        
                
        
    }
    else if ([[[UserInfo sharedManager] usertype] isEqualToString:@"1"]) {
        //投资
        
        AProjectViewController  *viewController = [[AProjectViewController alloc] init];
        viewController.myDic = dic;
        [nav.navigationController pushViewController:viewController animated:YES];

    }
    else if ([[[UserInfo sharedManager] usertype] isEqualToString:@"2"]) {
        //其他
        
        xiangmumingxiViewController  *viewController = [[xiangmumingxiViewController alloc] init];
        viewController.myDic = dic;
        [nav.navigationController pushViewController:viewController animated:YES];
    }

    
}

+ (void)jumpChatView
{
    ChatWithFriendViewController  *vc = [[ChatWithFriendViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
    [nc.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nc];
}



+ (void)jumpToContactView
{
    ContactViewController* viewCon = [[ContactViewController alloc] init];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewCon];
    [nav.navigationBar setBackgroundImage:[Utils getImageFromProject:@"shangdaohang_1"] forBarMetrics:UIBarMetricsDefault];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).window setRootViewController:nav];

}


@end
