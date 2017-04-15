//
//  TestThreeViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "TestThreeViewController.h"

@interface TestThreeViewController ()

@end

@implementation TestThreeViewController

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
    [self initExplainLabel];
    [self initSendButton];
}
-(void)initExplainLabel
{
    UILabel *explainLabel=[[UILabel alloc]init];
    explainLabel.frame=CGRectMake(5, 220, 310, 150);
    explainLabel.numberOfLines=0;
    explainLabel.textAlignment=NSTextAlignmentLeft;
    explainLabel.font=[UIFont systemFontOfSize:15];
    explainLabel.text=@"说明:\n\"发送\"按钮t001会向\"106测试讨论组\"发送消息\"ios\",但是会显示消息发送失败";
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
    titleLabel.text=@"测试三";
    [self.view addSubview:titleLabel];
    
}
// 20140818日
//#pragma -mark -doClickButton
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
//     }*/
//    NSString* nowTimeStr =  [Utils getTimeForNow];
//    number++;
//    NSString *contentStr=[NSString stringWithFormat:@"ios-three-%i",number];
//    stepLabel.text=[NSString stringWithFormat:@"用户t001向群组\"106测试群\"发送了消息\"%@\"",contentStr];
//    
//    
//    //把did改成负数。status改为6，然后消息发送失败。
//    [[NetManager sharedManager] senddiscussionWithusername:@"t001" did:@"-100" msgtype:@"0" msgtext:contentStr opendatetime:nowTimeStr openby:@"t001" locaid:@"" hudDic:nil success:^(id responseDic) {
//        
//        NSLog(@"---responseDic--%@",responseDic);
//        
//        NSString *statusString=[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"status"]];
//        
//        if ([statusString isEqualToString:@"6"]){
//            
//            /*
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送成功，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//            [alertView show];
//             */
//            
//        }else{
//            /*
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送失败，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//            [alertView show];
//            */
//        }
//            
//        
//    }
//                                                      fail:^(id errorString) {
//                                               /*
//                                                         UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送失败，请到”106测试群”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//                                                          [alertView show];
//                                                */
//                                                      }];
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
