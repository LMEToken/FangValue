//
//  FvalueBufferVC.m
//  FangChuang
//
//  Created by weiping on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvalueBufferVC.h"
#import "HomeLoginViewController.h"
#import "UIImageView+WebCache.h"
@interface FvalueBufferVC ()

@end

@implementation FvalueBufferVC

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
        [NetTest netTest];
    homeview = [[UIImageView alloc]initWithFrame:self.view.bounds];

    
    homeview.image = [UIImage imageNamed:@"4buffer.jpg"];
    if (self.view.bounds.size.height==480) {
         homeview.image = [UIImage imageNamed:@"3buffer.jpg"];
    }
    [self.view addSubview:homeview];
    [self.view setAlpha:.5];
    
    
    [UIView animateWithDuration:0 animations:^{
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(-6);
           [self.view setTransform:newTransform];
        }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:2 animations:^{
                             [self.view setAlpha:100];
                            } completion:^(BOOL finished){
                                 [self.view removeFromSuperview];
                                            [self login:[[NSUserDefaults standardUserDefaults] objectForKey:@"usernameid"] password:[[NSUserDefaults standardUserDefaults] objectForKey:@"usernamepwd"]];
                                  }];
                     }];
    
    
    // Do any additional setup after loading the view.
}

- (void) login:(NSString *)username password:(NSString *)password
{
    [[NetManager sharedManager] LoginWithusername:username password:password verificationcode:@"" hudDic:nil success:^(id responseDic) {
        NSDictionary *arr = [responseDic objectForKey:@"data"];
        NSLog(@"%@",arr);
        
        if ([[arr objectForKey:@"usertype"] isEqualToString:@"1"]) {
            //投资人
            
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
            

            
            //创业者权限
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
        

        
    } fail:^(id errorString) {
        
       [Utils changeViewControllerWithTabbarIndex:4];

    }];
    
    
}

@end
