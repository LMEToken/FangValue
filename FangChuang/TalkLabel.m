

//
//  TalkLabel.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//文本，录音，图片的一些设置
#import "TalkLabel.h"
#import "MyPlayer.h"
#import "AppDelegate.h"
#import "SQLite.h"

//214.08.21 chenlihua 修改本地缓存方式
#import "UIImageView+WebCache.h"

/*
#define MAXWIDTH  (160)
#define MINHEIGHT (20)
*/

//2014.05.26 chenlihua 解决当自己的聊天内容比较多时，会跑到边上，超出手机的宽度。
//#define MAXWIDTH  (125)
//2014.08.21 chenlihua 修改聊天框的宽度。
//2014.09.05 chenlihua 收到别人发来的消息的时候，文本会超出屏幕的范围。
#define MAXWIDTH (200)
#define MINHEIGHT (20)



/*********** 小红点label *************/
@interface UILabel (RedRound)
- (id) initRedRoundWithOrigin:(CGPoint)point;


@end

@implementation UILabel (RedRound)

/*
- (id)initRedRoundWithOrigin:(CGPoint)point
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 15, 15)];
    if (self) {
        
        [self.layer setCornerRadius:10];
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor redColor]];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:2.f];
        
    }
    return self;
}
*/
//2014.08.21 chenlihua 修改语音的小红点。
- (id)initRedRoundWithOrigin:(CGPoint)point
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 9, 9)];
    if (self) {
        
        [self.layer setCornerRadius:5];
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor redColor]];
      
        
    }
    return self;
}


@end


@implementation TalkLabel

@synthesize talkFont;

- (void)dealloc
{
    
    //注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[[[self.vedioDictionary objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject] object:nil];
    
    self.vedioDictionary = nil;
    self.talkFont = nil;
     view=nil;
    [super dealloc];
   
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//获得显示框的size
-(CGSize)sizeForContentWithString:(NSString*)content
{
    CGSize size;
// 首先算宽度
    size = [content sizeWithFont:self.talkFont constrainedToSize:CGSizeMake(MAXFLOAT,  20) lineBreakMode:NSLineBreakByWordWrapping];
//宽度大于150 ， 计算适配高度
    if (size.width > MAXWIDTH) {
         size = [content sizeWithFont:self.talkFont constrainedToSize:CGSizeMake(MAXWIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
         return size;
    }
    return size;
}
#pragma -mark -functions
- (id) initWithString:(NSString*)string style:(TalkLabelStyle)style
{
    self = [super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        //设置字体默认值
        self .talkFont = [UIFont fontWithName:KUIFont size:13];
        _talkLabelstyle = style;

        
        NSString *newStr=string;
        //[string stringByReplacingOccurrencesOfString:@" " withString:@""];
        CGSize size = [self sizeForContentWithString:newStr];

        CGFloat height = size.height > 20 ? size.height - 20: 0;

        switch (_talkLabelstyle) {
            case TalkLabelSelf:
            {
                //2014.08.21 chenlihua 修改框的高度
              [self setFrame:CGRectMake(60 + (190 - size.width - 30),  20, size.width + 40, 67 / 2. + height)];
                
                //2014.04.22 chenlihua 把聊天内容改为头像+昵称+内容+日期
               // [self setFrame:CGRectMake(60 + (190 - size.width - 30), 25, size.width + 30, 67 / 2. + height)];
                //消处外面黄色的框
               // UIImage* bmImg = [UIImage imageNamed:@"48_kuang_2"];
                UIImage* bmImg = [UIImage imageNamed:@"chat1"];
                
                //试试重绘image
                //失败
//                UIGraphicsBeginImageContext(self.bounds.size);
//                [bmImg drawInRect:self.bounds];
//                UIImage* NwbmImg = UIGraphicsGetImageFromCurrentImageContext();
//                UIGraphicsEndImageContext();
//                //九宫格处理图片
                
              //  bmImg = [bmImg stretchableImageWithLeftCapWidth:100 topCapHeight:60];
                bmImg = [bmImg stretchableImageWithLeftCapWidth:100 topCapHeight:60];
                
                //添加背景图
                bottomImageView = [[UIImageView alloc] initWithFrame:self.bounds];
                [bottomImageView setImage:bmImg];
                [self addSubview:bottomImageView];
                [bottomImageView release];
            }
                break;
            case TalkLabelOther:
            {
                //2014.08.21 chenlihua 修改框的高度。
                [self setFrame:CGRectMake(60,20, size.width + 30, 77 / 2. + height)];
                
                
                //白色的背景图
                UIImage* bmImg = [UIImage imageNamed:@"chat8"];
                //九宫格处理图片
                bmImg = [bmImg stretchableImageWithLeftCapWidth:100 topCapHeight:90];
                
                //添加背景图
                bottomImageView = [[UIImageView alloc] initWithFrame:self.bounds];
                [bottomImageView setImage:bmImg];
                [self addSubview:bottomImageView];
                [bottomImageView release];
            }
                break;
                case TalkLabelSystem:
            {
                [self setFrame:CGRectMake(55, 23, 220, 70 / 2. + height)];
                // [self setFrame:CGRectMake(70, 20, size.width + 30, 67 / 2. + height)];
             
                //白色的背景图
                UIImage* bmImg = [UIImage imageNamed:@"chat7"];
                //九宫格处理图片
                bmImg = [bmImg stretchableImageWithLeftCapWidth:90 topCapHeight:110];
                
                UIImageView *bmimae = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 220 ,self.bounds.size.height)];
                
                [bmimae setImage:[UIImage imageNamed:@"chat7"]];
                [self addSubview:bmimae];
                [bmimae release];
                //添加背景图
//                bottomImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//                [bottomImageView setImage:bmImg];
//                [self addSubview:bottomImageView];
//                [bottomImageView release];
            }
                break;
            default:
                break;
        }
        //添加内容
       /* contentLabel = [[UITextView alloc] initWithFrame:CGRectMake( _talkLabelstyle == TalkLabelOther ? 7: 5
                                                                     , 0, size.width+10
                                                                     , size.height+ 20)];
        */
        contentLabel = [[UITextView alloc] initWithFrame:CGRectMake( _talkLabelstyle == TalkLabelOther?((self.frame.size.width-size.width-10)/2)+2:((self.frame.size.width-size.width-10)/2)-7, 0, size.width+10,size.height+ 20)];
       
        contentLabel.backgroundColor = [UIColor clearColor];
       [contentLabel setFont:[UIFont fontWithName:KUIFont size:13]];
       [contentLabel setText:newStr];
        
        if (_talkLabelstyle==TalkLabelSystem) {
            
            [contentLabel setTextColor:[UIColor whiteColor]];
            contentLabel.textAlignment=UITextAlignmentCenter;
            contentLabel.frame = CGRectMake(self.bounds.origin.x+0, self.bounds.origin.y-5, 200 ,self.bounds.size.height+100);
            [contentLabel setFont:[UIFont fontWithName:KUIFont size:13]];
            contentLabel.backgroundColor=[UIColor clearColor];
            [contentLabel setText:newStr];
        }

//        contentLabel = [[UILabel alloc] initWithFrame:CGRectInset(bottomImageView.frame, 20, 67/4. - 20 / 2.)];
//        [contentLabel setFont:self.talkFont];
        // [contentLabel setBackgroundColor:[UIColor clearColor]];
        //2014.07.27 chenlihua 去掉其中的换行符
         contentLabel.editable=NO;
         contentLabel.scrollEnabled=NO;
       
//        [contentLabel setNumberOfLines:0];
//        [contentLabel setTextAlignment:_talkLabelstyle == TalkLabelOther ? NSTextAlignmentLeft : NSTextAlignmentRight];
       // contentLabel.textColor=[UIColor clearColor];
//        [contentLabel setBaselineAdjustment:UIBaselineAdjustmentNone];
//        [contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [contentLabel setBackgroundColor:[UIColor clearColor]];
        
        
         [self addSubview:contentLabel];
         [contentLabel release];

        //2014.08.27 chenlihua 复制，粘贴。
        //添加内容
//        self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.height,self.bounds.size.width );
        NSLog(@"%f",self.bounds.size.height);
//
//    contentTextView = [[[UITextView alloc] initWithFrame: CGRectMake( _talkLabelstyle == TalkLabelOther ? 20-10 : 10-10, 67/4. - 20 / 2.-5, contentLabel.frame.size.width+50, contentLabel.frame.size.height+50)] autorelease];
//        [contentTextView setFont:[UIFont fontWithName:KUIFont size:13]];
//        
////
////       contentTextView = [[UITextView alloc] initWithFrame: CGRectMake( _talkLabelstyle == TalkLabelOther ? 20-5 : 10-5, 67/4. - 20 / 2.-5, contentLabel.frame.size.width+20, contentLabel.frame.size.height+30)];
//
//        NSLog(@"%@",string);
//        contentTextView.text=string;
//
////        [contentTextView setFont:self.talkFont];
//       contentTextView.textColor=[UIColor clearColor];
//      contentTextView.editable=NO;
////     contentTextView.scrollEnabled=NO;
////
//       contentTextView.textAlignment=NSTextAlignmentLeft;
//
//        contentTextView.textColor=[UIColor clearColor];
//      //  contentTextView.textAlignment=NSTextAlignmentLeft;
//
//        contentTextView.backgroundColor=[UIColor clearColor];
//        [self addSubview:contentTextView];

    
       
    }
    return self;
}
- (id) initwithAudioDictionary:(NSMutableDictionary*)dic style:(TalkLabelStyle)style
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.vedioDictionary = dic;
         _talkLabelstyle = style;
        NSLog(@"cell  noti  = %@",[[[self.vedioDictionary objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject]);
        NSString* notiName = [[[self.vedioDictionary objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject];

    //注册通知
        //停止播放通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay:) name:notiName object:nil];

    switch (_talkLabelstyle) {
    case TalkLabelSelf:
        {
            
           [self setFrame:CGRectMake(205, 20, 60, 67 / 2.)];
            //黄色的聊天消息背景图片
            //UIImage* bmImg = [UIImage imageNamed:@"48_kuang_2"];
            UIImage* bmImg = [UIImage imageNamed:@"chat1"];
            //九宫格处理图片
            bmImg = [bmImg stretchableImageWithLeftCapWidth:36 topCapHeight:40];
            //试试重绘image
            //失败
            //                UIGraphicsBeginImageContext(self.bounds.size);
            //                [bmImg drawInRect:self.bounds];
            //                bmImg = UIGraphicsGetImageFromCurrentImageContext();
            //                UIGraphicsEndImageContext();
            
            
            //2014.08.30 chenlihua 通过时间的长短来判断底图的长度。
            /*
            NSString *soundTimer=[self.vedioDictionary objectForKey:@"second"];
            if ([soundTimer intValue]<5.0) {
                 bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0,60 , 67 / 2.)];
            }else{
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0,100 , 67 / 2.)];
            }
            */
            
            //将图片的长度细分
            /*
            NSString *soundTimerStr=[self.vedioDictionary objectForKey:@"second"];
            if ([soundTimerStr intValue]>30) {
                  bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(130-30*4, 0,60+30*4 , 67 / 2.)];
            }else{
                  bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(130-[soundTimerStr intValue]*4, 0,60+[soundTimerStr intValue]*4 , 67 / 2.)];
            }
            */
           
            NSLog(@"%@",[self.vedioDictionary objectForKey:@"second"]);
            //添加背景图
            NSString *str = [self.vedioDictionary objectForKey:@"second"];
            NSInteger content = [[str stringByReplacingOccurrencesOfString:@"''"withString:@""] intValue];
         
           bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0-content*2, 0,60+content*2 , 67 / 2.)];
            [bottomImageView setImage:bmImg];
           [self addSubview:bottomImageView];
        
            [bottomImageView release];
            
//            Chating_tubiao_2@2x   27 * 38
            
            //播放按钮
            playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [playButton setBackgroundImage:[UIImage imageNamed:@"Chating_tubiao_2@2x"] forState:UIControlStateNormal];
            [playButton setBackgroundImage:[UIImage imageNamed:@"Chating_tubiao_1@2x"] forState:UIControlStateSelected];
            [playButton setFrame:CGRectMake(35 , 10, 14, 16)];
            //CGRectMake(CGRectGetWidth(self.frame) - 10 - 27 / 2., CGRectGetHeight(self.frame)/ 2. - 38 / 4., 27/ 2., 38 / 2.)];
           [playButton addTarget:self action:@selector(playRecode:) forControlEvents:UIControlEventTouchUpInside];
           [self addSubview:playButton];
            
            //时间Label
            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(bottomImageView.frame)-55, CGRectGetMinY(bottomImageView.frame) +15, 50, 15)];
            [timeLabel setBackgroundColor:[UIColor clearColor]];
            [timeLabel setText:[NSString stringWithFormat:@"%@",[self.vedioDictionary objectForKey:@"second"]]];
            [timeLabel setTextAlignment:NSTextAlignmentRight];
            [timeLabel setFont:[UIFont fontWithName:KUIFont size:12]];
            timeLabel.textColor = [UIColor grayColor];
            [self addSubview:timeLabel];
            [timeLabel release];
//            
//            //消息背景按钮
            bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bigButton setFrame:bottomImageView.frame];
            [bigButton addTarget:self action:@selector(playRecode:) forControlEvents:UIControlEventTouchUpInside];
            [bigButton setShowsTouchWhenHighlighted:YES];
            bigButton.backgroundColor=[UIColor clearColor];
            [self addSubview:bigButton];
        }
        break;
    case TalkLabelOther:
        {
            
            
            
            [self setFrame:CGRectMake(55, 20, 190, 67 / 2.)];
          
            
            
            
            UIImage* bmImg = [UIImage imageNamed:@"chat8"];
            //九宫格处理图片
            bmImg = [bmImg stretchableImageWithLeftCapWidth:150 topCapHeight:40];
            
            
            //2014.08.30 chenlihua 通过时间的长短来判断底图的长度。
            /*
            NSString *soundTimer=[self.vedioDictionary objectForKey:@"second"];
            if ([soundTimer intValue]<5.0) {
               bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 60, 67 / 2.)];
            }else{
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 100, 67 / 2.)];
            }
            */
            
            //将图片的长度细分
            /*
            NSString *soundTimer=[self.vedioDictionary objectForKey:@"second"];
            if ([soundTimer intValue]>20) {
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 60+4*20, 67 / 2.)];
            }else{
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 60+4*[soundTimer intValue], 67 / 2.)];
            }
            */
            NSString *str = [self.vedioDictionary objectForKey:@"second"];
            NSInteger content = [[str stringByReplacingOccurrencesOfString:@"''"withString:@""] intValue];
            //添加背景图
            bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 60+content*2, 67 / 2.)];
            
            [bottomImageView setImage:bmImg];
            [self addSubview:bottomImageView];
            [bottomImageView release];
        
             NSLog(@"----isPlayPlay--%@----",[NSString stringWithFormat:@"%@",
                                              isPlayPlay]);
            
            //2014.08.30 chenlihua 将红点去掉
            /*
            if ([isPlayPlay isEqualToString:@"YES"]) {
                
                if (readLabel) {
                    [readLabel removeFromSuperview];
                    readLabel = nil ;
                }

                
            }else{
                
                
                if ([[self.vedioDictionary objectForKey:@"isRead"] intValue] != 2) {
                    //添加未读红点
                    readLabel = [[UILabel alloc] initRedRoundWithOrigin:CGPointMake(CGRectGetMaxX(bottomImageView.frame ) + 10, ( 67 / 2. - 15) / 2.)];
                    [self addSubview:readLabel];
                    [readLabel release];
                }

            }
           */
            
            
            
            
            
            
            
// Chating_tubiao_1@2x
            
            //播放按钮
            playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [playButton setBackgroundImage:[UIImage imageNamed:@"Chating_tubiao_1@2x"] forState:UIControlStateNormal];
            [playButton setBackgroundImage:[UIImage imageNamed:@"Chating_tubiao_2@2x"] forState:UIControlStateSelected];
            [playButton setFrame:CGRectMake(CGRectGetMinX(bottomImageView.frame) + 10, CGRectGetHeight(bottomImageView.frame)/ 2. - 38 / 4., 27/ 2., 38 / 2.)];
            [playButton addTarget:self action:@selector(playRecode:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:playButton];
            
            //时间Label
//            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(playButton.frame) + 5, CGRectGetMinY(playButton.frame) + 4.5, 50, 10)];
//            [timeLabel setBackgroundColor:[UIColor clearColor]];
//            [timeLabel setText:[NSString stringWithFormat:@"%@\"",[self.vedioDictionary objectForKey:@"second"]]];
//            [timeLabel setTextAlignment:NSTextAlignmentLeft];
//            [timeLabel setFont:[UIFont fontWithName:KUIFont size:10]];
//            [self addSubview:timeLabel];
//            [timeLabel release];
            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(bottomImageView.frame) +33+content*2,CGRectGetMinY(bottomImageView.frame) +10, 50, 15)];
            [timeLabel setBackgroundColor:[UIColor clearColor]];
            [timeLabel setText:[NSString stringWithFormat:@"%@''",[self.vedioDictionary objectForKey:@"second"]]];
            [timeLabel setTextAlignment:NSTextAlignmentRight];
            [timeLabel setFont:[UIFont fontWithName:KUIFont size:12]];
            timeLabel.textColor = [UIColor grayColor];
            [self addSubview:timeLabel];
            [timeLabel release];
            
            //消息背景按钮
            bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bigButton setFrame:bottomImageView.frame];
            [bigButton addTarget:self action:@selector(playRecode:) forControlEvents:UIControlEventTouchUpInside];
            [bigButton setShowsTouchWhenHighlighted:YES];
            [self addSubview:bigButton];
        }
        break;
    default:
        break;
    }
    }
    return self;
}
// 图片初始化
- (id) initWithPicture:(NSString*)imgPath style:(TalkLabelStyle)style
{

    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.imagePath = imgPath;
        _talkLabelstyle = style;
        
        switch (_talkLabelstyle) {
            case TalkLabelSelf:
            {
                [self setFrame:CGRectMake(170, 20, 90, 67 )];
               // UIImage* bmImg = [UIImage imageNamed:@"48_kuang_2"];
                UIImage* bmImg = [UIImage imageNamed:@"chat1"];
                //九宫格处理图片
                bmImg = [bmImg stretchableImageWithLeftCapWidth:36 topCapHeight:40];
                
                //试试重绘image
                //失败
                //                UIGraphicsBeginImageContext(self.bounds.size);
                //                [bmImg drawInRect:self.bounds];
                //                bmImg = UIGraphicsGetImageFromCurrentImageContext();
                //                UIGraphicsEndImageContext();
                
                
//                sself.backgroundColor = [UIColor redColor];
                //添加背景图
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 57, 57)];
                bottomImageView.layer.cornerRadius =5 ;//设置那个圆角的有多圆
                bottomImageView.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
                bottomImageView.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
               bottomImageView.layer.masksToBounds = YES;
                [bottomImageView setImage:bmImg];
                [self addSubview:bottomImageView];
                [bottomImageView release];
                
                //            Chating_tubiao_2@2x   27 * 38
                
                /*
                chatImageViwe = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bottomImageView.frame) - 67 - 20, CGRectGetMinY(bottomImageView.frame) + 5, 57, 57)];
                [chatImageViwe setContentMode:UIViewContentModeScaleAspectFit];
                 */
                //[chatImageViwe getImageFromURL:[NSURL URLWithString:self.imagePath]];
                
                //2014.08.21 chenlihua 修改图片缓存方式
                chatImageViwe = [[UIImageView alloc] initWithFrame:
                             
                                 CGRectMake(CGRectGetMaxX(bottomImageView.frame) - 58, CGRectGetMinY(bottomImageView.frame) , 55, 57)];
                chatImageViwe.layer.cornerRadius = 5;//设置那个圆角的有多圆
                chatImageViwe.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
                chatImageViwe.layer.borderColor = [[UIColor greenColor] CGColor];//设置边框的颜色
                chatImageViwe.layer.masksToBounds = YES;
//                [chatImageViwe setContentMode:UIViewContentModeScaleAspectFit];

                               
                
                
                [self addSubview:chatImageViwe];
                [chatImageViwe release];
                
                
                //获取本地图片
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSLog(@"%@",imgPath);
                    UIImage* image = [UIImage imageWithContentsOfFile:imgPath];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@",image);
                        [chatImageViwe setImage:image];
//                        [bottomImageView setImage:image];
                    });
                });
                UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:bottomImageView.frame];
                [button addTarget:self action:@selector(lookBigPicture:) forControlEvents:UIControlEventTouchUpInside];
                [button setShowsTouchWhenHighlighted:YES];
                [self addSubview:button];
                
            }
                break;
            case TalkLabelOther:
            {
                
                [self setFrame:CGRectMake(60, 20, 90, 67 )];
                
                UIImage* bmImg = [UIImage imageNamed:@"chat8"];
                //九宫格处理图片
                
                bmImg = [bmImg stretchableImageWithLeftCapWidth:60 topCapHeight:40];
                
                //添加背景图
                bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,57, 57)];
                bottomImageView.layer.cornerRadius =5 ;//设置那个圆角的有多圆
                bottomImageView.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
                bottomImageView.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
                bottomImageView.layer.masksToBounds = YES;
               [bottomImageView setImage:bmImg];
                [self addSubview:bottomImageView];
                [bottomImageView release];
                
                //            Chating_tubiao_1@2x
                
                
                
                /*
                chatImageViwe = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(bottomImageView.frame) + 20, CGRectGetMinY(bottomImageView.frame) + 5, 57, 57)];
                NSLog(@"---self.imagepATH--%@",self.imagePath);
                [chatImageViwe getImageFromURL:[NSURL URLWithString:self.imagePath]];
                */
                //2014.08.21 chenlihua 修改图片缓存
                chatImageViwe = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(bottomImageView.frame)+4, CGRectGetMinY(bottomImageView.frame) , 54, 57)];
                [chatImageViwe setImageWithURL:[NSURL URLWithString:self.imagePath]];
                NSLog(@"%f",chatImageViwe.frame.size.width);

                chatImageViwe.layer.cornerRadius =5 ;//设置那个圆角的有多圆
                chatImageViwe.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
                chatImageViwe.layer.borderColor = [[UIColor whiteColor] CGColor];//设置边框的颜色
                chatImageViwe.layer.masksToBounds = YES;
                
                
//                [chatImageViwe setContentMode:UIViewContentModeScaleAspectFit];
                [self addSubview:chatImageViwe];
                [chatImageViwe release];
                
                
                
                
                //                //获取本地图片
                //                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //
                //                    UIImage* image = [UIImage imageWithContentsOfFile:self.imagePath];
                //
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        [chatImageViwe setImage:image];
                //                    });
                //                });
                
                //图片放大button
                UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:bottomImageView.frame];
                [button addTarget:self action:@selector(lookBigPicture:) forControlEvents:UIControlEventTouchDown];//lookBigPicture
                [button setShowsTouchWhenHighlighted:YES];
                [self addSubview:button];
                
                
            }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}


#pragma  -mark -doClickAction
//播放
//2014.08.27 chenlihua 重新写播放部分
//上为最源始的播放
/*
- (void)playRecode:(UIButton*)button
{
    
        NSLog(@"-------点击播放--------");
        
        NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
        NSLog(@"-------talkId-----%@",[self.vedioDictionary objectForKey:@"talkId"]);
        NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
        NSLog(@"-------ID-----%@",[self.vedioDictionary objectForKey:@"ID"]);
        NSLog(@"-------isRead-----%@",[self.vedioDictionary objectForKey:@"isRead"]);
        NSLog(@"-------vedioPath-----%@",[self.vedioDictionary objectForKey:@"vedioPath"]);
        
        //    处理未读
        if (_talkLabelstyle == TalkLabelOther) {
            
            NSString* isRead = [self.vedioDictionary objectForKey:@"isRead"];
            if ([isRead intValue] != 2) {
                //处理未读
                
                BOOL resualt = [SQLite setReadWithUserId:[self.vedioDictionary objectForKey:@"userId"] talkId:[self.vedioDictionary objectForKey:@"talkId"] ID:[self.vedioDictionary objectForKey:@"ID"]];
                if (resualt) {
                    [self.vedioDictionary setObject:@"2" forKey:@"isRead"];
                }
                
                NSLog(@"resualt = %@",resualt ? @"yes" : @"NO");
                
                if (readLabel) {
                    [readLabel removeFromSuperview];
                    readLabel = nil ;
                }
            }
        }
        printf(__FUNCTION__);
        [playButton setSelected:YES];
        [[MyPlayer defualtMyPlayer] setContentUrl:[self.vedioDictionary objectForKey:@"vedioPath"]];
       // [[MyPlayer defualtMyPlayer] setContentUrl:[self.vedioDictionary objectForKey:@"vedioPath"] AndIsPlay:isPlay];

 }
*/
//播放

//- (void)playRecode:(UIButton*)button
//{
//   
//       isPlayPlay=@"YES";
//    
//        NSLog(@"-------点击播放--------");
//        
//        NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
//        NSLog(@"-------talkId-----%@",[self.vedioDictionary objectForKey:@"talkId"]);
//        NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
//        NSLog(@"-------ID-----%@",[self.vedioDictionary objectForKey:@"ID"]);
//        NSLog(@"-------isRead-----%@",[self.vedioDictionary objectForKey:@"isRead"]);
//        NSLog(@"-------vedioPath-----%@",[self.vedioDictionary objectForKey:@"vedioPath"]);
//    
//    
//        //    处理未读
//        if (_talkLabelstyle == TalkLabelOther) {
//            
//            NSString* isRead = [self.vedioDictionary objectForKey:@"isRead"];
//            if ([isRead intValue] != 2) {
//                //处理未读
//                
//                BOOL resualt = [SQLite setReadWithUserId:[self.vedioDictionary objectForKey:@"userId"] talkId:[self.vedioDictionary objectForKey:@"talkId"] ID:[self.vedioDictionary objectForKey:@"ID"]];
//                if (resualt) {
//                    [self.vedioDictionary setObject:@"2" forKey:@"isRead"];
//                }
//                
//                NSLog(@"resualt = %@",resualt ? @"yes" : @"NO");
//                
//                if (readLabel) {
//                    [readLabel removeFromSuperview];
//                    readLabel = nil ;
//                }
//            }
//            
//            if ([isPlayPlay isEqualToString:@"YES"]) {
//                if (readLabel) {
//                    [readLabel removeFromSuperview];
//                    readLabel = nil ;
//                }
//
//            }
//        }
//        printf(__FUNCTION__);
//        [playButton setSelected:YES];
//        [[MyPlayer defualtMyPlayer] setContentUrl:[self.vedioDictionary objectForKey:@"vedioPath"] AndIsPlay:isPlay];
//    
//    
//}

//2014.08.29 chenlihua 重新写播放

- (void)playRecode:(UIButton*)button
{
    
    isPlayPlay=@"YES";
    
    NSLog(@"-------点击播放--------");
    
    NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
    NSLog(@"-------talkId-----%@",[self.vedioDictionary objectForKey:@"talkId"]);
    NSLog(@"-------userID-----%@",[self.vedioDictionary objectForKey:@"userId"]);
    NSLog(@"-------ID-----%@",[self.vedioDictionary objectForKey:@"ID"]);
    NSLog(@"-------isRead-----%@",[self.vedioDictionary objectForKey:@"isRead"]);
    NSLog(@"-------vedioPath-----%@",[self.vedioDictionary objectForKey:@"vedioPath"]);
    
    /*2014.08.30 chenlihua 将红点去掉
    //    处理未读
    if (_talkLabelstyle == TalkLabelOther) {
        
        NSString* isRead = [self.vedioDictionary objectForKey:@"isRead"];
        if ([isRead intValue] != 2) {
            //处理未读
            
            BOOL resualt = [SQLite setReadWithUserId:[self.vedioDictionary objectForKey:@"userId"] talkId:[self.vedioDictionary objectForKey:@"talkId"] ID:[self.vedioDictionary objectForKey:@"ID"]];
            if (resualt) {
                [self.vedioDictionary setObject:@"2" forKey:@"isRead"];
                
                
               NSUserDefaults *readDefaults = [NSUserDefaults standardUserDefaults];
                [readDefaults setObject:self.vedioDictionary forKey:@"clhRead"];
                [readDefaults synchronize];
                
            }
            
            NSLog(@"resualt = %@",resualt ? @"yes" : @"NO");
            
            if (readLabel) {
                [readLabel removeFromSuperview];
                readLabel = nil ;
            }
        }
        
        if ([isPlayPlay isEqualToString:@"YES"]) {
            if (readLabel) {
                [readLabel removeFromSuperview];
                readLabel = nil ;
            }
            
        }
     
    }
     */
   
    printf(__FUNCTION__);
    //[playButton setSelected:YES];
    //使每次重新播放的时候，不跳转画面。
    [playButton setSelected:NO];
 
    /*
    if (playButton.selected) {
        [playButton setSelected:NO];
    }else{
        [playButton setSelected:YES];
    }
    */

    NSLog(@"%@",self.vedioDictionary);
    
    [[MyPlayer defualtMyPlayer] setContentUrl:self.vedioDictionary AndIsPlay:isPlay];
  
    
}
//2014.08.29 chenlihua 重新播放

// 更改播放状态
- (void)stopPlay:(NSNotification*)noti
{
    NSLog(@"recive noti  =  %@",noti.name);
    
    if ([noti.name isEqualToString:[[[self.vedioDictionary objectForKey:@"vedioPath"] componentsSeparatedByString:@"/"] lastObject]]) {
            [playButton setSelected:NO];
       }
}
//查看大图
- (void)lookBigPicture:(UIButton*)button
{

   [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"noloadata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
  view = [[UIView alloc] initWithFrame:_app.window.bounds];
//    view.userInteractionEnabled = YES;
    [view setBackgroundColor:[UIColor blackColor]];
    [_app.window addSubview:view];
  
    
//    CATransition* animation = [CATransition animation];
//    [animation setType:@"rippleEffect"];
//    [animation setDuration:1.f];
//    [view.layer addAnimation:animation forKey:nil];
//    [TalkLabel popupAnimation:view duration:1.];
    [view.layer addAnimation:[TalkLabel getKeyframeAni] forKey:nil];
    
    
    _imgV = [[UIImageView alloc] initWithFrame:view.bounds];
    [_imgV setImage:chatImageViwe.image];
    [_imgV setContentMode:UIViewContentModeScaleAspectFit];
    _imgV.userInteractionEnabled = YES;
    [view addSubview:_imgV];
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(view.bounds.size.width-50 , view.bounds.size.height-50, 30, 30)];
    [imageview setImage:[UIImage imageNamed:@"imagesave"]];
    [view addSubview:imageview];
    UIButton *imagebt = [[UIButton alloc]initWithFrame:CGRectMake(view.bounds.size.width-80 , view.bounds.size.height-80, 80, 80)];
//    [imagebt setImage:[UIImage imageNamed:@"imagesave"] forState:  UIControlStateNormal ];
    [imagebt addTarget:self action:@selector(savaimage) forControlEvents: UIControlEventTouchDown];

    [view addSubview:imagebt];

//    [imageView release];
    UITapGestureRecognizer *SingleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetImage)];
    SingleTapGesture.numberOfTapsRequired = 1;//tap次数
    [_imgV addGestureRecognizer:SingleTapGesture];
    [view addGestureRecognizer:SingleTapGesture];
//    [SingleTapGesture release];
    
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [pinch setDelegate:self];
    [_imgV addGestureRecognizer:pinch];
//    [pinch release];
    
    UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)] autorelease];
    [view addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.delegate = self;
    [_imgV addGestureRecognizer:panRecognizer];
//    [panRecognizer release];
}

-(void)savaimage
{
//    UIView *view2=  [[UIView alloc]initWithFrame:view.bounds];
//    view2.backgroundColor = [UIColor clearColor];
//    [view addSubview:view2];

    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
    [actionSheet showInView:view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
//        NSURL *url=[NSURL URLWithString:[self.cellDictionary objectForKey:@"picPath"]];
        UIImage *imgFromUrl = _imgV.image;
//        [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        UIImageWriteToSavedPhotosAlbum(imgFromUrl, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了!" message:@"存不了T_T" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
//单击恢复视图
- (void)resetImage
//:(UITapGestureRecognizer *)recognizer
{
 
    @try {
        [UIView animateWithDuration:1.f animations:^{
            
            [_imgV superview].transform = CGAffineTransformIdentity;
            [[_imgV superview] setAlpha:0.];
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[_imgV superview] cache:NO];
        } completion:^(BOOL finished) {
            
            [[_imgV superview] removeFromSuperview];
            
        }];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"noloadata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lodata" object:nil];
}
- (void)pinchGesture:(UIPinchGestureRecognizer*)sender
{
//    _imgV.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
    
    [_app.window bringSubviewToFront:[sender view]];
    
//    for (UIGestureRecognizer* gesture in [_imgV superview].gestureRecognizers) {
//        [[_imgV superview] removeGestureRecognizer:gesture];
//    }

    //当手指离开屏幕时,将lastscale设置为1.0
    if ([sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - sender.scale);
    CGAffineTransform currentTransform = [sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[sender view] setTransform:newTransform];
    lastScale = sender.scale;
}
- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    
    if(recognizer.state != UIGestureRecognizerStateEnded){
        CGPoint newCenter = [recognizer translationInView:_imgV];
        CGAffineTransform transform = CGAffineTransformTranslate(_imgV.transform, newCenter.x, newCenter.y);
        _imgV.transform = transform;
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:_app.window];
    }
}
// 视图抖动动画
+ (void)shakeView:(UIView *)view duration:(CGFloat)fDuration
{
    if (view && (fDuration >= 0.1f))
    {
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //设置抖动幅度
        shake.fromValue = [NSNumber numberWithFloat:-0.3];
        shake.toValue = [NSNumber numberWithFloat:+0.3];
        shake.duration = 0.1f;
        shake.repeatCount = fDuration/4/0.1f;
        shake.autoreverses = YES;
        [view.layer addAnimation:shake forKey:@"shakeView"];
    }else{}
}
+(CAKeyframeAnimation *)getKeyframeAni{
    CAKeyframeAnimation* popAni=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAni.duration=0.4;
    popAni.values=@[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAni.keyTimes=@[@0.0,@0.5,@0.75,@1.0];
    popAni.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    return popAni;
}
+ (void)animationRippleEffect:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    
    [view.layer addAnimation:animation forKey:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
