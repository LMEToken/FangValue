//
//  TalkLabel.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"
#import "AppDelegate.h"
#import "SCCommon.h"
typedef enum {
    
    TalkLabelSelf,
    TalkLabelOther,
    TalkLabelSystem
} TalkLabelStyle;
@interface TalkLabel : UIView<UIGestureRecognizerDelegate, UIActionSheetDelegate>
{
//*************文本属性*********************//

    UIImageView* bottomImageView; // 背景
    UITextView* contentLabel; //  内容框
    
    //2014.08.27 chenlihua 复制，粘贴。
    UITextView *contentTextView;
    
    NSString* contentString; // 内容
    TalkLabelStyle _talkLabelstyle;
    
    
    
    UIFont* talkFont; // 字体
//*************录音属性**********************//
    
    
    UILabel* timeLabel; // 录音时间长度
    UIButton* playButton; // 播放按钮
    UIButton* bigButton;  //全行按钮
    UILabel* readLabel; // 小红点
    int count;
    CGFloat lastScale;
    CGPoint lastPosition;
    
    NSString *isPlay;
    //播放标志
    NSString *isPlayPlay;
  //*************图片**************//
    
    
   // CacheImageView* chatImageViwe;
    UIView* view;
    UIImageView *chatImageViwe;
    
 }
@property (strong, nonatomic) UINavigationController* naviController;
@property (nonatomic , retain)    UIFont* talkFont; // 字体
@property (nonatomic , retain)    NSMutableDictionary* vedioDictionary;
@property (nonatomic , retain)    NSString* imagePath;

@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) AppDelegate* app;
//文本
- (id) initWithString:(NSString*)string style:(TalkLabelStyle)style;
//录音
- (id) initwithAudioDictionary:(NSMutableDictionary*)dic style:(TalkLabelStyle)style;
//图片
- (id) initWithPicture:(NSString*)imgPath style:(TalkLabelStyle)style;
@end
