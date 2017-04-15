//
//  MyChatCell.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//聊天内容的界面，已经进行了重写，现在无用。

#import "MyChatCell.h"

#import "MineInFoemationViewController.h"


@implementation MyChatCell
@synthesize cellDictionary;
@synthesize headButton;
@synthesize sighButton;


//- (void)dealloc
//{
////  [contentLabel release];
//    cellDictionary = nil;
//    [super dealloc];
//}
- (id) initWithNSDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        //cell背景色
        [self setBackgroundColor:[UIColor clearColor]];
         self.cellDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
 
        NSLog(@"-----聊天的cell--------self.cellDictionary = %@",self.cellDictionary);
        int contentType = [[self.cellDictionary objectForKey:@"contentType"] intValue];
        
        switch (contentType) {
            case 0:
            {
                //文本
                [self getWenBen];
            }
                break;
            case 1:
            {
                //录音
                
                [self getLuYin];
                
            }
                break;
            case 2:
            {
                //图片
                
                [self getPicture];
            }
                break;
            default:
                break;
        }
        
        [headImageView.layer setCornerRadius:20];
        [headImageView.layer setMasksToBounds:YES];
        
      
       [headImageView getImageFromURL:[NSURL URLWithString:[self.cellDictionary objectForKey:@"imageUrl"]]];
        NSLog(@"......CharCell.........headImage.%@.............",[NSURL URLWithString:[self.cellDictionary objectForKey:@"imageUrl"]]);
      
        
        
        //2014.04.30 chenlihua 点击聊天界面的头像后，跳转到相应的详细信息
        headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [headButton setFrame:headImageView.frame];
        headButton.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:headButton];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //重制坐标，相当之重要  zhutc留
        [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 320, CGRectGetMaxY(contentLabel.frame) + 20)];
    }
    return self;
}
#pragma -mark -functions
//文本View
- (void)getWenBen
{
    TalkLabelStyle style;
    if ([[self.cellDictionary objectForKey:@"talkType"] isEqualToString:@"0"])
    {
        style = TalkLabelSelf ;
    }
    else
    {
        style = TalkLabelOther;
    }
    switch (style) {
        case TalkLabelSelf:
        {
            
            //        48_tubiao_1
            //17 * 17
            
            
            //                time : 2014-01-14 07:27:34 +0000
            
            //聊天内容Label
            contentLabel = [[TalkLabel alloc] initWithString:[self.cellDictionary objectForKey:@"content"] style:TalkLabelSelf];
          //  contentLabel.backgroundColor=[UIColor redColor];
            [self.contentView addSubview:contentLabel];
//            [contentLabel retain];
            
            
            
            
            //发送消息的时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            NSLog(@"........timeStr...%@",timeStr);
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //发送消息的时间Label
           clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8, 35, 45, 9)];
          //  clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8, 5, 120, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setTextAlignment:NSTextAlignmentLeft];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
             [self.contentView addSubview:clockTextField];

   
//            [clockTextField release];
            
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8+120, 5, 50, 10)];
            [nickLabel setText:@"nick"];
            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor redColor];
            [self.contentView addSubview:nickLabel];

            
            //时间中表的小图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];
            
            
            
            //头像图片
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            
                   
            [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
 
        }
            break;
        case TalkLabelOther:
        {
            //头像图片
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            
            //内容Label
            contentLabel = [[TalkLabel alloc] initWithString:[self.cellDictionary objectForKey:@"content"] style:TalkLabelOther];
            [self.contentView addSubview:contentLabel];
//            [contentLabel release];
            
            
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //        48_tubiao_1
            //17 * 17
            //时间所在Label
            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 6, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            [self.contentView addSubview:clockTextField];
//            [clockTextField release];
            
            //表的图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];
            
        }
            break;
            
        default:
            break;
    }
}

//录音View
- (void)getLuYin
{
    TalkLabelStyle style;
     if ([[self.cellDictionary objectForKey:@"talkType"] isEqualToString:@"0"])
    {
        style = TalkLabelSelf ;
    }
    else
    {
        style = TalkLabelOther;
    }
    switch (style) {
        case TalkLabelSelf:
        {
            //聊天内容的textField
            contentLabel = [[TalkLabel alloc] initwithAudioDictionary:self.cellDictionary style:TalkLabelSelf];
//            [contentLabel release];
           // contentLabel.backgroundColor=[UIColor redColor];
            [self addSubview:contentLabel];
            
            //头像
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];

            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //时间所在Label
            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 35, 45, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setTextAlignment:NSTextAlignmentLeft];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            [self.contentView addSubview:clockTextField];
//            [clockTextField release];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];

        }
            break;
        case TalkLabelOther:
        {
            //头像
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            
            //发送内容Label
            contentLabel = [[TalkLabel alloc] initwithAudioDictionary:self.cellDictionary style:TalkLabelOther];

            [self addSubview:contentLabel];
//                 [contentLabel release];

            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //        48_tubiao_1
            //17 * 17
            //时间Label
            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(155, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            [self.contentView addSubview:clockTextField];
//            [clockTextField release];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];
            
        }
            break;
            
        default:
            break;
    }
}
//图片初始化
- (void)getPicture
{
    TalkLabelStyle style;
    
    if ([[self.cellDictionary objectForKey:@"talkType"] isEqualToString:@"0"])
    {
        style = TalkLabelSelf ;
    }
    else
    {
        style = TalkLabelOther;
    }
    switch (style) {
        case TalkLabelSelf:
        {
            //内容Label
            contentLabel = [[TalkLabel alloc] initWithPicture:[self.cellDictionary objectForKey:@"picPath"] style:TalkLabelSelf];
            [self addSubview:contentLabel];
//            [contentLabel release];
            
            //头像
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            
            [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
            
            //        48_tubiao_1
            //17 * 17
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //时间所在Label
            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 35, 45, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setTextAlignment:NSTextAlignmentLeft];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            [self.contentView addSubview:clockTextField];
//            [clockTextField release];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];
        }
            break;
        case TalkLabelOther:
        {
            //头像
            headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
            [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageView];
//            [headImageView release];
            
            //内容Label
            contentLabel = [[TalkLabel alloc] initWithPicture:[self.cellDictionary objectForKey:@"picPath"] style:TalkLabelOther];
            [self addSubview:contentLabel];
//            [contentLabel release];
            
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            //17 * 17
            //时间所在Label
            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(175, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            [clockTextField setEnabled:NO];
            [clockTextField setBorderStyle:UITextBorderStyleNone];
            [clockTextField setText:timeStr];
            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            [clockTextField setBackgroundColor:[UIColor clearColor]];
            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            [self.contentView addSubview:clockTextField];
//            [clockTextField release];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            [clockTextField setLeftView:imageView];
//            [imageView release];
        }
            break;
        default:
            break;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end
