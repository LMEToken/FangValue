//
//  MyPlayer.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-16.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "MyPlayer.h"

static MyPlayer* _myPlayer;

@implementation MyPlayer

@synthesize arrUnSendCollection;
+(MyPlayer *)defualtMyPlayer
{
    if (_myPlayer == nil) {
        _myPlayer = [[MyPlayer alloc] init];
          
    }
    return _myPlayer;
}
//2014.08.27 chenlihua 重新写此函数
/*
- (void)setContentUrl:(NSString*)urlUtring
{
    NSError* error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if (_myPlayer._player) {
        
        NSLog(@" notiname = %@ ",[_myPlayer._player.url absoluteString]);
        //屏蔽之前的
        
        NSString* notiName = [[[_myPlayer._player.url absoluteString] componentsSeparatedByString:@"/"] lastObject];

        
        [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
        if ([notiName isEqualToString:[[urlUtring componentsSeparatedByString:@"/"] lastObject]]) {
            
            if (![_myPlayer._player play]) {
                [_myPlayer._player play];

            }
            else
            {
                [_myPlayer._player stop];

                
                _myPlayer._player = nil;
            }
            
            return ;
        }
        
        
    }
    
//    NSData* data = [NSData dataWithContentsOfFile:[url absoluteString]];
    
//    [ShowBox showError:[NSString  stringWithFormat:@"开始播放  path = %@",[url absoluteString]]];
    
    NSString* head = [urlUtring substringWithRange:NSMakeRange(0, 4)];
    NSLog(@"--------head---------%@",head);
    BOOL wang = [head isEqualToString:@"http"];
    
    NSLog(@"wang = %@",wang ? @"yes" : @"NO");
    
    NSURL* url = wang ? [NSURL URLWithString:urlUtring]: [NSURL fileURLWithPath:urlUtring];
    
    if (wang) {
        
        NSData* data = [NSData dataWithContentsOfURL:url];
        
    NSRange rang = [urlUtring rangeOfString:@".acc"];
        if (rang.location) {
            
            _myPlayer._player = [[AVAudioPlayer alloc] initWithData:data error:nil];

        }
        else
        {
            _myPlayer._player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

        }
        
    }
    else
    {
        _myPlayer._player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

    }
    //    _myPlayer._player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    [_myPlayer._player setDelegate:self];
    [_myPlayer._player setNumberOfLoops:0];
    [_myPlayer._player setVolume:10.0f];
    [_myPlayer._player prepareToPlay];
    [_myPlayer._player play];
    
    if (error) {
        [ShowBox showError:[error description]];
    }
}
*/

- (void)setContentUrl:(NSMutableDictionary *)urlUtring  AndIsPlay:(NSString *)isPlay
{
    
//    解决点击播放语音两次才会播放
    NSInteger palystate =0;
    NSLog(@"--urlUtring-%@---",  [urlUtring objectForKey:@"messageId"]);
    NSString *msgid1= [urlUtring objectForKey:@"messageId"];
    NotiUrlString=[urlUtring objectForKey:@"vedioPath"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playnow"]!=nil
     ) {
        NSString  *msgid = [[NSUserDefaults standardUserDefaults] objectForKey:@"playnow"];
        if ( [[urlUtring objectForKey:@"messageId"]  isEqualToString:msgid]) {
            [_myPlayer._player stop];
            _myPlayer = nil;
            palystate =  1;
    
        }
    }
       [[NSUserDefaults standardUserDefaults] setObject:msgid1  forKey:@"playnow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (palystate==1) {
         [[NSUserDefaults standardUserDefaults] setObject:@""  forKey:@"playnow"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         palystate =0;
    }
   //other: http://fcapp.favalue.com/data/upload/1/201409/01/0108094507452vaq.mp3
  //self:  /Users/chenlihua/Library/Application Support/iPhone Simulator/7.1/Applications/7CECC5DC-F251-4353-9739-E6E2BEEDCE8B/DocumeurlUtring	__NSCFString *	@"http://fcapp.favalue.com/data/upload/1/201409/24/2414273609633i11.mp3"	0x0d4d2e80nts/1409530798340.mp3
    
    NSError* error = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSLog(@"--player--%@----",_myPlayer._player.url);
//    if (_myPlayer._player){
//        
//        NSLog(@" notiname = %@ ",[_myPlayer._player.url absoluteString]);
//        //屏蔽之前的
//        
//      // NSString* notiName = [[[_myPlayer._player.url absoluteString] componentsSeparatedByString:@"/"] lastObject];
//        
//       NSString *notiName=[[[urlUtring objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject];
//        NSLog(@"%@",notiName);
//        //2014.09.02 chenlihua 将其去掉
//      //  [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
//        
//        if ([notiName isEqualToString:[[[urlUtring objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject]]) {
//            
//            if (![_myPlayer._player play]) {
//                [_myPlayer._player play];
//                
//            }
//            else
//            {
//                [_myPlayer._player stop];
//                
//                
//                _myPlayer._player = nil;
//            }
//            
//            return ;
//        }else{
//            
//            
//            if (![_myPlayer._player play]) {
//                [_myPlayer._player play];
//                
//            }
//            else
//            {
//                [_myPlayer._player stop];
//                
//                 _myPlayer._player = nil;
//
//            }
//            
//            return ;
//            
//        }
//        
//        
//    }
    
     
    
    //    NSData* data = [NSData dataWithContentsOfFile:[url absoluteString]];
    
    //    [ShowBox showError:[NSString  stringWithFormat:@"开始播放  path = %@",[url absoluteString]]];
    NSLog(@"%@",urlUtring);
    NSString* head = [[urlUtring objectForKey:@"vedioPath"] substringWithRange:NSMakeRange(0, 4)];
    NSLog(@"--------head---------%@",head);
    BOOL wang = [head isEqualToString:@"http"];
    
    NSLog(@"wang = %@",wang ? @"yes" : @"NO");
    
    NSURL* url = wang ? [NSURL URLWithString:[urlUtring objectForKey:@"vedioPath"]]: [NSURL fileURLWithPath:[urlUtring objectForKey:@"vedioPath"]];
    NSLog(@"---url---%@",url);
    
    
    if (wang) {
        NSData* data=nil;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"luyindata"]
        !=nil) {
            NSMutableArray *luyindata =[[NSUserDefaults standardUserDefaults] objectForKey:@"luyindata"];

            for (int i =0; i<luyindata.count; i++)
            {
                NSLog(@"%@",[luyindata objectAtIndex:i] );
                NSLog(@"%@",[urlUtring objectForKey:@"messageId"]);
                if ([[[luyindata objectAtIndex:i] objectAtIndex:0]isEqualToString:[urlUtring objectForKey:@"messageId"]]) {
                    data =[[luyindata objectAtIndex:i] objectAtIndex:1];
                }
            }
            if (data==nil) {
               
                    data = [NSData dataWithContentsOfURL:url];
                    NSArray *luyindate  = [NSArray arrayWithObjects:[urlUtring objectForKey:@"messageId"],data,nil];
                    if (!self.arrUnSendCollection)
                    {
                        arrUnSendCollection=[[NSMutableArray alloc] init];
                        NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
                        if (![unSendDefault objectForKey:@"luyindata"]) {
                            ;
                        }else{
                            arrUnSendCollection=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:@"luyindata"]];
                        }
                    }
                    [arrUnSendCollection addObject:luyindate];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:arrUnSendCollection forKey:@"luyindata"];
                    [userDefault synchronize];
                
            }
        

        }else
        {
            data = [NSData dataWithContentsOfURL:url];
            NSArray *luyindate  = [NSArray arrayWithObjects:[urlUtring objectForKey:@"messageId"],data,nil];
            if (!self.arrUnSendCollection)
            {
                arrUnSendCollection=[[NSMutableArray alloc] init];
                NSUserDefaults *unSendDefault = [NSUserDefaults standardUserDefaults];
                if (![unSendDefault objectForKey:@"luyindata"]) {
                    ;
                }else{
                    arrUnSendCollection=[[NSMutableArray alloc]initWithArray:[unSendDefault objectForKey:@"luyindata"]];
                }
            }
            [arrUnSendCollection addObject:luyindate];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:arrUnSendCollection forKey:@"luyindata"];
            [userDefault synchronize];
        }
       
  


        NSLog(@"---data---%@",data);
        // NSRange rang = [urlUtring rangeOfString:@".acc"];
        NSRange rang=[[urlUtring objectForKey:@"vedioPath"] rangeOfString:@".mp3"];
        
        
        if (rang.location) {
            
            NSLog(@"---url---%@",url);
            
            _myPlayer._player = [[AVAudioPlayer alloc] initWithData:data error:nil];
            
            NSLog(@"---myPlayer.player---%@",_myPlayer._player.url);
            
        }
        else
        {
            NSLog(@"---url---%@",url);
            
            _myPlayer._player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
           
            NSLog(@"----myPlayer.player.url---%@",_myPlayer._player.url);
            
        }
        
    }
    else
    {
        NSLog(@"--url-%@---",url);
        _myPlayer._player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        NSLog(@"---myPlayer.url--%@",_myPlayer._player.url);
        
    }
    //    _myPlayer._player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    
    
    
   // _myPlayer._player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [_myPlayer._player setDelegate:self];
    [_myPlayer._player setNumberOfLoops:0];
    [_myPlayer._player setVolume:10.0f];
    [_myPlayer._player prepareToPlay];
    [_myPlayer._player play];
    
    if (error) {
        [ShowBox showError:[error description]];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
  
    
    NSLog(@"postNotiName =%@",[[[_myPlayer._player.url absoluteString] componentsSeparatedByString:@"/"] lastObject]);
    NSString* notiName = [[[_myPlayer._player.url absoluteString] componentsSeparatedByString:@"/"] lastObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
    
    
    
    //2014.09.02 chenlihua 接受别人发来的语音的时候，播放完成之后，回原位。
    /*
    NSLog(@"-----notistr---%@",NotiUrlString);
    NSLog(@"postNotiName =%@",[[NotiUrlString componentsSeparatedByString:@"/"] lastObject]);
    NSString* notiName = [[NotiUrlString componentsSeparatedByString:@"/"] lastObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
    */
}
@end

