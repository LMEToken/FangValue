//
//  MyPlayer.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-16.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "sqlite3.h"
@interface MyPlayer : NSObject<AVAudioPlayerDelegate>
{
    NSMutableDictionary *NotiUrlString;
    
}
@property(nonatomic,retain) NSMutableArray *arrUnSendCollection;
@property (nonatomic , strong)    AVAudioPlayer* _player;
+ (MyPlayer*)defualtMyPlayer;
- (void)setContentUrl:(NSString*)urlUtring;
//2014.08.27 chenlihua 重新写此函数
- (void)setContentUrl:(NSMutableDictionary *)urlUtring  AndIsPlay:(NSString *)isPlay;
@end
