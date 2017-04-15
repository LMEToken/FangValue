//
//  ChatWithFriendViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FaceBoard.h"
#import "PullingRefreshTableView.h"
#import <AVFoundation/AVFoundation.h>
#import "ZYQAssetPickerController.h"
#import "GCPlaceholderTextView.h"
#import "SDBManager.h"
#import "SUserDB.h"
#import "SUser.h"

#import "MessageDisplayViewController.h"
//2014.09.12 chenlihua 自定义相机
#import "SCNavigationController.h"
#import "PostViewController.h"

#import "FvalueIndexVC.h"
#import "AppDelegate.h"
#import "SetUPCell.h"
#import "LTBounceSheet.h"
#import "LCVoiceHud.h"
#import "SDImageCache.h"

#import "FangChuangInsiderViewController.h"
#import "PersonalDataVC.h"
#import "FvaluePeopleData.h"
@class  CustomStatueBar;
@interface ChatWithFriendViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PullingRefreshTableViewDelegate,ZYQAssetPickerControllerDelegate,UIApplicationDelegate,SCNavigationControllerDelegate,AVAudioRecorderDelegate>

{
    
    UIButton* infoBtn;
    LCVoiceHud * voiceHud_;
    NSTimer * timer_;
    NSMutableArray *messages;
    //aaa
    //表情键盘
    UIView *faceBorad;
    BOOL isFaceBoradShow;
    //聊天控件
    UIView *_talkView;
    GCPlaceholderTextView *_talkTextView;
    UIButton *_sendBtn;
    PullingRefreshTableView *_tabelView;
    
    UIButton *yuyingBtn;
    UIButton* keyBoradBtn;
    UIButton *addBtn;
    UIButton *showBtn;
    UIImageView *backImgV;
    
    //    FaceBoard *faceBoard;
    UIButton *faceBtn ;
    UIButton *inputVoiceBtn;
    UIImageView *imv; //输入对话内容的框
    FaceBoard *faceBoard;
    
    BOOL isYuYing;
    NSMutableArray* talkArray;
    BOOL chatType; //  yes群聊， no单聊
    int contentType; // 0 文本 ， 1 语音  2 图片
    
    AVAudioRecorder* audioRecorder; // 录音
    
    CGPoint currentPoint;
    
    //2014.05.23 chenlihua 解决有网后，断网时未发送的消息重新发送的问题。
    NSTimer *timer;
    
    //2014.07.09 chenlihua socket重连
    NSTimer *charTimer;
    
    SUserDB * _userDB;
    
    NSMutableArray * _userData;
    //当前时间
    NSString* dateString2;
    
    NSArray *savearr;
    NSMutableArray *typearr;
    
    UIButton *mybutton;
    
    //    NSMutableArray *dataArray;
    BOOL hideen;
    
    NSInteger currentIndex;
    NSMutableArray *dataArray[4] ;
//    xAppDelegate *_app;
    UIImageView *voiceview;
    NSTimer *timerhttp;
    
    //测试使用
    NSTimer *cishisend;
    //测试
    NSInteger cishistr;
    
    NSInteger jishu;
    
    
}

@property(nonatomic,retain) AVAudioRecorder * recorder;
@property(nonatomic) float recordTime;
@property (nonatomic , retain)    UIFont* talkFont; // 字体
@property(nonatomic,retain) NSString * recordPath;
@property (nonatomic , assign) BOOL        isFaceBoard;  // 标识是否弹出表情  yes表示当前是表情状态  no表示当前是键盘状态
@property (nonatomic , retain) NSString* vedioPath; //本地录音路径
@property (nonatomic , assign) NSTimeInterval vedioSecond;//录音时长
@property (nonatomic , retain) NSString* imagePath; //本地图片路径
@property (nonatomic , retain) NSString* talkId; // 回话ID；
@property (nonatomic , retain) NSString* titleName;

@property (nonatomic,strong) NSString* memberCount;
@property (nonatomic,strong) NSString* entrance;
@property (nonatomic,strong) NSDictionary* contactInfo;

@property (nonatomic,strong)NSString *qunzhuname;//群主名字
@property (nonatomic,retain) NSString *userName;

@property (nonatomic,retain) NSString  *isSelfString;

//2014.04.30 chenlihua 点击联系人界面的头像，弹出详细信息
@property (nonatomic,retain) NSString   *openByString;
//2014.05.17 chenlihua 判断是否由推送，跳转过来的标志。
@property (nonatomic,retain) NSString *isPushString;

//2014.05.22 chenlihua 是否有未读消息数提示。
@property (nonatomic,retain)NSString *unSendFlag;



@property(nonatomic,retain) NSString *msgText;


//2014.05.23 chenlihua

@property(nonatomic,retain) NSMutableArray *allUnSendArr;
@property(nonatomic,retain) NSMutableArray *arrUnSendCollection;
@property(nonatomic,retain) NSString *isFirst;


//2014.06.19 chenlihua socket
//@property(nonatomic,retain) AsyncSocket *chatSocket;
//2014.06.23 chenlihua socket picture
@property(nonatomic,retain) NSData *imageDataNew;
//2014.06.24 chenlihua socket,http上传图片，修改图片名
@property(nonatomic,retain) NSString *imagePathNew;
//2014.06.24 chenlihua socket,http上传语音，修改语音名
@property(nonatomic,retain) NSString *vedioPathNew;


//2014.07.01 chenlihua 使p001的账号从聊天记录跳转回方创部分的时候，会跳到t001的方创部分。
@property(nonatomic,retain) NSString *where;

//2014.07.03 chenlihua 当从添加群组界面选群修改名称后，跳到群聊天界面，没有显示群组的名字。
@property(nonatomic,retain) NSString *changeName;
@property(nonatomic,retain) NSString *flagView;
@property(nonatomic,retain) NSString *flagContact;

- (void)sendSocketMessage;
-(void)enSureBtnPressedSendMessage:(UIImage *)image;


@end


