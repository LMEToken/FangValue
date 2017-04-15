//
//  AppDelegate.h
//  FangChuang
//
//  Created by 朱天超 on 13-12-26.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMHud.h"
#import "MPNotificationView.h"
#import "LoginViewController.h"
#import "FvalueBufferVC.h"
#import "FvaMyVC.h"

#import "MobClick.h"
#import "FangChuangInsiderViewController.h"

//2014.06.19 chenlihua socket
//#import "AsyncSocket.h"





extern NSString * HaveNewMessageFromSevers; //消息通知


extern BOOL sound ; // 声音 no 开始， yes 关闭
extern BOOL shake ; // 震动 no 开启， yes 关闭
extern BOOL remind; //新消息提醒 no  开启 ， yes 关闭

@interface AppDelegate : UIResponder <UIApplicationDelegate,MPNotificationViewDelegate>
{
    ATMHud *myHud;
    NSTimer *chatTime; // 轮询及计时器
    NSString *talkType;

    //2014.06.19 chenlihua socket
//    AsyncSocket *_serverSocket;
    SUserDB * _userDB;
    
    NSMutableArray * _userData;
    
    NSMutableArray *turnButtonArray;
    NSMutableArray *chooseArray;
  
}
@property (nonatomic, strong) UIWindow * statusWindow;
@property (nonatomic, strong) UILabel * statusLabel;
@property (retain , nonatomic) NSString* talkID;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* naviController;
- (void) changeViewController : (int) _tabbarIndex;
- (void) hudShow;
- (void) hudShow : (NSString*) msg;
- (void) hudSuccessHidden;
- (void) hudSuccessHidden : (NSString*) msg;
- (void) hudFailHidden;
- (void) hudFailHidden : (NSString*) msg;

//2014.05.16 chenlihua 
@property(retain,nonatomic) NSString *openByString;

@property(nonatomic,retain)NSMutableArray *arrUnSendCollection;

//2014.06.25 chenlihua 程序在后台无限运行
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;



@end
