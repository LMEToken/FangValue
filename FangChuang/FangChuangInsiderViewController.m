//
//  FangChuangInsiderViewController.m
//  FangChuang
//
//  Created by chenlihua on 14-4-24.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//                            _ooOoo_
//                           o8888888o
//                             88" . "88
//                              (| -_- |)
//                              O\  =  /O
//                        ____/`---'\____
//                      .'  \\|     |//  `.
//                     /  \\|||  :  |||//  \
//                    /  _||||| -:- |||||-  \
//                    |   | \\\  -  /// |   |
//                    | \_|  ''\---/''  |   |
//                    \  .-\__  `-`  ___/-. /
//                  ___`. .'  /--.--\  `. . __
//               ."" '<  `.___\_<|>_/___.'  >'"".
//              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//              \  \ `-.   \_ __\ /__ _/   .-` /  /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                      佛祖保佑       永无BUG
//方创内部,t的账户调用
//方创下的栏目：分为：方创人、项目方、投资方与对接群，这四个栏目
#import "FangChuangInsiderViewController.h"
#import "CacheImageView.h"
#import "XuanZeLianXiRenViewController.h"
#import "XiangMuWenDangViewController.h"
#import "FangChuangRenWuViewController.h"
#import "XiangMuJinZhanViewController.h"
#import "JinZhanXiangQingViewController.h"
#import "XiangMuJinZhanViewController.h"
#import "RiChengBiaoViewController.h"
#import "ChatWithFriendViewController.h"
#import "SearchResultViewController.h"
#import "FaFinancierWelcomeItemCell.h"
#import "ButtonColumnView.h"
#import <sqlite3.h>
#import "SQLite.h"
#import "AppDelegate.h"
#import "XGPush.h"


//2014.05.21 chenlihua 解决方创信息保存在本地。
#import "Reachability.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

//2014.06.16 chenlihua JSONKit
#import "JSONKit.h"


#import "AsyncSocket+Single.h"

#import "AsyncSocket.h"
#import "socketNet.h"

#import "Utils.h"
#import "UserInfo.h"
#import "NetManager.h"
#import "UIView+ProgressView.h"
#import "NetManager.h"


#import "SDBManager.h"
#import "SUserDB.h"
#import "SUser.h"
#import "CustomStatueBar.h"
#import "FvalueIndexVC.h"
@interface FangChuangInsiderViewController ()
{
    int currentIndex;
    //2014.05.04 chenlihua 在方创主界面，讨论组名字下面显示最近的聊天信息，保持与微信同步。
    NSMutableArray *ChatArray;
    
    
    //2014 - 08-7 Tom  实现接口减少的一些变量 {
    
    NSInteger sum;
    
    NSMutableArray *typearr[4];
    
    NSMutableArray *unreadarr;
    
    NSMutableArray *unreadarrcount;
    
    NSInteger count;
    
    NSString *titlehead;
    
    //2014 -08-7 tom}
    
    NSInteger count2;
    
    NSString *inputcellname;
    
    NSMutableDictionary *configList;
    
    NSInteger cellcount;
    //    计算未读数的数组
    NSMutableArray *tablearr;
    //     预览消息的数组
    NSMutableArray *tablearrmore;
    
    SUserDB * _userDB;
    
    NSMutableArray * _userData;
    
    NSInteger sokectsuccessful;
    
    NSInteger choosedis;
    
}
@end

@implementation FangChuangInsiderViewController
@synthesize unReadAll;

//2014.06.24 把socket放在外面 chenlihua

@synthesize fromWhere;
@synthesize socketUpdate;


@synthesize arrUnSendCollection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//断开scoket 链接 且屏蔽定时器链接socket
-(void)downsoket
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"notConnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([socketUpdate isConnected]) {

       [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"dontconnect"];
         [socketNet managerDisconnect];
        [connectsockettimer invalidate];
         [socketUpdate disconnect];
         [socketUpdate setDelegate:nil];
        [waittime invalidate];
       
        [timerSocket invalidate];
        [HttpTimer invalidate];
        [HttpTimer1 invalidate];
        [ConnectTimer invalidate];
        [reloadtime invalidate]; 
    }
  




}
- (void)getChatMessageGoToShake
{
    


   if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToShake"] isEqualToString:@"0"]) {
       NSLog(@"aa");
   }else
   {
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  }
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToVoice"] isEqualToString:@"0"]) {
        NSLog(@"aa");
    }else
    {
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

- (void)viewDidDisappear:(BOOL)animated
{

    

}

#pragma mark - 封装返回数据最后一条MESGID
- (NSString *)getmesgid
{
    NSString *meglocaid =@"0";
 
    if (    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]]!=nil) {
        meglocaid =[NSString stringWithFormat:@"%d",   [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]] intValue]-0];
    }
    NSLog(@"%@",meglocaid);
    return  meglocaid;
    
}
-(void)ConSocket
{
    if ([self isConnectionAvailable])
    {
        socketUpdate=[socketNet sharedSocketNet];
        socketUpdate.delegate=self;

        if (![socketUpdate isConnected]) {
            NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
            
            NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
            NSString *jsonString=[jsonDic JSONString];
            NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
            NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
            NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
            sokectsuccessful=0;
            [socketUpdate writeData:data withTimeout:-1 tag:1000];
      
            
            
        }else{
        }
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    
    if ([self.view window] == nil)// 是否是正在使用的视图
        
    {
        
        self.view = nil;
    }
    
}



#pragma -mark -第一次启动 开启轮训 当没有数据了 再开启soket
- (void)gethttpdata
{
    self.titleLabel.text = @"收取中...";
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cometoapp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([messageFlag isEqualToString:@"1"]) {
        ;
    }else{
            [[NetManager sharedManager] getdiscussionWithusername:[[UserInfo sharedManager] username]
                                                              did:@"0"
                                                        rdatetime:@""
                                                            dflag:@"0"
                                                          perpage:@"300"
                                                           hudDic:nil
                                                            msgid:[self getmesgid]
                                                          success:^(id responseDic) {
                                                              NSLog(@"responseDic = %@",responseDic);
//                                                               [[NSUserDefaults standardUserDefaults] setObject:[mesDic objectForKey:@"msgid"] forKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
                                                              NSArray* array  = [[NSArray alloc]init];
                                                              NSLog(@"%@",array);
                                                              
                                                              array = [[responseDic objectForKey:@"data"] objectForKey:@"messagelist"];
                                                              if (array.count == 0) {
  
                                                              }
                                                              if (array.count>0) {
                                                                  //存储收到的信息
                                                                  [self saveChatToSqlite:array];
                                                                  for (int i =0; i<array.count; i++) {
                                                                      NSArray *mesDicarr = [NSArray arrayWithObjects:[[[[responseDic objectForKey:@"data"] objectForKey:@"messagelist"] objectAtIndex:i] objectForKey:@"dgid"],[[[[responseDic objectForKey:@"data"] objectForKey:@"messagelist"]objectAtIndex:i ]objectForKey:@"dtype"], nil];
                                                                      
                                                                      if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"]) {
                                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
                                                                          [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"intalking"];
                                                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                                                          
                                                                      }
                                                                      
                                                                  }
                                                                  for (int i = 0; i<array.count; i++) {
                                                                      NSInteger dgid=[[[array objectAtIndex:i] objectForKey:@"dgid"] intValue] ;
                                                                      NSInteger dgig2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
                                                                      if (dgid==dgig2)
                                                                      {
                                                                          NSLog(@"aa");
                                                                          
                                                                      }else
                                                                      {
                                                                          NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                                                                          NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                                                                          [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                                                                          NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                                                                          SUser * user = [SUser new];
                                                                          user.uid = [[array objectAtIndex:i] objectForKey:@"dgid"];
                                                                          user.titleName =   [[array objectAtIndex:i] objectForKey:@"dgid"];
                                                                          user.conText =  [[array objectAtIndex:i]  objectForKey:@"msgtext"];
                                                                          user.contentType =     [[array objectAtIndex:i]  objectForKey:@"dtype"];
                                                                          user.username =  [[array objectAtIndex:i]  objectForKey:@"openby"];
                                                                          user.msgid =[[array objectAtIndex:i]   objectForKey:@"msgid"];
                                                                          user.description = datetime;
                                                                          user.readed=@"0";
                                                                          [_userDB saveUser:user];
                                                                      }


                                                                  }
                                                                  
                                                              }
                               
                                                              
                                                       
                                           
                                                          }
                                                             fail:^(id errorString) {
                                                                 
                                                         
                                                                 
                                                             }];
   
        
        
    }
    
   
}
- (void)gethtoyesorno
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"gethttpyesorno"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)gethttpdataWithMsgid:(NSString *)msgid page:(NSString *)page
{
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(gethtoyesorno) userInfo:nil repeats:NO];

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"gethttpyesorno"]isEqualToString:@"1"]) {
        
       [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"gethttpyesorno"];
        [[NetManager sharedManager] getdiscussionWithusername:[[UserInfo sharedManager] username] did:@"0" rdatetime:@""dflag:@"0"perpage:page hudDic:nil msgid:msgid success:^(id responseDic) {
            NSLog(@"responseDic = %@",responseDic);
             NSArray* array  = [[NSArray alloc]init];
              array = [[responseDic objectForKey:@"data"] objectForKey:@"messagelist"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (array.count == 0) {  } if (array.count>0) {
                   [self saveChatToSqlite:array];
//                                                              for (int i =0; i<array.count; i++) {
//                                                                  NSArray *mesDicarr = [NSArray arrayWithObjects:[[[[responseDic objectForKey:@"data"] objectForKey:@"messagelist"] objectAtIndex:i] objectForKey:@"dgid"],[[[[responseDic objectForKey:@"data"] objectForKey:@"messagelist"]objectAtIndex:i ]objectForKey:@"dtype"], nil];
//                                                                  
//                                                                  if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"]) {
//                                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
//                                                                      [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"intalking"];
//                                                                      [[NSUserDefaults standardUserDefaults] synchronize];
//                                                                      
//                                                                  }
//                                                                  
//                                                              }
//                                                              for (int i = 0; i<array.count; i++) {
//                                                                  
//                                                                  if ([[[array objectAtIndex:i] objectForKey:@"dgid"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"]])
//                                                                  {
//                                                                      NSLog(@"aa");
//                                                                      
//                                                                  }else
//                                                                  {
////                                                                      NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
////                                                                      NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
////                                                                      [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
////                                                                      NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
//
//                                                                  }

                                                                  
//                                                              }

                                                          }
                                                          
                                                          
                                                  
                                                          
                                                      }
                                                         fail:^(id errorString) {
                                                             
                                                             
                                                             
                                                         }];
        
  
    }
    self.titleLabel.text = @"收取中...";
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cometoapp"];
    
    
    
    
    
    
}
#pragma -mark -连接Soket
- (void)ConnectSoket2
{
    

    [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata2" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lodata4" object:nil];
    [HttpTimer invalidate];
    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
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
-(void)socketConnectHost{
    
    socketUpdate    = [[AsyncSocket alloc] initWithDelegate:self];
    
    NSError *error = nil;
    
    [socketUpdate connectToHost:SOCKETADDRESS onPort:SOCKETPORT withTimeout:3 error:&error];
    
}
//心跳连接
-(void)longconnectsoket
{
    
    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",nil];
    NSString *jsonString=[jsonDic JSONString];
    //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
    NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
    NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
    NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
    [socketUpdate writeData:data withTimeout:-1 tag:1000];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
//    [waittime invalidate];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SendTexttoSever" object:nil];


    
}
- (void)loadData2
{
    
    
    [[NetManager sharedManager]getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        NSMutableArray *dataArray = [[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"]objectForKey:@"fclist"]];
        for (int i =0; i<dataArray.count; i++) {
            NSUserDefaults *headImageUrl1=[NSUserDefaults standardUserDefaults];
            [headImageUrl1 setObject:[[dataArray objectAtIndex:i] objectForKey:@"picurl2"] forKey:[NSString stringWithFormat:@"%@pic%@",[[dataArray objectAtIndex:i] objectForKey:@"username"],[[UserInfo sharedManager]username]]];
            [headImageUrl1 synchronize];
        }
        
        
        
        
    } fail:^(id errorString) {
        
        
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
  
    [super viewWillAppear:NO];

    
    

    //        socketUpdate=[socketNet sharedSocketNet];
    //        socketUpdate.delegate=self;
    //        //2014.08.05 chenlihua 把socket去掉
    //        timerSocket=[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ConSocket) userInfo:nil repeats:YES];
    
    
    //2014.05.21 chenlihua 定时器实现主页面的实时刷新。以在主页面获取最新消息数。
    
    //2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
    
    
    //2014.06.19 chenlihua socket
    // AsyncSocket *socketUpdate;
    
    //2014.07.08 chenlihua 判断有没有网络
    // NSTimer *timeNet;
    
    
    
    // int tilletext;
    
    
    //2014.07.07 chenlihua 重新改写socket
    //2014.08.05 chenlihua 将socket去掉
    NSLog(@"----messageFlag---%@",messageFlag);
    
    
    
    //2014.06.13 chenlihua 开始使用定时器
    //2014.06.13 chenlihua 将定时器部分移动到viewDidLoad中。
    //    [timer setFireDate:[NSDate distantPast]];
    //    [timerSecond setFireDate:[NSDate distantPast]];
    
    
    //2014.05.09 chenlihua 接口改动，暂时无用
    //第一次调用内部接口
    /*
     [[NetManager sharedManager] indexWithuserid:[[UserInfo sharedManager] username]   //接口后来更改 为 传username
     dtype:[NSString stringWithFormat:@"%d",currentIndex]
     hudDic:nil
     success:^(id responseDic) {
     //NSLog(@"response=%@",responseDic);
     NSDictionary *dic = [responseDic objectForKey:@"data"];
     
     dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
     [myTableView reloadData];
     }
     fail:^(id errorString) {
     
     }];
     */
    
    
//    currentPage=1;
//    
//    [self loadData];
    //2014.05.22 chenlihua 方创讨论组信息断网时可见。把调用接口部分暂时隐藏，用loadData代替。
    //[self loadData];
    //2014.06.22 chenlihua socket编程中，当在一个页面中，查看了新消息，但是还有别的新消息的时候，页面回来，“方创人”右上角的部分，未读消息数还存在。
    //[self initFourMes:<#(NSNotification *)#>];
    
    /*
     //2014.05.11 chenlihua 上拉刷新
     NSLog(@"--------上拉刷新时--loadData---currentPage--%d--",currentPage);
     NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*20];
     NSLog(@"-------刷新的总行数-----%@",perpageString);
     
     
     NSLog(@"--------开始进入方创，第一次调用接口--username--%@",[[UserInfo sharedManager] username]);
     NSLog(@"--------开始进入方创，第一次调用接口--dtype--%@",[NSString stringWithFormat:@"%d",currentIndex ]);
     NSLog(@"--------开始进入方创，第一次调用接口--AppToken--%@",[[UserInfo sharedManager] apptoken]);
     
     //第一次调用内部接口
     [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",currentIndex] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
     
     NSLog(@"----第一次调用接口成功--------%@",responseDic);
     NSDictionary *dic = [responseDic objectForKey:@"data"];
     
     
     unReadAll=[dic objectForKey:@"totmsg"];
     NSLog(@"------所有的未读消息条数----%@---",unReadAll);
     
     
     //2014.05.14 chenlihua 当消息数为0时，总的未读消息提醒数不显示。
     if ([unReadAll intValue]>0) {
     self.title=[NSString stringWithFormat:@"方创（%@）",unReadAll];
     }else
     {
     self.title=@"方创";
     }
     
     
     dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
     
     [myTableView reloadData];
     
     
     } fail:^(id errorString) {
     NSLog(@"--------第一次调用接口失败-------%@",errorString);
     ;
     
     }];
     */
    
}
- (void)addundata
{
    
//    sqlite3 *db ;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [paths objectAtIndex:0];
//    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
//    //
//    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
//        sqlite3_close(db);
//        NSLog(@"数据库打开失败");
//    }
//    
//    sqlite3_stmt *statement = nil;
//    NSString *sql =@"SELECT * FROM UNREAD";
//    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
//        NSLog(@"Error: failed to prepare statement with message:get testValue.");
//        
//    }
//    else {
//        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值，跟上面sqlite3_bind_text绑定的列值不一样！一定要分开，不然会crash，只有这一处的列号不同，注意！
//        
//        while (sqlite3_step(statement) == SQLITE_ROW) {
//            char *name = (char*)sqlite3_column_text(statement, 1);
//            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
//            
//            char *msgtext = (char*)sqlite3_column_text(statement, 2);
//            NSString *msgStr = [[NSString alloc]initWithUTF8String:msgtext];
//            
//            char *address = (char*)sqlite3_column_text(statement, 3);
//            NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];
//            
//            char *megname = (char*)sqlite3_column_text(statement, 4);
//            NSString *mesname  = [[NSString alloc]initWithUTF8String:megname];
//            
//            char *cmsgid = (char*)sqlite3_column_text(statement, 5);
//            NSString *msgidarr  = [[NSString alloc]initWithUTF8String:cmsgid];
//            NSArray *arr= [NSArray arrayWithObjects:nsNameStr, nsAddressStr,msgStr,mesname,msgidarr,nil];
//            
//            
//            
//            for (int i= 0; i<[tablearr count]; i++) {
//                if ([[[tablearr objectAtIndex:i] objectAtIndex:4] isEqualToString:[arr objectAtIndex:4]]) {
//                    [tablearr removeObject:arr];
//                }
//            }
//            [tablearr addObject:arr];
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(db);
//        
    
//        [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
//        self.titleLabel.text = [NSString stringWithFormat:@"方创(%lu)",(unsigned long)[tablearr count]];
//        if ([tablearr count]== 0) {
//            self.titleLabel.text=@"方创";
//        }
//        if ([tablearr count]>99) {
//            self.titleLabel.text=@"方创(99+)";
//        }
//        for (int i=0; i<[tablearr count]; i++) {
//            if ([[[tablearr objectAtIndex:i]objectAtIndex:1] intValue]==1) {
//                [unLabel0 setHidden:NO];
//            }
//            if ([[[tablearr objectAtIndex:i]objectAtIndex:1] intValue]==2) {
//                [unLabel1 setHidden:NO];
//            }
//            if ([[[tablearr objectAtIndex:i]objectAtIndex:1] intValue]==3) {
//                [unLabel2 setHidden:NO];
//            }
//            if ([[[tablearr objectAtIndex:i]objectAtIndex:1] intValue]==4) {
//                [unLabel3 setHidden:NO];
//            }
//        }
        
        
        //        select * from users LIMIT 5 order by uid desc ;
        //        char *sql2= "SELECT * FROM UNREAD2 ";
        //        NSString *sql2 =@"SELECT * FROM UNREAD2";
        //        //[NSString stringWithFormat:@"SELECT * FROM UNREAD2 where  name ='%@' order by msgid desc limit 1 ",cell.titleLab.text];
        //        //从testTable这个表中获取 testID, testValue ,testName，若获取全部的话可
        //        if (sqlite3_prepare_v2(db, [sql2 UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        //            NSLog(@"Error: failed to prepare statement with message:get testValue.");
        //
        //        }
        //        else {
        //
        //            while (sqlite3_step(statement) == SQLITE_ROW) {
        //                char *name = (char*)sqlite3_column_text(statement, 1);
        //                NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
        //
        //                char *msgtext = (char*)sqlite3_column_text(statement, 2);
        //                NSString *msgStr = [[NSString alloc]initWithUTF8String:msgtext];
        //
        //                char *address = (char*)sqlite3_column_text(statement, 3);
        //                NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];
        //
        //                char *megname = (char*)sqlite3_column_text(statement, 4);
        //                NSString *mesname  = [[NSString alloc]initWithUTF8String:megname];
        //                char *cmsgid = (char*)sqlite3_column_text(statement, 5);
        //                NSString *msgidarr  = [[NSString alloc]initWithUTF8String:cmsgid];
        //                NSArray *arr= [NSArray arrayWithObjects:nsNameStr, nsAddressStr,msgStr,mesname,msgidarr,nil];
        //                [tablearrmore addObject:arr];
        //
        //            }
        //        }
        //        _userDB = [[SUserDB alloc] init];
        //        _userData = [NSMutableArray arrayWithArray:[_userDB findWithUid:nil limit:1]];
        //        [tablearrmore addObject:_userData];
        //        NSLog(@"%@",tablearrmore);
        
        
        
        
        
//    }
}
-(void)getreload
{

//    [myTableView reloadData];
//    [self loadData];
  
}
- (void)myTask {
    
    sleep(3);
}
//为了 防止 数据操作太过频繁 以及 卡顿 将接收消息和发送消息 还有创群的方法 用定时器 执行。并且设定脸优先级
- (void)waitmsg
{
    if (sendarr.count>0) {
        [self sendsoket:[sendarr objectAtIndex:0]];
        [sendarr removeObjectAtIndex:0];

    }else if(creatarr.count>0)
    {
        [self creatqun:[creatarr objectAtIndex:0]];

    }
    else if(waitarr.count>0) {
        [self n:[waitarr objectAtIndex:0]];
        [waitarr removeObjectAtIndex:0];
    }
}

//发送消息
-(void)sendsoket:(NSDictionary *)jsonDic
{
    NSString *jsonString=[jsonDic JSONString];
    NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
    NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
    NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
    if ([[jsonDic objectForKey:@"msgtype"]isEqualToString:@"0"]) {
        [self savesqlite:jsonDic];
    }
    [socketUpdate writeData:data withTimeout:-1 tag:300];
}

- (void)viewDidLoad
{
    self.titleLabel.text = @"方创";
    [super viewDidLoad];
    [self gethtoyesorno];
    [self setTabBarHidden:YES];
    state =0;
    [self getview];
    waitarr = [[NSMutableArray alloc]init];
    sendarr = [[NSMutableArray alloc]init];
    msgarr =  [[NSMutableArray alloc]init];
    creatarr = [[NSMutableArray alloc]init];
    waittime = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(waitmsg) userInfo:nil repeats:YES];

    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"nosave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sendyes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontconnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"getmsg2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"notConnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SendTexttoSever2:) name:@"SendTexttoSever"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downanimo) name:@"downanimo"object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSever) name:@"connectSeverdown"object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downsoket) name:@"downsoket"object:nil];
    
    NSString *lianxiren= [[NSUserDefaults standardUserDefaults]objectForKey:@"lianxiren"];
    if ([lianxiren isEqualToString:@"0"]) {
        FvalueIndexVC* viewController = [[ FvalueIndexVC alloc] init];
        [self.navigationController pushViewController:viewController animated:NO];
    }else if([lianxiren isEqualToString:@"1"])
    {
         [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"lianxiren"];
        NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"lianxirenqun"];
        NSLog(@"%@",dic);
        ChatWithFriendViewController *viewCon=[[ChatWithFriendViewController alloc]init];
        viewCon.entrance = @"qun";
        viewCon.talkId=[dic objectForKey:@"id"];
        viewCon.titleName=[dic objectForKey:@"name"];
        viewCon.memberCount = [dic objectForKey:@"mcnt"];
        viewCon.where=@"insider";
        [[NSUserDefaults standardUserDefaults] setObject:viewCon.titleName forKey:@"nosave"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //2014 0807 Tom 本地计算
        if ([[NSUserDefaults standardUserDefaults] objectForKey:viewCon.titleName]) {
            NSString *cellcount =  [[NSUserDefaults standardUserDefaults] objectForKey:viewCon.titleName];
            sqlite3 *db ;
            sqlite3_stmt * statement;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documents = [paths objectAtIndex:0];
            NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
            if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
                sqlite3_close(db);
                NSLog(@"数据库打开失败");
            }
            NSString *deletesql = [NSString stringWithFormat:@"delete from UNREAD where name = '%@'",viewCon.titleName];
            [self execSql:deletesql];
            sqlite3_close(db);

            NSLog(@"群的标题。。。。viewCon.title %@",[NSString stringWithFormat:@"%@(%@)",viewCon.titleName,viewCon.memberCount]);
            
            
            
            NSLog(@"------dataDic--%@",dataDic);
            //2014.05.09 chenlihua 解决点击从服务器返回的新消息提醒数的时候，新消息仍然存在的问题。
            NSString  *tokenString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
            NSLog(@"--去别的页面，把提醒消息数清零--tokenString---%@---",tokenString);
            NSLog(@"---去别的页面，把提醒消息数清零-----username---%@--",[[UserInfo sharedManager] username]);
            NSLog(@"--去别的页面，把提醒消息数清零--dgid---%@---",[dataDic objectForKey:@"id"]);
            NSLog(@"---去别的页面，把提醒消息数清零-----jobnum---%@--",[dataDic objectForKey:@"msgcnt"]);
            if (tokenString == nil) {
                tokenString = @"";
            }
            //20140808 Tom 修改 传到服务器的
            NSLog(@"%@",tokenString);
            [[NetManager sharedManager] setPushJobNumWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[dataDic objectForKey:@"id"] pushtoken:tokenString jobnum:cellcount hudDic:nil
                                                          success:^(id responseDic) {
                                                              [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:viewCon.titleName];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              NSLog(@"--------去别的页面，把提醒消息数清零-----成功--responseDic-%@--",responseDic);
                                                              
                                                          } fail:^(id errorString) {
                                                              NSLog(@"--------去别的页面，把提醒消息数清零-----失败--responseDic-%@--",errorString);
                                                          }];

        }
        [self.navigationController pushViewController:viewCon animated:NO];
    }
    
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"lianxiren"];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"成功创建聊天",@"success", nil];
        [[NetManager sharedManager]getdid_by121Withusername:[[UserInfo sharedManager] username] sendto:lianxiren hudDic:dic success:^(id responseDic) {
            
            
            ChatWithFriendViewController *cfVc=[[ChatWithFriendViewController alloc]init];
            NSLog(@"--------从联系人点击后的个人简介页面发送消息--跳转到聊天界面----responseDic--%@",responseDic);
            cfVc.talkId=[[responseDic objectForKey:@"data"] objectForKey:@"did"];
            NSLog(@"--------did----%@",cfVc.talkId);
            cfVc.titleName=lianxiren;
            cfVc.entrance = @"contact";
            cfVc.memberCount=
            [NSString stringWithFormat:@"%@",[[responseDic objectForKey:@"data"] objectForKey:@"dname"]];
            
            cfVc.flagContact=@"2";
            NSArray *arr = [NSArray arrayWithObjects:[[responseDic objectForKey:@"data"] objectForKey:@"did"],@"1", nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"relodataarr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController pushViewController:cfVc animated:NO];
            
        }
                                                       fail:^(id errorString) {
                                                           
                                                           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"该投资人尚未开通账号，不能发送消息！您可以要求其开通！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                                           [alert show];
                                                           
                                                       } ];
    }
  
    
}
-(void)connectSeverdown
{
    socketUpdate=[socketNet sharedSocketNet];
    socketUpdate.delegate=self;
   
}
-(void)downanimo
{
      [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
}
-(void)getview
{

    
    
    @try {
        SUserDB * db = [[SUserDB alloc] init];
        [db createDataBase:@"SUser"];
        _userDB = [[SUserDB alloc] init];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    sum = 0;
    tablearr = [[NSMutableArray alloc]init];
    tablearrmore = [[NSMutableArray alloc]init];
    unreadarr = [[NSMutableArray alloc]init];
    unreadarrcount = [[NSMutableArray alloc]init];
    count = 0;
    currentIndex = 1;
     self.title = @"方创";
 
    [self connectSever];
//    timerSocket= 

    [self setTabBarIndex:0];
    //右侧添加按钮
    //2014.04.25 chenlihua 添加群功能暂时去掉，因为是无意义的操作
    UIButton* rtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rtBtn setFrame:CGRectMake(320 - 44 - 10, 0, 44, 44)];
    [rtBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];

    [rtBtn setImage:[UIImage imageNamed:@"fangchuangrightAdd"] forState:UIControlStateNormal];
    [rtBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:rtBtn isAutoFrame:NO];
    





}

-(void)httplodata
{
   [ [NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"httplodata"];

}
-(void)downsoket2
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontconnect"];
    [connectsockettimer invalidate];
    [socketUpdate disconnect];
     socketUpdate.delegate=nil;
    [socketNet managerDisconnect];
}
-(void)ConnectSocket
{
    socketUpdate=[socketNet sharedSocketNet];
    socketUpdate.delegate=self;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstconnet"] isEqualToString:@"1"])
    {
        [self gethttpdataWithMsgid:[NSString stringWithFormat:@"%d",[[self getmesgid]intValue]]page:@"999"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"firstconnet"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        connectsockettimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(ConnectSoket2) userInfo:nil repeats:NO];
//        [self ConnectSoket2];


    }
}
- (void) connectSever
{
    
    if ([self isConnectionAvailable])
    {


        if (![socketUpdate isConnected]) {


//            if ([[self getmesgid]intValue]>1) {
//                [self gethttpdataWithMsgid:[NSString stringWithFormat:@"%d",[[self getmesgid]intValue]-1]page:@"999"];
//            }else
//            {


//            }
            [self ConnectSocket];



        }


    
        
    }else
    {
       [self downsoket2];
    }
//     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(httplodata) userInfo:nil repeats:NO];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"httplodata"] isEqualToString:@"1"]
//       ) {
//    
//       [ [NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"httplodata"];
//    }
// 
    
}
- (void)creatqun:(NSArray *)arr2
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:arr2];
         [creatarr removeObjectAtIndex:0];
    }
}
-(void)relodata:(NSArray *) notification
{

    [creatarr addObject:notification];

}
//2014.06.25 chenlihua 把轮询收到的消息保存到数据库
- (void)saveChatToSqlite:(NSArray*)array
{
    for (short i = 0; i < array.count; i ++) {
        
        NSDictionary * dic = [array objectAtIndex:i];

       NSArray *mesDicarr = [NSArray arrayWithObjects:[[array objectAtIndex:i] objectForKey:@"dgid"],[[array objectAtIndex:i] objectForKey:@"dtype"], nil];
        [self relodata:mesDicarr];
//       [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
//        NSLog(@"%@",mesDicarr);
//       [[NSUserDefaults standardUserDefaults] setObject:mesDicarr forKey:@"relodataarr"];

        //2014.05.27 chenlihua 解决WEB端自己发送的消息，自己会收到的问题。
        //        if ([[dic objectForKey:@"openby"] isEqualToString:[[UserInfo sharedManager] username]]) {
        //            continue ;
        //        }
        
        
        //2014.07.27 chenlihua 将换行符转换成“，”。
        NSString *firstString=[[dic objectForKey:@"msgtext"] stringByReplacingOccurrencesOfString:@"<br!>"withString:@""];
        NSLog(@"--firstString--%@",firstString);
        
        [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"msgid"] forKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
        //2014.07.28 chenlihua 将isRead由0改成1.解决在聊天界面，当自己断网时，别人正常给自己发消息，当自己来网时，上聊天界面退出到方创主界面，然后，又进到聊天界面的时候，消息会有重复的现象。
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:[dic objectForKey:@"dgid"]
                            contentType:[dic objectForKey:@"msgtype"]
                               talkType:[dic objectForKey:@"talkId"]
                              vedioPath:[[dic objectForKey:@"msgtype"] intValue] == 1 ? [dic objectForKey:@"msgpath"] : @""
                                picPath:[[dic objectForKey:@"msgtype"] intValue] == 2 ? [dic objectForKey:@"msgpath"] : @""
                                content:firstString                               time:[dic objectForKey:@"opendatetime"]
                                 isRead:@"1"//@"0"
                                 second:[dic objectForKey:@"vsec"]
                                  MegId:[dic objectForKey:@"msgid"]
                               imageUrl:[dic objectForKey:@"url"]==nil ? @"":[dic objectForKey:@"url"]
                                 openBy:[dic objectForKey:@"openby"]];
        if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"themsgagehave"] isEqualToString:@"1"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"themsgagehave"];

        }else
        {
            NSLog(@"%@",dic);
        SUser * user = [SUser new];
        user.uid = [dic objectForKey:@"dgid"];
        user.titleName =   [dic objectForKey:@"dgid"];
        user.conText =  firstString;
        user.contentType = [dic objectForKey:@"msgtype"];
        user.username = [dic objectForKey:@"openby"];
        user.msgid = [dic objectForKey:@"dtype"];
        user.description = [dic objectForKey:@"opendatetime"];
        user.readed=@"0";
        [_userDB saveUser:user];

        }
        
    }
}

//2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
// 20140808 Tom 本地计算

-(void)getCount:(NSNotification *)note
{

    [self hiddenred];

}
- (void)hiddenred
{

    [unLabel0 setHidden:NO];
    [unLabel1 setHidden:NO];
    [unLabel2 setHidden:NO];
    [unLabel3 setHidden:NO];
}
-(void)initFourMes:(NSNotification *)note
{




}




//2014.05.20 chenlihua 判断网络是否连接,解决方创部分保存断网可见的问题。
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

//2014.05.22 chenlihua 解决方创部分信息断网时可见。重写loadData函数。
-(void)loadData
{
    

    
    NSLog(@"--------上拉刷新时--loadData---currentPage--%d--",currentPage);
    NSString *perpageString=[NSString stringWithFormat:@"%d",currentPage*20];
  
    if ([self isConnectionAvailable]) {
     
     
        [[NetManager sharedManager] indexWithusername:[[UserInfo sharedManager] username] dtype:[NSString stringWithFormat:@"%d",currentIndex] perpage:perpageString pagenum:@"1" hudDic:nil success:^(id responseDic) {
            NSDictionary *dic = [responseDic objectForKey:@"data"];
            NSLog(@"%@",dic);
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"%@groups%d",[[UserInfo sharedManager] username],currentIndex]];
            [[NSUserDefaults standardUserDefaults] synchronize];
                dataArray = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"indexlist"]];
                NSData *archiveConData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
                NSUserDefaults *OtherDefaults=[NSUserDefaults standardUserDefaults];
                NSString *fangInfoString=[NSString stringWithFormat:@"FANG_INFO_%d",currentIndex];
                [OtherDefaults setObject:archiveConData forKey:fangInfoString];
                [OtherDefaults synchronize];
          
            
        } fail:^(id errorString) {
        }];
                    
        
    }else
    {
  
        /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络未连接，请您一会儿重新发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];
         */
        
        NSUserDefaults *FangDefault=[NSUserDefaults standardUserDefaults];
        NSString *fangInfoString=[NSString stringWithFormat:@"FANG_INFO_%d",currentIndex];
        NSData *FangDic=[FangDefault objectForKey:fangInfoString];
        NSLog(@"-----联系人中保存数据成功后，00000000，OTHER，Fang--%@",[NSKeyedUnarchiver unarchiveObjectWithData:FangDic]);
        
        
        dataArray = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:FangDic]];
        NSLog(@"----dataArray----%@-----",dataArray);
        NSLog(@"-----dataArray.count---%d",dataArray.count);
        //2014.05.24 chenlihua 修改第一次登陆后，断网。本地还没有存数据的情况下，点击方创部分会崩溃掉的情况。
        
        if (dataArray.count==0) {
            
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"网络出现错误，请您一会刷新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
            NSLog(@"-----dataarray.count==0------");
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:@"discussion" forKey:@"dataflag"];
            [dic setObject:@"" forKey:@"dgcreateby"];
            [dic setObject:@"0" forKey:@"id"];
            [dic setObject:@"0" forKey:@"mcnt"];
            [dic setObject:@"0" forKey:@"msgcnt"];
            [dic setObject:@"" forKey:@"name"];
            [dic setObject:@"0" forKey:@"order"];
            NSLog(@"---------dic---%@-",dic);
            
            //2014.07.07 chenlihua 去掉最后的一个空白数组
            [dataArray addObject:dic];
            
            NSLog(@"--dataaray==0----dataArray-----%@",dataArray);
        }else
        {

            NSLog(@"----------myTablevIEW---reloaddATA-----");
           
        }
        
        
        // [myTableView reloadData];
        
    }
}


#pragma  -mark -doClickAction
//右上角添加群按钮
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
            [self loadData];
        }
    } fail:^(id errorString) {
        NSLog(@"------排序失败--------");
        NSLog(@"-------errorString---%@---",errorString);
    }];
    
    
}
//2014.05.10 chenlihua 删除点击事件
-(void)doDeleteButtonAction:(UIButton *)btn
{
    NSLog(@"%@",[dataArray objectAtIndex:btn.tag]);
     [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"creatteam"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[dataArray objectAtIndex:btn.tag] count]>0&&[dataArray count]>2) {
   
        if (!self.arrUnSendCollection)
        {
            arrUnSendCollection=[[NSMutableArray alloc] init];
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:@"nosee"]) {
                ;
            }else{
                arrUnSendCollection=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:@"nosee"]];
            }
        }
        NSLog(@"%@",[dataArray objectAtIndex:btn.tag]);
        [arrUnSendCollection addObject:[dataArray objectAtIndex:btn.tag]];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:arrUnSendCollection forKey:@"nosee"];
        [userDefault synchronize];
         [dataArray removeObject:[dataArray objectAtIndex:btn.tag]];
    }



    
    
//     NSArray *noseearr =[dataArray objectAtIndex:btn.tag];
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"nosee"]!=nil) {
//        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"nosee"]);
//         arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"nosee"];
//        [arr addObject:noseearr];
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:arr forKey:@"nosee"];
//        [userDefault synchronize];
//
////        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"nosee"];
//    }else
//    {
//    }
//
//    [self loadData];
    
//    NSLog(@"%@",  [[NSUserDefaults standardUserDefaults] objectForKey:@"nosee"]);

    
   
    //获取群主名
//    NSUserDefaults *deleteDefauts=[NSUserDefaults standardUserDefaults];
//    NSString *groupBy=[NSString stringWithFormat:@"DELETE_%d",btn.tag];
//    NSString *nameString=[deleteDefauts objectForKey:groupBy];
//    NSLog(@"--要删除的讨论组的群主----nameString---%@--",nameString);
//    
//    //获取讨论组id
//    NSUserDefaults *stickDefauts=[NSUserDefaults standardUserDefaults];
//    NSString *flagStr=[NSString stringWithFormat:@"STICK_%d",btn.tag];
//    NSString *didString=[stickDefauts objectForKey:flagStr];
//    NSLog(@"-删除的时候--didString---%@--",didString);

//    if ([nameString isEqualToString:[[UserInfo sharedManager] username]])
//    {
//        
//        [[NetManager sharedManager] deletedisgWithusername:[[UserInfo sharedManager] username]
//                                                       did:didString
//                                                    hudDic:Nil
//                                                   success:^(id responseDic) {
//                                                       
//                                                       NSLog(@"---删除讨论组成功---responseDic %@-----",responseDic);
//                                                       [self loadData];
//                                                   }
//                                                      fail:^(id errorString) {
//                                                          
//                                                          [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
//                                                          
//                                                          
//                                                      }];
//        
//    }
//    else
//    {
//        [[NetManager sharedManager] retreatdisgWithusername:[[UserInfo sharedManager] username] did:didString grpmember:[[UserInfo sharedManager] username] hudDic:nil success:^(id responseDic) {
//            
//            NSLog(@"-----群主不是本人的群组删除成功--responseDic-%@---",responseDic);
//            [self loadData];
//        } fail:^(id errorString) {
//            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
//        }];
//        
//    }
    
    
}


#pragma  -mark -FCSearchBar delegate
////按照聊天内容和昵称进行查询
//- (void)FCSearchBarDidSearch:(FCSearchBar *)fcSearchBar text:(NSString *)text
//{
//    NSLog(@"text = %@",text);
//    
//    SearchResultViewController* viewController = [[SearchResultViewController alloc] init];
//    [viewController setKey:text];
//    [self.navigationController pushViewController:viewController animated:NO];
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



#pragma  -mark 判断数据库 是否存在该字段
-(NSInteger)getcount:(NSString *)tablename key:(NSString *)key keyvalue:(NSString *)keyvalue
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
    NSString *sql1 = [NSString stringWithFormat:@"SELECT  COUNT(*)  FROM %@  WHERE  %@ ='%@' order by id  desc  limit  1 ",tablename,key,keyvalue];
    
    if (sqlite3_prepare_v2(db, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        NSInteger count = 0;
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
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return 0;
    }

}
-(void)execSql:(NSString *)sql
{

        sqlite3 *db ;
        sqlite3_stmt * statement;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
        if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"数据库打开失败");
        }
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, &statement, &err) != 0) {
            sqlite3_close(db);
            NSLog(@"数据库操作数据失败!");
        }
//        sqlite3_finalize(statement);
          sqlite3_close(db);


}

#pragma mark - tom 提示按钮 点击的效果
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0&&alertView.tag==10001) {
        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths1 objectAtIndex:0];
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *MapLayerDataPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];
        BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath];
        
        if (bRet) {
            //
            NSError *err;
            [fileMgr removeItemAtPath:MapLayerDataPath error:&err];
        }
        
        [Utils changeViewControllerWithTabbarIndex:4];

        [[UserInfo sharedManager] setIslogin:NO];
    }
    
}
#pragma -mark -几个刷新页面的通知
-(void)indexvcrelodata2
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata2" object:nil];
}
-(void)addretreatdisg
{
    [self getChatMessageGoToShake];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addretreatdisg" object:nil];
}
-(void)retreatdisg
{
    [self getChatMessageGoToShake];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"retreatdisg" object:nil];
}
-(void)getreload2
{
    
   [[NSNotificationCenter defaultCenter] postNotificationName:@"lodata3" object:nil];
    
    
}
-(void)hideenview
{
       [statueBar hide];
}
-(void)getreload3
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"lodata4" object:nil];
    
}
-(BOOL)stringIsEmpty:(NSString *)string {
    if([string isKindOfClass:[NSNull class]]){
        return NO;
    }
    if (string == nil) {
        return NO;
    }
    if (string == NULL) {
        return NO;
    }
//    if ([string isEqualToString:@"(null)"]) {
//        return NO;
//    }
//    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return YES;
}
#pragma -mark -AsyncSocketDelegate
-(void)getmesges :(NSDictionary *)mesDic1
{
    NSString *uidString=[mesDic1 objectForKey:@"uid"];
    //2014.12.11将删除，增加，更换，退出暂时去掉
    if ([uidString isEqualToString:@"deletedisg"] ) {
        //删除群成员操作
        //[self deletedisg:mesDic];
    }
    if ([uidString isEqualToString:@"adddisgmem"] ) {
        //增加群成员操作
        //[self adddisgmem:mesDic];
    }
    if ([uidString isEqualToString:@"chgdisname"]) {
        //更换群名操作
        //[self chgdisname:mesDic];
    }
    if ([uidString isEqualToString:@"retreatdisg"]) {
        //退出群操作
        // [self retreatdisg:mesDic];
    }
    if ([uidString isEqualToString:@"k"]) {
        //异地登录时
        [self k:mesDic1];
     }
    if ([uidString isEqualToString:@"!"]) {
        //链接socket
        [self i:mesDic1];
    }
    if ([uidString isEqualToString:@"0"]) {
        //自己发送的消息得到服务器返回的
        [self o:mesDic1];
    }
    if ([uidString isEqualToString:@"#"]) {
         //服务器转发别人发来的消息
        [waitarr addObject:mesDic1];
    }
}
//删除
-(void)deletedisg:(NSDictionary *)mesDic
{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];

     [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"] contentType:@"0"talkType:@"3"
                                            vedioPath:@""
                                              picPath:@""
                                              content:[mesDic objectForKey:@"msg"]
                                                 time:datetime
                                               isRead:@"0"
                                               second:@""
                                                MegId:[mesDic objectForKey:@"msg"]
                                             imageUrl:@""
                                               openBy:@""];

    
    NSInteger datadid =[[[mesDic objectForKey:@"data"] objectForKey:@"did"] intValue];
    NSInteger datadid2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
    if (datadid==datadid2)
    {
        NSString *dateStr=[mesDic objectForKey:@"msg"];
        dateStr = [dateStr  stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        dateStr  = [dateStr  stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        SUser * user = [SUser new];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText = dateStr;
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"1";
        [_userDB saveUser:user];
        
    }else
    {
        SUser * user = [SUser new];
        NSString *dateStr=[mesDic objectForKey:@"msg"];
        dateStr = [dateStr  stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        dateStr  = [dateStr  stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText =dateStr;
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"0";
        [_userDB saveUser:user];
        
        
    }
    
   
//    NSArray *mesDicarr = [NSArray arrayWithObjects:[[mesDic objectForKey:@"data"] objectForKey:@"did"],[mesDic objectForKey:@"dtype"], nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
    
    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
    
    
}
//增加
-(void)adddisgmem:(NSDictionary *)mesDic
{
    

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
    if ([[[mesDic objectForKey:@"data"] objectForKey:@"value1"] isEqualToString:[[UserInfo sharedManager] username]]) {
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          NSString *tablename = [NSString stringWithFormat:@"chat%@%@",[[UserInfo sharedManager] username],[[mesDic objectForKey:@"data"] objectForKey:@"did"]];
                          NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '1'  where isRead  = '110' ",tablename];
                          [self execSql2:sql localid2:@""];
                          
                          [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                   talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"]
                                              contentType:@"0"
                                                 talkType:@"3"
                                                vedioPath:@""
                                                  picPath:@""
                                                  content:[mesDic objectForKey:@"msg"]
                                                     time:datetime
                                                   isRead:@"1"
                                                   second:@""
                                                    MegId:[mesDic objectForKey:@"msg"]
                                                 imageUrl:@""
                                                   openBy:@""];
                      });
    }else
    {
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                   talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"]
                                              contentType:@"0"
                                                 talkType:@"3"
                                                vedioPath:@""
                                                  picPath:@""
                                                  content:[mesDic objectForKey:@"msg"]
                                                     time:datetime
                                                   isRead:@"0"
                                                   second:@""
                                                    MegId:[mesDic objectForKey:@"msg"]
                                                 imageUrl:@""
                                                   openBy:@""];
                      });
    }
    
    NSInteger datadid =[[[mesDic objectForKey:@"data"] objectForKey:@"did"] intValue];
    NSInteger datadid2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
    if (datadid==datadid2)
    {
        SUser * user = [SUser new];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText = [mesDic objectForKey:@"msg"];
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"1";
        [_userDB saveUser:user];
        
    }else
    {
        SUser * user = [SUser new];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText = [mesDic objectForKey:@"msg"];
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"0";
        [_userDB saveUser:user];
        
        
    }
    NSArray *mesDicarr = [NSArray arrayWithObjects:[[mesDic objectForKey:@"data"] objectForKey:@"did"],[mesDic objectForKey:@"dtype"], nil];
    [self relodata:mesDicarr];

    
    
    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
    
    
}
//更换
-(void)chgdisname:(NSDictionary *)mesDic
{

    NSInteger index = currentIndex;
    dataArray2[index]=[[NSMutableArray alloc] init];
    NSUserDefaults *unSendDefault3 = [NSUserDefaults standardUserDefaults];
    if (![unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
        ;
    }else{
        dataArray2[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
    }
    
    for (int i=0; i<dataArray2[currentIndex].count; i++) {
        NSString *str1=[[dataArray2[currentIndex] objectAtIndex:i] objectForKey:@"dgid"] ;
        NSString *str2=[[mesDic objectForKey:@"data"]objectForKey:@"did"];
        
        if ([str1 intValue]==[str2 intValue]) {
            NSDictionary *dic =  [dataArray2[currentIndex] objectAtIndex:i];
            NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
            [ee setValue:[dic objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [ee setValue:[dic objectForKey:@"dgid"] forKey:@"dgid"];
            [ee setValue:[[mesDic objectForKey:@"data"]objectForKey:@"value1"] forKey:@"dname"];
            [ee setValue:[dic objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            [ee setValue:[dic objectForKey:@"picurl1"]forKey:@"picurl1"];
            [ee setValue:[dic objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dataArray2[currentIndex]  removeObjectAtIndex:i];
            [dataArray2[currentIndex] addObject:ee];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray2[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
            
        }
    }
    
    NSArray *mesDicarr = [NSArray arrayWithObjects:[[mesDic objectForKey:@"data"] objectForKey:@"did"],[mesDic objectForKey:@"dtype"], nil];
     [self relodata:mesDicarr];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"])
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata" object:mesDicarr];
//    }else
//    {
//        
//        [[NSUserDefaults standardUserDefaults] setObject:mesDicarr forKey:@"relodataarr"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
    dispatch_sync(dispatch_get_main_queue(), ^
                  {
                      [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                               talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"]
                                          contentType:@"0"
                                             talkType:@"3"
                                            vedioPath:@""
                                              picPath:@""
                                              content:[mesDic objectForKey:@"msg"]
                                                 time:datetime
                                               isRead:@"0"
                                               second:@""
                                                MegId:[mesDic objectForKey:@"msg"]
                                             imageUrl:@""
                                               openBy:@""];
                      
                      
                      NSInteger datadid =[[[mesDic objectForKey:@"data"] objectForKey:@"did"] intValue];
                      NSInteger datadid2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
                      if (datadid==datadid2)
                      {
                          SUser * user = [SUser new];
                          user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
                          user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
                          user.conText = [mesDic objectForKey:@"msg"];
                          user.contentType = @"3";
                          user.username =@"";
                          user.msgid =  @"";
                          user.description = datetime;
                          user.readed=@"1";
                          [_userDB saveUser:user];
                          
                      }else
                      {
                          SUser * user = [SUser new];
                          user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
                          user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
                          user.conText = [mesDic objectForKey:@"msg"];
                          user.contentType = @"3";
                          user.username =@"";
                          user.msgid =  @"";
                          user.description = datetime;
                          user.readed=@"0";
                          [_userDB saveUser:user];
                          
                          
                      }
                  });
    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
    
    //        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(getreload2) userInfo:nil repeats:NO];
    
}
//退出
-(void)retreatdisg:(NSDictionary *)mesDic
{


    NSString *context=[mesDic objectForKey:@"msg"];
    if ([[[mesDic objectForKey:@"data"] objectForKey:@"value1"] isEqualToString:[[mesDic objectForKey:@"data"] objectForKey:@"from_uid"]]) {
      context = [NSString stringWithFormat:@"%@ 退出群组",[[mesDic objectForKey:@"data"] objectForKey:@"from_uid"]];
    }
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
    if ([[[mesDic objectForKey:@"data"] objectForKey:@"value1"] isEqualToString:[[UserInfo sharedManager] username]]) {
              [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"]
                                              contentType:@"0"
                                                 talkType:@"3"
                                                vedioPath:@""
                                                  picPath:@""
                                                  content:context
                                                     time:datetime
                                                   isRead:@"110"
                                                   second:@""
                                                    MegId:datetime
                                                 imageUrl:@""
                                                   openBy:@""];

    }else
    {
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username] talkId:[[mesDic objectForKey:@"data"] objectForKey:@"did"]contentType:@"0"
                                talkType:@"3"
                                  vedioPath:@""
                                  picPath:@""
                                  content:context
                                   time:datetime
                                   isRead:@"0"
                                   second:@""
                                   MegId:datetime
                                   imageUrl:@""
                                   openBy:@""];

    }
    NSInteger datadid =[[[mesDic objectForKey:@"data"] objectForKey:@"did"] intValue];
    NSInteger datadid2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
    if (datadid==datadid2)
    {
        SUser * user = [SUser new];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText = context;
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"1";
        [_userDB saveUser:user];
        
    }else
    {
        SUser * user = [SUser new];
        user.uid=[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.titleName =[[mesDic objectForKey:@"data"] objectForKey:@"did"];
        user.conText = context;
        user.contentType = @"3";
        user.username =@"";
        user.msgid =  @"";
        user.description = datetime;
        user.readed=@"0";
        [_userDB saveUser:user];
        
        
    }
    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
    
    
    
    
}
-(void)k:(NSDictionary *)mesDic
{
    
    
    [self downsoket];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"dontconnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths1 objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *MapLayerDataPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];
    BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath];
    
    if (bRet) {
        //
        NSError *err;
        [fileMgr removeItemAtPath:MapLayerDataPath error:&err];
    }
    

    
    [[UserInfo sharedManager] setIslogin:NO];
       UIAlertView *gooout  = [[UIAlertView alloc]initWithTitle:@"异地登陆" message:@"如果不是本人登陆请尽快修改密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    gooout.tag=10001;
         [gooout show];
    
    
}
//修改，添加，踢出。2014.12.11暂时去掉
-(void)i:(NSDictionary *)mesDic
{

    /*
   NSDictionary *newDic=[mesDic objectForKey:@"data"];
    
    if ([self stringIsEmpty:[NSString stringWithFormat:@"%@",[newDic objectForKey:@"minid"]]]) {

        if (![[NSString stringWithFormat:@"%@",[newDic objectForKey:@"minid"]]isEqualToString:@"0"]) {
                [self gethttpdataWithMsgid:[NSString stringWithFormat:@"%d",[[newDic objectForKey:@"minid"]intValue]-1]  page:[newDic objectForKey:@"newmsg"]];
        }
        
        NSString *str=[NSString stringWithFormat:@"%@",[[[newDic objectForKey:@"jobs"] objectAtIndex:0] objectForKey:@"did"]];
        if ( [str isEqualToString:@"0"]) {
            
        }else
        {
            for (int i =0; i<[[newDic objectForKey:@"jobs"]count];i++ ) {
                NSString *key=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"key"];
                if ([key isEqualToString:@"chgdisname"]) {
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                    
                    NSLog(@"%@",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]);
                    dispatch_sync(dispatch_get_main_queue(), ^
                                  {
                                      [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username] talkId:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]
                                                          contentType:@"0"
                                                             talkType:@"3"
                                                            vedioPath:@""
                                                              picPath:@""
                                                              content:[NSString stringWithFormat:@"%@修改群名称为[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                 time:datetime
                                                               isRead:@"0"
                                                               second:@""
                                                                MegId:[NSString stringWithFormat:@"%@修改群名称为[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                             imageUrl:@""
                                                               openBy:@""];
                                      
                                  });
                    NSLog(@"%@",mesDic);
                    NSInteger dgid=0;
                    if ([self stringIsEmpty:[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"did"]]) {
                       dgid= [[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"did"]intValue];
                    }
                     ;
                    NSInteger dtype=0;
                    if ([self stringIsEmpty:[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"dtype"] ]) {
                        dtype= [[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"dtype"] intValue];
                    }


                    
                    NSInteger dgig2=0;
                    if ([self stringIsEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"]]) {
                        dgig2= [[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
                    }



                    if (dgid==dgig2)
                    {
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@修改群名称为[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"1";
                        [_userDB saveUser:user];
                        
                    }else
                    {
                        
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@修改群名称为[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"0";
                        [_userDB saveUser:user];
                        
                    }
                    
                    
                    dataArray2[dtype]=[[NSMutableArray alloc] init];
                    NSUserDefaults *unSendDefault3 = [NSUserDefaults standardUserDefaults];
                    if (![unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",dtype,[[UserInfo sharedManager] username] ]]) {
                        ;
                    }else{
                        
                        dataArray2[dtype]=[[NSMutableArray alloc]initWithArray:[unSendDefault3 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",dtype,[[UserInfo sharedManager] username] ]]];
                    }
                    
                    for (int j=0; j<dataArray2[currentIndex].count; j++) {
                        
                        NSString *str1=@"0";
                        if ([self stringIsEmpty: [[dataArray2[currentIndex] objectAtIndex:j] objectForKey:@"dgid"]]) {
                            str1= [[dataArray2[currentIndex] objectAtIndex:j] objectForKey:@"dgid"];
                        }
                        NSString *str2=@"0";
                        if ([self stringIsEmpty:[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"did"]]) {
                            str2=[[[[mesDic objectForKey:@"data"]objectForKey:@"jobs"] objectAtIndex:i]objectForKey:@"did"];
                        }


                        if ([str1 intValue]==[str2 intValue]) {
                            NSDictionary *dic =  [dataArray2[currentIndex] objectAtIndex:j];
                            [dataArray2[currentIndex]  removeObjectAtIndex:j];
                            NSMutableDictionary *ee = [[ NSMutableDictionary alloc]init];
                            [ee setValue:[dic objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
                            [ee setValue:[dic objectForKey:@"dgid"] forKey:@"dgid"];
                            [ee setValue:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]  forKey:@"dname"];
                            [ee setValue:[dic objectForKey:@"dpicurl"] forKey:@"dpicurl"];
                            [ee setValue:[dic objectForKey:@"picurl1"]forKey:@"picurl1"];
                            [ee setValue:[dic objectForKey:@"mcnt"] forKey:@"mcnt"];
                            
                            [dataArray2[dtype]   addObject:ee];
                            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                            [userDefault setObject:dataArray2[dtype] forKey:[NSString stringWithFormat:@"peoplelist%d%@",dtype,[[UserInfo sharedManager] username] ]];
                            [userDefault synchronize];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"indexvcrelodata2" object:nil];
                            
                        }
                    }
                    
                    for (int i =0; i<dataArray2[dtype].count; i++) {
                        if ([[dataArray2[dtype] objectAtIndex:i]containsObject:[NSString stringWithFormat:@"%d",dgid]]) {
                            
                        }else
                        {
                            @try {
                                
                                NSLog(@"%@",mesDic);
                                NSArray *dic=[[mesDic objectForKey:@"data"]objectForKey:@"jobs"];
                                for (int i=0; i<dic.count; i++) {
                                    
                                    NSArray *mesDicarr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",dgid],[NSString stringWithFormat:@"%d",dtype], nil];
                                    [self relodata:mesDicarr];
//                                    [[NSNotificationCenter defaultCenter]   postNotificationName:@"indexvcrelodata" object:mesDicarr];
                                }
                                
                                
                            }
                            @catch (NSException *exception) {
                                
                            }
                            @finally {
                                
                            }
                            
                            
                        }
                    }
                    
                    
                    
                }
                
                
                if ([key isEqualToString:@"adddisgmem"]) {
                    
                    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"intalking"]isEqualToString:@"1"]) {
                        [self performSelectorOnMainThread:@selector(addretreatdisg) withObject:nil waitUntilDone:YES];
                    }
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                    NSLog(@"%@",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]);
                    if ([[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]isEqualToString:[[UserInfo sharedManager] username]]) {
                        dispatch_sync(dispatch_get_main_queue(), ^
                                      {
                                          NSString *tablename = [NSString stringWithFormat:@"chat%@%@",[[UserInfo sharedManager] username],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]];
                                          NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '1'  where isRead  = '110' ",tablename];
                                          [self execSql2:sql localid2:@""];
                                          
                                          [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                                   talkId:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]
                                                              contentType:@"0"
                                                                 talkType:@"3"
                                                                vedioPath:@""
                                                                  picPath:@""
                                                                  content:[NSString stringWithFormat:@"%@添加群成员[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                     time:datetime
                                                                   isRead:@"1"
                                                                   second:@""
                                                                    MegId:[NSString stringWithFormat:@"%@添加群成员[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                 imageUrl:@""
                                                                   openBy:@""];
                                      });
                    }
                    else
                    {
                        dispatch_sync(dispatch_get_main_queue(), ^
                                      {
                                          [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                                   talkId:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]
                                                              contentType:@"0"
                                                                 talkType:@"3"
                                                                vedioPath:@""
                                                                  picPath:@""
                                                                  content:[NSString stringWithFormat:@"%@添加群成员 [%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                     time:datetime
                                                                   isRead:@"0"
                                                                   second:@""
                                                                    MegId:[NSString stringWithFormat:@"%@添加群成员 [%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                 imageUrl:@""
                                                                   openBy:@""];
                                      });
                    }
                    NSInteger dgid=0;
                    if ([self stringIsEmpty:[mesDic objectForKey:@"dgid"] ]) {
                        dgid=[[mesDic objectForKey:@"dgid"] intValue];
                    }
                    NSInteger dgig2=0;
                    if ([self stringIsEmpty:[mesDic objectForKey:@"dgid"] ]) {
                        dgig2 = [[mesDic objectForKey:@"dgid"] intValue];
                    }

                    if (dgid==dgig2)
                    {
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@添加群成员[%@]",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"1";
                        [_userDB saveUser:user];
                        
                    }else
                    {
                        
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@添加群成员%@",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"0";
                        [_userDB saveUser:user];
                        
                    }
                    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
                    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
                    
                }
                
                
                if ([key isEqualToString:@"retreatdisg"]) {
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"intalking"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"intalking"]isEqualToString:@"1"]) {
                        [self performSelectorOnMainThread:@selector(retreatdisg) withObject:nil waitUntilDone:YES];
                    }
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSString *datetime= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
                    NSLog(@"%@",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]);
                    
                    
                    if ([[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]isEqualToString:[[UserInfo sharedManager] username]])
                    {
                        dispatch_sync(dispatch_get_main_queue(), ^
                                      {
                                          [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                                   talkId:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]
                                                              contentType:@"0"
                                                                 talkType:@"3"
                                                                vedioPath:@""
                                                                  picPath:@""
                                                                  content:[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                     time:datetime
                                                                   isRead:@"110"
                                                                   second:@""
                                                                    MegId:[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                                 imageUrl:@""
                                                                   openBy:@""];
                                      });
                        
                    }else{
                        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                                 talkId:[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"]
                                            contentType:@"0"
                                               talkType:@"3"
                                              vedioPath:@""
                                                picPath:@""
                                                content:[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                                   time:datetime
                                                 isRead:@"0"
                                                 second:@""
                                                  MegId:[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]]
                                               imageUrl:@""
                                                 openBy:@""];
                    }
                    NSInteger dgid=[[mesDic objectForKey:@"dgid"] intValue];
                    NSInteger dgig2=[[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"] intValue];
                    if (dgid==dgig2)
                    {
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"1";
                        [_userDB saveUser:user];
                        
                    }else
                    {
                        
                        SUser * user = [SUser new];
                        user.uid=[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.titleName =[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"did"];
                        user.conText =[NSString stringWithFormat:@"%@踢出群成员［%@］",[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"openby"],[[[newDic objectForKey:@"jobs"] objectAtIndex:i] objectForKey:@"value"]];
                        user.contentType = @"1";
                        user.username =@"";
                        user.msgid = @"";
                        user.description = datetime;
                        user.readed=@"0";
                        [_userDB saveUser:user];
                        
                    }
                    [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
                    [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
                    
                }
            }
            
        }
    }

*/
    
    
}
-(void)o:(NSDictionary *)mesDic
{

    [[NSUserDefaults standardUserDefaults] setObject:[[mesDic objectForKey:@"data"] objectForKey:@"msgid"] forKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[[mesDic objectForKey:@"data"] objectForKey:@"msgid"] intValue]==0) {
        
        NSString *localid2 =  [[mesDic objectForKey:@"data"] objectForKey:@"localid"];
        NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
        NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '2'  where messageId  = '%@' ",tablename,localid2];
        [self execSql3:sql localid3:localid2];
        
    }else
    {
        NSString *localid2 =  [[mesDic objectForKey:@"data"] objectForKey:@"localid"];
        NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
        NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '1'  where messageId  = '%@' ",tablename,localid2];
        NSString *msgidd= [[NSUserDefaults standardUserDefaults] objectForKey:@"Sendsuccessful"];
        if ([msgidd isEqualToString:localid2]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Sendsuccessful"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self execSql2:sql localid2:localid2];
    }
    
    
    
    
    
}
-(void)n:(NSDictionary *)mesDic
{

    [msgarr addObject:[mesDic objectForKey:@"msgtext"]];
    NSLog(@"%@",msgarr);
    NSLog(@"%d",msgarr.count);
    NSString *otherString=[[mesDic objectForKey:@"msgtext"] stringByReplacingOccurrencesOfString:@"<br!>"withString:@""];
    NSString *talkid=@"";
    if ([self stringIsEmpty:[NSString stringWithFormat:@"%@",[mesDic objectForKey:@"dgid"]]]) {
       talkid=[mesDic objectForKey:@"dgid"];
    }
    NSString *contentType=@"";
    if ([self stringIsEmpty:[NSString stringWithFormat:@"%@",[mesDic objectForKey:@"msgtype"]]]) {
        contentType=[mesDic objectForKey:@"msgtype"];
    }
    NSLog(@"%@",mesDic);
    NSString *vedioPath=@"";
    if ([self stringIsEmpty:[mesDic objectForKey:@"msgpath"]]) {
        vedioPath=[mesDic objectForKey:@"msgpath"];
    }
    NSString *picPath=@"";
    if ([self stringIsEmpty:[mesDic objectForKey:@"msgpath"]]) {
        picPath=[mesDic objectForKey:@"msgpath"];
    }
    NSString *time=@"";
    if ([self stringIsEmpty:[mesDic objectForKey:@"opendatetime"]]) {
        time=[mesDic objectForKey:@"opendatetime"];
    }
    NSString *second=@"";
    if ([self stringIsEmpty:[mesDic objectForKey:@"vsec"]]) {
        second=[mesDic objectForKey:@"vsec"];
    }
    NSString *msgid=@"";
    if ([self stringIsEmpty:[NSString stringWithFormat:@"%@",[mesDic objectForKey:@"msgid"]]]) {
        msgid = [mesDic objectForKey:@"msgid"];
    }
    NSString *openid=@"";
    if ([self stringIsEmpty:[mesDic objectForKey:@"openby"]]) {
        openid=[mesDic objectForKey:@"openby"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:msgid forKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username] talkId:talkid
                        contentType:contentType
                           talkType:@"2"
                          vedioPath:vedioPath
                            picPath:picPath
                            content:otherString
                               time:time
                             isRead:@"1"
                             second:second
                              MegId:msgid
                           imageUrl:@""
                             openBy:openid];


    NSString * nosave =@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"]) {
        nosave = [[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"];
    }
    if (nosave.length==0) {
        nosave = @"0";
    }
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"themsgagehave"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"themsgagehave"];

    }else
    {
        otherString = [otherString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        otherString = [otherString stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];

        otherString = [otherString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    SUser * user = [SUser new];
    user.uid=talkid;
    user.titleName =talkid;
    user.conText = otherString;
    user.contentType = @"1";
    user.username =openid;
    user.msgid =  [mesDic objectForKey:@"dtype"];
    user.description = time;
    if ([talkid intValue]==[nosave intValue])
    {
        user.readed=@"1";
    }else
    {
        user.readed=@"0";
    }
    [_userDB saveUser:user];
    }

    NSArray *mesDicarr = [NSArray arrayWithObjects:[mesDic objectForKey:@"dgid"],[mesDic objectForKey:@"dtype"], nil];
//    [[NSUserDefaults standardUserDefaults] setObject:mesDicarr forKey:@"relodataarr"];
    [creatarr addObject:mesDicarr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"indexvcrelodata"] isEqualToString:@"1"])
    {

        [self performSelectorOnMainThread:@selector(indexvcrelodata2) withObject:nil waitUntilDone:YES];
        [self getChatMessageGoToShake];

    }else
    {
        if ([talkid intValue]==[nosave intValue])
        {

           
            [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
        }
        
    }
    
    
}

-(void)reloadata
{
    if (  [[[NSUserDefaults standardUserDefaults] objectForKey:@"reloadatayes"]isEqualToString:@"1"]) {
        [self performSelectorOnMainThread:@selector(getreload2) withObject:nil waitUntilDone:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"reloadatayes"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
//2014.06.07 chenlihua socket
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [socketUpdate readDataWithTimeout:-1 tag:300];
    NSString *mes=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *mesArray = [mes componentsSeparatedByString:@"\n"];
    NSMutableArray *mesArrayNew=[[NSMutableArray alloc]initWithArray:mesArray];
    [mesArrayNew removeLastObject];
    for (NSString *newNes in mesArrayNew){
        NSDictionary *mesDic=[newNes objectFromJSONString];
        [NSThread detachNewThreadSelector:@selector(getmesges:) toTarget:self withObject:mesDic];
    }
    
}
//发送失败再次发送调用的函数 这个为刷新聊天页面2⃣️不上跳
-(void)execSql3:(NSString *)sql localid3:(NSString *)localid2
{
    sqlite3 *db ;
    sqlite3_stmt *stmt ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"/chat.sqlite"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }

    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL,&stmt, &err) != 0) {
        //        sqlite3_finalize(stmt);
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }

    [self performSelectorOnMainThread:@selector(getreload2) withObject:nil waitUntilDone:YES];

    
    
    
    
}
//服务器返回自己身发送成功的
-(void)execSql2:(NSString *)sql localid2:(NSString *)localid2
{
     onsleep=1;
   NSString *relodata;
   NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
    
    sqlite3 *db ;
    sqlite3_stmt *stmt ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"/chat.sqlite"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlQuery =[NSString stringWithFormat:@"SELECT isRead  FROM '%@' where messageId = '%@' ", tablename,localid2];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *n1 = (char *)sqlite3_column_text(statement, 0);
            relodata = [[NSString alloc]initWithUTF8String:n1] ;
        }
    }
    sqlite3_finalize(statement);
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL,&stmt, &err) != 0) {
   
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    
    if ([relodata isEqualToString:@"4"]) {
        [self performSelectorOnMainThread:@selector(getreload2) withObject:nil waitUntilDone:YES];
    }else{
        [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
    }
   sqlite3_close(db);

    
    
}
//即将连接

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {
    NSLog(@"Socket 已经接受了一个连接");
}
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock {
    if (![self isConnectionAvailable])
    {
        return NO;
    }
    if ([socketUpdate isConnected]) {
        return NO;
    }
    return YES;
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    
  
     reloadtime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadata) userInfo:nil repeats:YES];
    [socketUpdate readDataWithTimeout:-1 tag:300];
    [timeNet invalidate];
    
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发送数据成功");

}
//2014.06.26 chenlihua sokcet断开后无法连接的问题
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{

   
}
//接收发送消息的通知来发送消息
-(void)sendyesorno
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sendyes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//定时器调用的存消息事件
-(void) savesqlite:(NSDictionary *)mesgarr
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
     NSString *isread=@"2";
    if ( ! [self isConnectionAvailable]) {
        isread =@"0";
    }
    SUser * user = [SUser new];
    user.titleName =[mesgarr objectForKey:@"did"];
    user.conText = [mesgarr objectForKey:@"msgtext"];
    user.contentType = @"1";
    user.username = [[UserInfo sharedManager] username];
    user.msgid =  @"1";
    user.description = dateString;
    [_userDB saveUser:user];
    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]talkId:[mesgarr objectForKey:@"did"]
                        contentType:[mesgarr objectForKey:@"msgtype"]talkType:@"0"
                          vedioPath:@""
                            picPath:@""
                            content:[mesgarr objectForKey:@"msgtext"]time:dateString
                             isRead:isread
                             second:@""
                              MegId:[mesgarr objectForKey:@"localid"]imageUrl:@""
                             openBy:[[UserInfo sharedManager] username]
     ];
      [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];

}
//-(void) savesqlitefile:(NSDictionary *)mesgarr
//{
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
//    NSString *isread=@"2";
//
//    if ( ! [self isConnectionAvailable]) {
//        isread =@"0";
//    }
//
//    SUser * user = [SUser new];
//    user.titleName =[mesgarr objectForKey:@"did"];
//    user.conText = @"发送了条语音";
//    user.contentType = @"1";
//    user.username = [[UserInfo sharedManager] username];
//    user.msgid =  @"1";
//    user.description = dateString;
//    [_userDB saveUser:user];
//    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username] talkId:[mesgarr objectForKey:@"did"]  contentType:[mesgarr objectForKey:@"msgtype"] // 0文本 1语音 2图片
//                 talkType:@"0"  // 0 是自己 1 是对方
//                 vedioPath:[mesgarr objectForKey:@"vedioPath"]
//                 picPath:@""
//                 content:@""
//                 time:dateString
//                 isRead:isread
//                 second:[NSString stringWithFormat:@"%@\"",[mesgarr objectForKey:@"vsec"]]
//                 MegId:[mesgarr objectForKey:@"localid"]
//                 imageUrl:@""
//                 openBy:[[UserInfo sharedManager] username]
//                       ];
// [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
//
//}
//-(void) savesqlitepic:(NSDictionary *)mesgarr
//{
//
//    NSLog(@"%@",mesgarr);
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
//    NSString *isread=@"2";
//    if ( ! [self isConnectionAvailable]) {
//        isread =@"0";
//    }
//    SUser * user = [SUser new];
//    user.titleName =[mesgarr objectForKey:@"did"];
//    user.conText = @"发送了一张图片";
//    user.contentType = @"1";
//    user.username =[[UserInfo sharedManager]username];
//
//    user.msgid = @"1";
//    user.description = dateString;
//    [_userDB saveUser:user];
//                      [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
//                                               talkId:[mesgarr objectForKey:@"did"]
//                                          contentType:@"2"
//                                             talkType:@"0"
//                                            vedioPath:@""
//                                              picPath:[mesgarr objectForKey:@"imagePath"]
//                                              content:@""
//                                                 time:dateString
//                                               isRead:isread
//                                               second:@"0"
//                                                MegId:[mesgarr objectForKey:@"localid"]
//                                             imageUrl:@""
//                                               openBy:[[UserInfo sharedManager] username]];
//     [self performSelectorOnMainThread:@selector(getreload3) withObject:nil waitUntilDone:YES];
//
//}

//这是发送消息接受通知调用的方法。
- (void)SendTexttoSever2:(NSNotification*) notification
{

    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontconnect"];
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(sendyesorno) userInfo:nil repeats:NO];
    if (![socketUpdate isConnected]) {
        
        [self downsoket2];
    }else
    {
        [socketUpdate readDataWithTimeout:-1 tag:300];
    }
 
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sendyes"] isEqualToString:@"1"]) {
        NSDictionary *jsonDic=notification.object;

       [sendarr addObject:jsonDic];
        state = 1;
         [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"sendyes"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


}

- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
    
    return [NSRunLoop currentRunLoop];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{

    //断开连接 要调用 downsoket2 把单列上的sokect 也关掉 不然下次连接不上

    [self downsoket2];
    [reloadtime invalidate];
    reloadtime=nil;

}

//2014 - 8-8 读文件封装方法
-(void)removefile :(NSString *)filename
{
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths1 objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *MapLayerDataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename]];
    BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath];
    if (bRet) {
        NSError *err;
        [fileMgr removeItemAtPath:MapLayerDataPath error:&err];
    }
}

// 读取文件
-(NSDictionary *)readfile:(NSString *)filename
{
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* fileName = [[paths1 objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename]];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]initWithContentsOfFile:fileName];
    return dict;
}
//写文件
- (void)wirtefile:(NSString *)filename file:(id)file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename]];
    configList =[[NSMutableDictionary alloc] initWithContentsOfFile:configFile];
    if ( ![fileManager fileExistsAtPath:configFile]) {
        
        [fileManager createFileAtPath:configFile contents:nil attributes:nil];
    }
    configList = [[NSMutableDictionary alloc] initWithObjectsAndKeys:file,filename,nil];
    [configList writeToFile:configFile atomically:YES];
}

-(void)isHaveNet
{
    if ([self isConnectionAvailable]) {
        //        [self reconnect];
    }else{
        ;
    }
}
-(void)reconnect
{
    
    
    socketUpdate=[socketNet sharedSocketNet];
    socketUpdate.delegate=self;
    
    NSLog(@"---idConnect---%i---",[socketUpdate isConnected]);
    
    NSString* nowTimeStr =  [Utils getTimeForNow];
    
    if(![SQLite getLastTime])
    {
        [SQLite setLastTime:nowTimeStr];
        
    }
    
    
    NSString *lastTime=[SQLite getLastTime];
    
    NSLog(@"----lastTime-----%@",lastTime);
    
    
    //2014.06.25 执行一次轮询操作，把数据取下来。
    [[NetManager sharedManager] getdiscussionWithusername:[[UserInfo sharedManager] username]
                                                      did:@"0"
                                                rdatetime:lastTime
                                                    dflag:@"0"  //  1 向前 0 向后
                                                  perpage:@"20"
                                                   hudDic:nil
                                                    msgid:@"1"
                                                  success:^(id responseDic) {
                                                      
                                                      NSLog(@"responseDic = %@",responseDic);
                                                      
                                                      
                                                      NSArray* array = [[responseDic objectForKey:@"data"] objectForKey:@"messagelist"];
                                                      
                                                      if (array.count == 0) {
                                                          
                                                          return ;
                                                      }
                                                      
                                                      
                                                      //存储收到的信息
                                                      [self saveChatToSqlite:array];
                                                      
                                                  }
                                                     fail:^(id errorString) {
                                                         NSLog(@"----errorString---%@",errorString);
                                                         
                                                     }];
    
    
    
    //2014.06.16 chenlihua 上传服务器JSON数据
    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",lastTime,@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"all",@"to_uid",@"ios",@"message",nil];
    
    NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
    NSString *jsonString=[jsonDic JSONString];
    NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [socketUpdate writeData:data withTimeout:-1 tag:1000];
    
    
}
@end
