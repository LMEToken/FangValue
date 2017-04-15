//
//  TestFourViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "TestFourViewController.h"

@interface TestFourViewController ()

@end

@implementation TestFourViewController

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
    [self initdoubleSendButton];
}
-(void)initExplainLabel
{
    UILabel *explainLabel=[[UILabel alloc]init];
    explainLabel.frame=CGRectMake(5, 220, 310, 150);
    explainLabel.numberOfLines=0;
    explainLabel.textAlignment=NSTextAlignmentLeft;
    explainLabel.font=[UIFont systemFontOfSize:15];
    explainLabel.text=@"说明:\n请您在点击发送按钮前，断开网然，然后，点击\"发送\"按钮，此是，t001在群组\"106测试群\"中发送文本消息\"ios\",但是会显示发送失败。然后，重新打开网络，点击重发按钮，会在次在群组\"106测试群\"中发送刚才没有成功的消息。此时发送成功.";
    
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
-(void)initdoubleSendButton
{
    UIButton *doubleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    doubleButton.frame=CGRectMake(0, 440, 320, 30);
    doubleButton.backgroundColor=[UIColor redColor];
    [doubleButton setTitle:@"重发" forState:UIControlStateNormal];
    [doubleButton addTarget:self action:@selector(doClickDoubleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doubleButton];
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
    titleLabel.text=@"测试四";
    [self.view addSubview:titleLabel];
    
}

#pragma -mark -doClickButton
//-(void)doClickDoubleButton:(UIButton *)btn
//{
//    
//    NSArray *failDoubleArr=[[NSUserDefaults standardUserDefaults] objectForKey:@"Fail"];
//    NSMutableArray *tempfailArr=[[NSMutableArray alloc]initWithArray:failDoubleArr];
//    
//    //计算一共的未发送成功消息数
//    if (!contentArr) {
//        contentArr=[[NSMutableArray alloc]init];
//    }
//    [contentArr removeAllObjects];
//
//    for (NSMutableDictionary *dic in failDoubleArr){
//      [contentArr addObject:[dic objectForKey:@"msgtest"]];
//    }
//    NSString *contentStr = [contentArr componentsJoinedByString:@","];
//    stepLabel.text=[NSString stringWithFormat:@"用户t001向群组\"106测试群\"重新发送了消息\"%@\"",contentStr];
//    
//    
//    
//    
//    for (NSMutableDictionary *dic in failDoubleArr) {
//        
//        NSLog(@"---dic---%@",dic);
//        
//        [[NetManager sharedManager] senddiscussionWithusername:[dic objectForKey:@"username"] did:[dic objectForKey:@"did"] msgtype:[dic objectForKey:@"msgType"] msgtext:[dic objectForKey:@"msgtest"] opendatetime:[dic objectForKey:@"time"] openby:[dic objectForKey:@"openby"]   locaid:@"1" hudDic:nil success:^(id responseDic) {
//            
//            
//            
//           
//            NSLog(@"---responseDic--%@",responseDic);
//            NSString *statusString=[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"status"]];
//            
//            if ([statusString isEqualToString:@"0"]){
//                
//                [tempfailArr removeObject:dic];
//                NSLog(@"--tempfailArr---%@---",tempfailArr);
//                
//                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                [userDefault setObject:tempfailArr forKey:@"Fail"];
//                [userDefault synchronize];
//
//                
//               // UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送成功，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//               // [alertView show];
//                
//            }else{
//                
//                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络不稳定，请您一会重新发送" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
//                [alertView show];
//            }
//            
//        }
//                                                          fail:^(id errorString) {
//                                                              
//                                                             UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络不稳定，请您一会重新发送" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
//                                                              [alertView show];
//                                                          }];
//        
//
//        
//        
//        
//    }
// 
//}
//-(void)doClickSendButton:(UIButton *)btn
//{
//    NSString* nowTimeStr =  [Utils getTimeForNow];
//    number++;
//    NSString *contentStr=[NSString stringWithFormat:@"ios-four-%i",number];
//    stepLabel.text=[NSString stringWithFormat:@"用户t001向群组\"106测试群\"发送了消息\"%@\"",contentStr];
//
//    [[NetManager sharedManager] senddiscussionWithusername:@"t001" did:@"106" msgtype:@"0" msgtext:contentStr opendatetime:nowTimeStr openby:@"t001" locaid:@"" hudDic:nil success:^(id responseDic) {
//        
//        NSLog(@"---responseDic--%@",responseDic);
//        NSString *statusString=[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"status"]];
//        
//        if ([statusString isEqualToString:@"0"]){
//            
//         //   UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送成功，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//          //  [alertView show];
//            
//        }else{
//            
//          //  UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送失败，请到”106测试讨论组”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//           // [alertView show];
//            
//            
//            NSMutableDictionary *failDic=[[NSMutableDictionary alloc]init];
//            
//            [failDic setObject:@"t001" forKey:@"username"];
//            [failDic setObject:@"106" forKey:@"did"];
//            [failDic setObject:@"0" forKey:@"msgType"];
//            [failDic setObject:contentStr forKey:@"msgtest"];
//            [failDic setObject:nowTimeStr forKey:@"time"];
//            [failDic setObject:@"t001" forKey:@"openby"];
//            
//            
//            if (!failArr) {
//                failArr=[[NSMutableArray alloc]init];
//            }
//            [failArr addObject:failDic];
//            NSLog(@"--failArr--%@",failArr);
//            
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setObject:failArr forKey:@"Fail"];
//            [userDefault synchronize];
//            
//        }
//        
//    }
//                                                      fail:^(id errorString) {
//                                            
//                                                                                                                    NSMutableDictionary *failDic=[[NSMutableDictionary alloc]init];
//                                                          
//                                                          [failDic setObject:@"t001" forKey:@"username"];
//                                                          [failDic setObject:@"106" forKey:@"did"];
//                                                          [failDic setObject:@"0" forKey:@"msgType"];
//                                                          [failDic setObject:contentStr forKey:@"msgtest"];
//                                                          [failDic setObject:nowTimeStr forKey:@"time"];
//                                                          [failDic setObject:@"t001" forKey:@"openby"];
//                                                        
//                                                          
//                                                          
//                                                          if (!failArr) {
//                                                              failArr=[[NSMutableArray alloc]init];
//                                                          }
//                                                          [failArr addObject:failDic];
//                                                          NSLog(@"--failArr--%@",failArr);
//                                                          
//                                                          NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                                                          [userDefault setObject:failArr forKey:@"Fail"];
//                                                          [userDefault synchronize];
//                                                          
//                                                          
//                                                          //UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"消息发送失败，请到”106测试群”群组查看是否收到消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
//                                                       //   [alertView show];
//                                                          
//                                                          
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
