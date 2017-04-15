//
//  GengXinViewController.m
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//软件更新
#import "GengXinViewController.h"
@interface GengXinViewController ()
@end
@implementation GengXinViewController
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
    [self setTitle:@"软件更新"];
    
    //当前软件版本Label
   // UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(70, 50, 110, 40)];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 110, 40)];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setText:@"当前软件版本:"];
    [lab setTextColor:[UIColor orangeColor]];
    [lab setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:lab];
    
    //版本号Label
    //UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(180, 50, 150, 40)];
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(160, 50, 150, 40)];
    [lab2 setBackgroundColor:[UIColor clearColor]];
    [lab2 setText:@"ios20141011"];
    [lab2 setTag:1000];
    [lab2 setTextColor:[UIColor orangeColor]];
    [lab2 setFont:[UIFont fontWithName:KUIFont size:17]];
    [self.contentView addSubview:lab2];
    
    //更新版本button
    UIImage *image6=[UIImage imageNamed:@"03_anniu_1"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake((320-254)/2, CGRectGetMaxY(lab.frame)+20, 508/2, 66/2)];
    [button setBackgroundImage:image6 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"更新版本" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gengXinBanBenEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=[UIFont fontWithName:KUIFont size:17];
    [self.contentView addSubview:button];
}


#pragma -mark -doClickButton
- (void)gengXinBanBenEvent:(UIButton *)sender{
    
    /*
    //1000是版本号Label
    UILabel *verLab=(UILabel *)[self.contentView viewWithTag:1000];
    if (![verLab.text isEqualToString:@""])
    {
        UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"有新的版本可供下载" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles: @"去下载", nil];
        [createUserResponseAlert show];
    } else {
        UIAlertView *createUserResponseAlert = [[UIAlertView alloc] initWithTitle:@"提示" message: @"当前已是最新版本" delegate:self cancelButtonTitle:nil otherButtonTitles: @"确定", nil];
        [createUserResponseAlert show];
    }
    NSLog(@"更新");
     
     */
    //2014.05.30 chenlihua 重写软件版本更新部分代码，原代码暂时注释。
    //新代码暂时注释掉。因为还返回不了数据，易崩溃。
   // [self onCheckVersion];
    
}
//2014.05.30 chenlihua 检查软件的版本号。
-(void)onCheckVersion
{
    //查看本地版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    //查看appStore版本号
    NSString *URL = @"http://itunes.apple.com/lookup?id=你的应用程序的ID";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    //同步加载数据。
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    /*
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [results JSONValue];
    */
    //2014.05.30 chenlihua 将原来的解析变为系统自带的JSON解析。
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        if (![lastVersion isEqualToString:currentVersion]) {
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            alert.tag = 10000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 10001;
            [alert show];
        }
    }
}


#pragma  -mark  -UIAertViewdelegate
//2014.05.30 chenlihua 软件版本更新。
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

//2014.05.30 chenlihua 原来的代码注释掉，重新写。
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//    {
//        
////        
//        if (buttonIndex == 1) {
//            
//            NSLog(@"---点的去下载-----------");
//    
//            
//            //去appstore中更新
//             //方法一：根据应用的id打开appstore，并跳转到应用下载页面
//          //2014.05.12 318676629 为appid chenlihua
//        /*   NSString *appStoreLink = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id/318676629"];
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
//         */
//            
//            
//            //方法二：直接通过获取到的url打开应用在appstore，并跳转到应用下载页面
//            
////            [[UIApplicationsharedApplication] openURL:[NSURLURLWithString:updateURL]];
//            
//            NSLog(@"buttonIndex==1");
//            
//        } else if (buttonIndex == 0) {
//            
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"buttonIndex==0" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            
//            NSLog(@"点击的取消");
//            
//        }
//}

@end
