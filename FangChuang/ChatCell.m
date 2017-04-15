//
//  ChatCell.m
//  QQtest
//
//  Created by Tony on 13-8-15.
//  Copyright (c) 2013年 xipj. All rights reserved.
//

//暂时没看懂是做什么的页面
#import "ChatCell.h"

@implementation ChatCell
//@synthesize rightLabel=_rightLabel;
//@synthesize leftLabel= _leftLabel;
//@synthesize rightView=_rightView;
//@synthesize leftView=_leftView;
//@synthesize headImgView = _headImgView;
//@synthesize rightheadImgView;
//@synthesize leftTimeLabel;
//@synthesize rightTimeLabel;
@synthesize otherUrl;

- (void)creatCellWithDic:(NSDictionary *)dic
{
    int type=[[dic objectForKey:@"Type"] integerValue];
    switch (type) {
        case 1:
//            1是收
        {
            //头像
            _headImgView = [[CacheImageView alloc] initWithFrame:CGRectMake(5, 10, 94/2.0, 95/2.0)];
            _headImgView.layer.cornerRadius=6.0f;
            _headImgView.backgroundColor=[UIColor clearColor];
            [_headImgView setImage:[UIImage imageNamed:@"common_default_head.png"]];
            
            [_headImgView getImageFromURL:[NSURL URLWithString:[Utils getString:[dic objectForKey:@"attach_pic"]] ]];
            _headImgView.layer.cornerRadius=6.0f;
            _headImgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
            _headImgView.layer.borderWidth=1.0f;
            [self.contentView addSubview:_headImgView];

            
            UIImage *leftImage = [UIImage imageNamed:@"Chating_duihuakuang_3"];
          
            leftImage = [leftImage stretchableImageWithLeftCapWidth:21 topCapHeight:14];
            
//            
//            NSString *content=[dic objectForKey:@"content"];
//            CGSize size=[content sizeWithFont:[Utils getDefaultFont:15.0f] constrainedToSize:CGSizeMake(230, 400) lineBreakMode:NSLineBreakByCharWrapping];
//            
            _leftView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 10, 30,40)];
            _leftView.image = leftImage;
            _leftView.layer.cornerRadius = 5.0;
            _leftView.layer.masksToBounds = YES;
            [self.contentView addSubview:_leftView];

            
//            leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10+_leftView.frame.size.height, 120, 20)];
//            [leftTimeLabel setBackgroundColor:[UIColor clearColor]];
//            [leftTimeLabel setTextColor:[UIColor blackColor]];
//            [leftTimeLabel setFont:[UIFont systemFontOfSize:10.0f]];
//            [self.contentView addSubview:leftTimeLabel];
//            [leftTimeLabel release];
//            
            
            
      
            
            //    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(80-5-5, 10, 11, 17)];
            //    [_leftLabel setBackgroundColor:[UIColor clearColor]];
            //    [_leftLabel setFont:[UIFont systemFontOfSize:15]];
            //    [_leftLabel setNumberOfLines:0];
            //    [_leftLabel setLineBreakMode:NSLineBreakByCharWrapping];
            //    [self.leftView addSubview:_leftLabel];
            //    [_leftLabel release];
            
            
            
//            [_leftView addSubview:item];
           

            
             int type=[[Utils getString:[dic objectForKey:@"contentType"]] integerValue];
            
            if (type==2) {
                item=[[ChatItem alloc]init];
                [item setWithDic:dic];
                item.frame=CGRectMake(65, 10, 109+30, 37);
                [self addSubview:item];
                _leftView.frame=CGRectMake(60, 10,109 , 37);
            }else{
                item=[[ChatItem alloc]init];
                item.frame=CGRectMake(10, 5, 11, 17);
                
                [item setWithDic:dic];
                [_leftView addSubview:item];
                
                _leftView.frame=CGRectMake(60, 10,item.width, item.height);
            }
 
            [self setFrame:CGRectMake(0, 0, 320, item.height<50?50+15:item.height+5+35)];
         }
            
            break;
            
        default:
//            0是发
            
        {
            
        
            UIImage *rightImage = [UIImage imageNamed:@"Chating_duihuakuang_4"];
            rightImage =[rightImage stretchableImageWithLeftCapWidth:15 topCapHeight:14];

             _rightheadImgView = [[CacheImageView alloc] initWithFrame:CGRectMake(260, 10, 94/2.0, 95/2.0)];
            [_rightheadImgView setImage:[UIImage imageNamed:@"common_default_head"]];
            _rightheadImgView.layer.cornerRadius=6.0f;
            _rightheadImgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
            _rightheadImgView.layer.borderWidth=1.0f;
            
            
//            NSString *url=[Utils getString:[[[UserInfo sharedManager] userInformationDic] objectForKey:@"head_pic"] ];
//            [ _rightheadImgView getImageFromURL:[NSURL URLWithString:url]];
            [self.contentView addSubview:_rightheadImgView];

            
            _rightView = [[UIImageView alloc]initWithFrame:CGRectMake(320-22-10-90-5, 10, 30, 40)];
            _rightView.image = rightImage;
            _rightView.layer.cornerRadius = 5.0;
            _rightView.layer.masksToBounds = YES;
            [self.contentView addSubview:_rightView];

            
            item1=[[ChatItem alloc]init];
            item1.frame=CGRectMake(0, 5, 11, 17);
            [item1 setWithDic:dic];
            
            
             int type=[[Utils getString:[dic objectForKey:@"contentType"]] integerValue];
            if (type==2) {
                
                item1.frame=CGRectMake(250-item1.width-20, 10, 109+30, item1.height);
                [self addSubview:item1];
                _rightView.frame=CGRectMake(250-item1.width, 10,item1.width , item1.height);
            }else{
            
                [_rightView addSubview:item1];
                _rightView.frame=CGRectMake(250-item1.width, 10,item1.width, item1.height);
            }
            

//            rightTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(250-120-10, 5+CGRectGetMaxY(_rightView.frame), 120, 20)];
////            [rightTimeLabel setBackgroundColor:[UIColor blueColor]];
//            [rightTimeLabel setTextColor:[UIColor blackColor]];
//            [rightTimeLabel setTextAlignment:NSTextAlignmentRight];
//            [rightTimeLabel setFont:[UIFont systemFontOfSize:10.0f]];
//            [self.contentView addSubview:rightTimeLabel];
//            [rightTimeLabel release];
//            
//            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//            formatter.dateFormat=[NSString stringWithFormat:@"yyyy-MM-dd  HH:mm:ss"];
//            NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
//            [rightTimeLabel setText:currentDateStr];
            
        
            
            [self setFrame:CGRectMake(0, 0, 320, item1.height<50?50+15:item1.height+5+35)];
//            self.backgroundColor=[UIColor blueColor];
            //    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 11, 17)];
            //    [_rightLabel setBackgroundColor:[UIColor clearColor]];
            //    [_rightLabel setFont:[UIFont systemFontOfSize:15]];
            //    [_rightLabel setNumberOfLines:0];
            //    [_rightLabel setLineBreakMode:NSLineBreakByCharWrapping];
            //    [self.rightView addSubview:_rightLabel];
            //    [_rightLabel release];
        }
            break;
    }
}
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatcell"];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=NO;
        [self creatCellWithDic:dic];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
