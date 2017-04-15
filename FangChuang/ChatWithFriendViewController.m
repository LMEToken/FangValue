

//
//  ChatWithFriendViewController.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.

//

//聊天界面

#import "ChatWithFriendViewController.h"
#import "MyChatCell.h"
#import "SQLite.h"
#import "lame.h"
#import "AppDelegate.h"
#import "QunLiaoViewController.h"
#import "JumpControl.h"
#import "ZYQAssetPickerController.h"
#import "JianJieViewController.h"
#import "MineInFoemationViewController.h"
#import "FangChuangMainCell.h"


#import "FangChuangInsiderViewController.h"

//2014.05.20 chenlihua 解决未发送成功消息，断网后可以重发。
#import "Reachability.h"

//2014.05.27 chenlihua 将聊天界面每页直接显示的消息数改为50;
#define PAGENUMBER 10
#define MAXFLOAT    0x1.fffffep+127f
#import "JSONKit.h"
#define MAXWIDTH (200)
#define MINHEIGHT (20)
//2014.07.01 chenlihua 解决p001,t001,在聊天记录部分返回时，跳转到t001的方创首页总会。
#import "FangChuangGuWenViewController.h"

//tom fmdb 使用

#import "SUserDB.h"

//2014.09.12 chenlihua 自定义相机
#import "PostViewController.h"
#import "SCCommon.h"
#import "SendfailButton.h"


@interface ChatWithFriendViewController ()
{
    BOOL firstPulling;
    
    //2014.4.18 chenlihua 聊天的行数，解决刷新后聊天内容不显示到最底部的问题。
    NSInteger mCountTalk_;
    
    NSInteger state;
    NSArray *datas;
    
    NSInteger mesgeid;
    //消息标示
    NSString *localid;
    //未发送成功数据
    NSMutableArray *mesarr;
    
    NSMutableArray *unarr ;
    //断网时，数据的id.
    NSInteger failMesId;
    //断网时，数据的localId;
    NSString *failLocalId;
    //断网时，数据重新发送的未发送成功数据
    NSMutableArray *failMesArr;
    
    NSInteger talkpage;
    NSMutableArray *diccount;
    //    NSMutableDictionary *dic;
    
    NSInteger socketnow;
    
    NSInteger sokectsuccessful;
    //发送失败显示的感叹号图片
    UIImageView *sendimageview;
    //加载的旋转图标
    UIActivityIndicatorView *ActivityIndicator;
}
@property(nonatomic,strong) LTBounceSheet *sheet;
@end

@implementation ChatWithFriendViewController
@synthesize isFaceBoard;
@synthesize vedioPath;

@synthesize isSelfString;
@synthesize openByString;

@synthesize unSendFlag;



//2014.06.23 chenlihua socket
@synthesize imageDataNew;
//2014.06.24 chenlihua http,socket上传文件，修改文件名
@synthesize imagePathNew;




//2014.05.17 chenlihua 判断是否由推送，跳转过来的标志。
@synthesize isPushString;
@synthesize msgText;
//2014.05.23 chenlihua
@synthesize arrUnSendCollection;
@synthesize allUnSendArr;


//2014.07.01 chenlihua 使p001的账号从聊天记录跳转回方创部分的时候，会跳到t001的方创部分。
@synthesize where;
//2014.07.03 chenlihua 当从添加群组界面选群修改名称后，跳到群聊天界面，没有显示群组的名字。
@synthesize changeName;
@synthesize flagView;
//2014.08.30
@synthesize flagContact;

- (void)dealloc
{
    
    if (talkArray) {
        
        talkArray = nil;
    }
    _titleName = nil;
    _talkId = nil;
    _imagePath = nil;
    vedioPath = nil;
    //    self.vedioSecond = nil ;
    if (audioRecorder) {
        
        audioRecorder = nil;
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    /*
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"disappear" delegate:self cancelButtonTitle:@"2222" otherButtonTitles:nil, nil];
     [alert show];
     */
    [cishisend invalidate];
    [timerhttp invalidate];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"noremove"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"noremove"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else
    {
        
        //移除通知
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QUNTITLECHANGE" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"lodata3" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"lodata4" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"retreatdisg" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addretreatdisg" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"indexvcrelodata2" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sendimage" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SendTexttoSever" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Clickimage" object:nil];
        
    }
    
   
    [super viewWillDisappear:NO];
    [timer invalidate];
    //移除通知，重置聊天记录indexvcrelodata2f
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"noremove"]);
    
    [self.sheet hide];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"intalking"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    firstPage = 0;
    //2014.05.23 chenlihua
    //  [timer invalidate];
    //2014.05.23 chenlihua 修改定时器停止，启动的方式，防止其在后台暂用CPU
    
    //2014.06.13 chenlihua 暂停定时器
    [timer setFireDate:[NSDate distantFuture]];
    
    //2014.07.09 chenlihua 定时器中止。
    //   [charTimer invalidate];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:_talkTextView.text forKey:[NSString stringWithFormat:@"%@unsend",self.titleName]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view.layer removeAllAnimations];
    
}

#pragma mark - 封装返回数据最后一条MESGID
- (NSString *)getmesgid
{
    NSString *meglocaid =@"0";
    if (    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]]!=nil) {
        meglocaid =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@lastmegid",[[UserInfo sharedManager]username]]];
    }
    NSLog(@"%@",meglocaid);
    return  meglocaid;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    //2014.09.13 chenlihua 自定义相机，确定后发送图片
    //声明通知中心,获得默认的通知中心
    
    //    [notiCenter removeObserver:self name:@"Click" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(sendSureMessage:) name:@"Clickimage" object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendSureMessage:) name:@"qunnamegogo"object:nil];
    //2014.9.12 chenlihua 拍照完成后，点击确定后，状态条会不见。
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //2014.07.10 chenlihua socket
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"qunnamegogo"object:nil];
    //    // [self chatSocket];
    //    [self getNotification];
    //
    //    NSLog(@"*******************getNotification**********************");
    //    //在这里设置轮询信息
    //    //2014.05.21 chenlihua 把轮询消息转到登陆之后。
    //
    //
    //    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    NSLog(@"-------设置轮询信息---------！");
    //    if(self.talkId==nil)
    //    {
    //        self.talkId=[[UserInfo sharedManager] userid];
    //    }
    //    app.talkID = self.talkId;
    //
    //
    //    NSLog(@"*****ViewWillAppear Finished********************************");
    
}

//2014.06.13 chenlihua 单独开线程执行，获取联系人部分全部头像的操作。
-(void)getContractHeadImage
{
    
    [[NetManager sharedManager] getdiscussion_ulistWithuserName:[[UserInfo sharedManager] username]
                                                         hudDic:nil
                                                        success:^(id responseDic) {
                                                            NSMutableDictionary *conDic = [[NSMutableDictionary alloc]initWithDictionary:[responseDic objectForKey:@"data"]];
                                                            NSArray *arr1=[[NSArray alloc]init];
                                                            arr1=[conDic objectForKey:@"ulist"];
                                                            for (NSDictionary *dic in arr1){
                                                                NSUserDefaults *headImageUrl1=[NSUserDefaults standardUserDefaults];
                                                                NSLog(@"%@",[dic objectForKey:@"username"]);
                                                                [headImageUrl1 setObject:[dic objectForKey:@"picurl"] forKey:[dic objectForKey:@"username"]];
                                                                [headImageUrl1 synchronize];
                                                                
                                                            }
                                                        } fail:^(id errorString) {
                                                            
                                                            [self.view showActivityOnlyLabelWithOneMiao:[NSString stringWithFormat:@"%@",errorString]];
                                                        }];
    
    
    
}

- (void)pushlodate
{
    [self loadData3];
    
    
}
#pragma -mark  -消息断网重发的通知方法
//- (void)sendagain: (NSNotification *)sender
//{
//
//    NSDictionary *array = sender.object;
//
//    NSString *megid=@"";
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"messageId"]!=nil) {
//        megid=  [[NSUserDefaults standardUserDefaults] objectForKey:@"messageId"];
//    }else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:[array objectForKey:@"messageId"] forKey:@"messageId"];
//    }
//    if ([[array objectForKey:@"messageId"]isEqualToString:megid] ) {
//
//    }else
//    {
//        if ([[array objectForKey:@"contentType"] isEqualToString:@"0"])
//        {
//
//            NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",[array objectForKey:@"contentType"],@"msgtype",@"0",@"vsec",[array objectForKey:@"content"],@"msgtext",@"",@"filename",[array objectForKey:@"messageId"],@"localid",@"dev",@"iOS",nil];
//            [self SendTexttoSever:jsonDic];
//
//        }
//        else
//        {
//            NSString *pathname = @"";
//            if ([[array objectForKey:@"contentType"]isEqualToString:@"1"]) {
//                pathname =[array objectForKey:@"vedioPath"];
//                [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:@"1" files:pathname hudDic:nil success:^(id responseDic) {
//                    NSString *pathname = @"";
//
//                    if ([[array objectForKey:@"contentType"]isEqualToString:@"1"]) {
//                        pathname =[array objectForKey:@"vedioPath"];
//
//                    }else
//                    {
//                        pathname =[array objectForKey:@"imageUrl"];
//                    }
//                    pathname= [pathname lastPathComponent] ;
//                    NSString * vase =  [array objectForKey:@"second"];
//                    if (vase.length==2) {
//                        vase = [vase substringToIndex: 1];
//                    }else if(vase.length==3)
//                    {
//                        vase = [vase substringToIndex: 2];
//                    }
//                    NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];
//                    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",@"1",@"msgtype", vase,@"vsec",pathname,@"filename",@"",@"msgtext",@"dev",@"iOS", [array objectForKey:@"messageId"],@"localid",nil];
//
//
//
//                    [self SendTexttoSever:jsonDic];
//
//                } fail:^(id errorString) {
//
//                }];
//            }else
//            {
//                NSString  *  pathname2  =[array objectForKey:@"picPath"];
//
//                [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:@"2" files:pathname2 hudDic:nil success:^(id responseDic) {
//                    NSString *pathname3 = [array objectForKey:@"picPath"];
//                    pathname3= [pathname3 lastPathComponent] ;
//
//                    NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];
//                    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",@"2",@"msgtype", @"0",@"vsec",pathname3,@"filename",@"",@"msgtext",@"dev",@"iOS", [array objectForKey:@"messageId"],@"localid",nil];
//                    NSLog(@"%@",jsonDic);
//
//                    [self SendTexttoSever:jsonDic];
//                    NSString *localid2 =  [array objectForKey:@"messageId"];
//                    NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
//                    NSString *sql =[NSString stringWithFormat:@"update %@  set  isRead = '1'  where messageId  = '%@' ",tablename,localid2];
//                    [self execSql2:sql];
//                } fail:^(id errorString) {
//
//                }];
//
//            }
//
//        }
//    }
//
//
//    mesgeid = 1;
//
//
//
//}

#pragma mark - tom 提示按钮 点击的效果
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
    }
    
}
-(void)loadData4yes
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"loadData4yes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)shuaxin
{
    //       [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(loadData4yes) userInfo:nil repeats:NO];
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loadData4yes"] ==nil) {
    //        [self setTitle:[NSString stringWithFormat:@"%@(%@)",self.titleName,[[NSUserDefaults standardUserDefaults] objectForKey:@"qunnamegogo"]]];
    //        [self loadData4];
    //        [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"loadData4yes"];
    //    }
    //     if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loadData4yes"] isEqualToString:@"1"]) {
    //         [self setTitle:[NSString stringWithFormat:@"%@(%@)",self.titleName,[[NSUserDefaults standardUserDefaults] objectForKey:@"qunnamegogo"]]];
    //         [self loadData4];
    //         [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"loadData4yes"];
    //     }
    
}
-(void)relodataarr:(NSArray *)arr
{
    
    NSInteger index=[[arr objectAtIndex:1] intValue];
    NSInteger dgids =[[arr objectAtIndex:0]intValue];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"relodataarr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
    dataArray[index] = [[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
    if (dataArray[index].count>0) {
        for (int i=0; i< dataArray[index].count; i++) {
            NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
            if (dgidm==dgids)
            {
                
                if (i!=0) {
                    [dataArray [index] exchangeObjectAtIndex:0 withObjectAtIndex:i];
                    for (int j=1; j<dataArray[index].count;j++) {
                        [dataArray [index] exchangeObjectAtIndex:i withObjectAtIndex:j];
                    }
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                    [userDefault synchronize];
            
                    return;
                }else
                {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
                    [userDefault synchronize];
                  
                    return;
                    
                }
                
            }
        }
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
            sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[arr objectAtIndex:0] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            NSLog(@"%@",dic);
            for (int i = 0; i<dataArray[currentIndex].count; i++) {
                NSInteger dgidm=[[[dataArray[currentIndex] objectAtIndex:i] objectForKey:@"dgid"] intValue];
                
                if (dgidm==dgids) {
                    return ;
                }
              
              
            }
            
            
            
            [dataArray[index] addObject:dic];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
        } fail:^(id errorString) {  }];
        
        
    }else
    {
        
        [[NetManager sharedManager]getdisginfoWithusername:[[UserInfo sharedManager] username] apptoken:[[UserInfo sharedManager] apptoken] dgid:[arr objectAtIndex:0] hudDic:nil success:^(id responseDic) {
            sleep(1);
            dataArray[index]=[[NSMutableArray alloc] init];
            
            NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
            if (![unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]) {
                ;
            }else{
                dataArray[index]=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]]];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[NSString stringWithFormat:@"%d",dgids] forKey:@"dgid"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dgcreateby"] forKey:@"dgcreateby"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dpicurl"] forKey:@"dpicurl"];
            
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"mcnt"] forKey:@"mcnt"];
            [dic setValue:[[responseDic objectForKey:@"data"] objectForKey:@"dname"] forKey:@"dname"];
            for (int i = 0; i<dataArray[currentIndex].count; i++) {
                NSInteger dgidm =[[[dataArray[index] objectAtIndex:i] objectForKey:@"dgid"]intValue];
                if (dgidm==dgids) {
                    return ;
                }
               
                
            }
            
            [dataArray[index] addObject:dic];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataArray[index] forKey:[NSString stringWithFormat:@"peoplelist%d%@",index,[[UserInfo sharedManager] username] ]];
            [userDefault synchronize];
           
        }fail:^(id errorString) {}];
    }
    
    
}

-(void)setTitle:( NSString *)name
{
    UIButton *NewBackButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [NewBackButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [NewBackButton.titleLabel setFont:[UIFont fontWithName:KUIFont size:15]];
    NewBackButton.frame=CGRectMake(self.view.bounds.size.width/2-80, 0, 160, 44);
    [NewBackButton setTitle:name forState:UIControlStateNormal];
    [self.navigationView addSubview:NewBackButton];
}
- (void)loadData
{
    
    
    [[NetManager sharedManager] getcontactlistWithusername:[[UserInfo sharedManager]username] hudDic:nil success:^(id responseDic)
     {
         NSMutableArray* dataArray = [[NSMutableArray alloc]initWithArray:[[responseDic objectForKey:@"data"]objectForKey:@"fclist"]];
         for (int i=0; i<dataArray.count; i++) {
             [[NSUserDefaults standardUserDefaults] setObject:[[dataArray objectAtIndex:i]objectForKey:@"name"] forKey:[NSString stringWithFormat:@"relname%@",[[dataArray objectAtIndex:i]objectForKey:@"username"]]];
             [[NSUserDefaults standardUserDefaults] synchronize];
             NSUserDefaults *headImageUrl1=[NSUserDefaults standardUserDefaults];
             [headImageUrl1 setObject:[[dataArray objectAtIndex:i] objectForKey:@"picurl2"] forKey:[NSString stringWithFormat:@"%@pic%@",[[dataArray objectAtIndex:i] objectForKey:@"username"],[[UserInfo sharedManager]username]]];
             [headImageUrl1 synchronize];
         }
         
       
        
    
        
     }fail:^(id failer)
     {
         
     }];
        
    
        
   
 }
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    jishu=0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectSeverdown" object:nil];
    //测试
   cishistr=0;
   cishisend = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(cisend) userInfo:nil repeats:YES];
    
    SUserDB * db = [[SUserDB alloc] init];
    [db createDataBase:@"SUser"];
    _userDB = [[SUserDB alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.talkId forKey:@"nosave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_userDB mergeWithUser:self.talkId];
    //对比的时间
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"dontconnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"]!=nil) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"] count]==2) {
            
            [self relodataarr: [[NSUserDefaults standardUserDefaults] objectForKey:@"relodataarr"]];
        }
        
    }
    //刷新页面
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"qunnamegogo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"intalking"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    dateString2= [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sendtimer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData3)name:@"lodata3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData4)name:@"lodata4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(retreatdisg)name:@"retreatdisg" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addretreatdisg)name:@"addretreatdisg" object:nil];
    
    //注册发送图片的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(picBtnClick) name:@"sendimage"object:nil];
    
    //tom 2-140903  定义一个定时器 每5秒
    [self creatTableView];
    socketnow = 0;
    //数据库初始化
    
    talkpage = 1;
    mesgeid= 0;
    mesarr  = [[NSMutableArray alloc]init];
    unarr = [[NSMutableArray alloc]init];
    diccount = [[NSMutableArray alloc]init];
    failLocalId= @"0";
    
    //tom 2014 0826
    //2014.06.13 chenlihua 从进来的时候获取头像，改为在viewDidLoad中获取联系人的头像。
    // [self getContractHeadImage];
    //2014.06.13 chenlihua 由直接获取，改为开线程进行获取。
    //   [self performSelectorOnMainThread:@selector(getContractHeadImage) withObject:self waitUntilDone:YES];
    //    dispatch_queue_t queue = dispatch_queue_create("HeradImage", NULL);
    //    dispatch_async(queue, ^
    //
    //                   {
    //                       [self getContractHeadImage];
    //                   });
    
    //2014.05.23 chenlihua 解决有网后，断网时未发送的消息重新发送的问题。
    //2014.06.13 chenlihua 将定时器，移到viewDiLoad里。
    
    //2014.08.27 chenlihua 断网后重发打开。
    
    
    
    if ([messageFlag isEqualToString:@"1"]) {
        
        
        //注册到 NSRunLoopCommonModes 模式下
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }else{
        
        
        //注册到 NSRunLoopCommonModes 模式下
        //        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    
    
    
    
    
    //2014.05.22 chenlihua 未读消息数重新发送，有无未发送的数据的标志。
    
    NSLog(@"***************ChatWithFriendViewController********************");
    // Do any additional setup after loading the view.
    UIView *view = [self.view viewWithTag:backButtonTag];
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
    
    //  UIImage *backImage = [UIImage imageNamed:@"01_anniu_3"];
    UIImage *backImage = [UIImage imageNamed:@"project_main_back-new"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setTag:backButtonTag];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake((navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2, (navigationHeight  - backImage.size.height/2)/2, (navigationHeight  - backImage.size.width/2)/2)];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goindexVC) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:backButton];
    
    
    [self setTabBarHidden:YES];
    //[self setTitle:self.titleName];
    
    
    
    //2014.04.21 chenlihua 方创的群聊，显示群名（人数），联系人中的单聊显示人名（人数）
    if ([self.memberCount intValue]>1) {
        
        [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
        
        
        
        if ([[NSString stringWithFormat:@"%@",self.memberCount] isEqualToString:@"2"]) {
            [self setTitle:self.titleName];
        }else
        {
            [self setTitle:[NSString stringWithFormat:@"%@(%@)",self.titleName,self.memberCount]];
        }
        
    }else
    {
        NSLog(@"-----flagView---%@",flagView);
        NSLog(@"-------changeName---%@",changeName);
        
        //添加群组部分
        if ([flagContact isEqualToString:@"1"]) {
            
            if ([flagView isEqualToString:@"changeName"]) {
                // [self setTitle:changeName];
                //2014.07.03 chenlihua 使添加群组后，修改名称后跳转到聊天界面，标题没有。
                [self setTitle:[NSString stringWithFormat:@"%@",changeName]];
            }else{
                [self setTitle:self.userName];
            }
            
        }else if ([flagContact isEqualToString:@"2"]){
            //联系人部分
            [self.titleLabel setFont:[UIFont fontWithName:KUIFont size:20]];
            [self setTitle:[NSString stringWithFormat:@"%@",self.memberCount]];
        }else if ([flagContact isEqualToString:@"3"]){
            
            //2014.09.13 chenlihua 当从搜索界面进来的时候，没有群名称
            [self setTitle:self.titleName];
            
        }else{
            
            if ([flagView isEqualToString:@"changeName"]) {
                [self setTitle:changeName];
            }else{
                [self setTitle:self.userName];
            }
            
        }
        
    }
    

    
   [self addRightButtons2];

    [self chatView];
    talkArray = [[NSMutableArray alloc] init];
    currentPage = 0;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(talkResign:)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [_tabelView addGestureRecognizer:tap];
    
    _talkTextView.text =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@unsend",self.titleName]];
    [self setGroupMessages:nil];
    timerhttp = [NSTimer scheduledTimerWithTimeInterval:15.0f target:self selector:@selector(getlocaidinServer) userInfo:nil repeats:YES];
    
    
    
}
-(void)goindexVC
{
    FvalueIndexVC  *indexvc = [[FvalueIndexVC alloc]init];
    [self.navigationController pushViewController:indexvc animated:NO];
}
-(void)getlocaidinServer
{
    for (int i = 0; i<talkArray.count; i++) {
        if ( [[[talkArray objectAtIndex:i] objectForKey:@"isRead"]isEqualToString:@"2"]|| [[[talkArray objectAtIndex:i] objectForKey:@"isRead"]isEqualToString:@"4"]) {
            [[NetManager sharedManager]getlocaidinServerWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] localid:[[talkArray objectAtIndex:i] objectForKey:@"messageId"] hudDic:nil success:^(id success)
             {
                 NSLog(@"%@",success);
                 NSString *localid2 =[[talkArray objectAtIndex:i] objectForKey:@"messageId"];
                 NSString *tablename =  [NSString stringWithFormat:@"chat%@%@",[[UserInfo sharedManager] username],self.talkId];
                 NSString *sql=@"";
                 if ([[[success objectForKey:@"data"] objectForKey:@"chkflag"]isEqualToString:@"1"]) {
                     sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '1'  where messageId  = '%@' ",tablename,localid2];
                 }else
                 {
                     sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '0'  where messageId  = '%@' ",tablename,localid2];
                 }
                 [self execSql2:sql localid2:localid2];
                 
             }fail:^(id fail)
             {
                 
             }];
            
        }
    }
}
- (void)sendMessage:(ZBMessage *)message
{
    
    NSLog(@"%@",message);
    NSString *isread=@"2";
    
    NSLog(@"---------------开始按发送按钮----------------------------------");
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
    
    NSString* path = @"";
    //2014.06.24 chenlihua http,socket上传图片消息，修改名字
    NSString *pathNew=@"";
    
    [[NSUserDefaults standardUserDefaults] setObject:self.talkId  forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (contentType == 0) {
        
        //2014.05.20 chenlihua 解决连续点击Send按钮发送同一条消息的情况，原来没有，添加。
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
            NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
            failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
            
        }
        [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"-------------contentType==0-----");
        NSLog(@"'%@",path);
        NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];
        NSLog(@"%@",onlyfailLocalId);
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",[NSString stringWithFormat:@"%d",contentType],@"msgtype",@"0",@"vsec",message.text,@"msgtext",path,@"filename",onlyfailLocalId,@"localid",@"dev",@"iOS",nil];
        NSLog(@"%@",jsonDic);
        //        if (msgText.length>200) {
        //            [self.view showActivityOnlyLabelWithOneMiao:@"超出200字数限制"];
        //            return;
        //        }else
        //        {
        //            [self SendTexttoSever:jsonDic];
        //        }
        [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
        NSString *dateStr = [msgText stringByReplacingOccurrencesOfString:@"<br!>" withString:@""];
        
        if ( ! [self isConnectionAvailable]) {
            isread =@"0";
        }
        
        
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:self.talkId  //默认对方ID
                            contentType:[NSString stringWithFormat:@"%d",contentType] // 0文本 1语音 2图片
                               talkType:@"0"  // 0 是自己 1 是对方
                              vedioPath:self.vedioPath
                                picPath:self.imagePath
                                content:message.text
                                   time:dateString
                                 isRead:isread
                                 second:[NSString stringWithFormat:@"%d\"",(int)(self.vedioSecond)]
                                  MegId:onlyfailLocalId
                               imageUrl:[[UserInfo sharedManager] userpicture]
                                 openBy:self.titleName
         ];
        [self loadData4];
        
        
        [_talkTextView setText:@""];
        self.vedioPath = nil;
        self.imagePath = nil;
        self.vedioPathNew=nil;
        self.imagePathNew=nil;
        NSLog(@"-------服务器前，content--%@---",msgText);
        return;
    }
    
    
    
    
    
    
    
    
}
-(void)execSql2:(NSString *)sql localid2:(NSString *)localid2
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
    //    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (sqlite3_exec(db, [sql UTF8String], NULL,&stmt, &err) != 0) {
        //        sqlite3_finalize(stmt);
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    [self loadData3];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"lodata4" object:nil];
    //    [self loadData4];
    //    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
    //        sqlite3_close(db);
    //        NSLog(@"数据库打开失败");
    //    }
    
    
    //    sqlite3_stmt *statement ;
    //    NSString *sql2 =[NSString stringWithFormat:@"Select IsRead From %@  where messageId = '%@' ", [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"],localid2];
    //    if (sqlite3_prepare_v2(db, [sql2 UTF8String], -1, &statement, NULL) != SQLITE_OK) {
    //        NSLog(@"Error: failed to prepare statement with message:get testValue.");
    //
    //    }
    //    else {
    //        while (sqlite3_step(statement) == SQLITE_ROW) {
    //            char *name = (char*)sqlite3_column_text(statement, 0);
    //            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
    //
    //
    //            if ([nsNameStr isEqualToString:@"0"]) {
    //                UIAlertView *myshwow =[ [UIAlertView alloc]initWithTitle:@"出现这个提醒请告诉我" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上", nil];
    //                [myshwow show];
    //            }else
    //            {
    //                  [self loadData4];
    //            }
    //
    //
    //        }
    //        sqlite3_finalize(statement);
    //        sqlite3_close(db);
    //    }
    //
    //  sqlite3_finalize();
    //    int sqlite3_step(sqlite3_stmt*);
    //    int sqlite3_reset(sqlite3_stmt *pStmt);
    //    int sqlite3_column_count(sqlite3_stmt *pStmt);
    
    
}
//- (void)connectagain2
//{
//
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"Sendsuccessful"]isEqualToString:@"YES"])
//    {
//        //                [chatSocket disconnect];
//        if ([self isConnectionAvailable])
//        {
//            [self loadData4];
//            //           [chatSocket disconnect];
//            //            chatSocket.delegate = nil;
//            //           [socketNet managerDisconnect];
//
//            //            chatSocket=[socketNet sharedSocketNet];
//            //           chatSocket.delegate=self;
//            //        [chatSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
//            //        [chatSocket readDataWithTimeout:-1 tag:1];
//        }
//
//
//    }
//
//
//
//
//
//
//}
//- (void)connectsoket
//{
//    @try {
//        //                [chatSocket disconnect];
//        if ([self isConnectionAvailable]) {
//            chatSocket=[socketNet sharedSocketNet];
//            chatSocket.delegate=self;
//            [chatSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
//            [chatSocket readDataWithTimeout:-1 tag:1];
//        }
//
//
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//    }
//}

#pragma  -mark -pullingrefreshTableView delegate
//载入数据的时候，（往下拉）
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    //    talkpage = talkpage +1;
    //
    //    dispatch_queue_t quueue = dispatch_queue_create("cgd1", NULL);
    //    dispatch_async(quueue, ^{
    //        [self loadData2];
    //    });
    //    [_tabelView tableViewDidFinishedLoading];
    //    NSLog(@"aaaa");
}
//重新刷新的时候（往下拉）
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    
    talkpage = talkpage +1;
    [self loadData2];
    [_tabelView tableViewDidFinishedLoading];
}
#pragma -mark -UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_tabelView tableViewDidEndDragging:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tabelView tableViewDidScroll:scrollView];
}

- (void)loadData3
{
    
    
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"noloadata"] isEqualToString:@"1"]) {
        return;
    }
    if(self.talkId==nil)
    {
        self.talkId=[[UserInfo sharedManager] userid];
    }
    NSArray * getChats = [SQLite getSingleChatArrayWithUserId:[[UserInfo sharedManager] username] talkId:self.talkId page:talkpage*20];
    
    if (getChats == nil || getChats.count == 0) {
        
        return ;
    }
    else
    {
        //获取到聊天记录。有聊天信息。
        if (talkArray.count>0) {
            [talkArray removeAllObjects];
        }
        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, getChats.count)];
        [talkArray insertObjects:getChats atIndexes:set];
        [_tabelView reloadData];
        
    }
    
    
}
-(void)addretreatdisg
{
    [self setTitle:[NSString stringWithFormat:@"%@(%d)",self.titleName,[self.memberCount intValue]+1]];
    [self performSelectorOnMainThread:@selector(loadData4) withObject:nil waitUntilDone:YES];
}
-(void)retreatdisg
{
    
    [self setTitle:[NSString stringWithFormat:@"%@(%d)",self.titleName,[self.memberCount intValue]-1]];
    [self performSelectorOnMainThread:@selector(loadData4) withObject:nil waitUntilDone:YES];
    
}
- (void)loadData4
{
    
//    
//    NSMutableDictionary *msgdic = [[NSMutableDictionary alloc]init];
//    [msgdic setValue:@"839" forKey:@"ID"];
//    [msgdic setValue:@"IOS-12014-11-26 17:58:441944" forKey:@"content"];
//    [msgdic setValue:@"0" forKey:@"contentType"];
//    [msgdic setValue:@"" forKey:@"imageUrl"];
//    [msgdic setValue:@"1" forKey:@"isRead"];
//    [msgdic setValue:@"IOS-12014-11-26 17:58:441944" forKey:@"messageId"];
//    [msgdic setValue:@"t002" forKey:@"openby"];
//    [msgdic setValue:@"" forKey:@"picPath"];
//    [msgdic setValue:@"0\"" forKey:@"second"];
//    [msgdic setValue:@"4089" forKey:@"talkId"];
//    [msgdic setValue:@"0" forKey:@"talkType"];
//    [msgdic setValue:@"2014-11-26 17:58:44" forKey:@"time"];
//    [msgdic setValue:@"t002" forKey:@"userId"];
//    [msgdic setValue:@"" forKey:@"vedioPath"];
//    [talkArray addObject:msgdic];
//    [_tabelView reloadData];
//    if (talkArray.count>0) {
//        [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }

//
//
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"noloadata"] isEqualToString:@"1"]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"aaa" forKey:@"messageId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if(self.talkId==nil)
    {
        self.talkId=[[UserInfo sharedManager] userid];
    }
    NSArray * getChats = [SQLite getSingleChatArrayWithUserId:[[UserInfo sharedManager] username] talkId:self.talkId page:20];
    NSLog(@"%@",getChats);

    infoBtn.hidden=NO;
    for (int i =0; i<getChats.count; i++) {
        if ([[[getChats objectAtIndex:i ]objectForKey:@"isRead"] isEqualToString:@"110"]) {
            infoBtn.hidden=YES;
        }
    }
    if (getChats == nil || getChats.count == 0) {
        
        return ;
    }
    else
    {
        //获取到聊天记录。有聊天信息。
        if (talkArray.count>0) {
            [talkArray removeAllObjects];
        }
        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, getChats.count)];
        [talkArray insertObjects:getChats atIndexes:set];
        [_tabelView reloadData];
        if (talkArray.count>0) {
            [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    
    
}
- (void)pushMsg
{
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"noloadata"] isEqualToString:@"1"]) {
        return;
    }
    if(self.talkId==nil)
    {
        self.talkId=[[UserInfo sharedManager] userid];
    }
    NSArray * getChats = [SQLite getSingleChatArrayWithUserId:[[UserInfo sharedManager] username] talkId:self.talkId page:20];
    if (getChats == nil || getChats.count == 0) {
        return ;
    }
    else
    {
        //获取到聊天记录。有聊天信息。
        [talkArray addObject:[getChats objectAtIndex:0]];
        //        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, getChats.count)];
        //        [talkArray insertObjects:getChats atIndexes:set];
        [_tabelView reloadData];
        if (talkArray.count>0) {
            [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
    
    
}
- (void)loadData2
{
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"noloadata"] isEqualToString:@"1"]) {
        return;
    }
    NSLog(@"*****************loadData begin***********************");
    if(self.talkId==nil)
    {
        self.talkId=[[UserInfo sharedManager] userid];
        
    }
    NSArray * getChats = [SQLite getSingleChatArrayWithUserId:[[UserInfo sharedManager] username] talkId:self.talkId page:talkpage*20];
    //    NSLog(@"%@",getChats);
    if (getChats .count==talkArray.count) {
        [_tabelView tableViewDidFinishedLoadingWithMessage:@"没有更多消息了"];
        return;
    }
    if (getChats == nil || getChats.count == 0) {
        [_tabelView reloadData];
        return ;
    }
    else
    {
        
        [talkArray removeAllObjects];
        //        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, getChats.count)];
        //        [talkArray insertObjects:getChats atIndexes:set];
        for (int i =0; i<getChats.count; i++) {
            [talkArray addObject:[getChats objectAtIndex:i]];
        }
        [_tabelView reloadData];
        //        if (talkArray.count>0) {
        //                [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        //        }
        
        
        
        
        //2014.05.05 chenlihua 有新消息时，并不显示到最底部。
        //[self performSelectorOnMainThread:@selector(scrollTableView) withObject:nil waitUntilDone:NO];
        
    }
    
    
    //tom 20140709 实现上拉加载数据[[NSString stringWithFormat:@"%d",getChats.count ]
    
    
}

//解决刷新后聊天内容不显示到最底部的问题(2014.04.18，前期此代码被注释掉)
- (void)scrollTableView
{
    
    [_tabelView setContentOffset:currentPoint animated:NO];
    _tabelView.backgroundColor=[UIColor clearColor];
    //   [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:mCountTalk_-1  inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkArray.count-1  inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
//初始化聊天内容界面
- (void)creatTableView
{
    NSLog(@"creatTableView");
    
    _tabelView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight - navigationHeight-50) pullingDelegate:self];
    
    //只显示上边的刷新，不显示下边的刷新
    [_tabelView setHeaderOnly:YES];
    
    [_tabelView setDelegate:self];
    [_tabelView setDataSource:self];
    [_tabelView setBackgroundColor:[UIColor clearColor]];
    //聊天之间是一个一个的cell
    [_tabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tabelView.userInteractionEnabled=YES;
    
    //    [_tabelView registerClass:[FangChuangMainCell class]  forCellReuseIdentifier:@"cell"];
    
    [self.contentView addSubview:_tabelView];
    
}
-(CGSize)sizeForContentWithString:(NSString*)content
{
    CGSize size;
    // 首先算宽度
    size = [content sizeWithFont:self.talkFont constrainedToSize:CGSizeMake(MAXFLOAT, 20) lineBreakMode:NSLineBreakByWordWrapping];
    //宽度大于150 ， 计算适配高度
    if (size.width > MAXWIDTH) {
        size = [content sizeWithFont:self.talkFont constrainedToSize:CGSizeMake(MAXWIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return size;
}
#pragma mark 聊天textview 的值改变事件
- (void)textViewDidChange:(UITextView *)textView
{
    //    CGSize size = [self sizeForContentWithString:_talkTextView.text];
    //       CGFloat height = size.height > 20 ? size.height - 20: 0;
    //    [_talkTextView setFrame:CGRectMake(60 + (190 - size.width - 30), 20, size.width + 40, 67 / 2. + height)];
}
#pragma mark 聊天控件初始化

- (void) chatView
{
    
    //底下的黄色的背景框
    // UIImage *back = [UIImage imageNamed:@"48_kuang_3"]; //640*100
    UIImage *back = [UIImage imageNamed:@"chatz"];
    _talkView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-20-10-44-20, 320, 50)];
    [_talkView setBackgroundColor:[UIColor colorWithPatternImage:back]];
    
    [self.contentView addSubview:_talkView];
    UIImage *yuyingImg = [UIImage imageNamed:@"chat2"];//58*58    81 * 58
    // UIImage *addImg = [UIImage imageNamed:@"48_anniu_2"];
    UIImage *addImg = [UIImage imageNamed:@"chat4"];
    
    //语音按钮
    yuyingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [yuyingBtn setBackgroundColor:[UIColor clearColor]];
    // [yuyingBtn setFrame:CGRectMake(8,  8, 81 / 2., 68 / 2.)];
    [yuyingBtn setFrame:CGRectMake(5,  8, 58 / 2., 58 / 2.)];
    [yuyingBtn setBackgroundImage:yuyingImg forState:UIControlStateNormal];
    [yuyingBtn addTarget:self action:@selector(yuyingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_talkView addSubview:yuyingBtn];
    
    //点语音按钮后，变为键盘图片
    keyBoradBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //  [keyBoradBtn setBackgroundImage:[UIImage imageNamed:@"68liaotianmoshi_icon01"] forState:UIControlStateNormal];
    [keyBoradBtn setBackgroundImage:[UIImage imageNamed:@"chat5"] forState:UIControlStateNormal];
    [keyBoradBtn setFrame:yuyingBtn.frame];
    [keyBoradBtn setBackgroundColor:[UIColor clearColor]];
    [keyBoradBtn addTarget:self action:@selector(becomeActivity:) forControlEvents:UIControlEventTouchUpInside];
    [_talkView addSubview:keyBoradBtn];
    [keyBoradBtn setHidden:YES];
    
    //请按住说话，背景图
    inputVoiceBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //  inputVoiceBtn.frame = CGRectMake(CGRectGetMaxX(yuyingBtn.frame)+8, 8, 320 - 8 -  81/2.0  - 8 - CGRectGetMaxX(yuyingBtn.frame)-8, 40);
    
    //2014.04.22 chenlihua 解决发送消息录入框高度多了，与光标一样高的问题。高度减少了5个像素。
    inputVoiceBtn.frame = CGRectMake(CGRectGetMaxX(yuyingBtn.frame)+5, 8, 320 - 10-8 -  81/2.0  - 8 - CGRectGetMaxX(yuyingBtn.frame)-8, 40-5);
    [inputVoiceBtn setTitle:@"请按住说话" forState:UIControlStateNormal];
    [inputVoiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [inputVoiceBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    /*
     [inputVoiceBtn setBackgroundImage:[UIImage imageNamed:@"10_shurukuang_3"] forState:UIControlStateHighlighted];
     [inputVoiceBtn setBackgroundImage:[UIImage imageNamed:@"10_shurukuang_3"] forState:UIControlStateNormal];
     */
    [inputVoiceBtn setBackgroundImage:[UIImage imageNamed:@"chat3"] forState:UIControlStateHighlighted];
    [inputVoiceBtn setBackgroundImage:[UIImage imageNamed:@"chat3"] forState:UIControlStateNormal];
    
    
    [inputVoiceBtn addTarget:self action:@selector(recordStart)
            forControlEvents:UIControlEventTouchDown];
    [inputVoiceBtn addTarget:self action:@selector(recordFinished2) forControlEvents:UIControlEventTouchUpInside];
    
    
    inputVoiceBtn.backgroundColor=[UIColor clearColor];
    inputVoiceBtn.titleLabel.font=[UIFont fontWithName:KUIFont size:14];
    [_talkView addSubview:inputVoiceBtn];
    
    inputVoiceBtn.hidden = YES;
    //输入框
    UIImage *im = [UIImage imageNamed:@"10_shurukuang_3"];
    imv = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yuyingBtn.frame)+5, 8, inputVoiceBtn.frame.size.width, inputVoiceBtn.frame.size.height)];
    //CGRectMake(CGRectGetMaxX(addBtn.frame) + 10, 10, 320 - 10 -  117/2.0  - CGRectGetMaxX(addBtn.frame)- 20, 32)
    [imv setImage:im];
    [_talkView addSubview:imv];
    
    
    //输入框
    _talkTextView = [[GCPlaceholderTextView alloc] initWithFrame:
                     CGRectInset(imv.frame, 2, 0)];
    _talkTextView.delegate = self;
    
    //2014.05.22 chenlihua 解决连续点击send，发送同一条消息的问题。
    [_talkTextView setBackgroundColor:[UIColor clearColor]];
    [_talkTextView setFont:[UIFont fontWithName:KUIFont size:14]];
    self.talkFont =[UIFont fontWithName:KUIFont size:14];
    //[UIFont systemFontOfSize:14];
    _talkTextView.returnKeyType = UIReturnKeySend;
    
    
    //设置textfield的是否大写功能
    _talkTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //2014.05.20 chenlihua 当textFiled里无字时，send不可点击。以前是NO；
    _talkTextView.enablesReturnKeyAutomatically =YES;
    //    UITapGestureRecognizer *tapCgr=nil;
    //    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
    //    action:@selector(textclick)];
    //    tapCgr.numberOfTapsRequired=2;
    //    [_talkTextView addGestureRecognizer:tapCgr];
    
    
    [_talkView addSubview:_talkTextView];
    
    [_sendBtn addTarget:self action:@selector(sendclick) forControlEvents: UIControlEventTouchDown ];
    
    
    
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 220)];
    faceBorad = myview;
    myview.backgroundColor = [UIColor whiteColor];
    
    //右侧选择图片按钮
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundColor:[UIColor clearColor]];
    [addBtn setFrame:CGRectMake(CGRectGetMaxX(_talkTextView.frame) + 10, CGRectGetMinY(yuyingBtn.frame), CGRectGetWidth(yuyingBtn.frame)+5, CGRectGetHeight(yuyingBtn.frame)+5)];
    [addBtn setBackgroundImage:addImg forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(picBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_talkView addSubview:addBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)recordFinished2
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"recordFinished"]isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"recordFinished"];
        return;
    }
    [self recordFinished];
}
-(void)typeclick2:(UIButton *)mxybtn
{
    
}
int a=0;
- (void)showFaceBorad{
    a++;
    if(a==1)
    {
        [self.view endEditing:YES];
        // 调整视图的位置
        CGRect ff = [[UIScreen mainScreen] bounds];
        self.view.frame = ff;
        ff.origin.y -= 220;
        self.view.frame = ff;
        [self.view addSubview:faceBorad];
        isFaceBoradShow = YES;
        
    }else
    {
        [_talkTextView resignFirstResponder];
        [faceBorad removeFromSuperview];
        isFaceBoradShow = NO;
        
        CGRect ff = [[UIScreen mainScreen] bounds];
        self.view.frame = ff;
        a=0;
    }
    
    
}
-(void)getNotification
{
    NSLog(@"***********getNotification begin*************");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setGroupMessages:) name:HaveNewMessageFromSevers object:nil];
    NSLog(@"***********getNotification finished*************");
}



//2014.05.22 chenlihua 解决断网后，重新发送消息的问题。

-(void)setGroupMessages:(NSNotification *)noti
{
    
    [self loadData4];
    
}



//查看群组成员

- (void)goToInfo:(UIButton*)button
{
    
    
    //    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    //    [notiCenter removeObserver:self name:@"Click" object:nil];
    
    
    //    if ([self.entrance isEqualToString:@"contact"]) {
    //        JianJieViewController* view = [[JianJieViewController alloc]init];
    //        view.myDiction = self.contactInfo;
    //        [view setTitle:[self.contactInfo objectForKey:@"name"]];
    //        [self.navigationController pushViewController:view animated:NO];
    //
    //
    //    }else{
//    NSUserDefaults *unSendDefault2 = [NSUserDefaults standardUserDefaults];
//    dataArray[1]=[[NSMutableArray alloc]initWithArray:[unSendDefault2 objectForKey:[NSString stringWithFormat:@"peoplelist%d%@",1,[[UserInfo sharedManager] username] ]]];
//    NSLog(@"%@",dataArray[1]);
//    NSLog(@"%@",self.qunzhuname);
    QunLiaoViewController* viewController = [[QunLiaoViewController alloc] init];
    viewController.digId = self.talkId;//将会话ID传给下个页面，作为群ID
    NSLog(@"%@",self.talkId);
    viewController.qunzhuname = self.qunzhuname;
    //2014.04.25 修改群的textField里默认显示群名称
    viewController.qunChatName=self.titleName;//将群名称传下去。
    
    
    
    [self.navigationController pushViewController:viewController animated:NO];
    
    //    }
}

- (void)doWithVedionFile
{
    
    @try {
        NSLog(@"---------doWithVedionFile--------");
        NSString* strMp3Path = [self.vedioPath stringByAppendingString:@".mp3"];
        NSString *strMp3PathNew=[self.vedioPathNew stringByAppendingString:@".mp3"];
        int read, write;
        //原来名字
        FILE *pcm = fopen([self.vedioPath cStringUsingEncoding:1], "rb");  //source
        fseek(pcm, 8*1024, SEEK_CUR);  //4*1024                                 //skip file header
        FILE *mp3 = fopen([strMp3Path cStringUsingEncoding:1], "wb");  //output
        
        const int PCM_SIZE = 16384;//8192
        const int MP3_SIZE = 16384;//8192
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 22050.0);//11025.0
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        
        
        
        
        [[NSFileManager defaultManager] removeItemAtPath:self.vedioPath error:nil];
        
        self.vedioPath = strMp3Path ;
        self.vedioPathNew=strMp3PathNew;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    
    if ([self isConnectionAvailable]) {

     [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
    
        
    }else
    {
     [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
      
    }
    
    
    //兼容环境
    
}

//2014.05.20 chenlihua 判断网络是否连接
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





//2014.05.26 chenlihua 重写sendMessage

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

#pragma  -mark -数据库语句
-(void)execSql:(NSString *)sql
{
    sqlite3 *db ;
    sqlite3_stmt *stmt ;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"count"];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, &stmt, &err) != 0) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
    sqlite3_finalize(stmt);
    
    sqlite3_close(db);
}



//2014.08.05 chenlihua socket改成http注释掉
-(void)selfloadData
{
    [self loadData4];
    [_talkTextView setText:@""];
    self.vedioPath = nil;
    self.imagePath = nil;
    self.vedioPathNew=nil;
    self.imagePathNew=nil;
}
- (void)sendSocketMessage
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"intalking"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *isread=@"2";
    NSLog(@"---------------开始按发送按钮----------------------------------");
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
    
    NSString* path = @"";
    NSString *pathNew=@"";
    
    if (_talkTextView.text.length>0) {
        contentType = 0;
        self.vedioPath = @"";
        self.imagePath = @"";
        //2014.06.24 chenlihua http,socket修改文件名
        self.imagePathNew=@"";
        self.vedioPathNew=@"";
        
        //2014.07.27 chenlihua 去掉其中的换行符
        NSString *dateStr = [_talkTextView.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        msgText=dateStr;
        
        
    }
    else   if (self.vedioPath && ![self.vedioPath isEqualToString:@""] ) {
        
        contentType = 1;
        _talkTextView.text = @"";
        self.imagePath = @"";
        //        msgText = self.vedioPath;
        path = self.vedioPath;
        
        //2014.06.24 chenlihua http,socket修改文件名
        pathNew=self.vedioPathNew;
        
    }
    else if (self.imagePath && ![self.imagePath isEqualToString:@""] ){
        
        contentType = 2;
        _talkTextView.text = @"";
        self.vedioPath = @"";
        //        msgText = self.imagePath;
        path = self.imagePath;
        //2014.06.24 chenlihua http,socket修改文件名
        pathNew=self.imagePathNew;
    }
    else
    {
        //        [self.view showActivityOnlyLabelWithOneMiao:@"发送内容不能为空"];
        return ;
    }


    [[NSUserDefaults standardUserDefaults] setObject:self.talkId  forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if (contentType == 0) {

        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
            NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
            failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
            
        }
        [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",[NSString stringWithFormat:@"%d",contentType],@"msgtype",@"0",@"vsec",msgText,@"msgtext",path,@"filename",onlyfailLocalId,@"localid",@"dev",@"iOS",nil];
        [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
        [[NSUserDefaults standardUserDefaults] setObject:onlyfailLocalId forKey:@"onlyfailLocalId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSelectorOnMainThread:@selector(selfloadData) withObject:nil waitUntilDone:YES];  
        return;
    }
    else if(contentType ==1)
    {


        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
            NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
            failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
        }

        [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
        NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];
        NSLog(@"%@",path);
        [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:[NSString stringWithFormat:@"%d",contentType] files:path hudDic:nil success:^(id responseDic) {
            NSLog(@"---responseDic----%@",responseDic);
            NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];



            NSLog(@"------content---%@",[NSString stringWithFormat:@"%d",contentType]);



            //2014.08.04 chenlihua local变为整形
            NSLog(@"%@",failLocalId);
            NSString *vsec=@"1";
            if ([NSString stringWithFormat:@"%d",(int)(self.vedioSecond)]<=0) {
                vsec = @"1";
            }else
            {
                vsec =[NSString stringWithFormat:@"%d",(int)(self.vedioSecond)];
            }

            NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",[NSString stringWithFormat:@"%d",contentType],@"msgtype",vsec,@"vsec",pathNew,@"filename",/*@"bin"*/@"",@"msgtext",@"dev",@"iOS", onlyfailLocalId,@"localid",nil];

            [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];


        } fail:^(id errorString) {

        }];
        if ( ! [self isConnectionAvailable]) {
            //            [self loadData4];
            isread =@"0";
        }
        SUser * user = [SUser new];
        user.titleName =self.talkId;
        user.conText = @"发送了一条语音";
        user.contentType = @"1";
        user.username =[[UserInfo sharedManager] username];
        user.msgid =  onlyfailLocalId;
        user.description = dateString;
        [_userDB saveUser:user];
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:self.talkId
                            contentType:[NSString stringWithFormat:@"%d",contentType]
                               talkType:@"0"
                              vedioPath:self.vedioPath
                                picPath:@""
                                content:msgText
                                   time:dateString
                                 isRead:isread
                                 second:[NSString stringWithFormat:@"%d\"",(int)(self.vedioSecond)]
                                  MegId:onlyfailLocalId
                               imageUrl:@""
                                 openBy:[[UserInfo sharedManager] username]];
        [[NSUserDefaults standardUserDefaults] setObject:onlyfailLocalId forKey:@"onlyfailLocalId"];
        [self performSelectorOnMainThread:@selector(selfloadData) withObject:nil waitUntilDone:YES];






    }else if (contentType ==2)
    {

        NSString *dgid= [[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"];
        NSLog(@"'%@",dgid);
        self.talkId=dgid;
        NSLog(@"------contentType---%@",[NSString stringWithFormat:@"%d",contentType]);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
            NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
            failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
        }
        if ( ! [self isConnectionAvailable]) {

            isread =@"0";
        }

        [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
        NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];

        SUser * user = [SUser new];
        user.titleName =self.talkId;
        user.conText = @"发送了一张图片";
        user.contentType = @"1";
        user.username =[[UserInfo sharedManager] username];
        user.msgid =  onlyfailLocalId;
        user.description = dateString;
        [_userDB saveUser:user];
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:self.talkId
                            contentType:[NSString stringWithFormat:@"%d",contentType]
                               talkType:@"0"
                              vedioPath:@""
                                picPath:self.imagePath
                                content:msgText
                                   time:dateString
                                 isRead:isread
                                 second:[NSString stringWithFormat:@"%d\"",(int)(self.vedioSecond)]
                                  MegId:onlyfailLocalId
                               imageUrl:@""
                                 openBy:[[UserInfo sharedManager] username]];

        [[NSUserDefaults standardUserDefaults] setObject:onlyfailLocalId forKey:@"onlyfailLocalId"];
        [self performSelectorOnMainThread:@selector(selfloadData) withObject:nil waitUntilDone:YES];
        [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:[NSString stringWithFormat:@"%d",contentType] files:path hudDic:nil success:^(id responseDic) {
            NSLog(@"---responseDic----%@",responseDic);
            NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];

            NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",[NSString stringWithFormat:@"%d",contentType],@"msgtype",[NSString stringWithFormat:@"%d",(int)(self.vedioSecond)],@"vsec",pathNew,@"filename",/*@"bin"*/@"",@"msgtext",@"dev",@"iOS", onlyfailLocalId,@"localid",nil];
            [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
        } fail:^(id errorString) {

        }];



    }
    
    
    
}

// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
}
//我们发送消息
//-(void)sendBtnOnClick
//{
//
//    [self sendMessage];
//}
- (void)backBtnDid{
    
    NSLog(@"------开始点击返回按钮-----聊天界面中-----");
    //2014.05.17 chenlihua 解决推送跳转到指定页面返回的问题。
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)sendBtnDid
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
    [_talkTextView resignFirstResponder];
}
#pragma -mark -doClickAction
- (void)addRightButtons2
{
    infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake(320 - 44 , 0, 44, 44)];
    //    37 * 31
    // [infoBtn setImage:[UIImage imageNamed:@"48_anniu_4"] forState:UIControlStateNormal];
    
    if ([self.memberCount intValue]<=2) {
        [infoBtn setImage:[UIImage imageNamed:@"chat6"] forState:UIControlStateNormal];
    }else
    {
        [infoBtn setImage:[UIImage imageNamed:@"chat_qun"] forState:UIControlStateNormal];
    }
    // [infoBtn setImageEdgeInsets:UIEdgeInsetsMake(22 - 31 / 4., 22 - 37 / 4., 22 - 31 / 4., 22 - 37 / 4.)];
    [infoBtn setImageEdgeInsets:UIEdgeInsetsMake(22 - 32 / 4., 22 - 35 / 4., 22 - 32 / 4., 22 - 35 / 4.)];
    [infoBtn addTarget:self action:@selector(goToInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self addRightButton:infoBtn isAutoFrame:NO];
    
}
#pragma -mark --返回按钮
- (void) backButtonAction : (id) sender
{
    
    //        [self.navigationController popToRootViewControllerAnimated:NO];
    //    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    //    [notiCenter removeObserver:self name:@"Click" object:nil];
    //
    //    //2014.05.17 chenlihua 解决从推送界面进入聊天界面在返回方创主页面的时候，消息没有清零。
    //    if ([isPushString isEqualToString:@"is"]) {
    //
    //        //2014.05.17 chenlihua 设备Token
    //        NSString  *tokenString=[[NSUserDefaults standardUserDefaults]objectForKey:@"devicePushToken"];
    //        NSUserDefaults *infoPush=[NSUserDefaults standardUserDefaults];
    //        NSDictionary *infoDic=[infoPush objectForKey:@"pushInfo"];
    //
    //    }
    //    //2014.06.24 chenlihua 解决返回后socket没变的问题。
    //    // [self.navigationController popToRootViewControllerAnimated:YES];
    //
    //    if ([where isEqualToString:@"insider"]) {
    //        //2014.06.24 chenlihua 解决返回后socket没变的问题。
//    FangChuangInsiderViewController *insideView=[[FangChuangInsiderViewController alloc]init];
//    [self.navigationController pushViewController:insideView animated:NO];
    
      [Utils changeViewControllerWithTabbarIndex:5];
    //
    //    }else if([where isEqualToString:@"guWen"]){
    //
    //        FangChuangGuWenViewController *guWenView=[[FangChuangGuWenViewController alloc]init];
    //        // guWenView.socketUpdate=chatSocket;
    //        // guWenView.socketUpdate.delegate=guWenView;
    //        [self.navigationController pushViewController:guWenView animated:NO];
    //        //2014.07.03 chenlihua 解决在添加群组，修改群名称，进入聊天界面，又返回时，跳转到p001,i001所在的方创模块界面。
    //    }else{
    //        [self.navigationController popToRootViewControllerAnimated:NO];
    //    }
    
    
}
//语音聊天按钮
- (void) yuyingBtnClick:(UIButton*)sender
{
    
    
    
    _talkTextView.text = @"";
    self.imagePath = @"";
    
    if ((backImgV.frame.origin.y != screenHeight - navigationHeight && backImgV) || (_talkView.frame.origin.y != screenHeight - navigationHeight-50)){
        //        [UIView beginAnimations:nil context:nil];
        //        [UIView setAnimationDuration:0.3];
        //        if (faceBoard) {
        //            [faceBoard setHidden:YES];
        //        }
        if (_talkTextView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
            [_talkTextView resignFirstResponder];
        }
        
        [self setFaceBoardPointY:screenHeight-navigationHeight];
        [backImgV setFrame:CGRectMake(0, screenHeight-navigationHeight, 320, 137/2.0)];
        [_talkView setFrame:CGRectMake(0, screenHeight-navigationHeight-50 , 320, 50)];
        [_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-navigationHeight-50)];
        //        [self tableViewButtom];
    }
    isYuYing = YES;
    
    [inputVoiceBtn setHidden:!isYuYing];
    [yuyingBtn setHidden:isYuYing];
    [keyBoradBtn setHidden:!isYuYing];
    [_talkTextView setHidden:isYuYing];
    [imv setHidden:isYuYing];
    
    NSLog(@"语音聊天");
}
//点击键盘按钮
- (void)becomeActivity:(UIButton*)button
{
    isYuYing = NO;
    [inputVoiceBtn setHidden:!isYuYing];
    [yuyingBtn setHidden:isYuYing];
    [keyBoradBtn setHidden:!isYuYing];
    [_talkTextView setHidden:isYuYing];
    [imv setHidden:isYuYing];
    
    
    
}
- (void)talkResign:(UITapGestureRecognizer*)tap
{
    if (isFaceBoradShow) {
        [faceBorad removeFromSuperview];
        isFaceBoradShow = NO;
    }
    CGRect ff = [[UIScreen mainScreen] bounds];
    self.view.frame = ff;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
    [_talkTextView resignFirstResponder];
}
//开始录音
-(void)startRecordWithPath:(NSString *)path
{
    NSError * err = nil;
    
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
    
	[audioSession setActive:YES error:&err];
    
	err = nil;
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
	
	NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
	
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
	
    
	self.recordPath = path;
	NSURL * url = [NSURL fileURLWithPath:self.recordPath];
	
	err = nil;
	
	NSData * audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    
	if(audioData)
	{
		NSFileManager *fm = [NSFileManager defaultManager];
		[fm removeItemAtPath:[url path] error:&err];
	}
	
	err = nil;
    
    if(self.recorder){[self.recorder stop];self.recorder = nil;}
    
	self.recorder =[ [AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err] ;
    
	if(!_recorder){
        NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: [err localizedDescription]
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [alert show];
        return;
	}
	
	[_recorder setDelegate:self];
	[_recorder prepareToRecord];
	_recorder.meteringEnabled = YES;
	
	BOOL audioHWAvailable = audioSession.inputIsAvailable;
	if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: @"Audio input hardware not available"
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
	}
	
	[_recorder recordForDuration:(NSTimeInterval) 60];
    
    self.recordTime = 0;
    [self resetTimer];
    
	timer_ = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    
    [self showVoiceHudOrHide:YES];
    
}
#pragma mark - Timer Update

- (void)updateMeters {
    
    self.recordTime += 0.05;
    NSLog(@"%f",audioRecorder.currentTime);
    if (audioRecorder.currentTime>59) {
        
        [self recordFinished];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"recordFinished"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    if (voiceHud_)
    {
        /*  发送updateMeters消息来刷新平均和峰值功率。
         *  此计数是以对数刻度计量的，-160表示完全安静，
         *  0表示最大输入值
         */
        
        if (_recorder) {
            [_recorder updateMeters];
        }
        
        float peakPower = [_recorder averagePowerForChannel:0];
        double ALPHA = 0.05;
        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
        
        [voiceHud_ setProgress:peakPowerForChannel];
    }
}
-(void) resetTimer
{
    if (timer_) {
        [timer_ invalidate];
        timer_ = nil;
    }
}
#pragma mark - Helper Function

-(void) showVoiceHudOrHide:(BOOL)yesOrNo{
    
    if (voiceHud_) {
        [voiceHud_ hide];
        
    }
    
    if (yesOrNo) {
        
        voiceHud_ = [[LCVoiceHud alloc] init];
        [voiceHud_ show];
        
        
    }else{
        
    }
}
-(void)recordStart
{
    
    
    [self startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()]];
    
    //2014.08.27 chenlihua 给提示
    [inputVoiceBtn setTitle:@"松开发送" forState:UIControlStateNormal];
    
    NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",timeString]];
    
    //2014.06.24 chenlihua socket,http上传语音，修改文件名
    NSString *pathNew=[NSString stringWithFormat:@"%.0f",data];
    
    NSLog(@"*********timeString %@****************",timeString);
    NSLog(@"------------data--%f-------------",data);
    NSLog(@"--------------path--- %@",path);
    
    self.vedioPath = path ;
    //2014.06.24 chenlihua ,socket,http上传语音，修改语音名
    self.vedioPathNew=pathNew;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    NSLog(@"%ld",  (long)audioSession.maximumInputNumberOfChannels);
    
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100],AVSampleRateKey,
                                   //                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   
                                   //                                   44100.0
                                   nil];
//    NSLog(@"%@",audioRecorder.currentTime)
   
    NSError *error;
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:recordSetting error:&error];
    if ([audioRecorder prepareToRecord]) {
        
        [audioRecorder record];
    }else{
    }
    NSLog(@"***********recordStart finished*******************");
}


//结束录音
-(void)recordFinished
{

    [self resetTimer];
    [self showVoiceHudOrHide:NO];
    
    //2014.08.27 chenlihua 给提示
    [inputVoiceBtn setTitle:@"请按住说话" forState:UIControlStateNormal];
    NSLog(@"***********recordFinished  begin*******************");
    [inputVoiceBtn setHighlighted:YES];
    
    if (audioRecorder) {
        self.vedioSecond = audioRecorder.currentTime;
        if (audioRecorder.currentTime>59) {
            self.vedioSecond=60;
        }
        NSLog(@"*********self.vedioSecond %f********",audioRecorder.currentTime);
        
        //解决发送语音为0的情况，发送为0时，弹出提示。
        if (self.vedioSecond<1.0) {
            
            [self.view showActivityOnlyLabelWithOneMiao:@"语音太短,无法发送!"];
            return;
        }
     
        
        [audioRecorder pause];
        //        [self sendVedioMessageWithVedioUrl:audioRecorder.url];
        
        audioRecorder = nil;
    }
    //开启一个线程处理音频文件
    [NSThread detachNewThreadSelector:@selector(doWithVedionFile) toTarget:self withObject:nil];
    NSLog(@"***********recordFinished  finished*******************");
    
}
//加号按钮 （表情 ＋ 图片）(暂时不知道做什么的)
- (void) addBtnClick
{
    NSLog(@"加号按钮");
    
    if (backImgV == nil) {
        UIImage *img = [UIImage imageNamed:@"Chatting_biaoqing_beijingtiao_1"]; //640*137
        backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenHeight-navigationHeight, 320, 137/2.0)];
        [backImgV setUserInteractionEnabled:YES];
        [backImgV setImage:img];
        [self.contentView addSubview:backImgV];
        
        
        //表情按钮
        UIImage *image1 = [UIImage imageNamed:@"Chatting_biaoqing_tubiao_2"]; //74*74
        faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceBtn setFrame:CGRectMake(90, 10, 74/2.0, 74/2.0)];
        [faceBtn setBackgroundImage:image1 forState:UIControlStateNormal];
        [faceBtn setBackgroundColor:[UIColor orangeColor]];
        [faceBtn addTarget:self action:@selector(faceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backImgV addSubview:faceBtn];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(90, [Utils nextHeight:faceBtn]+5, 74/2.0, 10)];
        [Utils setDefaultFont:label1 size:10.0f];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setTextColor:[UIColor grayColor]];
        [label1 setText:@"表情"];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [backImgV addSubview:label1];
        
        
        //图片按钮
        UIImage *image2 = [UIImage imageNamed:@"Chatting_biaoqing_tubiao_1"]; //74*74
        UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [picBtn setFrame:CGRectMake(190, 10, 74/2.0, 74/2.0)];
        [picBtn setBackgroundColor:[UIColor orangeColor]];
        
        [picBtn addTarget:self action:@selector(picBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [picBtn setBackgroundImage:image2 forState:UIControlStateNormal];
        [backImgV addSubview:picBtn];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(190, [Utils nextHeight:faceBtn]+5, 74/2.0, 10)];
        [Utils setDefaultFont:label2 size:10.0f];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setTextColor:[UIColor grayColor]];
        [label2 setText:@"图 片"];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [backImgV addSubview:label2];
        
    }
    if (faceBoard.frame.origin.y!=screenHeight-navigationHeight) {
        [self setFaceBoardPointY:screenHeight-navigationHeight];
    }
    if (inputVoiceBtn) {
        [inputVoiceBtn setHidden:YES];
        [imv setHidden:NO];
        [_talkTextView setHidden:NO];
        [_sendBtn setHidden:YES];
    }
    if (_talkTextView ) {
        if (isFaceBoradShow) {
            [faceBorad removeFromSuperview];
            isFaceBoradShow = NO;
        }
        CGRect ff = [[UIScreen mainScreen] bounds];
        self.view.frame = ff;
        [_talkTextView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
    }
    if (backImgV.frame.origin.y != screenHeight-navigationHeight-137/2.0 ||_talkView.frame.origin.y!=screenHeight-navigationHeight-50 -137/2.0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        [backImgV setFrame:CGRectMake(0, screenHeight-navigationHeight-137/2.0, 320, 137/2.0)];
        [_talkView setFrame:CGRectMake(0, screenHeight-navigationHeight-50 -137/2.0, 320, 50)];
        [_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-navigationHeight-50-137/2.0)];
    }
}
//添加表情(暂时不知道做什么的)
- (void) faceBtnClick
{
    NSLog(@"添加表情");
    
    if (faceBoard.frame.origin.y==screenHeight-navigationHeight) {
        [backImgV setFrame:CGRectMake(0, screenHeight-navigationHeight, 320, 137/2.0)];
        [_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-navigationHeight-50-216)];
        [_talkView setFrame:CGRectMake(0, screenHeight-navigationHeight-216-50, 320, 50)];
        [self setFaceBoardPointY:screenHeight-navigationHeight-216];
        _talkTextView.hidden = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
        [_talkTextView resignFirstResponder];
        if (isFaceBoradShow) {
            [faceBorad removeFromSuperview];
            isFaceBoradShow = NO;
        }
        CGRect ff = [[UIScreen mainScreen] bounds];
        self.view.frame = ff;
    }
    //    [self tableViewButtom];
}
- (void)setFaceBoardPointY:(float)y
{
    [UIView animateWithDuration:.25 animations:^{
        [faceBoard setFrame:CGRectMake(0, y, faceBoard.frame.size.width, faceBoard.frame.size.height)];
    }];
}
//点击添加图片
-(UIButton *) produceButtonWithTitle:(NSString*) title
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor= [UIColor whiteColor];
    button.layer.cornerRadius=23;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    return button;
}

- (void) picBtnClick
{
    NSLog(@"添加图片");
    if (isFaceBoradShow) {
        [faceBorad removeFromSuperview];
        isFaceBoradShow = NO;
    }
    CGRect ff = [[UIScreen mainScreen] bounds];
    self.view.frame = ff;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removborad"object:nil];
    [_talkTextView resignFirstResponder];
    self.sheet = [[LTBounceSheet alloc]initWithHeight:250 bgColor:[UIColor orangeColor]
                  ];
    
    UIButton * option1 = [self produceButtonWithTitle:@"相册"];
    [option1 addTarget:self action:@selector(selectorxiangji) forControlEvents:UIControlEventTouchDown];
    option1.frame=CGRectMake(15, 10, 290, 40);
    [self.sheet addView:option1];
    
    UIButton * option2 = [self produceButtonWithTitle:@"拍照"];
    [option2 addTarget:self action:@selector(paizhao) forControlEvents:UIControlEventTouchDown];
    option2.frame=CGRectMake(15, 60, 290, 40);
    [self.sheet addView:option2];
    
    UIButton * cancel = [self produceButtonWithTitle:@"取消"];
    [cancel addTarget:self action:@selector(showhide) forControlEvents:UIControlEventTouchDown];
    cancel.frame=CGRectMake(15, 113, 290, 40);
    [self.sheet addView:cancel];
    [self.sheet show];
    
    
    UIButton * cishi = [self produceButtonWithTitle:@"开始测试发消息"];
    [cishi addTarget:self action:@selector(cisendstr) forControlEvents:UIControlEventTouchDown];
    cishi.frame=CGRectMake(15, 163, 90, 40);
    [self.sheet addView:cishi];
    
    UIButton * cishi2 = [self produceButtonWithTitle:@"关闭测试"];
    [cishi2 addTarget:self action:@selector(cisendend) forControlEvents:UIControlEventTouchDown];
    cishi2.frame=CGRectMake(110, 163, 90, 40);
    [self.sheet addView:cishi2];
    
    UIButton * cishi3 = [self produceButtonWithTitle:@"发送我的友盟id"];
    [cishi3 addTarget:self action:@selector(sendyoum) forControlEvents:UIControlEventTouchDown];
    cishi3.frame=CGRectMake(210, 163, 90, 40);
    [self.sheet addView:cishi3];
    //    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    //    [actionSheet showInView:self.view];
    //[actionSheet release];
}
-(void)sendyoum
{
    NSString *isread=@"2";
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
        NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
        failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
    }
    [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];
    
    NSString *megtext = [[NSUserDefaults standardUserDefaults] objectForKey:@"youmeng"];
    NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",@"0",@"msgtype",@"0",@"vsec",megtext,@"msgtext",@"",@"filename",onlyfailLocalId,@"localid",@"dev",@"iOS",nil];
    [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
    
    
    if ( ! [self isConnectionAvailable]) {
        isread =@"0";
    }
    
    SUser * user = [SUser new];
    user.titleName =self.talkId;
    user.conText = megtext;
    user.contentType = @"1";
    user.username =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[[UserInfo sharedManager] username]]];
    
    user.msgid =  onlyfailLocalId;
    user.description = dateString;
    [_userDB saveUser:user];
    [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                             talkId:self.talkId  //默认对方ID
                        contentType:@"0" // 0文本 1语音 2图片
                           talkType:@"0"  // 0 是自己 1 是对方
                          vedioPath:self.vedioPath
                            picPath:self.imagePath
                            content:megtext
                               time:dateString
                             isRead:isread
                             second:[NSString stringWithFormat:@"%d\"",(int)(self.vedioSecond)]
                              MegId:onlyfailLocalId
                           imageUrl:@""
                             openBy:[[UserInfo sharedManager] username]
     ];
    [[NSUserDefaults standardUserDefaults] setObject:onlyfailLocalId forKey:@"onlyfailLocalId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSelectorOnMainThread:@selector(selfloadData) withObject:nil waitUntilDone:YES];
[self.sheet hide];
}
-(void)cisendstr
{
    cishistr=1;
     [self.sheet hide];
}
-(void)cisendend
{
    cishistr=0;
     [self.sheet hide];
}

-(void)cisend
{
   
    if (cishistr==1&&jishu<=1000) {
         jishu=jishu+1;
         if (jishu==1000) {
            jishu=0;
         }
        
        NSString *isread=@"2";
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString* dateString = [[NSString alloc] initWithString:[dateformatter stringFromDate:dat]] ;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"]!=nil) {
            NSString *locaod = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfailfailLocalId"];
            failLocalId = [NSString stringWithFormat:@"%d",[locaod intValue]+1];
        }
        [[NSUserDefaults standardUserDefaults] setObject:failLocalId forKey:@"lastfailfailLocalId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *onlyfailLocalId = [NSString stringWithFormat:@"IOS-1%@%@",dateString,failLocalId];
        
        
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",@"0",@"msgtype",@"0",@"vsec",[NSString stringWithFormat:@"%d",jishu],@"msgtext",@"",@"filename",onlyfailLocalId,@"localid",@"dev",@"iOS",nil];
        [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
        
        
        if ( ! [self isConnectionAvailable]) {
            isread =@"0";
        }
        
        SUser * user = [SUser new];
        user.titleName =self.talkId;
        user.conText = onlyfailLocalId;
        user.contentType = @"1";
        user.username =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[[UserInfo sharedManager] username]]];
        
        user.msgid =  onlyfailLocalId;
        user.description = dateString;
        [_userDB saveUser:user];
        [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
                                 talkId:self.talkId  //默认对方ID
                            contentType:@"0" // 0文本 1语音 2图片
                               talkType:@"0"  // 0 是自己 1 是对方
                              vedioPath:self.vedioPath
                                picPath:self.imagePath
                                content:[NSString stringWithFormat:@"%d",jishu]
                                   time:dateString
                                 isRead:isread
                                 second:[NSString stringWithFormat:@"%d\"",(int)(self.vedioSecond)]
                                  MegId:onlyfailLocalId
                               imageUrl:@""
                                 openBy:[[UserInfo sharedManager] username]
         ];
        [[NSUserDefaults standardUserDefaults] setObject:onlyfailLocalId forKey:@"onlyfailLocalId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSelectorOnMainThread:@selector(selfloadData) withObject:nil waitUntilDone:YES];
        
        
        
        
        
        
        
        

    }


}
//选择拍照
-(void)paizhao
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"noremove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.sheet hide];
    //2014.09.12 chenlihua 修改成用自定义的相机
    [self configureNotification:YES];
    SCNavigationController *nav = [[SCNavigationController alloc] init];
    nav.scNaigationDelegate = self;
    [nav showCameraWithParentController:self];
}

-(void)showhide
{
    [self.sheet hide];
}
//选择照片
-(void)selectorxiangji
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"noremove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.sheet hide];
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    //最大选择文件的数量
    picker.maximumNumberOfSelection = 1;
    //只选择图片
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    //2014.05.19 chenlihua 允许选9以下的数字张数的照片。
    picker.showEmptyGroups=YES;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
    self.vedioPath = @"";
    _talkTextView.text = @"";
}
//2014.04.30 chenlihua 点击聊天界面的头像后，跳转到相应的详细信息
-(void)gotoDetail:(UIButton *)btn
{
    NSLog(@"%@",[talkArray objectAtIndex:btn.tag]);
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"noremove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"----点击后--btn.tag-----%@",talkArray);
    NSLog(@"-----点击后---talkArray--%@",[talkArray objectAtIndex:btn.tag]);
    if ([[[talkArray objectAtIndex:btn.tag]objectForKey:@"openby"] isEqualToString:[[talkArray objectAtIndex:btn.tag]objectForKey:@"userId"]]) {
        openByString=[[talkArray objectAtIndex:btn.tag]objectForKey:@"useld"];
    }else
    {
        openByString=[[talkArray objectAtIndex:btn.tag]objectForKey:@"openby"];
    }
    NSLog(@"-点击后---openByString----%@",openByString);
    
    NSLog(@"-点击后---------self.titleName--%@----",self.titleName);
    
    //chenlihua 2014.05.20 暂时回到原来的状态
    //chenlihua 2014.05.27 解决聊天界面点击自己头像会弹出提示用户名错误的问题。
    //    if ([openByString isEqualToString:self.titleName]) {
    //        openByString=[[talkArray objectAtIndex:btn.tag]objectForKey:@"userId"];
    //        NSLog(@"-----点击自己时--openByString-----%@---",openByString);
    //    }
    //2014.05.27 chenlihua 解决在发送消息后，点击自己头像后，崩溃，但是等1-2分钟后，点击自己的头像，则跳转正常的问题。
    if (openByString.length==0||[openByString isEqualToString:@""]) {
        NSLog(@"0000000000000000000000");
        openByString=[[talkArray objectAtIndex:btn.tag]objectForKey:@"userId"];
    }
    
    
    if (![self isConnectionAvailable]) {
        [self.view showActivityOnlyLabelWithOneMiao:@"网络已断，请稍后重试"];
    }
    
    [[NetManager sharedManager] getHeadImageDetailInformationWithusername:openByString hudDic:nil success:^(id responseDic) {
        NSLog(@"在聊天界面点击联系人头像跳转到详细页面，成功获取数据，，responseDic--%@",responseDic);
        NSDictionary *detailDic=[responseDic objectForKey:@"data"];
        NSLog(@"-----detailDic----%@",detailDic);
        FvaluePeopleData *vc = [[FvaluePeopleData alloc]init];
//        PersonalDataVC *vc = [[PersonalDataVC alloc]init];
        vc.peopledic = detailDic;
        [self.navigationController pushViewController:vc
                                             animated:NO];
        //        MineInFoemationViewController* viewController = [[MineInFoemationViewController alloc] init];
        //        //2014.05.04 chenlihua 解决点击联系人聊天界面头像，详细信息里，头像错乱的问题。
        //        viewController.flagPage=@"1";
        //        viewController.dic = detailDic;
        //        NSLog(@"-----点击头像进入详细信息时传的数据--dic--%@---",viewController.dic);
        //        [self.navigationController pushViewController:viewController animated:NO];
        
    } fail:^(id errorString) {
        NSLog(@"在聊天界面点击联系人头像跳转到详细页面，获取数据失败");
        
                
        
    }];
}
//2014.05.06 chenlihua 解决拍照发送时，把照片存到相册。
//保存在相册下出错时
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {   //error非nil时保存失败
        NSLog(@"%@",[error localizedDescription]);
    }
    else
    {
        //nil时保存成功
    }
}


#pragma  -mark -ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    //2014.06.04 chenlihua CGD.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i=0; i<assets.count; i++) {
            
            ALAsset *asset=assets[i];
            
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            
            NSFileManager* fm = [NSFileManager defaultManager];
            NSString* string = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/chatCacheImage%d",i]];
            NSLog(@"----------发送照片时-----string = %@-------",string);
            
            //创建文件家
            [fm createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:nil];
            NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
            NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
            NSData* imageData =  UIImageJPEGRepresentation(tempImg, .5);
            NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
            NSLog(@"---------发送多张照片时--imagePth--%@----",imgPth);
            [imageData writeToFile:imgPth atomically:YES];
            
            //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
            NSString *imgPthNew=[NSString stringWithFormat:@"%@.jpg",timeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.imagePath = imgPth;
                //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
                self.imagePathNew=imgPthNew;
                
                
                //2014.06.23 chenlihua socket picture
                self.imageDataNew=imageData;
                NSLog(@"----------发送多张图片时，发送前--imagePath--%@",self.imagePath);
                // [self sendMessage];
                
                //2014.05.21 chenlihua 判断有网时，才发送消息
                //2014.06.26 chenlihua 有网并且sokcet连接时发送数据
                if ([self isConnectionAvailable]/*&&[chatSocket isConnected]*/){
                    
                    //[self sendMessage];
                    //2014.06.13 chenlihua 开启额外线程发送消息。改为不阻塞，及在发送消息的时候，可以同时进行别的动作。
                    if ([messageFlag isEqualToString:@"1"]) {
                        [self performSelectorOnMainThread:@selector(sendMessage) withObject:nil waitUntilDone:NO];
                    }else{
                        //                        [self performSelectorOnMainThread:@selector(sendSocketMessage) withObject:nil waitUntilDone:NO];
                        [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
                    }
                    
                }else
                {
                    
                    //2014.06.13 chenlihua 开启额外线程发送消息。改为不阻塞，及在发送消息的时候，可以同时进行别的动作。
                    //                    [self performSelectorOnMainThread:@selector(sendSocketMessage) withObject:nil waitUntilDone:NO];
                    [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
                }
                
            });
            
        }
    });
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //2014.05.20 chenlihua iOS选择正方形要去掉，iOS提示要改成中文提示；暂时注释掉。
    // [picker dismissModalViewControllerAnimated:YES];
    
    if (info) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (image) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSFileManager* fm = [NSFileManager defaultManager];
                
                NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents/chatCacheImage"];
                
                NSLog(@"string = %@",string);
                //创建文件家
                [fm createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:nil];
                
                NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
                NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
                NSData* imageDate =  UIImageJPEGRepresentation(image, .5);
                NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
                [imageDate writeToFile:imgPth atomically:YES];
                
                //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
                NSString *imgPthNew=[NSString stringWithFormat:@"%@.jpg",timeString];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.imagePath = imgPth;
                    //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
                    self.imagePathNew=imgPthNew;
                    
                    //2014.06.23 chenlihua socket picture
                    self.imageDataNew=imageDate;
                    
                    //                    [self performSelectorOnMainThread:@selector(sendSocketMessage) withObject:nil waitUntilDone:NO];
                    [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
                    //2014.05.06 chenlihua 实现拍照的发送，此段代码打开，以前是注释掉的。
                    
                    
                    
                });
            });
            
            NSLog(@"-------开始保存于相册---------");
            //2014.05.06 chenlihua 解决拍照发送时，把照片存到相册。
            //保存于相册时处理如下
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            NSLog(@"----------保存相册完毕--------");
            //关闭相册
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
//- (void)keyboardWillShow:(NSNotification *)aNotification
//{
//    if (isFaceBoradShow) {
//        [faceBorad removeFromSuperview];
//        isFaceBoradShow = NO;
//    }
//    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    int height = keyboardRect.size.height;
//
//    // 调整视图的位置
//    CGRect ff = [[UIScreen mainScreen] bounds];
//    ff.origin.y -= height;
//    self.view.frame = ff;
//
//    NSLog(@"\n keyboradHight %d", height);
//}
#pragma  -mark -keyboard键盘协议
- (void)keyboardWillShow:(NSNotification *)noti
{
    
    
    if (isFaceBoradShow==NO) {
        NSLog(@"keyBoardWillShow!");
        //键盘size
        CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        //[_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-size.height-navigationHeight-50)];
        [_tabelView setFrame:CGRectMake(0, 0, 320, screenHeight-size.height-navigationHeight-50)];
        [_talkView setFrame:CGRectMake(0, screenHeight-size.height-55-20-20, 320, 50)];
        
        //2014 - 08 05 Tom 聊天窗最新的消息内容被键盘界面遮挡了
        
        if ([talkArray count]>0) {
            [_tabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkArray.count-1  inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        
        NSLog(@"%f",size.height);
        
        [UIView commitAnimations];
    }
    
    //    [self tableViewButtom];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
    
    
}
- (void)keyboardWillHide:(NSNotification *)noti
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    _tabelView.frame = CGRectMake(0, 0, 320, screenHeight - navigationHeight-50);
    [_talkView setFrame:CGRectMake(0, screenHeight-20-10-44-20, 320, 50)];
    [UIView commitAnimations];
    //    [self tableViewButtom];
}

//2014.05.21 chenlihua  处理有网的时候，发送消息，无网的时候提醒。
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if ([text isEqualToString:@"\n"]) {
        text=@"";
        self.vedioPath = @"";
        self.imagePath = @"";
        _sendBtn.userInteractionEnabled = NO;
        
        // [self sendMessage];
        
        
        //2014.06.26 chenlihua socket 连接成功或者有网的时候。
        if ([self isConnectionAvailable]/*&&[chatSocket isConnected]*/) {
            // [self sendMessage];
            //2014.06.13 chenlihua 开启额外线程发送消息。改为不阻塞，及在发送消息的时候，可以同时进行别的动作。
            if ([messageFlag isEqualToString:@"1"]) {
                [self performSelectorOnMainThread:@selector(sendMessage) withObject:nil waitUntilDone:NO];
            }else{
                //                [self performSelectorOnMainThread:@selector(sendSocketMessage) withObject:nil waitUntilDone:NO];
                [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
            }
            
        }else
        {
            
            [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
            
            
            
        }
        return NO;
        
    }
    return YES;
}




#pragma -mark  -UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FangChuangMainCell *cell =[[ FangChuangMainCell alloc] init];

    
    if ([[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"]) {
        cell.clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(125, 2, 70, 15)];
        cell.clockTextField.textColor=[UIColor whiteColor];
        [cell.clockTextField setEnabled:NO];
        [cell.clockTextField setBorderStyle:UITextBorderStyleNone];
        
        dateString2 = [dateString2 substringWithRange:NSMakeRange(0,10)];
        NSString * dateString3 = [[[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"] substringWithRange:NSMakeRange(0,10)];
        NSString *time ;
        if ([dateString2 isEqualToString:dateString3]) {
            time =   [NSString stringWithFormat:@" 今天  %@",[[[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"]substringWithRange:NSMakeRange(11,5)]];
        }else
        {
            time =   [[[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"]substringWithRange:NSMakeRange(5,11)];
        }
        [cell.clockTextField setText:time];
        [cell.clockTextField setTextAlignment:NSTextAlignmentLeft];
        [cell.clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
        [cell.clockTextField setBackgroundColor:[UIColor clearColor]];
        [cell.clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
        [cell.clockTextField setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    
    if ([[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"]) {
        if (indexPath.row>1) {
            NSString *time1 =[[[talkArray objectAtIndex:indexPath.row] objectForKey:@"time"]substringWithRange:NSMakeRange(11,5)];
            NSString *time2=[[[talkArray objectAtIndex:indexPath.row-1] objectForKey:@"time"]substringWithRange:NSMakeRange(11,5)];
            if ([time1 isEqualToString:time2]) {
                
                
            }
            else
            {
               [cell addSubview:cell.clockTextField];
            }
        }else
        {
            [cell addSubview:cell.clockTextField];
        }
    }
    
   
    if ([[talkArray objectAtIndex:indexPath.row] objectForKey:@"openby"]) {
        
        NSString *nickLabel=[[talkArray objectAtIndex:indexPath.row] objectForKey:@"openby"];
        
        if (cell.nickLabel.tag==1) {
            [cell.nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            
            cell.nickLabel.text =[[UserInfo sharedManager] username];
            [cell.nickLabel setText:[[UserInfo sharedManager] username] ];
            
            //cell.nickLabel.text=[[UserInfo sharedManager] user_name];
        }
        else
        {
            cell.nickLabel.text=nickLabel;
           [cell.nickLabel setText:nickLabel];
            
            
        }
    }
    
   [cell updata:[talkArray objectAtIndex:indexPath.row]];
    
    NSLog(@"----%@-----",[talkArray objectAtIndex:indexPath.row]);
    
    NSMutableDictionary *sendDic=[NSMutableDictionary dictionaryWithDictionary:[talkArray objectAtIndex:indexPath.row]];
    if ([sendDic objectForKey:@"isRead"]) {
        if ([[sendDic objectForKey:@"isRead"]isEqualToString:@"2"]||[[sendDic objectForKey:@"isRead"]isEqualToString:@"4"]) {
            [cell.sighButton setHidden:NO];
            cell.sighButton.userInteractionEnabled = YES;
            cell.sighButton.btimage.hidden = YES;
            [cell.sighButton.ActivityIndicator startAnimating];
            cell.sighButton.ActivityIndicator.userInteractionEnabled = NO;
            
        }else   if ([[sendDic objectForKey:@"isRead"]isEqualToString:@"0"]) {
             [cell.sighButton.ActivityIndicator stopAnimating];
            cell.sighButton.ActivityIndicator.hidden= YES;
            [cell.sighButton setHidden:NO];
            cell.sighButton.userInteractionEnabled = YES;
            cell.sighButton.tag =indexPath.row;
           
            [cell.sighButton.btimage setImage:[UIImage imageNamed:@"duanwang"]];
//             cell.sighButton.backgroundColor = [UIColor blackColor];
            [cell.sighButton addTarget:self action: @selector(sendagain:) forControlEvents: UIControlEventTouchDown];
        }else
        {
            [cell.sighButton.ActivityIndicator stopAnimating];
        }
    }
    [cell.headButton addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    cell.headButton.tag=indexPath.row;
    return cell;
    
    
}
- (void)sendagain:(SendfailButton *)bt
{

    if ( ! [self isConnectionAvailable]) {
        UIAlertView *tishiview = [[UIAlertView alloc]initWithTitle:@"当前为无网状态" message:@"请检查网络" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        tishiview.tag=5;
        [tishiview show];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"intalking"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    bt.btimage.hidden = YES;
    
    [bt.ActivityIndicator startAnimating];
    bt.userInteractionEnabled = NO;

    NSString *tablename =  [NSString stringWithFormat:@"chat%@%@",[[UserInfo sharedManager] username],self.talkId];
    
    NSDictionary *array =[talkArray objectAtIndex:bt.tag];
    NSString *localid2 =  [array objectForKey:@"messageId"];
    //        NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
    NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '4'  where messageId  = '%@' ",tablename,localid2];
    NSString *msgidd= [[NSUserDefaults standardUserDefaults] objectForKey:@"Sendsuccessful"];
    
    if ([msgidd isEqualToString:localid2]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Sendsuccessful"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [_tabelView reloadData];

    [self execSql2:sql localid2:localid2];
    if ([[array objectForKey:@"contentType"] isEqualToString:@"0"])
    {
        NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"senddiscussion",@"class",[[UserInfo sharedManager] username],@"from_uid",self.talkId,@"did",[array objectForKey:@"contentType"],@"msgtype",@"0",@"vsec",[array objectForKey:@"content"],@"msgtext",@"",@"filename",[array objectForKey:@"messageId"],@"localid",@"dev",@"iOS",nil];
        //        [self SendTexttoSever:jsonDic];
        [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
        
        
    }
    else
    {
        NSString *pathname = @"";
        if ([[array objectForKey:@"contentType"]isEqualToString:@"1"])
        {
            pathname =[array objectForKey:@"vedioPath"];
            [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:@"1" files:pathname hudDic:nil success:^(id responseDic) {
                NSString *pathname = @"";
                
                if ([[array objectForKey:@"contentType"]isEqualToString:@"1"]) {
                    pathname =[array objectForKey:@"vedioPath"];
                    
                }else
                {
                    pathname =[array objectForKey:@"imageUrl"];
                }
                pathname= [pathname lastPathComponent] ;
                NSString * vase =  [array objectForKey:@"second"];
                if (vase.length==2) {
                    vase = [vase substringToIndex: 1];
                }else if(vase.length==3)
                {
                    vase = [vase substringToIndex: 2];
                }
                NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];
                NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",@"1",@"msgtype", vase,@"vsec",pathname,@"filename",@"",@"msgtext",@"dev",@"iOS", [array objectForKey:@"messageId"],@"localid",nil];
                
                NSLog(@"%@",jsonDic);
                //                [self SendTexttoSever:jsonDic];
                [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
            } fail:^(id errorString) {
                
            }];
        }
        else
        {
            NSString  *  pathname2  =[array objectForKey:@"picPath"];
            
            [[NetManager sharedManager] sendfileWithusername:[[UserInfo sharedManager] username]  apptoken:[[UserInfo sharedManager] apptoken] msgtype:@"2" files:pathname2 hudDic:nil success:^(id responseDic) {
                NSString *pathname3 = [array objectForKey:@"picPath"];
                pathname3= [pathname3 lastPathComponent] ;
                
                NSString *fileID=[[responseDic objectForKey:@"data"]objectForKey:@"fileid"];
                NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"fileid",@"senddiscussion",@"class",[[UserInfo sharedManager]username],@"from_uid",self.talkId,@"did",@"2",@"msgtype", @"0",@"vsec",pathname3,@"filename",@"",@"msgtext",@"dev",@"iOS", [array objectForKey:@"messageId"],@"localid",nil];
                NSLog(@"%@",jsonDic);
                
                //                [self SendTexttoSever:jsonDic];
                [self performSelectorOnMainThread:@selector(SendTexttoSever:) withObject:jsonDic waitUntilDone:YES];
            } fail:^(id errorString) {
                
            }];
            
        }
        
    }
    
    
    
    
    
    
    
}


//2014.05.23 chenlihua 解决有网后，断网时未发送的消息重新发送的问题。


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%f",cell.frame.size.height);
    return CGRectGetHeight(cell.frame)-30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [talkArray count];
}


//
//#pragma -mark -AsyncSocketDelegate
//- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
//
//}
//- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket
//{
//    return [NSRunLoop currentRunLoop];
//}
//- (void) connectSever
//{
//    if ([self isConnectionAvailable])
//    {
//        @try {
//            chatSocket=[socketNet sharedSocketNet];
//           chatSocket.delegate=self;
//            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstconnet"] isEqualToString:@"1"])
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"firstconnet"];
//                NSDictionary* jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"connect",@"class",[self getmesgid],@"msgid",[[UserInfo sharedManager] username],@"from_uid",@"dev",@"iOS",/*@"all",@"to_uid",@"ios",@"message",*/nil];
//                NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
//                NSString *jsonString=[jsonDic JSONString];
//                NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
//
//
//                //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
//                NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
//                NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
//                NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
//                NSLog(@"-----------newJson-------%@",newJson);
//
//
//                NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
//
//                [chatSocket  writeData:data withTimeout:-1 tag:1000];
//
//            }
//
//
//
//        }
//        @catch (NSException *exception) {
//        }
//        @finally {
//        }
//
//    }
//}
//
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    if(self.talkId==nil)
//    {
//        self.talkId=[[UserInfo sharedManager] userid];
//    }
//    NSString *mes=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",mes);
//    NSArray *mesArray = [mes componentsSeparatedByString:@"\n"];
//    NSLog(@"%@",mesArray);
//    NSMutableArray *mesArrayNew=[[NSMutableArray alloc]initWithArray:mesArray];
//    NSLog(@"%@",mesArrayNew);
//  [mesArrayNew removeLastObject];
//    for (NSString *newNes in mesArrayNew){
//        NSDictionary *mesDic=[newNes objectFromJSONString];
//        NSLog(@"%@",mesDic);
//        NSString *status = [mesDic objectForKey:@"status"];
//         NSString *uidString=[mesDic objectForKey:@"uid"];
//        if ([uidString isEqualToString:@"k"]) {
//
//            self.view.backgroundColor = [UIColor redColor];
//            UIAlertView *gooout  = [[UIAlertView alloc]initWithTitle:@"异地登陆" message:@"如果不是本人登陆请尽快修改密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
//            [gooout show];
//        }
//
//        if ([status intValue] == 0) {
//
//            if (![uidString  isEqualToString:@"!"]) {
//                dispatch_queue_t queue = dispatch_queue_create("cgd2", NULL);
//                dispatch_sync(queue, ^{
//
//                    NSString *context=@"";
//                    NSLog(@"%@",mesDic);
//                    if ( contentType ==1) {
//                        context = @"发送一段【语音】";
//                    }else if (contentType ==2)
//                    {
//                        context = @"发送一张【图片】";
//                    }else
//                    {
//                        if( [[mesDic objectForKey:@"data"] objectForKey:@"msgtext"]==nil)
//                        {
//                            context =[mesDic objectForKey:@"msgtext"] ;
//                        }else
//                        {
//                            context =[[mesDic objectForKey:@"data"] objectForKey:@"msgtext"];
//                        }
//                    }
//                    NSString *megid = @"";
//                    if ( [[mesDic objectForKey:@"data"]objectForKey:@"msgid"]==nil) {
//                        megid = [mesDic objectForKey:@"msgid"] ;
//                    }else
//                    {
//                        megid = [[mesDic objectForKey:@"data"]objectForKey:@"msgid"];
//                    }
//                    NSString *openname = @"";
//                    if ( [mesDic objectForKey:@"openby"]==nil ) {
//                        openname = [[UserInfo sharedManager] username];
//                    }else
//                    {
//                        openname =[mesDic objectForKey:@"openby"];
//                    }
//                    NSString *dname = @"";
//                    if ( [mesDic objectForKey:@"dgid"]==nil) {
//                        dname = self.talkId;
//                    }else
//                    {
//                        dname = [mesDic objectForKey:@"dgid"];
//                    }
//
//                    SUser * user = [SUser new];
//                    user.titleName =dname;
//                    user.conText = context;
//                    user.contentType = @"1";
//                    user.username =openname;
//                    user.msgid =  megid;
//                    user.description = @"4";
//                    [_userDB saveUser:user];
//
//                });
//
//
//            }
//
//             if ([uidString isEqualToString:@"0"]) {
//                NSString *localid2 =  [[mesDic objectForKey:@"data"] objectForKey:@"localid"];
//                NSString *tablename =   [[NSUserDefaults standardUserDefaults] objectForKey:@"tableName"];
//                NSString *sql =[NSString stringWithFormat:@"update [%@]  set  isRead = '1'  where messageId  = '%@' ",tablename,localid2];
//                NSString *msgidd= [[NSUserDefaults standardUserDefaults] objectForKey:@"Sendsuccessful"];
//
//                if ([msgidd isEqualToString:localid2]) {
//                    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Sendsuccessful"];
//                }
//
//                [self execSql2:sql localid2:localid2];
//
//            }
//            else if([uidString isEqualToString:@"!"])
//            {
//                /*
//                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"----未读消息提醒22222----" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                 [alert show];
//                 */
//            }else if([uidString isEqualToString:@"#"])
//            {
//
//                [SQLite setSingleChatWithUserId:[[UserInfo sharedManager] username]
//                                         talkId:[mesDic objectForKey:@"dgid"]
//                                    contentType:[mesDic objectForKey:@"msgtype"]
//                                       talkType:[mesDic objectForKey:@"dtype"]
//                                      vedioPath:[[mesDic objectForKey:@"msgtype"] intValue] == 1 ? [mesDic objectForKey:@"msgpath"] : @""
//                                        picPath:[[mesDic objectForKey:@"msgtype"] intValue] == 2 ? [mesDic objectForKey:@"msgpath"] : @""
//                                        content:[mesDic objectForKey:@"msgtext"]
//                                           time:[mesDic objectForKey:@"opendatetime"]
//                                         isRead:@"1"
//                                         second:[mesDic objectForKey:@"vsec"]
//                                          MegId:[mesDic objectForKey:@"msgid"]
//                                       imageUrl:[[UserInfo sharedManager] userpicture]
//                                         openBy:[mesDic objectForKey:@"openby"]];
//
//
//
//                if ([[mesDic objectForKey:@"dgid"] isEqualToString:self.talkId]) {
//                    [self loadData3];
////                    [self pushMsg];
//                }
//
//
//                if ([[mesDic objectForKey:@"dname"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"nosave"]])
//                {
//                    NSLog(@"aa");
//
//                }else
//                {
//                    if ([self getcount:@"UNREAD2" key:@"msgid" keyvalue:[mesDic objectForKey:@"msgid"]]>0){
//
//                        return;
//                    }else
//                    {
//
//                        if ( [[mesDic objectForKey:@"dgid"]isKindOfClass:[NSNull class]]) {
//                            return;
//                        }else
//                        {
//                            NSString * dname = [mesDic objectForKey:@"dgid"];
//                            NSLog(@"%@====%@",dname,self.talkId);
//                            if (![dname isEqualToString:self.talkId]) {
//                                NSString *sql1 = [NSString stringWithFormat:
//                                                  @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@', '%@', '%@','%@','%@')",
//                                                  @"UNREAD", @"name", @"age",@"address",@"sendname",@"msgid",
//                                                  dname,
//                                                  [mesDic objectForKey:@"msgtext"],
//                                                  [mesDic objectForKey:@"dtype"],
//                                                  [mesDic objectForKey:@"openby"],
//                                                  [mesDic  objectForKey:@"msgid"]];
//                                [self execSql:sql1];
//                            }
//
//                        }
//                    }
//
//                }
//
//
//                if ([self.talkId isEqualToString:[mesDic objectForKey:@"dgid"]]) {
//
//                }else
//                {
//
//                    if (![self isConnectionAvailable]) {
//                    }
//                }
//
//            }
//            [chatSocket readDataWithTimeout:-1 tag:200];
//
//
//        }
//
//
//    }
//
//
//
//
//}
//
//- (void)renotevc
//{
//    if (socketnow >0) {
//
//        socketnow = 0;
//    }
//}
//
//
//
//
////2014.06.26 chenlihua sokcet断开后无法连接的问题
//-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//
//    // [chatSocket connectToHost:@"42.121.132.104" onPort:8480 error:nil];
//}
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
//{
//    NSLog(@"连接服务器成功");
//
//    [chatSocket readDataWithTimeout:-1 tag:200];
//
//}
//
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//
//    //    [sock disconnectAfterReadingAndWriting];
//    //    [chatSocket disconnect];
//
//    //    chatSocket = nil;
//}
//#pragma mark -内存警告
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//
//    //2014.05.28 chenlihua 解决拍照闪退的问题。
//    /*
//     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"内存警告！！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//     [alert show];
//     */
//}
//SendTexttoSever
- (void)SendTexttoSever:(NSDictionary *)jsonDic
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SendTexttoSever"object:jsonDic];
}

//{
//    NSString *jsonString=[jsonDic JSONString];
//    NSLog(@"-------------上传服务器的JSONDic--%@",jsonDic);
//    NSLog(@"---------上传服务器的JSON数据----- jsonDic %@-------",jsonString);
//
//    //2014.07.11 chenlihua 修改上传到服务器的格式，前面要加上字符数量
//    NSString *lengJson=[NSString stringWithFormat:@"%i",jsonString.length];
//    NSString *newJson=[NSString stringWithFormat:@"%@#%@\n",lengJson,jsonString];
//    NSLog(@"-----------最后上传服务器的数据---newJson--%@--",lengJson);
//    NSLog(@"-----------newJson-------%@",newJson);
//    NSData *data = [newJson dataUsingEncoding:NSUTF8StringEncoding];
//    if (![chatSocket isConnected]) {
//
//        [socketNet managerDisconnect];
//
//        chatSocket = [socketNet sharedSocketNet];
//    }
//
//    [chatSocket writeData:data withTimeout:-1 tag:300];
//
//    //提交给服务器
//
//
//
//}

#pragma -mark -自定义相机
- (void)configureNotification:(BOOL)toAdd {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTakePicture object:nil];
    if (toAdd) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackNotificationForFilter:) name:kNotificationTakePicture object:nil];
    }
}

- (void)callbackNotificationForFilter:(NSNotification*)noti {
    UIViewController *cameraCon = noti.object;
    if (!cameraCon) {
        return;
    }
    UIImage *finalImage = [noti.userInfo objectForKey:kImage];
    if (!finalImage) {
        return;
    }
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = finalImage;
    
    if (cameraCon.navigationController) {
        [cameraCon.navigationController pushViewController:con animated:YES];
    } else {
        [cameraCon presentViewController:con animated:YES completion:nil];
    }
}
-(void)sendyesorno
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"sendyesorno6"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma -mark - SCNavigationController delegate
-(void)sendSureMessage:(NSNotification *)notification
{
    
    [NSTimer scheduledTimerWithTimeInterval:.5f target:self selector:@selector(sendyesorno) userInfo:nil repeats:NO];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sendyesorno6"]);
    
    UIImage *image = [notification.userInfo objectForKey:@"POST"];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"sendyesorno6"] ) {
        
        [self enSureBtnPressedSendMessage:image];
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"sendyesorno6"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"sendyesorno6"] isEqualToString:@"0"]) {
        [self enSureBtnPressedSendMessage:image];
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"sendyesorno6"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    /*
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"11111" delegate:self cancelButtonTitle:@"2222" otherButtonTitles:nil, nil];
     [alert show];
     */
    
    
    
}

- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = image;
    
    
    [navigationController pushViewController:con animated:YES];
    
    
}
//发送照片
#pragma -mark -postViewControllerdelegate
-(void)enSureBtnPressedSendMessage:(UIImage *)image
{
    NSLog(@"---image--%@",image);
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (image) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager* fm = [NSFileManager defaultManager];
            
            NSString* string = [NSHomeDirectory() stringByAppendingString:@"/Documents/chatCacheImage"];
            
            NSLog(@"string = %@",string);
            //创建文件家
            [fm createDirectoryAtPath:string withIntermediateDirectories:YES attributes:nil error:nil];
            
            NSTimeInterval data=[[NSDate date] timeIntervalSince1970]*1000;
            NSString *timeString = [NSString stringWithFormat:@"%.0f", data];
            NSData* imageDate =  UIImageJPEGRepresentation(image, .5);
            NSString* imgPth = [string stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",timeString]];
            [imageDate writeToFile:imgPth atomically:YES];
            
            //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
            NSString *imgPthNew=[NSString stringWithFormat:@"%@.jpg",timeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.imagePath = imgPth;
                //2014.06.24 chenlihua sokcet,http上传图片，修改文件名
                self.imagePathNew=imgPthNew;
                //2014.06.23 chenlihua socket picture
                self.imageDataNew=imageDate;
                //                dispatch_queue_t queue = dispatch_queue_create("SendMessage", NULL);
                
                //                [self performSelectorOnMainThread:@selector(sendSocketMessage) withObject:nil waitUntilDone:NO];
                [NSThread detachNewThreadSelector:@selector(sendSocketMessage) toTarget:self withObject:nil];
                
                
            });
        });
        
    }
}

@end
