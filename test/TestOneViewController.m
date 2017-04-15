//
//  TestOneViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "TestOneViewController.h"
#import "NetManager.h"
#import "Utils.h"


@interface TestOneViewController ()

@end

@implementation TestOneViewController

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
    // Do any additional setup after loading the view.
    
    [self initView];
    
    number=0;
    
    
}
#pragma -mark -functions
-(void)initView
{
    self.view.backgroundColor=[UIColor orangeColor];
    [self initBackButton];
    [self initTestTitle];
    [self initTextLabel];
    [self initSendButton];
    [self initExplainLabel];
}
-(void)initExplainLabel
{
    UILabel *explainLabel=[[UILabel alloc]init];
    explainLabel.frame=CGRectMake(5, 220, 310, 150);
    explainLabel.numberOfLines=0;
    explainLabel.textAlignment=NSTextAlignmentLeft;
    explainLabel.font=[UIFont systemFontOfSize:15];
    explainLabel.text=@"说明:\n测试此项前，一定要保证网络正常。点击\"发送\"按钮的时候，t001会向服务器发送\"ios\"，同时在群组\"106测试讨论组\"中会收到发送的文本消息\"ios\"";
    explainLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:explainLabel];
    
}
-(void)initSendButton
{
    UIButton *sendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.frame=CGRectMake(0, 400, 320, 30);
    sendButton.backgroundColor=[UIColor redColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(doClickSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
}
-(void)initTextLabel
{
    stepLabel=[[UILabel alloc]init];
    stepLabel.frame=CGRectMake(5, 60, 310, 150);
    stepLabel.numberOfLines=0;
    stepLabel.textAlignment=NSTextAlignmentLeft;
    stepLabel.font=[UIFont systemFontOfSize:15];
    stepLabel.backgroundColor=[UIColor redColor];
    [self.view addSubview:stepLabel];
    
}
-(void)initBackButton
{
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame=CGRectMake(10, 10, 50, 50);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(doClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
-(void)initTestTitle
{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(130, 10, 100, 50);
    titleLabel.text=@"测试一";
    [self.view addSubview:titleLabel];
    
}

#pragma -mark -doClickButton
//-(void)doClickSendButton:(UIButton *)btn
//{
//    /*
//     模拟t001在"106测试讨论组"群发1.
//     -发送消息时，发送的dic---{
//     apptoken = app53e9ac70eab4c;
//     did = 106;
//     localid = 1;
//     msgtext = 1;
//     msgtype = 0;
//     openby = t001;
//     opendatetime = "2014-08-12 13:56:12";
//     username = t001;
//     }
//
//    }*/
//    /*
//     -responseDic--{
//     data =     {
//     localid = 1;
//     msgid = 112617;
//     openby = t001;
//     opendatetime = "2014-08-12 18:32:05";
//     };
//     msg = "\U53d1\U9001\U6d88\U606f\U6210\U529f";
//     status = 0;
//     }
//    */
//    
//    number++;
//    
//    NSString *contentStr=[NSString stringWithFormat:@"ios-one-%i",number];
//    stepLabel.text=[NSString stringWithFormat:@"用户t001向群组\"106测试群\"发送了消息\"%@\"",contentStr];
//    NSString* nowTimeStr =  [Utils getTimeForNow];
//    
//    //将参数传错误，服务器有返回，但是对方不会收到
//    [[NetManager sharedManager] senddiscussionWithusername:@"t001" did:@"106" msgtype:@"0" msgtext:contentStr opendatetime:nowTimeStr openby:@"t001" locaid:@"" hudDic:nil success:^(id responseDic) {
//        
//        NSLog(@"--responseDic--%@",responseDic);
//        NSString *statusString=[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"status"]];
//        
//        if ([statusString isEqualToString:@"0"]) {
//            /*
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送成功，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//            [alertView show];
//            */
//            
//        }else{
//            
//            
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络不稳定，请您一会发送" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
//            [alertView show];
//            
//        }
//        
//    }
//                                                      fail:^(id errorString) {
//                                            
//                                                         UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络不稳定，请您一会发送" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
//                                                          [alertView show];
//                                                     }];
//    
//    
//    
//}
-(void)doClickBackButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
