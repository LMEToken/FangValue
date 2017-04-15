//
//  FangChuangGuWenViewController.m
//  FangChuang
//
//  Created by 朱天超 on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

//方创，没有上面选择栏的时候，p,i的账户调用
#import "FangChuangGuWenViewController.h"
#import "CacheImageView.h"
#import "FangChuangNeiBuViewController.h"
#import "CaiWuMoXingViewController.h"
#import "XuanZeLianXiRenViewController.h"
#import "14BianJiViewController.h"
#import "ShangYeJiHuaViewController.h"
#import "XiangMuJiDuViewController.h"

#import "XiangMuJinZhanViewController.h"
#import "JinZhanXiangQingViewController.h"
#import "FangChuangRenWuViewController.h"
#import "RiChengBiaoViewController.h"
#import "ChatWithFriendViewController.h"

#import "FaFinancierWelcomeItemCell.h"

#import "SearchResultViewController.h"


#import "SQLite.h"
#import "AppDelegate.h"
#import "XGPush.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

//2014.06.23 chenlihua
#import "JSONKit.h"

@interface FangChuangGuWenViewController ()
{
    //2014 - 08-7 Tom  实现接口减少的一些变量 {
    
    NSInteger sum;
    
    NSMutableArray *typearr[4];
    
    NSMutableArray *unreadarr;
    
    NSMutableArray *unreadarrcount;
    
    NSInteger count;
   
    NSString *titlehead;
    
    //2014 -08-7 tom}
    
    NSInteger count2;
}

@end

@implementation FangChuangGuWenViewController
@synthesize unReadAll;
@synthesize socketUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
//2014.04.30 chenlihua  内部消息提醒，内部联系人的头像右上角显示未读的消息数。
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NetManager sharedManager] indexWithuserid:[[UserInfo sharedManager] username]   //接口后来更改 为 传username
                                          dtype:@""
                                         hudDic:nil
                                        success:^(id responseDic) {
                                            
                                            NSDictionary *dic = [responseDic objectForKey:@"data"];
                                            
                                            dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
                                            
                                            for (NSDictionary* dic in dataArray) {
                                                NSLog(@"_______%@",dic);
                                            }
                                            [myTableView reloadData];
                                        }
                                           fail:^(id errorString) {
                                               
                                           }];

}
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    //2014.07.10 chenlihua 关闭定时器
   // [timerSocket invalidate];
}
-(void)ConSocket2
{
    
    if (![socketUpdate isConnected]) {
        [socketUpdate connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
        
        /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"11111初始化网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
        */
        
        NSString* nowTimeStr =  [Utils getTimeForNow];
        
        if(![SQLite getLastTime])
        {
            [SQLite setLastTime:nowTimeStr];
            
        }
        
        NSString *lastTime=[SQLite getLastTime];
        
        //2014.07.11 chenlihua 将to_uid,message去掉。
       // NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"from_rdatetime",[[UserInfo sharedManager] username],@"from_uid",/*@"all",@"to_uid",@"ios",@"message",*/nil];
        
        
        //2014.07.29 chenlihua 发送给socket的数据给加上标识,dev:iOS 或者 dev:android.
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"from_rdatetime",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
        
        
       
        
        
        NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
        NSString *jsonString=[jsonDic JSONString];
        NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
        
        
        //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
        NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
        NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
        NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
        NSLog(@"-----------newJson-------%@",newJson);
        
        
        NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
        [socketUpdate writeData:data withTimeout:-1 tag:1000];
        
    }else{
        /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"11111m网络没有断开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
         */
    }
}

//2014.06.23 chenlihua 解决点完消息后，未读消息数不能及时更新的问题
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"pgroups1"]!=nil) {
        
        NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:@"pgroups1"];
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
        [myTableView reloadData];
        
    }else
    {
        
        [self loadData];
    }

    
    
    
    //2014.07.07 chenlihua 重新改写socket
    //2014.08.05 chenlihua 去掉socket
    if ([messageFlag isEqualToString:@"1"]) {
        ;
    }else{
        socketUpdate=[socketNet sharedSocketNet];
        socketUpdate.delegate=self;
        
        timerSocket=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ConSocket2) userInfo:nil repeats:YES];
        
        
        //2014.06.18 chenlihua 获取上一条消息存入数据库的时间
        NSString* nowTimeStr =  [Utils getTimeForNow];
        
        if(![SQLite getLastTime])
        {
            [SQLite setLastTime:nowTimeStr];
            
        }
        
        NSLog(@"------from_rdateTime---%@",[SQLite getLastTime]);
        
        NSString *lastTime=[SQLite getLastTime];
        
        NSLog(@"----lastTime-----%@",lastTime);
        
        
        //2014.06.25 执行一次轮询操作，把数据取下来。
        //2014.07.28 chenlihua 把轮询移到viewDidLoad.解决断网后，别人给自己发送消息时，会收到重复消息的问题。
        
        [[NetManager sharedManager] getdiscussionWithusername:[[UserInfo sharedManager] username]
                                                          did:@"0"
                                                    rdatetime:lastTime
                                                        dflag:@"0"  //  1 向前 0 向后
                                                      perpage:@"20"
                                                       hudDic:nil
                                                        msgid:@"0"
                                                      success:^(id responseDic) {
                                                          
                                                          NSLog(@"responseDic = %@",responseDic);
                                                          
                                                          
                                                          NSArray* array = [[responseDic objectForKey:@"data"] objectForKey:@"messagelist"];
                                                          
                                                          if (array.count == 0) {
                                                              
                                                              return ;
                                                          }
                                                          
                                                          NSLog(@"--array---%@---",array);
                                                          
                                                          
                                                          //存储收到的信息
                                                          [self saveChatToSqlite:array];
                                                          
                                                          /*
                                                           NSString *str=[NSString stringWithFormat:@"轮询array%@",array];
                                                           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                           [alert show];
                                                           */
                                                          
                                                          
                                                      }
                                                         fail:^(id errorString) {
                                                             NSLog(@"----errorString---%@",errorString);
                                                             
                                                         }];
        
        
        
        //2014.07.27 chenlihua 测试form_uid是否为空
        /*
         if (![[UserInfo sharedManager] username]) {
         NSString *str=[NSString stringWithFormat:@"from_id--%@",[[UserInfo sharedManager] username]];
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
         }*/
        
        
        //2014.06.16 chenlihua 上传服务器JSON数据
        //   NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"from_rdatetime",[[UserInfo sharedManager] username],@"from_uid",/*@"all",@"to_uid",@"ios",@"message",*/nil];
        
        //2014.06.16 chenlihua 上传服务器JSON数据
        //NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"from_rdatetime",[[UserInfo sharedManager] username],@"from_uid",/*@"all",@"to_uid",@"ios",@"message",*/nil];
        
        
        //2014.07.29 chenlihua 发送给socket的数据给加上标识,dev:iOS 或者 dev:android.
        
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"from_rdatetime",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
        
        
        NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
        NSString *jsonString=[jsonDic JSONString];
        NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
        
        
        //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
        NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
        NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
        NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
        NSLog(@"-----------newJson-------%@",newJson);
        
        
        NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
        [socketUpdate writeData:data withTimeout:-1 tag:1000];
    }
   
   

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
	[self.titleLabel setText:@"方创"];
    [self setTabBarIndex:0];
    
    unreadarr = [[NSMutableArray alloc]init];
    //2014.08.05 chenlihua socket改http,重新打开
//    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
//    //注册到 NSRunLoopCommonModes 模式下
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //2014.08.05 chenlihua socket改http，重新打开
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initFourMes:)  name:@"choose" object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:@"choose" object:nil];

    
    
    
    //2014.06.23 chenliha 连接服务器
    /*
    socketUpdate=[[AsyncSocket alloc]initWithDelegate:self];
    
    [socketUpdate connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
    */
    
    
    //右侧添加按钮
    //2014.06.23 chenlihua 添加群功能
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [rtBtn setImage:[UIImage imageNamed:@"44_anniu_1"] forState:UIControlStateNormal];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];

    
    //搜索框
    FCSearchBar* searchBar = [[FCSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) delegate:self];
    [self.contentView addSubview:searchBar];

    //方创背景Label
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.contentViewHeight - 40) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:myTableView];

    //2014.08.15 chenlihua 将系统自带的线去掉
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   //2014.04.09 chenlihua 接口更改
    //暂时无用
    /*
    [[NetManager sharedManager] indexWithuserid:[[UserInfo sharedManager] username]   //接口后来更改 为 传username
                                          dtype:@""
                                         hudDic:nil
                                        success:^(id responseDic) {

                                            NSDictionary *dic = [responseDic objectForKey:@"data"];
                                            
                                            dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];

                                            for (NSDictionary* dic in dataArray) {
                                                NSLog(@"_______%@",dic);
                                            }
                                            [myTableView reloadData];
                                        }
                                           fail:^(id errorString) {
                                               
                                           }];
    
  */
    //tom 20140809 本地计算
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"pgroups1"]!=nil) {
        
        NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:@"pgroups1"];
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
        [myTableView reloadData];

    }else
    {
    
        [self loadData];
    }
    
    
}

//2014.07.01 chenlihua 把轮询收到的消息保存到数据库
- (void)saveChatToSqlite:(NSArray*)array
{
    for (short i = 0; i < array.count; i ++) {
        
        NSDictionary * dic = [array objectAtIndex:i];
        
        //2014.05.27 chenlihua 解决WEB端自己发送的消息，自己会收到的问题。
        if ([[dic objectForKey:@"openby"] isEqualToString:[[UserInfo sharedManager] username]]) {
            continue ;
        }
        
        //2014.07.27 chenlihua 将换行符转换成“，”。
        NSString *firstString=[[dic objectForKey:@"msgtext"] stringByReplacingOccurrencesOfString:@"<br!>"withString:@""];
        NSLog(@"--firstString--%@",firstString);
        
        //2014.07.28 chenlihua 解决本地断网时，当别人发来消息，然后，退出聊天界面到方创界面，重新进入时，会有消息重复的现象。将，isRead设置为8;
        
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:[dic objectForKey:@"dgid"]
                            contentType:[dic objectForKey:@"msgtype"]
                               talkType:[dic objectForKey:@"talkId"]
                              vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
                                picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
                                content:firstString//[dic objectForKey:@"msgtext"]
                                   time:[dic objectForKey:@"opendatetime"]
                                 isRead:@"1"//@"0"
                                 second:[dic objectForKey:@"vsec"]
                                  MegId:[dic objectForKey:@"msgid"]
                               imageUrl:[dic objectForKey:@"url"]
                                 openBy:[dic objectForKey:@"openby"]];
        
        
    }
    
    /*
    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                             talkId:[dic objectForKey:@"dgid"]
                        contentType:[dic objectForKey:@"msgtype"]
                           talkType:[dic objectForKey:@"talkId"]
                          vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
                            picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
                            content:firstString//[dic objectForKey:@"msgtext"]
                               time:[dic objectForKey:@"opendatetime"]
                             isRead:@"0"
                             second:[dic objectForKey:@"vsec"]
                              MegId:[dic objectForKey:@"msgid"]
                           imageUrl:[dic objectForKey:@"url"]
                             openBy:[dic objectForKey:@"openby"]];
    
    
}*/

}


#pragma -mark -加上角添加群的功能
//右上角添加群按钮 2014.06.23 chenlihua
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
    
    XuanZeLianXiRenViewController *viewCon = [[XuanZeLianXiRenViewController alloc]init];
    
    [self.navigationController pushViewController:viewCon animated:NO];
    // 动画事件
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}


#pragma -mark -FCSearchBar delegate
//2014.04.29 chenlihua 实现t001,p001的搜索功能
- (void)FCSearchBarDidSearch:(FCSearchBar *)fcSearchBar text:(NSString *)text
{
    NSLog(@"text = %@",text);
    
    SearchResultViewController* viewController = [[SearchResultViewController alloc] init];
    [viewController setKey:text];
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma -mark -UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //2014.07.01 chenlihua 解决未读消息数不能及时更新的问题。
    /*
    static NSString* identifier = @"cellId";
    
    //方创cell
    FaFinancierWelcomeItemCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    */
    FaFinancierWelcomeItemCell *cell;
    
    dataDic = [dataArray objectAtIndex:indexPath.row];
    
     
    NSString *type = [dataDic objectForKey:@"dataflag"];
    if (cell == nil) {
        
        //2014.07.01 chenlihua 解决未读消息数不能及时更新的问题。
       // cell = [[FaFinancierWelcomeItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell=[[FaFinancierWelcomeItemCell alloc] init];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    
        if ([type isEqualToString:@"board"]) {
            
            [cell.titleLab setText:@"【项目进展】"];
            [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:17]];
          //  [cell.avatar getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]]];
            //2014.06.12 chenlihua 修改图片缓存方式
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] ];
            
             [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:17]];
            [cell.subTitleLab setFrame:CGRectMake(CGRectGetWidth(cell.avatar.frame)+22, CGRectGetMaxY(cell.titleLab.frame), 205, 20)];
            [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];
            
            //2014.07.23 chenlihua 修改项目进展前面的图标
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"项目进展.png"]];
            
            //2014.06.23 chenlihua 未读消息数暂时隐藏。
            [cell.unReadLabel setHidden:YES];
            
        }else if ([type isEqualToString:@"task"]){
          //  [cell.avatar getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]]];
            //2014.06.12 chenlihua 修改图片缓存方式
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] ];
            
            [cell.titleLab setText:@"【方创任务】"];
            [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:17]];
            [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];
            //            [cell.contentView addSubview:cell.unReadImageV];
            [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:12]];
            //2014.06.23 chenlihua 未读消息数暂时隐藏。
            [cell.unReadLabel setHidden:YES];
            
            //2014.07.23 chenlihua 修改方创任务前面的图标
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"方创任务.png"]];

            
        }else if ([type isEqualToString:@"schedule"])
        {
           // [cell.avatar getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]]];
            //2014.06.12 chenlihua 修改图片缓存方式
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] ];
            
            [cell.titleLab setText:@"【我的日程】"];
            [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:17]];
            [cell.subTitleLab setText:[dataDic objectForKey:@"name"]];
            [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:12]];
            
            //2014.06.23 chenlihua 未读消息数暂时隐藏。
            [cell.unReadLabel setHidden:YES];
            
            //2014.07.23 chenlihua 修改我的日程前面的图标
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"我的日程.png"]];

            
        }else if ([type isEqualToString:@"discussion"]){
           // [cell.avatar getImageFromURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]]];
            //2014.06.12 chenlihua 修改图片缓存方式
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] ];
            [cell.titleLab setText:[dataDic objectForKey:@"name"]];
            [cell.titleLab setFont:[UIFont fontWithName:KUIFont size:17]];
            [cell.subTitleLab setFont:[UIFont fontWithName:KUIFont size:12]];
           // [cell.subTitleLab setHidden:YES];
            
            
            
            //2014.04.30 chenlihua 内部消息提醒，内部联系人的头像右上角显示未读的消息数。
            //2014.06.23 将其注释掉
            /*
            NSLog(@"----------开始进入方创时的未读息---cell username %@--",[[UserInfo sharedManager] username]);
            NSLog(@"----------开始进入方创时的未读息---cell talkId %@--",[dataDic objectForKey:@"id"]);
            
            NSArray* arrayUnRead =  [SQLite getNewSingleChatArrayWithUserId:[[UserInfo sharedManager] username] talkId:[dataDic objectForKey:@"id"]];
            NSLog(@"-----Cell-----开始进入方创时的未读消息--arrayUnRead %@------------------",arrayUnRead);
            NSLog(@"-----Cell-----开始进入方创时的未读消息--arrayUnRead count %d------------------",arrayUnRead.count);
            cell.unReadLabel.text=[NSString stringWithFormat:@"%d",arrayUnRead.count];
            if ([cell.unReadLabel.text isEqualToString:@"0"]) {
               [cell.unReadLabel setHidden:YES];
            }
            */
            //2014.05.09 chenlihua 内部消息提醒，内部联系人的头像右上角显示未读的消息数。由本地数据库查询，改成服务器端返回。
            NSLog(@"---右上角----未读消息数-----%@",[dataDic objectForKey:@"msgcnt"]);
            //  cell.unReadLabel.text=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"msgcnt"]];
            //2014.05.24 chenlihua 当未读消息大于100时，显示99+。
            
            
//            if ([[dataDic objectForKey:@"msgcnt"] intValue]<100) {
//                cell.unReadLabel.text=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"msgcnt"]];
//            }
//            else
//            {
//                cell.unReadLabel.text=@"99+";
//            }
//            
//            if ([cell.unReadLabel.text isEqualToString:@"0"]) {
//                [cell.unReadLabel setHidden:YES];
//                //  cell.unReadLabel.text=@"0";
            //            } if ([unreadarr count]>0) {
          
            NSInteger a;
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:cell.titleLab.text] intValue]!=0) {
                a = [[[NSUserDefaults standardUserDefaults] objectForKey:cell.titleLab.text] intValue];
            }else
            {
                a = 0;
            }
            for (int i = 0; i<[unreadarr count]; i++) {
                if ([cell.titleLab.text isEqualToString:[[unreadarr objectAtIndex:i] objectForKey:@"dname"] ]) {
                    
                    a=a+1;
                    NSLog(@"%@",cell.unReadLabel.text);
                    [unreadarr removeObjectAtIndex:i];
                }
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",a] forKey:cell.titleLab.text];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //[self wirtefile:cell.titleLab.text file:[NSString stringWithFormat:@"%d",a]];
            }
            
            [cell.unReadLabel setFont:[UIFont fontWithName:KUIFont size:8]];
        
        int ssum=[[[NSUserDefaults standardUserDefaults] objectForKey:cell.titleLab.text] intValue];
        if (ssum>0 && ssum<99) {
            [cell.unReadLabel setHidden:NO];
            cell.unReadLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:cell.titleLab.text];

         }
         else if(ssum>99)
         {
           
            [cell.unReadLabel setHidden:NO];
            cell.unReadLabel.text=@" 99+";
            
            
        }else
        {
            
            [cell.unReadLabel setHidden:YES];
        }


            NSLog(@"-------dataDic---%@",dataDic);
            
            
            //2014.06.23 chenlihua 在方创首页讨论组中在群组名称下显示聊天记录，实现像微信一样的功能。
            NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
            NSDictionary *dic=[defauts objectForKey:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"id"]]];
            NSLog(@"------最后的聊天记录----dic----%@",dic);
            NSLog(@"------最后的聊天记录----dic content---%@",[dic objectForKey:@"content"]);
            NSLog(@"------最后的聊天记录----dic openby---%@",[dic objectForKey:@"openby"]);
            NSLog(@"-----最后的聊天记录-----dic userId---%@",[dic objectForKey:@"userId"]);
            NSLog(@"-----最后的聊天记录-----dic contentType--%@",[dic objectForKey:@"contentType"]);
            NSLog(@"------最后的聊天记录----dic talkType--%@",[dic objectForKey:@"talkType"]);
            // 2014.06.23 chenlihua  消息内容为文本的时候显示为最后一条信息，消息内容为语音时，显示语音两个字，当消息内容为图片时，显示图片两个字。当消息为其它时，显示为其它两个字。在前面加上昵称。是自己发送的显示自己，是别人发送的显示别人。
            if ([[dic objectForKey:@"talkType"] isEqualToString:@"0"]) {
                
                if ([dic objectForKey:@"content"]) {
                    
                    if ([[dic objectForKey:@"contentType"]intValue]==0) {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:%@",[[UserInfo sharedManager] username],[dic objectForKey:@"content"]];
                    }else if ([[dic objectForKey:@"contentType"] intValue]==1)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[语音]",[[UserInfo sharedManager] username]];
                    }
                    else if([[dic objectForKey:@"contentType"] intValue]==2)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[图片]",[[UserInfo sharedManager] username]];
                    }
                    else if([[dic objectForKey:@"contentType"] intValue]==3)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[其它]",[[UserInfo sharedManager] username]];
                    }
                    
                }else
                {
                    cell.subTitleLab.text=@"    ";
                }
                
            }else
            {
                if ([dic objectForKey:@"content"]) {
                    
                    if ([[dic objectForKey:@"contentType"]intValue]==0) {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"openby"],[dic objectForKey:@"content"]];
                    }else if ([[dic objectForKey:@"contentType"] intValue]==1)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[语音]",[dic objectForKey:@"openby"]];
                    }
                    else if([[dic objectForKey:@"contentType"] intValue]==2)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[图片]",[dic objectForKey:@"openby"]];
                    }
                    else if([[dic objectForKey:@"contentType"] intValue]==3)
                    {
                        cell.subTitleLab.text=[NSString stringWithFormat:@"%@:[其它]",[dic objectForKey:@"openby"]];
                    }
                    
                }else
                {
                    cell.subTitleLab.text=@"    ";
                }
                
            }
            //2014.05.19 chenlihua 方创首页增加左滑置顶和删除按钮
            [cell.stickButton addTarget:self action:@selector(doStickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.stickButton.tag=indexPath.row;
            
            [cell.deleteButton addTarget:self action:@selector(doDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteButton.tag=indexPath.row;
            
            //2014.05.19 chenlihua 要置顶的群组的id
            NSUserDefaults *stickDefauts=[NSUserDefaults standardUserDefaults];
            NSString *flagString=[NSString stringWithFormat:@"STICK_%d",indexPath.row];
            [stickDefauts setObject:[dataDic objectForKey:@"id"] forKey:flagString];
            [stickDefauts synchronize];
            NSLog(@"-------要置顶的组的id---%@---",[dataDic objectForKey:@"id"]);
            
            //2014.05.19 chenlihua 要删除的群组的群主
            NSUserDefaults *deleteDefauts=[NSUserDefaults standardUserDefaults];
            NSString *creatByString=[NSString stringWithFormat:@"DELETE_%d",indexPath.row];
            [deleteDefauts setObject:[dataDic objectForKey:@"dgcreateby"] forKey:creatByString];
            [deleteDefauts synchronize];
            NSLog(@"------要删除的群组的群主--%@--",[dataDic objectForKey:@"dgcreateby"]);
 
           
            //2014.07.23 chenlihua 修改群组前面的图标
            [cell.avatar setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"dpicurl"]] placeholderImage:[UIImage imageNamed:@"chatHeadImage.png"]];
            
        }
    }
    return cell;
}
//2014.05.07 chenlihua 方创首页增加左滑置顶和删除按钮
//置顶点击事件
-(void)doStickButtonAction:(UIButton *)btn
{
    NSLog(@"--------开始进行置顶操作--------");
    
    NSUserDefaults *stickDefauts=[NSUserDefaults standardUserDefaults];
    NSString *flagStr=[NSString stringWithFormat:@"STICK_%d",btn.tag];
    NSString *didString=[stickDefauts objectForKey:flagStr];
    NSLog(@"---didString---%@--",didString);
    
    [[NetManager sharedManager] getDiscussionGroupSortWithusername:[[UserInfo sharedManager] username]  did:didString order:@"0" hudDic:nil success:^(id responseDic) {
        {
            NSLog(@"------排序成功------");
            NSLog(@"-------responsedic--%@---",responseDic);
        }
    } fail:^(id errorString) {
        NSLog(@"------排序失败--------");
        NSLog(@"-------errorString---%@---",errorString);
    }];
    NSLog(@"----开始进行排序---");
    [self loadData];
     NSLog(@"----排序完成------");
}
//2014.05.10 chenlihua 删除点击事件
-(void)doDeleteButtonAction:(UIButton *)btn
{
    NSLog(@"--------开始进行删除操作--------");
    
    //获取群主名
    NSUserDefaults *deleteDefauts=[NSUserDefaults standardUserDefaults];
    NSString *groupBy=[NSString stringWithFormat:@"DELETE_%d",btn.tag];
    NSString *nameString=[deleteDefauts objectForKey:groupBy];
    NSLog(@"--要删除的讨论组的群主----nameString---%@--",nameString);
    
    //获取讨论组id
    NSUserDefaults *stickDefauts=[NSUserDefaults standardUserDefaults];
    NSString *flagStr=[NSString stringWithFormat:@"STICK_%d",btn.tag];
    NSString *didString=[stickDefauts objectForKey:flagStr];
    NSLog(@"-删除的时候--didString---%@--",didString);
    
    if ([nameString isEqualToString:[[UserInfo sharedManager] username]])
    {
        
        [[NetManager sharedManager] deletedisgWithusername:[[UserInfo sharedManager] username]
                                                       did:didString
                                                    hudDic:Nil
                                                   success:^(id responseDic) {
                                                       
                                                       NSLog(@"---删除讨论组成功---responseDic %@-----",responseDic);
                                                      [self loadData];
                                                   }
                                                      fail:^(id errorString) {
                                                          
                                                          [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                          
                                                          
                                                      }];
        
    }
    else
    {
        [[NetManager sharedManager] retreatdisgWithusername:[[UserInfo sharedManager] username] did:didString grpmember:[[UserInfo sharedManager] username] hudDic:nil success:^(id responseDic) {
            
            NSLog(@"-----群主不是本人的群组删除成功--responseDic-%@---",responseDic);
            
        } fail:^(id errorString) {
            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];;
        }];
        
    }
    [self loadData];
}
-(void)loadData
{
    /*
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"loadData" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    */
    
    [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username]  dtype:[[UserInfo sharedManager] username] perpage:@"20" pagenum:@"1" hudDic:nil success:^(id responseDic) {
        NSDictionary *dic = [responseDic objectForKey:@"data"];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"pgroups1"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
//        unReadAll=[dic objectForKey:@"totmsg"];
//        NSLog(@"------所有的未读消息条数----%@---",unReadAll);
//   
//        //2014.06.23 chenlihua 当消息数为大于100的数时，显示99+。否则显示正常未读数。
//        if ([unReadAll intValue]>0&&[unReadAll intValue]<100)
//        {
//            self.title=[NSString stringWithFormat:@"方创（%@）",unReadAll];
//        }
//        else if([unReadAll intValue]>99)
//        {
//            self.title=@"方创(99+)";
//            
//        }
//        else
//        {
//            self.title=@"方创";
//            
//        }

        
        
        
        
        dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
        
        for (NSDictionary* dic in dataArray) {
            NSLog(@"__TableView重新刷新数据---_____%@",dic);
        }
        
        [myTableView reloadData];
        
    } fail:^(id errorString) {
        ;
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataDic = [[NSDictionary alloc]initWithDictionary:[dataArray objectAtIndex:indexPath.row]];
    
 
    NSString *type = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"dataflag"]];
    
    UIViewController* viewController = Nil;
    if ([type isEqualToString:@"board"]) {//board=项目进展
        
        viewController = [[XiangMuJinZhanViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([type isEqualToString:@"task"]){//task
        
        viewController = [[FangChuangRenWuViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    else if ([type isEqualToString:@"schedule"])
    {//日程
        
        viewController=[[RiChengBiaoViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];

    }
   // else{
    //2014.08.07 chenlihua 修改jobnum为0的情况出现
    else if ([type isEqualToString:@"discussion"]) {
        
        //其他全是讨论组
        ChatWithFriendViewController *cfVC=[[ChatWithFriendViewController alloc]init];
        cfVC.talkId=[dataDic objectForKey:@"id"];//对方ID
        cfVC.titleName=[dataDic objectForKey:@"name"];
        //2014.04.29 chenlihua 使聊天的时候，聊天界面的标题为群组名（人数)
        cfVC.entrance = @"qun";
        cfVC.memberCount = [dataDic objectForKey:@"mcnt"];
        
        cfVC.where=@"guWen";
        //2014.06.23 chenlihua socket
//        cfVC.chatSocket=socketUpdate;
//        cfVC.chatSocket.delegate=cfVC;
        
        NSInteger cellcount = [[[NSUserDefaults standardUserDefaults] objectForKey:cfVC.titleName] intValue] ;
        
       [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:cfVC.titleName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //2014.08.05 chenlihua 将提前.
        //2014.06.23 chenlihua 解决点击从服务器返回的新消息提醒数的时候，新消息仍然存在的问题。
        NSString  *tokenString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
        NSLog(@"--去别的页面，把提醒消息数清零--tokenString---%@---",tokenString);
        NSLog(@"---去别的页面，把提醒消息数清零-----username---%@--",[[UserInfo sharedManager] username]);
        NSLog(@"--去别的页面，把提醒消息数清零--dgid---%@---",[dataDic objectForKey:@"id"]);
        NSLog(@"---去别的页面，把提醒消息数清零-----jobnum---%@--",[dataDic objectForKey:@"msgcnt"]);
        NSLog(@"---appken---%@",[[UserInfo sharedManager] apptoken]);
        
        //2014-8-7Tom 本地计算 调接暂不使用了
        [[NetManager sharedManager] setPushJobNumWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[dataDic objectForKey:@"id"] pushtoken:tokenString jobnum:[NSString stringWithFormat:@"%d",cellcount] hudDic:nil
                                                      success:^(id responseDic) {
                                                          NSLog(@"--------去别的页面，把提醒消息数清零-----成功--responseDic-%@--",responseDic);
                                                      } fail:^(id errorString) {
                                                          NSLog(@"--------去别的页面，把提醒消息数清零-----失败--responseDic-%@--",errorString);
                                                      }];
        

        
        [self.navigationController pushViewController:cfVC animated:YES];

    }
    
    
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
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


#pragma -mark -AsyncSocketDelegate


//2014.06.07 chenlihua socket
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    
    //2014.06.16 chenlihua 返回的socket数据。
    NSString *mes=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    //2014.07.16 chenlihua 改正sokcet粘包的问题
    NSArray *mesArray = [mes componentsSeparatedByString:@"\n"];
    NSMutableArray *mesArrayNew=[[NSMutableArray alloc]initWithArray:mesArray];
    [mesArrayNew removeLastObject];
    NSLog(@"----mesArrayNew---%@",mesArrayNew);
    
    
    for (NSString *newNes in mesArrayNew){
        
        NSDictionary *mesDic=[newNes objectFromJSONString];
        NSLog(@"MesDicNew---%@",mesDic);
        
        NSString *uidString=[mesDic objectForKey:@"uid"];
        
        NSLog(@"-----mes------%@",mes);
        NSLog(@"------mesDic-----%@",mesDic);
        NSLog(@"-------uidString----%@",uidString);
        
        
        
        if ([uidString isEqualToString:@"!"]) {
            
            
            NSDictionary *newDic=[mesDic objectForKey:@"data"];
            NSString *newStr=[newDic objectForKey:@"newmsg"];
            
            
            NSLog(@"----newDic---%@",newDic);
            NSLog(@"--------newStr---%@",newStr);
            
            
            if ([newStr intValue]>0) {
                
                /*
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"更新未读消息数，服务器返回111111" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                 [alert show];
                */
                
                [self loadData];
            }
            
            
        }else if([uidString isEqualToString:@"0"]){
            
            
            NSLog(@"------mesDic-----%@",mesDic);
            
            /*
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"----自己发出去的消息-服务器返回11111-----" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert show];
            */
        }else if([uidString isEqualToString:@"#"]){
            
            /*
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"---收到别人的消息------" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert show];
           */
            if ([self getcount:@"UNREAD2" key:@"msgid" keyvalue:[mesDic objectForKey:@"msgid"]]){
                NSLog(@"aaa");
                
            }else
            {
                NSString *sql1 = [NSString stringWithFormat:
                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@')",
                                  @"UNREAD", @"name", @"age",@"address",@"sendname",@"msgid",
                                  [mesDic objectForKey:@"dname"],
                                  [mesDic objectForKey:@"msgtext"],
                                  [mesDic objectForKey:@"dtype"],
                                  [mesDic objectForKey:@"openby"],
                                  [mesDic  objectForKey:@"msgid"]];
                NSString *sql2 = [NSString stringWithFormat:
                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@')",
                                  @"UNREAD2", @"name", @"age",@"address",@"sendname",@"msgid",
                                  [mesDic objectForKey:@"dname"],
                                  [mesDic objectForKey:@"msgtext"],
                                  [mesDic objectForKey:@"dtype"],
                                  [mesDic objectForKey:@"openby"],
                                  [mesDic  objectForKey:@"msgid"]];
                
                [self execSql:sql1];
                [self execSql:sql2];

            }
            //2014.07.27 chenlihua 将换行符转换成“，”。
            NSString *otherString=[[mesDic objectForKey:@"msgtext"] stringByReplacingOccurrencesOfString:@"<br!>"withString:@""];
            
            NSLog(@"--otherString--%@",otherString);
            
            [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                     talkId:[mesDic objectForKey:@"dgid"]
                                contentType:[mesDic objectForKey:@"msgtype"]
                                   talkType:[mesDic objectForKey:@"dtype"]
                                  vedioPath:[[mesDic objectForKey:@"msgtype"] intValue] == 1 ? [mesDic objectForKey:@"msgpath"] : @""
                                    picPath:[[mesDic objectForKey:@"msgtype"] intValue] == 2 ? [mesDic objectForKey:@"msgpath"] : @""
                                    content:otherString/*[mesDic objectForKey:@"msgtext"]*/
                                       time:[mesDic objectForKey:@"opendatetime"]
                                     isRead:@"0"
                                     second:[mesDic objectForKey:@"vsec"]
                                      MegId:[mesDic objectForKey:@"msgid"]
                                   imageUrl:@""
                                     openBy:[mesDic objectForKey:@"openby"]];
            [self loadData];
            
        }else{
            
            
          //  NSString *spaceString=[NSString stringWithFormat:@"---空。。投资---mesDic--%@-",mesDic];
            /*
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:spaceString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            */
        }
    }
    
    [socketUpdate readDataWithTimeout:-1 tag:300];
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"连接服务器成功");
    
    /*
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"连接服务器成功11111" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
    */
    
    [socketUpdate readDataWithTimeout:-1 tag:300];
    
    
}
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    NSLog(@"发送数据成功");
//    
//   /*
//     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"发送数据成功1111111" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//     [alert show];
//   */
//    
//}
- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
    return [NSRunLoop currentRunLoop];
}
//2014.06.26 chenlihua sokcet断开后无法连接的问题
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    //  NSLog(@"即将断开和服务器 %@的连接",[sock connectedHost]);
    
    /*
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"连接即将断开111111" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
    */
    
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
     socketUpdate = nil;
    // NSLog(@"已经断开和服务器 %@的连接",[sock connectedHost]);
    
    //  [socketUpdate connectToHost:@"42.121.132.104" onPort:8480 error:nil];
    
    /*
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"连接已经断开----投资人----" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
    */
}


@end
