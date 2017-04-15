//
//  ChatItem.m
//  QQtest
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 xipj. All rights reserved.
//

#import "ChatItem.h"
#import <CoreText/CoreText.h>
//#import "ImagesCharacterArrange.h"
static AVAudioPlayer* currentAudioPlayer; // 音频播放
static UIButton* currentPlauButton; // 指向当前正在播放的 按钮
@implementation ChatItem

@synthesize content ;
@synthesize time;
@synthesize isSelf  ;
@synthesize width;
@synthesize height;


-(id)initWithFrame:(CGRect)frame
{

    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}
#pragma -mark -functions
-(void)setWithDic:(NSDictionary *)dic
{
//        self.backgroundColor=[UIColor blackColor];
        chatDic=[[NSDictionary alloc]initWithDictionary:dic];
     
//    self.backgroundColor=[UIColor blackColor];
 
        int type=[[Utils getString:[dic objectForKey:@"contentType"]] integerValue];
        switch (type) {
            case 0:
            {
//                 NSString *i_string=[Utils getString:[dic objectForKey:@"content"]];
                
                //获得图文排版后的View
//                ImagesCharacterArrange *i_imageCharact = [[ImagesCharacterArrange alloc] init];
//                mesgeView = [i_imageCharact imagesCharactersArrange:i_string maxWidth:230 peopleName:nil fontStyle:3];
                mesgeView.backgroundColor = [UIColor clearColor];
                mesgeView.frame = CGRectMake(0, 0, mesgeView.frame.size.width, mesgeView.frame.size.height);
                [self addSubview:mesgeView];
//                width=((i_imageCharact.width==230)?230:(i_imageCharact.width+20 ));
//                height=i_imageCharact.frame.size.height+5;
//                NSLog(@"i_imageCharact=====%@====%d",i_imageCharact,i_imageCharact.width);

            }
            break;
                
            case 1:
            {
//            图片
                contentImage=[[CacheImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
                contentImage.backgroundColor=[UIColor lightGrayColor];
                [self addSubview:contentImage];

                
//                NSData *data=[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[dic objectForKey:@"picPath"]]];
//                UIImage *image=[UIImage imageWithData:data];
                UIImage *image;
                if (![[dic objectForKey:@"picPath"] hasPrefix:@"http"]) {
                    UIImage *image1 = [[UIImage alloc]initWithContentsOfFile:[dic objectForKey:@"picPath"]];
                    NSLog(@"%@====image",image1);
                    image=image1;
                 }else{
                    CacheImageView *image1=[[CacheImageView alloc]init];
                    [image1 getImageFromURL:[NSURL URLWithString:[Utils getString:[dic objectForKey:@"picPath"]]]];
                    image=image1.image;
                }
                contentImage.image=image;
                if (image.size.width>120) {
                     float imageHeight=  image.size.height/(image.size.width/120.0);
                    contentImage.frame=CGRectMake(0, 0, 120, imageHeight);
                }else{
                     contentImage.frame=CGRectMake(0, 0, image.size.width, image.size.height);
                }
                width=contentImage.frame.size.width+20;
                height=contentImage.frame.size.height+10;
                NSLog(@"%@=====%f====%f",contentImage,width,height);
            }
                break;
            case 2:
            {
                NSLog(@"接收文件初始化播放器 = %@",chatDic);
                
                //初始化 播放器
                
                NSURL* url = nil;
//                if ([Utils lookDictionary:chatDic key:@"vedioPath"]) {
//                    url = [NSURL fileURLWithPath:[Utils getString:[chatDic objectForKey:@"vedioPath"] ]];
//                }
                if (url) {
                    NSError* localErr;
                    if (audioPlayer == nil && url != nil) {
                         audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&localErr];
                     }
                     //设置音量
                    [audioPlayer setVolume:10.0f];
                     //设置播放一次
                    [audioPlayer setNumberOfLoops:0];
                     //加入播放队列
                    [audioPlayer prepareToPlay];
                 }
//            语音
                vediobutton=[UIButton buttonWithType:UIButtonTypeCustom];
                [vediobutton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:vediobutton];
                vedioTime=[[UILabel alloc]init];
                
//                [Utils setDefaultLabel:vedioTime fontSize:14.0 text:@"5\""];
                
                [self addSubview:vedioTime];
            }
                break;
            default:
                break;
        }
        int talkType=[[Utils getString:[dic objectForKey:@"Type"]] integerValue];
        switch (talkType) {
            case 0:
                  [self addRightView];
                break;
            case 1:
                [self addLeftView];
                break;
            default:
                break;
        }
}
#pragma -mark -doClickAction
-(void)addLeftView
{
//Chating_duihuakuang_3@2x.png  Chating_duihuakuang_4@2x.png
    
    int type=[[Utils getString:[chatDic objectForKey:@"contentType"]] integerValue];
    switch (type) {
        case 0:
        {
            mesgeView.frame=CGRectMake(5, 0, mesgeView.frame.size.width, mesgeView.frame.size.height);
        }
             break;
         case 1:
        {
            contentImage.frame=CGRectMake(5, 0, contentImage.frame.size.width, contentImage.frame.size.height);
//            width=contentImage.frame.size.width;
//            height=contentImage.frame.size.height;
            
        }
            break;
        case 2:
        {
            
            //            语音
            
//            [vediobutton setBackgroundImage:[UIImage imageNamed:@"Chating_duihuakuang_4"] forState:UIControlStateNormal];
//            vediobutton.frame=CGRectMake(0, 0, 109, 37);
//            
//            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10,(37- 38/2)/2, 27/2, 38/2)];
//            image.image=[UIImage imageNamed:@"Chating_tubiao_1.png"];
//            [vediobutton addSubview:image];
//            [image release];
//            
//            vedioTime.frame=CGRectMake(CGRectGetMaxX(vediobutton.frame)+5, (37-38/2)/2, 27/2, 38/2);
//            
//            width=vediobutton.frame.size.width;
//            height=vediobutton.frame.size.height;
            
            
            vediobutton.frame=CGRectMake(0,0, 109, 37);
            
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10,(37- 38/2)/2, 27/2, 38/2)];
            image.image=[UIImage imageNamed:@"Chating_tubiao_1.png"];
            [vediobutton addSubview:image];

            
            vedioTime.frame=CGRectMake(109, (37-38/2)/2, 27/2, 38/2);
//            vedioTime.backgroundColor=[UIColor blackColor];
            width=109;
            height=37;
//            self.frame=CGRectMake(0, 0, 109+30, 37);
        }
            break;
        default:
            break;
    }
}
-(void)addRightView
{
    int type=[[Utils getString:[chatDic objectForKey:@"contentType"]] integerValue];
    switch (type) {
        case 0:
        {
            mesgeView.frame=CGRectMake(5, 0, mesgeView.frame.size.width, mesgeView.frame.size.height);
        }
            break;
            
        case 1:
        {
            contentImage.frame=CGRectMake(5, 0, contentImage.frame.size.width, contentImage.frame.size.height);
//            width=contentImage.frame.size.width;
//            height=contentImage.frame.size.height;
        }
            break;
        case 2:
        {
                        //            语音
            
//            [vediobutton setBackgroundImage:[UIImage imageNamed:@"Chating_duihuakuang_4"] forState:UIControlStateNormal];
            vediobutton.frame=CGRectMake(30,0, 109, 37);
            
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(109-16,(37- 38/2)/2, 27/2, 38/2)];
            image.image=[UIImage imageNamed:@"Chating_tubiao_2.png"];
            [vediobutton addSubview:image];
            
            vedioTime.frame=CGRectMake(0, (37-38/2)/2, 27/2, 38/2);
            
            width=109+30;
            height=37;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 播放声音
-(void)play:(UIButton*)button
{
    NSURL *url;
//    if ([Utils lookDictionary:chatDic key:@"vedioPath"]) {
//        url = [NSURL fileURLWithPath:[Utils getString:[chatDic objectForKey:@"vedioPath"] ]];
//    }else{
//    
//        return;
//    }

    NSData *data=[NSData dataWithContentsOfURL:url];
//    NSData *data = [NSData dataWithBytes:sounddata length:sizeof(sounddata)];
    AVAudioPlayer *newPlayer =[[AVAudioPlayer alloc] initWithData:data error: nil];
    [newPlayer play];
    NSLog(@"播放语音");
    NSLog(@"dic = %@",chatDic);
    
    return;
    if ([currentAudioPlayer isEqual:audioPlayer]) {
        
        //点击的是自己
        
        if ([audioPlayer prepareToPlay]) {
            
            [audioPlayer play];
            [vediobutton setBackgroundColor:[UIColor greenColor]];
            
        }
        else if ([audioPlayer play])
        {
            //变成暂停状态
            [audioPlayer pause];
            [vediobutton setBackgroundColor:[UIColor orangeColor]];
        }
     }
    else
    {
        //点击另外的按钮
        //首先暂停之前播放器
        [currentAudioPlayer stop];
        [currentPlauButton setBackgroundColor:[UIColor clearColor]];
        //当前的播放器播放
        [audioPlayer play];
        [vediobutton setBackgroundColor:[UIColor greenColor]];
    }
//    if (error) {
//        NSLog(@"error = %@",[error description]);
//    }
    
    //指向播放按钮
    currentPlauButton = button;
    //指向当前的播放器
    currentAudioPlayer = audioPlayer;
}
@end
