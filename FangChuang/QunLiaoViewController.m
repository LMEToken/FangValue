//
//  QunLiaoViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//群聊（人数)
#import "QunLiaoViewController.h"
#import "CacheImageView.h"
#import "MineInFoemationViewController.h"

#import "QunLiaoMingChengViewController.h"
#import "SelectContactViewController.h"

#import "ChatWithFriendViewController.h"

//2014.06.13 chenlihua 修改图片缓存方式
#import "UIImageView+WebCache.h"

//2014.07.01 chenlihua 从群聊界面返回到聊天界面时，没有新消息。
#import "SQLite.h"
#import "JSONKit.h"
#import "Reachability.h"
//#define KUIFont  "FZLanTingHeiS-R-GB"
@interface QunLiaoViewController ()
{
    NSString* QunzhuName;
    BOOL adminSend;
}
@end

@implementation QunLiaoViewController

@synthesize qunChatName;
//@synthesize qunLiaoSocket;
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
- (void)lodata2
{

    [[NetManager sharedManager] getgrpmembersWithusername:[[UserInfo sharedManager]username]  dgid:self.digId
                                                   hudDic:nil
                                                  success:^(id responseDic) {
                                                      
                                                      NSLog(@"\n\n\nresponseDic = %@",responseDic);
                                                      
                                                      NSLog(@"%@",QunzhuName);
        self.datas=[NSMutableArray arrayWithArray: [[responseDic objectForKey:@"data"] objectForKey:@"memlist"]];
         for (int i =0; i<self.datas.count; i++) {
            if ( [[[self.datas objectAtIndex:i] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
                     [self.datas exchangeObjectAtIndex:0 withObjectAtIndex:i];
                                                          }
                     }
             if (self.datas.count==-1) {
                 NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
                 dataArray[1] = [[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",1,[[UserInfo sharedManager] username] ]]];
                 NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
               
                 for (int i=0; i<dataArray[1].count; i++) {
                     if ([[[dataArray[1] objectAtIndex:i] objectForKey:@"dgid"] isEqualToString:self.digId]) {
                         [dataArray[1] removeObjectAtIndex:i];
                     }
                 }
            
                 [userDefault setObject:dataArray[1] forKey:[NSString stringWithFormat:@"peoplelist%d%@",1,[[UserInfo sharedManager] username] ]];
                 [userDefault synchronize];
                 
                   for (int i=0; i<2; i++) {
                        if ([[[self.datas objectAtIndex:i] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
                    }else {
                  NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"成功创建聊天",@"success", nil];
                 [[NetManager sharedManager]getdid_by121Withusername:[[UserInfo sharedManager] username] sendto:[[self.datas objectAtIndex:i] objectForKey:@"username"] hudDic:dic success:^(id responseDic) {
                                                                      
                                                                      NSLog(@"%@",responseDic);
                ChatWithFriendViewController *cfVc=[[ChatWithFriendViewController alloc]init];
                                                                      cfVc.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"did"];
                                                                      NSLog(@"--------did----%@",cfVc.talkId);
                                                                      cfVc.titleName=[[self.datas objectAtIndex:i] objectForKey:@"username"];
                                                                      cfVc.entrance = @"contact";
                                                                      cfVc.memberCount=
                                                                      [NSString stringWithFormat:@"%@",[[responseDic objectForKey:@"data"] objectForKey:@"dname"]];
                                                                      //         ,[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"]];
                                                                      cfVc.flagContact=@"2";
                                                                      NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
                                                                      
                                                                      [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
                                                                      [[NSUserDefaults standardUserDefaults] synchronize];
                                                                      [self.navigationController pushViewController:cfVc animated:YES];
                                                                      
                                                                  }
                                                                                                                 fail:^(id errorString) {
                                                                                                                     
                                                                                                                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"该投资人尚未开通账号，不能发送消息！您可以要求其开通！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                                                                                     [alert show];
                                                                                                                     
                                                                                                                 } ];
                                                              }
                                                          }
                                                          
                                                          
                                                      }else{}
                                                      
                                                      [myTableView reloadData];
                                                  } fail:^(id errorString) {
                                                      //
                                                      //                                                      [self viewrodata];
                                                      
                                                      
                                                  }];
    
    
    
}
-(void)lodata
{
   [[NetManager sharedManager] getgrpmembersWithusername:[[UserInfo sharedManager]username]dgid:self.digId hudDic:nil success:^(id responseDic) {
       self.datas=[NSMutableArray arrayWithArray: [[responseDic objectForKey:@"data"] objectForKey:@"memlist"]];
       [myTableView reloadData];
       NSLog(@"%@",self.datas);
       self.title = [NSString stringWithFormat:@"群聊(%d)",self.datas.count];
       for (int i =0; i<self.datas.count; i++) {
           if ( [[[self.datas objectAtIndex:i] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
               [self.datas exchangeObjectAtIndex:0 withObjectAtIndex:i];
           }
       }
       NSLog(@"%@",self.datas);
       if (self.datas.count<=0) {
           
       }
       NSInteger index = 1;
       dataArray[index]=[[NSMutableArray alloc] init];
       NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
       if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
           ;
       }else{
           dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
           
       }
       NSString *dgid=self.digId;
       for (int i=0; i<dataArray[index].count; i++) {
           if ([[dataArray[index] objectAtIndex:i] containsObject:dgid]) {
               NSDictionary *dic =  [dataArray[index] objectAtIndex:i];
               NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
               [ee setValue:[dic objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
               [ee setValue:[dic objectForKey:@"dgid"] forKey:@"dgid"];
               [ee setValue:[dic objectForKey:@"dname"] forKey:@"dname"];
               if ([[NSString stringWithFormat:@"%d",self.datas.count] isEqualToString:@"2"]) {
                   [ee setValue:@"1v1" forKey:@"type"];
               }else {
                   [ee setValue:@"1vn" forKey:@"type"];
               }
               [ee setValue:[dic objectForKey:@"dpicurl"] forKey:@"dpicurl"];
               [ee setValue:[dic objectForKey:@"picurl2"]forKey:@"picurl1"];
               [ee setValue:[NSString stringWithFormat:@"%d",self.datas.count] forKey:@"mcnt"];
               [dataArray[index]  removeObjectAtIndex:i];
               [dataArray[index] addObject:ee];
           }
       }
       
       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
       [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
       [userDefault synchronize];
       NSInteger state = 0;
       for (int i =0; i<self.datas.count; i++) {
           if (  [[self.datas objectAtIndex:i]containsObject:[[UserInfo sharedManager]username]] ) {
               state = 1;
           }
       }
       if (state==0) {
           
           NSInteger index = 1;
           dataArray[index]=[[NSMutableArray alloc] init];
           NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
           if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
               ;
           }else{
               dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
           }
           
           
           NSString *dgid=self.digId;
           for (int i=0; i<dataArray[index].count; i++) {
               if ([[dataArray[index] objectAtIndex:i] containsObject:dgid]) {
                   [dataArray[index] removeObjectAtIndex:i];
               }
               
               
           }
           
           NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
           [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
           [userDefault synchronize];
     
           [self performSelector:@selector(viewrodata) withObject:nil afterDelay:1.0f];
       }
       
       //2014.07.03 chenlihua 获取所有人的id加入到一个数组中.
       NSMutableArray *arrayId=[[NSMutableArray alloc]init];
       for (NSDictionary *dic in self.datas)
       {
           [arrayId addObject:[dic objectForKey:@"id"]];
       }
       //将arrayId保存到本地
       NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
       [defauts setObject:arrayId forKey:@"arrayId"];
       [defauts synchronize];
       QunzhuName = [[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"];
       [self setTitle:[NSString stringWithFormat:@"群聊(%d)",[self.datas count]]];
       [myTableView reloadData];
       
       NSLog(@"--获取数据完成----");
       
       
    }fail:^(id errorString) {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        

    
    }];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{

    NSLog(@"00000");
    
   [self lodata];
}
- (void) backButtonAction : (id) sender
{
    //    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[self.datas count]] forKey:@"qunnamegogo"];
    //
    //     [[NSNotificationCenter defaultCenter] postNotificationName:@"qunnamegogo"object:nil];
    //
    //    self.datas.count
    //     [self.navigationController popViewControllerAnimated:NO];
    
    ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
    [[NSUserDefaults standardUserDefaults] setObject:self.digId forKey:@"nosave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    viewCon.entrance = @"qun";
    viewCon.talkId=self.digId;
    viewCon.titleName=qunChatName;
    viewCon.memberCount=[NSString stringWithFormat:@"%d",self.datas.count];
    viewCon.isPushString=@"is";
    
    [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:self.digId hudDic:nil success:^(id responseDic) {
        
        NSLog(@"%@",responseDic);
        //        if ([[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] isEqualToString:@"2"]) {
        //            NSInteger index =  1;
        //            dataArray[index]=[[NSMutableArray alloc] init];
        //            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
        //            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
        //                ;
        //            }else{
        //                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
        //            }
        //            for (int i =0; i<dataArray[index].count; i++) {
        //                if ([[dataArray[index] objectAtIndex:i]containsObject:self.digId]) {
        //                    NSLog(@"%@",[dataArray[index] objectAtIndex:i]);
        //                    [dataArray [index] removeObjectAtIndex:i];
        //                }
        //            }
        //            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
        //            [userDefault synchronize];
        //            return ;
        //
        //        }
        
        NSInteger index =  1;
        dataArray[index]=[[NSMutableArray alloc] init];
        NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
        if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
            ;
        }else{
            dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
        }
        for (int i =0; i<dataArray[index].count; i++) {
            if ([[dataArray[index] objectAtIndex:i]containsObject:self.digId]) {
                NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
                [dic setValue:self.digId forKey:@"dgid"];
                [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
                [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
                [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
                [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"]
                ;
                [dataArray [index] removeObjectAtIndex:i];
                [dataArray [index] addObject:dic];
                
            }
        }
        if ([dataArray[index]count]>1 ) {

            [dataArray[index] exchangeObjectAtIndex:0 withObjectAtIndex:[dataArray [index] count]-1];
        }

        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username]]];
        [userDefault synchronize];
        
    } fail:^(id errorString) {
    
    
    }];
    
    [self.navigationController pushViewController:viewCon animated:NO];
    
}
- (void) hudShow
{
    //2014.05.27 chenlihua 解决每隔10s刷新下主页，以使提醒的消息数更新。为了用户体验，暂时不显示@“正在加载."字样。
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datas = [[NSMutableArray alloc]init];
    [self setTabBarHidden:YES];
    [self hudShow];
    //从服务器获取，无用数据 chenlihua 2014.4.21
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    
    //  [self.titleLabel setText:@"群聊(3人)"];
    [self addBackButton];
    self.contentView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<4; i++) {
        dataArray[i]=[[NSMutableArray alloc]init];
    }
    hideen=YES;
    currentPage=1;
    //2014.04.25 chenlihua 在群聊（人数）界面右上角按钮，添加群成员
    //    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    //    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    //    [rtBtn setImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
    //    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addRightButton:rtBtn isAutoFrame:NO];
    //
    //
    //    //群名称后的背景图片
    //    UIImage* bcImg = [UIImage imageNamed:@"63_kuang_1"];
    //     bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    //    [bcImgV setImage:bcImg];
    //    [self.contentView addSubview:bcImgV];
    //
    //    //群名称Label
    //   titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, (55 - 20) / 2., 200, 20)];
    //    [titleLb setText:@"群名称"];
    //    [titleLb setTextColor:ORANGE];
    //    [titleLb setBackgroundColor:[UIColor clearColor]];
    //    [titleLb setFont:[UIFont fontWithName:KUIFont size:15]];
    //    [self.contentView addSubview:titleLb];
    
    //15 * 26
    //箭头button
    //    arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [arrowBtn setFrame:CGRectMake(320 - 10 - 26 / 2. , (55 - 15/ 2.) / 2., 15 / 2., 26 / 2.)];
    //    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"59_jiantou_1"] forState:UIControlStateNormal];
    //   // arrowBtn.backgroundColor=[UIColor redColor];
    //    [self.contentView addSubview:arrowBtn];
    //
    //    //和群名称背景图片一样大小的button
    //    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setFrame:bcImgV.frame];
    //    [self.contentView addSubview:btn];
    //    [btn addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    
    //群成员UITableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bcImgV.frame) , 320, self.contentViewHeight - CGRectGetMaxY(bcImgV.frame) ) style:UITableViewStylePlain];
    //    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setDataSource:self];
    [myTableView setDelegate:self];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //     [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]
    //2014.05.04 chenlihua 设置单元格可以被滑动删除
    //    [myTableView setEditing:NO animated:YES];
    [self.contentView addSubview:myTableView];
}

#pragma mark - button action


#pragma  -mark -doClickButton
//2014.04.25 chenlihua  右上角添加人数按钮
- (void)rightButton:(UIButton*)button
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    // 动画时间控制
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //是否代理
    transition.delegate = self;
    // 是否在当前层完成动画
    transition.removedOnCompletion = NO;
    
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    
    SelectContactViewController *viewCon = [[SelectContactViewController alloc]init];
    viewCon.didString=self.digId;
    viewCon.guoluarr =self.datas;
    NSLog(@"%@", self.datas);
    NSInteger index = 1;
    dataArray[index]=[[NSMutableArray alloc] init];
    
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
    NSLog(@"%@",dataArray[1]);
    
    NSString *dgid=self.digId;
    for (int i=0; i<dataArray[index].count; i++) {
        if ([[dataArray[index] objectAtIndex:i] containsObject:dgid]) {
            NSLog(@"%@",[dataArray[index] objectAtIndex:i]);
            viewCon.quntype = [[dataArray[index] objectAtIndex:i] objectForKey:@"type"];
        }
    }
    
    
    
    
    [self.navigationController pushViewController:viewCon animated:NO];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

//点击群名称背景图片
- (void)changeName
{
    QunLiaoMingChengViewController* viewController = [[QunLiaoMingChengViewController alloc] init];
    
    viewController.peoplecount = [NSString stringWithFormat:@"%d",self.datas.count];
    
    [viewController setDigId:self.digId];

    viewController.groupChatName=self.qunChatName;
    [self.navigationController pushViewController:viewController animated:YES];
}
//点击“删除并退出"按钮
- (void)deleteButton:(UIButton*)button
{
    
    if (![self isConnectionAvailable]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络已断开，请稍后重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }

    if (self.datas.count==0) {
        
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，已经没有可以删除的群组" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alv show];
        return;
        
    }
    
    if (!qunChatName) {
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，此群不能进行删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alv show];
        return;
        
    }
    if ([QunzhuName isEqualToString:[[UserInfo sharedManager] username]]) {
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:nil message:@"您是群主，确定要删除该群吗？删除后记录将不能恢复！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alv show];
        adminSend = YES;
    }else
    {
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:nil message:@"你不是群主，确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alv show];
        adminSend = NO;
    }
}
#pragma -mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        for (int index=1; index<=4; index++) {
            dataArray[index]=[[NSMutableArray alloc] init];
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSString *dgid=self.digId;
            for (int i=0; i<dataArray[index].count; i++) {
                if ([[dataArray[index] objectAtIndex:i] containsObject:dgid]) {
                    [dataArray[index] removeObjectAtIndex:i];
                }
            }
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
        }
      
        
        if (adminSend) {
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"删除中。。";
            [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            [[NetManager sharedManager] deletedisgWithusername:[[UserInfo sharedManager] username]
                                                           did:self.digId
                                                        hudDic:Nil
                                                       success:^(id responseDic) {
                                                           
                                                           NSLog(@"responseDic = %@",responseDic);
                                                           
                                                           
                                                           
                                                           [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
                                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                                           FvalueIndexVC *detailView=[[FvalueIndexVC alloc]init];
                                                           [self.navigationController pushViewController:detailView animated:YES];
                                                           //root
                                                           //                                                        [self.navigationController popToRootViewControllerAnimated:YES];
                                                           
                                                       }
                                                          fail:^(id errorString) {
                                                              
                                                              [self viewrodata];
                                                              
                                                          }];
        }else{
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"删除中。。";
            [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            [[NetManager sharedManager] retreatdisgWithusername:[[UserInfo sharedManager] username] did:self.digId grpmember:[[UserInfo sharedManager] username] hudDic:nil success:^(id responseDic) {
                [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                FvalueIndexVC *detailView=[[FvalueIndexVC alloc]init];
                [self.navigationController pushViewController:detailView animated:YES];
                
            } fail:^(id errorString) {
                
                [self viewrodata];
                
                
                //                 [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"删除失败"]];
            }];
        }
    }
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
    //    FangChuangInsiderViewController *detailView=[[FangChuangInsiderViewController alloc]init];
    //    [self.navigationController pushViewController:detailView animated:YES];
    
}
-(void)viewrodata
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    FvalueIndexVC *detailView=[[FvalueIndexVC alloc]init];
    [self.navigationController pushViewController:detailView animated:NO];
}
-(void)gotoimage:(UIButton *)btn
{
    //    MineInFoemationViewController* viewController = [[MineInFoemationViewController alloc] init];
    
    FvaluePeopleData *vc = [[FvaluePeopleData alloc]init];
    //    NSLog(@"%@",[self.datas objectAtIndex:btn.tag]);
    //    viewController.dic = [self.datas objectAtIndex:btn.tag];
    //    viewController.flagPage=@"2";
    vc.peopledic = [self.datas objectAtIndex:btn.tag];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)deleteshow
{
    [myTableView reloadData];
    if (date==0) {
        hideen = NO;
        date++;
    }else
    {
        hideen=YES;
        date=0;
    }
    [myTableView reloadData];
    
    
    
    
}
#pragma  -mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datas.count==2) {
        myTableView.frame =CGRectMake(0, 20, 500,320);
        bcImgV.hidden = YES;
        titleLb.hidden = YES;
        arrowBtn.hidden = YES;
        btn.hidden = YES;
        
    }
    //    NSDictionary* dic = [self.datas objectAtIndex:indexPath.row];
    //    NSLog(@"%@",self.datas);
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //          deletebt.hidden = YES;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row==0) {
        
       
        UILabel *heradllable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
        
        [heradllable setFont:[UIFont fontWithName:KUIFont size:13]];
        [heradllable setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:heradllable];
        
        NSInteger count=self.datas.count;
        NSInteger line=4;
        NSInteger sheng=count-line*(count/line);
        
        for ( int i = 0; i<count/line; i++) {
            for (int j= 0 ; j<line; j++) {
                NSInteger index=line*i+j;
                NSLog(@"%@",[[self.datas objectAtIndex:index] objectForKey:@"name"]);
                UIImageView *mybtn =[ [UIImageView alloc]initWithFrame
                                     :CGRectMake(20+73*j, 10+73*i, 50, 50)];
                UIButton *clickbt =[ [UIButton alloc]initWithFrame
                                    :CGRectMake(20+73*j, 10+73*i, 50, 50)];
                clickbt.tag =index;
                clickbt.userInteractionEnabled = hideen;
                clickbt.backgroundColor = [UIColor clearColor];
                [clickbt addTarget:self action:@selector(gotoimage:) forControlEvents:UIControlEventTouchDown];
                UILabel *textlable = [[UILabel alloc]initWithFrame
                                      :CGRectMake(20+73*j, 67+73*i, 50,15)];
                textlable.textAlignment = NSTextAlignmentCenter;
                [textlable setFont:[UIFont fontWithName:KUIFont size:11]];
                textlable.text =[[self.datas objectAtIndex:index] objectForKey:@"username"] ;
                
                NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
                if ([[[self.datas objectAtIndex:index] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
                    
                    [mybtn setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager]userpicture]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                    
                }else
                {
                    NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[[self.datas objectAtIndex:index] objectForKey:@"username"] ,   [[UserInfo sharedManager]username]]];
                    //                [mybtn setImageWithURL:[NSURL URLWithString:[[self.datas objectAtIndex:index] objectForKey:@"picurl2"]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                    [mybtn setImageWithURL:[NSURL URLWithString:urlString]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                }
          
                [mybtn.layer setCornerRadius:10.0f];
                [mybtn.layer setMasksToBounds:YES];
                [clickbt.layer setCornerRadius:10.0f];
                [clickbt.layer setMasksToBounds:YES];
                [mybtn setBackgroundColor:[UIColor clearColor]];
                
                
               [cell addSubview:textlable];
                UIButton  *deletebt =[ [UIButton alloc]initWithFrame:CGRectMake(15+73*j, 3+73*i, 25, 25)];
                [deletebt addTarget:self action:@selector(deletepeople:) forControlEvents:
                 UIControlEventTouchDown];
                deletebt.tag =index;
                
                
                if (  [[[self.datas objectAtIndex:index] objectForKey:@"name"] isEqualToString:QunzhuName]) {
                    
                    deletebt.hidden = YES;
                }else
                {
                    deletebt.hidden = hideen;
                }
                if (index==0) {
                    deletebt.hidden = YES;
                }
                [deletebt setImage:[UIImage imageNamed:@"jianpeoplered"] forState: UIControlStateNormal ];
                
                [cell addSubview:mybtn];
                [cell addSubview:clickbt];
                [cell addSubview:deletebt];
                
            }
        }
        if (sheng==0) {
            //            UIButton *clickbt =[ [UIButton alloc]initWithFrame
            //                                :CGRectMake(20, 10+73*count/line+73, 50, 50)];
            //            clickbt.backgroundColor = [UIColor blackColor
            //                                       ];
            //            [clickbt addTarget:self action:@selector(rightButton:) forControlEvents: UIControlEventTouchDown];
            //
            //             [cell addSubview:clickbt];
        }
        if (self.datas.count==3||sheng==3) {
            
            clickbt1 =[ [UIButton alloc]initWithFrame
                       :CGRectMake(20, 87+73*(count/line), 50, 50)];
            [clickbt1 addTarget:self action:@selector(deleteshow) forControlEvents: UIControlEventTouchDown];
            [clickbt1 setImage:[UIImage imageNamed:@"jianpeople"] forState: UIControlStateNormal ];
            clickbt1.hidden=YES;
            if (QunzhuName!=nil&&[[UserInfo sharedManager]username]!=nil&&![QunzhuName isEqual:[NSNull null]]) {
                if ([QunzhuName isEqualToString:[[UserInfo sharedManager]username]]) {
                    clickbt1.hidden = NO;
                }
            }
            [cell addSubview:clickbt1];
            
            
        }
        for (int n=0; n<sheng+2; n++) {
            
            
            if (n==sheng) {
                
                UIButton *clickbt =[ [UIButton alloc]initWithFrame
                                    :CGRectMake(20+73*n, 87+73*(count/line-1), 50, 50)];
                //                clickbt.backgroundColor = [UIColor grayColor];
                [clickbt addTarget:self action:@selector(rightButton:) forControlEvents: UIControlEventTouchDown];
                [clickbt setImage:[UIImage imageNamed:@"addnewpeople"] forState: UIControlStateNormal ];
                //                [clickbt.titleLabel setFont:[UIFont fontWithName:KUIFont size:12]];
                //                [clickbt setTitle:@"添加成员" forState:UIControlStateNormal];
                
                
                
                [cell addSubview:clickbt];
            }else if(n==sheng+1)
            {
                if (sheng==3) {
                    
                }else
                {
                    clickbt1 =[ [UIButton alloc]initWithFrame
                               :CGRectMake(20+73*n, 87+73*(count/line-1), 50, 50)];
                    //                clickbt.backgroundColor = [UIColor grayColor];
                    [clickbt1 addTarget:self action:@selector(deleteshow) forControlEvents: UIControlEventTouchDown];
                    [clickbt1 setImage:[UIImage imageNamed:@"jianpeople"] forState: UIControlStateNormal ];
                    clickbt1.hidden=YES;
                    NSLog(@"%@",QunzhuName);
                    NSLog(@"%@",[[UserInfo sharedManager]username]);
                    if (QunzhuName!=nil&&[[UserInfo sharedManager]username]!=nil&&![QunzhuName isEqual:[NSNull null]]) {
                        if ([QunzhuName isEqualToString:[[UserInfo sharedManager]username]]) {
                            clickbt1.hidden = NO;
                        }
                    }
                    
                    //                [clickbt.titleLabel setFont:[UIFont fontWithName:KUIFont size:12]];
                    //                [clickbt setTitle:@"添加成员" forState:UIControlStateNormal];
                    
                    
                    
                    [cell addSubview:clickbt1];
                }
                
            }
            
            else
            {
                
                UIImageView *typebutton = [[ UIImageView alloc]initWithFrame:CGRectMake(20+73*n, 10+73*(count/line), 50, 50)];
                [typebutton.layer setCornerRadius:10.0f];
                [typebutton.layer setMasksToBounds:YES];
                NSInteger index=(line *(count/line))+n;
                typebutton.tag =index;
                NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
                
                NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[[self.datas objectAtIndex:index] objectForKey:@"username"] ,   [[UserInfo sharedManager]username]]];
                //                [mybtn setImageWithURL:[NSURL URLWithString:[[self.datas objectAtIndex:index] objectForKey:@"picurl2"]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
           
                NSLog(@"%@",[[UserInfo sharedManager]username]);
                if ([[[self.datas objectAtIndex:index] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
                    
                     [typebutton  setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                    
                }else
                {
                      [typebutton  setImageWithURL:[NSURL URLWithString:urlString]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                }
              
                //                [  typebutton setImageWithURL:[NSURL URLWithString:[[self.datas objectAtIndex:index] objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
                [cell addSubview:typebutton];
                
                UIButton * deletebt2=[ [UIButton alloc]initWithFrame:CGRectMake(15+73*n, 3+73*(count/line), 25, 25)];
                [deletebt2 addTarget:self action:@selector(deletepeople:) forControlEvents:
                 UIControlEventTouchDown];
                deletebt2.tag = (line *(count/line))+n;
                deletebt2.hidden=hideen;
                if (  [[[self.datas objectAtIndex:index] objectForKey:@"name"] isEqualToString:QunzhuName]) {
                    
                    deletebt2.hidden = YES;
                }
                if (index==0) {
                    deletebt2.hidden = YES;
                }
                [deletebt2 setImage:[UIImage imageNamed:@"jianpeoplered"] forState: UIControlStateNormal ];
                
                
                
                UIButton *clickbt =[ [UIButton alloc]initWithFrame:CGRectMake(20+73*n, 10+73*(count/line), 57, 57)];
                clickbt.tag=(line *(count/line))+n;
                //                clickbt.backgroundColor = [UIColor blackColor];
                clickbt.userInteractionEnabled = hideen;
                [clickbt addTarget:self action:@selector(gotoimage:) forControlEvents:UIControlEventTouchDown];
                [cell addSubview:clickbt];
                
                
                
                
                UILabel *textlable = [[UILabel alloc]initWithFrame
                                      :CGRectMake(20+73*n, 67+73*(count/line), 70, 15)];
                textlable.textAlignment = NSTextAlignmentCenter;
                textlable.backgroundColor=[UIColor clearColor];
                [textlable setFont:[UIFont fontWithName:KUIFont size:11]];
               // textlable.text = [[self.datas objectAtIndex:index] objectForKey:@"username"];
                //将账号改为真实姓名
                if ([[[self.datas objectAtIndex:index] objectForKey:@"username"] isEqualToString:[[UserInfo sharedManager]username]]) {
                    textlable.text=[[UserInfo sharedManager] user_name];
                }else{
                    textlable.text = [[self.datas objectAtIndex:index] objectForKey:@"username"];
                }
                
               [cell addSubview:textlable];
                
               [cell addSubview:deletebt2];
                
                
            }
            
            
            //            UILabel *typelable = [[UILabel alloc]initWithFrame:CGRectMake(20+75*n, 60+70*(count/line), 65, 50)];
            //
            //            typelable.textAlignment = UITextAlignmentCenter;
            //            typelable.text =[savearr objectAtIndex:(line *(count/line))+n];
            //            [typelable setFont:[UIFont fontWithName:KUIFont size:13]];
            //            [self.contentView addSubview:typelable];
            
        }
        
    }else
    {
        if (self.datas.count==2) {
            if (indexPath.row==1) {
                //                UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 320, 1)];
                //                myview.image = [UIImage imageNamed:@"celllin@2x"];
                //                [cell addSubview:myview];
                //                UIImageView *myview2= [[UIImageView alloc]initWithFrame:CGRectMake(15, 45, 320, 1)];
                //                myview2.image = [UIImage imageNamed:@"celllin@2x"];
                //                [cell addSubview:myview2];
                UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 320, 1)];
                myview.image = [UIImage imageNamed:@"celllin@2x"];
                [cell addSubview:myview];
                UIButton *my = [[UIButton alloc]initWithFrame:CGRectMake(30,20, 260, 37)];
                [my addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchDown];
                //            [my setTitle:@"退出讨论组" forState:UIControlStateNormal];
                [my setImage:[UIImage imageNamed:@"deleteandreturn"] forState:UIControlStateNormal];
                //            my.backgroundColor = [UIColor redColor];
                [cell addSubview:my];
            }
            
        }else
        {
            if (indexPath.row==1) {
                UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 320, 1)];
                myview.image = [UIImage imageNamed:@"celllin@2x"];
                [cell addSubview:myview];
                UIImageView *myview2= [[UIImageView alloc]initWithFrame:CGRectMake(15, 45, 320, 1)];
                myview2.image = [UIImage imageNamed:@"celllin@2x"];
                [cell addSubview:myview2];
                
                UILabel *qunname= [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 40)];
                [qunname setText:@"群名称 ："];
                [qunname setFont:[UIFont fontWithName:KUIFont size:12]];
                [cell addSubview:qunname];
                UILabel *qunname2= [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 190, 40)];
                qunname2.textAlignment = UITextAlignmentRight;
                [qunname2 setText:qunChatName];
                [qunname2 setTextColor:[UIColor grayColor]];
                [qunname2 setFont:[UIFont fontWithName:KUIFont size:12]];
                
                
                
                [cell addSubview:qunname2];
                
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(290, 13, 10, 20)];
                imageview.image = [UIImage imageNamed:@"accessory"];
                [cell addSubview:imageview];
                //            UIButton *my = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 260, 37)];
                //            [my addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchDown];
                //            //            [my setTitle:@"退出讨论组" forState:UIControlStateNormal];
                //            [my setImage:[UIImage imageNamed:@"deleteandreturn"] forState:UIControlStateNormal];
                //            //            my.backgroundColor = [UIColor redColor];
                //            [cell addSubview:my];
                
            }
            if (indexPath.row==2) {
                UIButton *my = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 260, 37)];
                [my addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchDown];
                //            [my setTitle:@"退出讨论组" forState:UIControlStateNormal];
                [my setImage:[UIImage imageNamed:@"deleteandreturn"] forState:UIControlStateNormal];
                //            my.backgroundColor = [UIColor redColor];
                [cell addSubview:my];
            }
        }
    }
    
    return cell;
    
    //    [cell setBackgroundColor:[UIColor clearColor]];
    
    //头像
    /*
     UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
     CacheImageView *headView = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 10, 50, 50)];
     [headView getImageFromURL:[NSURL URLWithString:[dic objectForKey:@"picurl"]]];
     [headView setBackgroundColor:[UIColor clearColor]];
     [cell.contentView addSubview:headView];
     */
    
    //    //2014.06.13 chenlihua 修改图片缓存方式
    //    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    //    [headView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"picurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
    //    [headView.layer setCornerRadius:10.0f];
    //    [headView.layer setMasksToBounds:YES];
    //    [headView setBackgroundColor:[UIColor clearColor]];
    //    [cell.contentView addSubview:headView];
    
    
    //姓名
    //    UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame)+10, 25, 320 - CGRectGetMaxX(headView.frame) - 10 -10, 20)];
    //    [xingminglab setBackgroundColor:[UIColor clearColor]];
    //    [xingminglab setText:[dic objectForKey:@"username"]];
    //    [xingminglab setFont: [UIFont fontWithName:KUIFont size:15]];
    //    [xingminglab setTextColor:[UIColor grayColor]];
    //    [cell.contentView addSubview:xingminglab];
    //
    //    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        [self changeName];
    }
    //    MineInFoemationViewController* viewController = [[MineInFoemationViewController alloc] init];
    //    viewController.dic = [self.datas objectAtIndex:indexPath.row];
    //    NSLog(@"-------------跳转到个人详细信息时。------------viewController.dic %@-------",viewController.dic);
    //    NSLog(@"-------------跳转到个人详细信息时，服务器提供的数据");
    //    viewController.flagPage=@"2";
    //    [self.navigationController pushViewController:viewController animated:YES];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 40;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//
//    //508 * 66
//    UIButton* deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleBtn setFrame:CGRectMake((320 - 508 / 2.) / 2., 3.5, 508 / 2., 66 / 2)];
//    [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [deleBtn setTitle:@"删除并退出" forState:UIControlStateNormal];
//    [deleBtn.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
//    [deleBtn setBackgroundImage:[UIImage imageNamed:@"ic_btn_bg2"] forState:UIControlStateNormal];
//    deleBtn.tag = 200;
//
//    [deleBtn addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:deleBtn];
//    return view;
//}


- (void)showAlert
{
    
    promptAlert = [[UIAlertView alloc] initWithTitle:@"正在删除群成员" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    promptAlert.frame = CGRectMake(30, 30, 30, 30);
    
    [promptAlert show];
}
- (void)myTask {
    
    sleep(3);
}
-(void)deletepeople:(UIButton *)mybtn
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"删除中。。";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    //踢出群成员，暂时去掉
    /*
    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                             talkId:self.digId
                        contentType:@"0"
                           talkType:@"3"
                          vedioPath:@""
                            picPath:@""
                            content:[NSString stringWithFormat:@"%@踢出群成员[%@]",[[UserInfo sharedManager] username],  [[self.datas objectAtIndex:mybtn.tag] objectForKey:@"name"]]
                               time:@""
                             isRead:@"0"
                             second:@""
                              MegId:[NSString stringWithFormat:@"%@踢出群成员[%@]",[[UserInfo sharedManager] username],  [[self.datas objectAtIndex:mybtn.tag] objectForKey:@"name"]]
                           imageUrl:@""
                             openBy:@""];
    SUser * user = [SUser new];
    user.uid=self.digId;
    user.titleName =self.digId;
    user.conText = [NSString stringWithFormat:@"%@踢出群成员[%@]",[[UserInfo sharedManager] username],  [[self.datas objectAtIndex:mybtn.tag] objectForKey:@"name"]];
    user.contentType = @"3";
    user.username =[[UserInfo sharedManager] username];
    user.msgid =  @"";
    user.description = @"";
    user.readed=@"1";
    NSLog(@"%@",user);
    NSLog(@"%@  ",  user);
    NSLog(@"%@  ",user.titleName);
    NSLog(@"%@ ",user.conText);
    NSLog(@"%@  ",user.contentType);
    NSLog(@"%@  ",user.username);
    NSLog(@"%@  ",user.msgid );
    NSLog(@"%@  ",user.description);
    [_userDB saveUser:user];
    */
    
    [[NetManager sharedManager] retreatdisgWithusername:[[UserInfo sharedManager] username] did:self.digId grpmember: [[self.datas objectAtIndex:mybtn.tag] objectForKey:@"username"] hudDic:nil success:^(id responseDic) {
        
        NSLog(@"%@",responseDic);
        //        NSInteger  currentIndex=1;
        //        NSInteger index = currentIndex;
        //        dataArray[index]=[[NSMutableArray alloc] init];
        //        NSUserDefaults *unSendDefault3 = [NSUserDefaults standardUserDefaults];
        //        if (![unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
        //            ;
        //        }else{
        //            dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
        //        }
        //        for (int i=0; i<dataArray[currentIndex].count; i++) {
        //            if ([[dataArray[currentIndex] objectAtIndex:i]containsObject:self.digId]) {
        //                NSDictionary *dic =  [dataArray[currentIndex] objectAtIndex:i];
        //                NSInteger mcnt = [[dic objectForKey:@"mcnt"] intValue]-1;
        //                NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
        //                [ee setValue:[dic objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
        //                [ee setValue:[dic objectForKey:@"dgid"] forKey:@"dgid"];
        //                [ee setValue:[dic objectForKey:@"dname"] forKey:@"dname"];
        //                [ee setValue:[dic objectForKey:@"dpicurl"] forKey:@"dpicurl"];
        //                [ee setValue:[dic objectForKey:@"picurl1"]forKey:@"picurl1"];
        //                [ee setValue:[NSString stringWithFormat:@"%d",mcnt] forKey:@"mcnt"];
        //                [dataArray[currentIndex]  removeObjectAtIndex:i];
        //                [dataArray[currentIndex] addObject:ee];
        //            }
        //        }
        //        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //        [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
        //        [userDefault synchronize];
        
        
        [self lodata2];
        
        
       
        //    [self.datas]
        
        
        
        //        [self.navigationController pushViewController:viewController animated:NO];
    } fail:^(id errorString) {
        [myTableView reloadData];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.datas.count==2) {
        return 2;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@%@",[[UserInfo sharedManager] username],QunzhuName);
    
    if (indexPath.row==0) {
        
        if (  [[[UserInfo sharedManager] username] isEqualToString:QunzhuName]) {
            if (self.datas.count<3) {
                return 80;
            }
            if (self.datas.count>=2&&self.datas.count<=6) {
                return 160;
            }
            if (self.datas.count-(self.datas.count/4)*4==3) {
                return self.datas.count/4 *80+160;
            }
            if (self.datas.count-(self.datas.count/4)*4 >=0) {
                return self.datas.count/4 *80+80;
            }
            
            if (self.datas.count/4>0) {
                return self.datas.count/4 *80;
            }
            
            
        }else
        {
            if (self.datas.count<4) {
                return 80;
            }
            if (self.datas.count>=3&&self.datas.count<=7) {
                return 160;
            }
            if (self.datas.count-(self.datas.count/4)*4==4) {
                return self.datas.count/4 *80+160;
            }
            if (self.datas.count-(self.datas.count/4)*4 >=0) {
                return self.datas.count/4 *80+80;
            }
            
            if (self.datas.count/4>0) {
                return self.datas.count/4 *80;
            }
            
        }
    }
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//2014.05.04 chenlihua 群主可以删除群组成员
//单元的追加/删除

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"-----开始进行删除-------------");
//    if(UITableViewCellEditingStyleDelete==editingStyle)
//    {
//        NSLog(@"-----开始退出群组--------");
//        NSDictionary* dic = [self.datas objectAtIndex:indexPath.row];
//        NSLog(@"----dic------%@-----",dic);
//        NSLog(@"----name-------%@--",[dic objectForKey:@"username"]);
//        NSLog(@"----grpmemeber--- %@---",[dic objectForKey:@"grpmember"]);
//        NSLog(@"-----id----%@-----",[dic objectForKey:@"id"]);
//        NSLog(@"----userName---%@---",[[UserInfo sharedManager] username]);
//        NSLog(@"-------self.digId--%@--",self.digId);
//        //退出群组
//        //删除群组
//
//    }
//}
//2014.05.07 chenlihua 实现删除群成员的功能。
//重新从服务器获取数据，实现在本页面中数据的更新。

#pragma -mark -functions
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
    return isExistenceNetwork;
}



@end
