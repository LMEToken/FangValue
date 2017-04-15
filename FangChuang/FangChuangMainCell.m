//
//  FangChuangMainCell.m
//  FangChuang
//
//  Created by chenlihua on 14-5-4.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//聊天内容的cell界面。
#import "FangChuangMainCell.h"
#import "MineInFoemationViewController.h"

//2014.06.12 chenlihua 修改图片缓存的方式。
#import "UIImageView+WebCache.h"

@implementation FangChuangMainCell

@synthesize cellDictionary;
@synthesize headButton;
@synthesize sighButton;
@synthesize nickLabel;
@synthesize clockTextField;
-(void)updata:(NSDictionary *)dic
{
    
    //cell背景色
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.cellDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    if(![[self.cellDictionary objectForKey:@"contentType"] isKindOfClass:[NSNull class]])
    {
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
    }
    
    [headImageViewNew.layer setCornerRadius:7];
    [headImageViewNew.layer setMasksToBounds:YES];
    //2014.04.30 chenlihua 点击聊天界面的头像后，跳转到相应的详细信息
    headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headButton setFrame:headImageViewNew.frame];
    
    headButton.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:headButton];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //重制坐标，相当之重要  zhutc留
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 320, CGRectGetMaxY(contentLabel.frame) + 40)];
    
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
    else    if ([[self.cellDictionary objectForKey:@"talkType"] isEqualToString:@"3"])
    {
        style = TalkLabelSystem;
    }
else
    {
        style = TalkLabelOther;
  

        
    }
    


  
    switch (style) {
         case TalkLabelSelf:
        {
            

         
           contentLabel = [[TalkLabel alloc] initWithString:[self.cellDictionary objectForKey:@"content"] style:TalkLabelSelf];
            
            //将收到的内容的换行替换出成","
            /*
             NSString *contentString = [[self.cellDictionary objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<br!>" withString:@","];
             
             contentLabel = [[TalkLabel alloc] initWithString:contentString style:TalkLabelSelf];
             */
            
           contentLabel.backgroundColor=[UIColor clearColor];
           [self.contentView addSubview:contentLabel];
            
            
            NSLog(@"%@",self.cellDictionary);
            
            
            //发送消息的时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            NSLog(@"........timeStr...%@",timeStr);
            //2014-09-10 10:44:24
            
            //2014.05.13  chenlihua 发送的消息的时间，改成日期加时间。
            //timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            
            /*
             if (timeStr.length>11) {
             timeStr=[timeStr substringWithRange:NSMakeRange(5, 11)];
             }else
             {
             timeStr = [self.cellDictionary objectForKey:@"time"];
             }
             NSLog(@"---timeStr---%@",timeStr);
             //09-10 10:44
             */
//            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
//            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
//            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
//            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
//            NSLog(@"--%@---%@---%@",yearStr,monthStr,dayStr);
//            NSString *timStrStr=[NSString stringWithFormat:@"  %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            
            //发送消息的时间Label
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8, 35, 45, 9)];
            //2014.05.13 chenlihua 发送消息的时候，改成日期加时间。
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8-45, 35, 90, 9)];
            //2014.08.21 chenlihua 将时间上移
            //clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105 , 2, 90, 15)];
            //2014.09.10 chenlihua 将时间图标换作新的。
//            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105 , 2, 115, 15)];
//            clockTextField.textColor=[UIColor whiteColor];
//            [clockTextField setEnabled:NO];
//            [clockTextField setBorderStyle:UITextBorderStyleNone];
//            [clockTextField setText:timStrStr];
//            [clockTextField setTextAlignment:NSTextAlignmentLeft];
//            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
//            //  [clockTextField setBackgroundColor:[UIColor redColor]];
//            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
//            //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
//            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
//
//     
//            [self addsendtime:timStrStr];
//           [self.contentView addSubview:clockTextField];
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            // nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8+100, 8, 50, 10)];
            //2014.05.26 chenlihua 当聊天消息内容特别多时，昵称会显示到聊天信息的中间。
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 8, 60, 10)];
            NSLog(@"%@",self.cellDictionary);
         //   nickLabel.text=[[UserInfo sharedManager]username];
            
            //修改为显示真实姓名
            nickLabel.text=[[UserInfo sharedManager] user_name];
            
            //[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[self.cellDictionary objectForKey:@"userId"]]];
            //[self.cellDictionary objectForKey:@"userId"];
            
            //            nickLabel.backgroundColor = [UIColor redColor];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nickLabel.tag=1;
            [self.contentView addSubview:nickLabel];
            
            
            //chenlihua 2014.05.08 chenlihua 消息发不出去时，要用":"提醒
            sighButton=[[SendfailButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 -8+31, 30, 24, 24)];
            //2014.09.03 chenlihua 将感叹号外移
            // sighButton=[[UIButton alloc]initWithFrame:CGRectMake(190, 27, 20 , 20)];
            //sighButton.backgroundColor=[UIColor redColor];
            //  [sighButton setTitle:@"!" forState:UIControlStateNormal];
            //            sighButton.imageView.image = [UIImage imageNamed:@"duanwang"];
//            [sighButton setBackgroundImage:[UIImage imageNamed:@"duanwang"] forState:UIControlStateNormal ];
            //2014.05.23 chenlihua 字体变红。
            [sighButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            //2014.05.23 chenlihua 字体加粗。
            sighButton.titleLabel.font=[UIFont fontWithName:KUIFont size:20];
           sighButton.hidden=YES;
            //            [sighButton addTarget:self action:@selector(sendagain) forControlEvents:UIControlEventTouchDown];
           
            
            
            
            //时间中表的小图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            // [clockTextField setLeftView:imageView];
            
            
            
            //头像图片
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
             */
            
            //2014.06.12 chenlihua 修改图片缓存方式。
            headImageViewNew= [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) +5, 20, 40, 40)];
            //利用第三方库(SDWebImage)的方法异步加载图片
            // [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"48_touxziang_1"]];
            //2014.07.25 chenlihua 修改头像
            NSLog(@"%@",[[UserInfo sharedManager] userpicture]);
            [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            [self.contentView addSubview:headImageViewNew];
             [self.contentView addSubview:sighButton];
            
        }
        break;
        case TalkLabelOther:
        {
            //头像图片
            
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             */
            
            //2014.06.12 chenlihua 修改图片缓存的方式
            headImageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
        
            
            //  [headImageView getImageFromURL:[NSURL URLWithString:[self.cellDictionary objectForKey:@"imageUrl"]]];
            
            //2014.05.26 chenlihua 从联系人的头像信息中加载头像。
  
                NSLog(@"%@",self.cellDictionary);
                NSLog(@"------------openby--%@---",[self.cellDictionary objectForKey:@"openby"]);
                NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
         
                NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[self.cellDictionary objectForKey:@"openby"],   [[UserInfo sharedManager]username]]];
               [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
     
//             if ([headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]]!=nil) {
//                    NSString *urlString=[headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]];
//                    [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//          
//                }
//              if ([[self.cellDictionary objectForKey:@"openby"]isEqualToString:[self.cellDictionary objectForKey:@"userId"]] ) {
//                    [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//               }
//              if ([[self.cellDictionary objectForKey:@"imageUrl"]isEqualToString:@""]) {
//                [headImageViewNew setImage:[UIImage imageNamed:@"chatHeadImage"]];
//               }
               [self.contentView addSubview:headImageViewNew];
            
            
            //            NSLog(@"--------urlString------%@-----",urlString);
            
            // [headImageView getImageFromURL:[NSURL URLWithString:urlString]];
            
            //2014.06.12 chenlihua 利用第三方库(SDWebImage)的方法异步加载图片
            
            
            
            
            
            //内容Label
            //contentLabel = [[TalkLabel alloc] initWithString:[self.cellDictionary objectForKey:@"content"] style:TalkLabelOther];
            
            NSString *contentString = [[self.cellDictionary objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<br!>" withString:@","];
            contentLabel = [[TalkLabel alloc] initWithString:contentString style:TalkLabelOther];
             [self.contentView addSubview:contentLabel];
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 30)];
            nickLabel.text=[self.cellDictionary objectForKey:@"openby"];
            //[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[self.cellDictionary objectForKey:@"openby"]]];
            
//            [self.cellDictionary objectForKey:@"openby"];
            
       
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
//            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nickLabel.tag=2;
            [self.contentView addSubview:nickLabel];
            
            
            //时间
//            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            //    timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            //2014.05.13 chenlihua 时间加上日期
            // timeStr=[timeStr substringWithRange:NSMakeRange(5, 11)];
            
            
//            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
//            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
//            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
//            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
//            NSLog(@"--%@---%@---%@",yearStr,monthStr,dayStr);
//            NSString *timStrStr=[NSString stringWithFormat:@"  %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            
            //        48_tubiao_1
            //17 * 17
            //时间所在Label
            //  clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 6, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            //2014.05.13 chenlihua 时间加上日期
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 6, CGRectGetMinY(contentLabel.frame) + 10, 90, 9)];
            //2014.08.21 chenlihua 时间上移
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 90, 15)];
//            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 115, 15)];
//            clockTextField.textColor=[UIColor whiteColor];
//            [clockTextField setEnabled:NO];
//            [clockTextField setBorderStyle:UITextBorderStyleNone];
//            [clockTextField setText:timStrStr];
//            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
//            [clockTextField setBackgroundColor:[UIColor clearColor]];
//            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
//            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
//            [self addsendtime:timStrStr];
//            [self.contentView addSubview:clockTextField];
            
            
            //表的图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            // [clockTextField setLeftView:imageView];
            
            
        }
        break;
            //提示谁谁推出群，谁谁加入群
        case TalkLabelSystem:
        {
            NSString *contentString = [[self.cellDictionary objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<br!>" withString:@","];
            NSLog(@"---contentString--%@--",contentString);
            contentLabel = [[TalkLabel alloc] initWithString:contentString style:TalkLabelSystem];
            [self.contentView addSubview:contentLabel];
        
        }
        break;
            
        default:
            break;
    }
}
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
            // contentLabel.backgroundColor=[UIColor redColor];
            [self addSubview:contentLabel];
            
            //头像
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             
             [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
             */
            //            NSString *contentString = [[self.cellDictionary objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<br!>" withString:@","];
            //            contentLabel = [[TalkLabel alloc] initWithString:contentString style:TalkLabelOther];
            //
            //
            //            [self.contentView addSubview:contentLabel];
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 8, 40, 10)];
           
            nickLabel.text=[[UserInfo sharedManager]username];
            //[self.cellDictionary objectForKey:@"userId"];
            //            nickLabel.backgroundColor = [UIColor redColor];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nickLabel.tag=2;
            [self.contentView addSubview:nickLabel];
            NSLog(@"%f",CGRectGetMaxX(contentLabel.frame));
            //2014.06.12 chenlihua 修改图片缓存方式。
            headImageViewNew= [[UIImageView alloc] initWithFrame:CGRectMake(265, 20, 40, 40)];
            
            //利用第三方库(SDWebImage)的方法异步加载图片
            [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            [self.contentView addSubview:headImageViewNew];
     
            NSString *str = [self.cellDictionary objectForKey:@"second"];
            NSInteger content = [[str stringByReplacingOccurrencesOfString:@"''"withString:@""] intValue];
        
          //  CGRectMake(0-content*3, 0,60+content*3 , 67 / 2.)
            //chenlihua 2014.05.08 chenlihua 消息发不出去时，要用":"提醒
            sighButton=[[SendfailButton alloc]initWithFrame:CGRectMake(155-content*2, 30,60+content*2 , 67 / 2.)];
                        //CGRectMake(CGRectGetMinX(contentLabel.frame) - 45 - 8+31, 30, 20, 20)];
            [sighButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            sighButton.titleLabel.font=[UIFont fontWithName:KUIFont size:20];
            sighButton.hidden=YES;
            [self.contentView addSubview:sighButton];
            
            
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame)+200, 8, 50, 10)];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nickLabel.backgroundColor=[UIColor clearColor];
            nickLabel.tag=1;
            [self.contentView addSubview:nickLabel];
            
            
            //        48_tubiao_1
            //17 * 17
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            
            // timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            //2014.05.13 chenlihua 时间要加上日期
            // timeStr=[timeStr substringWithRange:NSMakeRange(5, 11)];
            
            
            //时间所在Label
            //  clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 35, 45, 9)];
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(95, 35, 90, 9)];
            
            //            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
            //            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
            //            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
            //            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
            //            NSLog(@"--%@---%@---%@---%@",yearStr,monthStr,dayStr,minStr);
            //            NSString *timStrStr=[NSString stringWithFormat:@"   %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            
            //2014.08.21 chenlihua 时间上移
            //clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 90, 15)];
            //            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 115, 15)];
            //            clockTextField.textColor=[UIColor whiteColor];
            //            [clockTextField setEnabled:NO];
            //            [clockTextField setBorderStyle:UITextBorderStyleNone];
            //            [clockTextField setText:timStrStr];
            //            [clockTextField setTextAlignment:NSTextAlignmentLeft];
            //            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [clockTextField setBackgroundColor:[UIColor clearColor]];
            //            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
            //            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            //            [self addsendtime:timStrStr];
            //            [self.contentView addSubview:clockTextField];
            
            
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            // [clockTextField setLeftView:imageView];
            
        }
            break;
        case TalkLabelOther:
        {
            //头像
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             */
            // [headImageView getImageFromURL:[NSURL URLWithString:[self.cellDictionary objectForKey:@"imageUrl"]]];
            
            
            //2014.06.12 chenlihua 修改图片缓存的方式
            headImageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
            //   [headImageViewNew setImage:[UIImage imageNamed:@"48_touxziang_1"]];
//            [self.contentView addSubview:headImageViewNew];
            
            
            //2014.05.26 chenlihua 从联系人的头像信息中加载头像。
            NSLog(@"------------openby--%@---",[self.cellDictionary objectForKey:@"openby"]);
            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
//            if ([headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]]!=nil) {
//                NSString *urlString=[headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]];
//                
//                
//                [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//            }
//            if ([[self.cellDictionary objectForKey:@"openby"]isEqualToString:[self.cellDictionary objectForKey:@"userId"]] ) {
//                [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//            }
//            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
            
            NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[self.cellDictionary objectForKey:@"openby"],   [[UserInfo sharedManager]username]]];
            [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            
            [self.contentView addSubview:headImageViewNew];
            
            
            //发送内容Label
            contentLabel = [[TalkLabel alloc] initwithAudioDictionary:self.cellDictionary style:TalkLabelOther];
             [self addSubview:contentLabel];
            
      
          
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 50, 10)];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.text =[self.cellDictionary objectForKey:@"openby"];
            //[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[self.cellDictionary objectForKey:@"openby"]]];
            //[self.cellDictionary objectForKey:@"openby"];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
            nickLabel.tag=2;
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.contentView addSubview:nickLabel];
            
            //时间
            //            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            //  timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            //2014.05.13 chenlihua 时间要加上日期
            // timeStr=[timeStr substringWithRange:NSMakeRange(5, 11)];
            
            //        48_tubiao_1
            //17 * 17
            //时间Label
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(155, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            //2014.05.13 chenlihua 时间加上日期
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(155, CGRectGetMinY(contentLabel.frame) + 10, 90, 9)];
            //
            //            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
            //            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
            //            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
            //            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
            //            NSLog(@"--%@---%@---%@",yearStr,monthStr,dayStr);
            //            NSString *timStrStr=[NSString stringWithFormat:@"  %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            //
            //2014.08.21 chenlihua 时间上移
            //            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 90, 15)];
            //            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 115, 15)];
            //            clockTextField.textColor=[UIColor whiteColor];
            //            [clockTextField setEnabled:NO];
            //            [clockTextField setBorderStyle:UITextBorderStyleNone];
            //            [clockTextField setText:timStrStr];
            //            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [clockTextField setBackgroundColor:[UIColor clearColor]];
            //            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
            //            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            //            [self addsendtime:timStrStr];
            //            [self.contentView addSubview:clockTextField];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            // [clockTextField setLeftView:imageView];
            
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
            NSLog(@"-----picPath-----%@",[self.cellDictionary objectForKey:@"picPath"]);
            //内容Label
            contentLabel = [[TalkLabel alloc] initWithPicture:[self.cellDictionary objectForKey:@"picPath"] style:TalkLabelSelf];
            
            
            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 8, 40, 10)];
            NSLog(@"%@",self.cellDictionary);
            nickLabel.text=[[UserInfo sharedManager]username];
            //[self.cellDictionary objectForKey:@"userId"];
            //            nickLabel.backgroundColor = [UIColor redColor];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nickLabel.tag=1;
            [self.contentView addSubview:nickLabel];
            //            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            //            nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame)+200, 8, 50, 10)];
            //            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            //            nickLabel.backgroundColor=[UIColor clearColor];
            ////            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //            nickLabel.tag=1;
            ////            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //            [self.contentView addSubview:nickLabel];
            
            
            //头像
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) + 15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             
             [headImageView getImageFromURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]];
             
             */
            
            //2014.06.12 chenlihua 修改图片缓存方式。
            headImageViewNew= [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLabel.frame) +5, 20, 40, 40)];
            //利用第三方库(SDWebImage)的方法异步加载图片
//            [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            NSLog(@"%@",self.cellDictionary);
         [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
            
//            [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] options:SDWebImageLowPriority];
                [self.contentView addSubview:headImageViewNew];
            

            //        48_tubiao_1
            //17 * 17
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            // timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            //2014.05.13 chenlihua 时间加上日期
            // timeStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
            
            //            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
            //            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
            //            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
            //            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
            //            NSLog(@"--%@---%@---%@",yearStr,monthStr,dayStr);
            //            NSString *timStrStr=[NSString stringWithFormat:@"  %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            
            //时间所在Label
            //   clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 35, 45, 9)];
            //2014.05.13 chenlihua 时间加上日期
            //clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 35, 90, 9)];
            //2014.08.21 chenlihua 时间上移
            //            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 115, 15)];
            //            clockTextField.textColor=[UIColor whiteColor];
            //            [clockTextField setEnabled:NO];
            //            [clockTextField setBorderStyle:UITextBorderStyleNone];
            //            [clockTextField setText:timStrStr];
            //            [clockTextField setTextAlignment:NSTextAlignmentLeft];
            //            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [clockTextField setBackgroundColor:[UIColor clearColor]];
            //            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
            //            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            //            [self addsendtime:timStrStr];
            //            [self.contentView addSubview:clockTextField];
            
            
            //chenlihua 2014.05.08 chenlihua 消息发不出去时，要用"!"提醒
            sighButton=[[SendfailButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame) - 8, 30, 60,30)];
            
            //2014.09.03 chenlihua 将感叹号外移
            // sighButton=[[UIButton alloc]initWithFrame:CGRectMake(190, 27, 20 , 20)];
            //sighButton.backgroundColor=[UIColor redColor];
            //  [sighButton setTitle:@"!" forState:UIControlStateNormal];
            //            sighButton.imageView.image = [UIImage imageNamed:@"duanwang"];
            //            [sighButton setBackgroundImage:[UIImage imageNamed:@"duanwang"] forState:UIControlStateNormal ];
            //2014.05.23 chenlihua 字体变红。
            [sighButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            //2014.05.23 chenlihua 字体加粗。
            sighButton.titleLabel.font=[UIFont fontWithName:KUIFont size:20];
            sighButton.hidden=YES;
            //            [sighButton addTarget:self action:@selector(sendagain) forControlEvents:UIControlEventTouchDown];
           
            
            
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            //  [clockTextField setLeftView:imageView];
            [self addSubview:contentLabel];
            [self.contentView addSubview:sighButton];
        }
            break;
        case TalkLabelOther:
        {
            //头像
            /*
             headImageView = [[CacheImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
             [headImageView setImage:[UIImage imageNamed:@"48_touxziang_1"]];
             [self.contentView addSubview:headImageView];
             */
            
            
            // [headImageView getImageFromURL:[NSURL URLWithString:[self.cellDictionary objectForKey:@"imageUrl"]]];
            
            
            //2014.06.12 chenlihua 修改图片缓存的方式
            headImageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
            //  [headImageViewNew setImage:[UIImage imageNamed:@"48_touxziang_1"]];
            [self.contentView addSubview:headImageViewNew];
            
            //2014.05.26 chenlihua 从联系人的头像信息中加载头像。
            NSLog(@"------------openby--%@---",[self.cellDictionary objectForKey:@"openby"]);
//            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
//            if ([headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]]!=nil) {
//                NSString *urlString=[headImageUrl objectForKey:[self.cellDictionary objectForKey:@"openby"]];
//                
//                
////                [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
//                     [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString ]  placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
////                      [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString ] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] options:SDWebImageLowPriority];
//            }
//            if ([[self.cellDictionary objectForKey:@"openby"]isEqualToString:[self.cellDictionary objectForKey:@"userId"]] ) {
////                [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
////                 [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]]placeholderImage:[UIImage imageNamed:@"chatHeadImage"] options:SDWebImageLowPriority];
//                
//                
//                [headImageViewNew setImageWithURL:[NSURL URLWithString:[[UserInfo sharedManager] userpicture]] placeholderImage:[UIImage imageNamed:@"chatHeadImage"] success:^(UIImage *image){} failure:^(NSError *error){} ];
//          
//        
//        
//            }
            NSUserDefaults *headImageUrl=[NSUserDefaults standardUserDefaults];
            
            NSString *urlString=[headImageUrl objectForKey:[NSString stringWithFormat:@"%@pic%@",[self.cellDictionary objectForKey:@"openby"],   [[UserInfo sharedManager]username]]];
            [headImageViewNew setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"chatHeadImage"]];
            [self.contentView addSubview:headImageViewNew];
            
            
            //内容Label
            contentLabel = [[TalkLabel alloc] initWithPicture:[self.cellDictionary objectForKey:@"picPath"] style:TalkLabelOther];
            [self addSubview:contentLabel];
               //2014.05.27 chenlihua 长按别人发来的图片时，保存到相册中。
            UILongPressGestureRecognizer *longPress =
            [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleTableviewCellLongPressed:)];
            //代理
            longPress.delegate = self;
            longPress.minimumPressDuration = 1.0;
            //将长按手势添加到需要实现长按操作的视图里
            [contentLabel addGestureRecognizer:longPress];
            
            
            
            
            
            
            //chenlihua 2014.04.22 消息内容调整为头像+昵称+消息+日期时间
            nickLabel = [[UILabel  alloc] initWithFrame:CGRectMake(20, 8, 50, 10)];
            //            [nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
             nickLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"relname%@",[self.cellDictionary objectForKey:@"openby"]]];
            //[self.cellDictionary objectForKey:@"openby"];
            [ nickLabel setFont:[UIFont fontWithName:KUIFont size:9]];
            nickLabel.backgroundColor=[UIColor clearColor];
            nickLabel.tag=2;
            //            [nickLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.contentView addSubview:nickLabel];
            
            //时间
            NSString* timeStr = [self.cellDictionary objectForKey:@"time"];
            // timeStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
            //2014.05.13 chenlihua 时间加上日期
            //  timeStr=[timeStr substringWithRange:NSMakeRange(5, 11)];
            //17 * 17
            //时间所在Label
            //  clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(175, CGRectGetMinY(contentLabel.frame) + 10, 50, 9)];
            //2014.05.13 chenlihua 时间加上日期
            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(175, CGRectGetMinY(contentLabel.frame) + 10, 90, 9)];
            //
            //            NSString *yearStr=[timeStr substringWithRange:NSMakeRange(0, 4)];
            //            NSString *monthStr=[timeStr substringWithRange:NSMakeRange(5, 2)];
            //            NSString *dayStr=[timeStr substringWithRange:NSMakeRange(8, 2)];
            //            NSString *minStr=[timeStr substringWithRange:NSMakeRange(10, 6)];
            //            NSLog(@"--%@---%@---%@",yearStr,monthStr,dayStr);
            //            NSString *timStrStr=[NSString stringWithFormat:@"  %@年%@月%@日 %@",yearStr,monthStr,dayStr,minStr];
            //
            //            //2014.08.21 chenlihua 时间上移
            //            // clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 90, 15)];
            //            clockTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 2, 115, 15)];
            //            clockTextField.textColor=[UIColor whiteColor];
            //            [clockTextField setEnabled:NO];
            //            [clockTextField setBorderStyle:UITextBorderStyleNone];
            //            [clockTextField setText:timStrStr];
            //            [clockTextField setFont:[UIFont fontWithName:KUIFont size:9]];
            //            [clockTextField setBackgroundColor:[UIColor clearColor]];
            //            [clockTextField setBackground:[UIImage imageNamed:@"chat7"]];
            //            [clockTextField setLeftViewMode:UITextFieldViewModeAlways];
            //            [self addsendtime:timStrStr];
            //            [self.contentView addSubview:clockTextField];
            
            //时间图标
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 9)];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setImage:[UIImage imageNamed:@"48_tubiao_1"]];
            //[clockTextField setLeftView:imageView];
            
        }
            break;
        default:
            break;
    }
}
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {

}
-(void)addsendtime :(NSString*)timStrStr
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"addclock"]!=nil) {
        if ([timStrStr isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"addclock"]]) {
            clockTextField.hidden  = YES;
        }else
        {
            clockTextField.hidden = NO;
    
        }
    }else
    {
        clockTextField.hidden = NO;
        
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:timStrStr forKey:@"addclock"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma -mark -长按事件的实现方法
//2014.05.27 chenlihua 长按别人发来的图片时，保存到相册中
//长按事件的实现方法
- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"保存图片到相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
    
}
#pragma -mark -UIAlertView 代理
//2014.05.27 chenlihua 长按别人发来的图片时，保存到相册中
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"取消");
        /*
         UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了取消" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
         [alertView show];
         */
        
    }else{
        NSLog(@"确定");
        /*
         UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了确定" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
         [alertView show];
         */
        
        //  UIImage* image = [UIImage imageWithContentsOfFile:self.imagePath];
        
        NSLog(@"------self.cellDictionary---%@",[self.cellDictionary objectForKey:@"picPath"]);
        
        NSURL *url=[NSURL URLWithString:[self.cellDictionary objectForKey:@"picPath"]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        UIImageWriteToSavedPhotosAlbum(imgFromUrl, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }
}
#pragma -mark -保存图片到相册
//2014.05.27 chenlihua 长按别人发来的图片时，保存到相册中
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (error != NULL) {
        
        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [photoSave show];
        [photoSave dismissWithClickedButtonIndex:0 animated:YES];
        
    }else {
        
        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:@"保存图片成功" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [photoSave show];
        // [photoSave dismissWithClickedButtonIndex:0 animated:YES];
        
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
