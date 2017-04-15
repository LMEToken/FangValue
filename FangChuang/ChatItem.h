//
//  ChatItem.h
//  QQtest
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 xipj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheImageView.h"
#import <AVFoundation/AVFoundation.h>
@interface ChatItem : UIView
{

    NSDictionary *chatDic;
    UIButton *vediobutton;
    UIView *vedioView;
    UILabel *vedioTime;
    UIImage *headImage;
    CacheImageView *contentImage;
    UIView *mesgeView;
    UILabel *contentLabel;
    AVAudioPlayer* audioPlayer;
    
    NSError* error; // 音频错误
}

@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *time;
@property (nonatomic,assign)BOOL isSelf;
@property (nonatomic)float width;
@property (nonatomic)float height;
-(void)setWithDic:(NSDictionary *)dic;
@end

