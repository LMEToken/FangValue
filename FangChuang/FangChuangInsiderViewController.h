
//  FangChuang
//
//  Created by chenlihua on 14-4-24.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//


#import "ParentViewController.h"
//#import "ButtonColumnView.h"
//#import "FCSearchBar.h"
//#import "CacheImageView.h"
//
//#import "PullingRefreshTableView.h"

//2014.06.07 chenlihua socket
#import "AsyncSocket.h"

#import "AsyncSocket+Single.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ZBMessageInputView.h"
#import "MessageDisplayDetailViewController.h"
#import "MBProgressHUD.h"
@class   CustomStatueBar ;
@interface FangChuangInsiderViewController : ParentViewController<AsyncSocketDelegate,MBProgressHUDDelegate>
{
    	MBProgressHUD *HUD;
    //   UITableView* myTableView;
    //改成下拉刷新
//    PullingRefreshTableView *myTableView;
    int currentPage;//页数
    
      CustomStatueBar *statueBar;
    NSMutableArray *dataArray;
//    NSMutableArray *dataArray2[4];

    NSDictionary *dataDic;
    //2014.05.21 chenlihua 定时器实现主页面的实时刷新。以在主页面获取最新消息数。
    NSTimer *timer;
    //2014.05.29 chenlihua 在方创人，项目方，投资方，对接群，有未读消息的时候，显示红点。
    NSTimer *timerSecond;
    NSString *pushtoken;
//    ButtonColumnView *topView;
    
    UILabel *unLabel0;
    UILabel *unLabel00;
    UILabel *unLabel1;
    UILabel *unLabel2;
    UILabel *unLabel3;
    
    //2014.06.19 chenlihua socket
    // AsyncSocket *socketUpdate;
    
    //2014.07.08 chenlihua 判断有没有网络
    NSTimer *timeNet;
    
    //2014.07.09 chenlihua sockete 有没有连接
    NSTimer *timerSocket;
    
    NSTimer *HttpTimer1;
    
    NSTimer *HttpTimer;
    
    NSTimer *ConnectTimer;
    
    NSTimer *reloadtime;
    int tilletext;
    
    NSMutableArray *arr;
    
    NSMutableArray *dataArray2[4];
    
    UIAlertView * promptAlert;
    
    NSInteger state;
    NSInteger onsleep;
    NSTimer *connectsockettimer;
    
    NSMutableArray *msgarr;

//接收消息存储的数组
    NSMutableArray *waitarr;
//发送消息存储的数组
    NSMutableArray *sendarr;
//要生成的群组
    NSMutableArray *creatarr;
    NSTimer *waittime;
}
@property(nonatomic,retain) NSString *unReadAll;

@property(nonatomic,retain) NSMutableArray *arrUnSendCollection;

//2014.06.24 chenlihua socket写在外面
@property(nonatomic,retain) AsyncSocket *socketUpdate;
//2014.07.01 chenlihua 使p001的账号从聊天记录跳转回方创部分的时候，会跳到t001的方创部分。
@property(nonatomic,retain) NSString *fromWhere;

- (void)downsoket;
@end
