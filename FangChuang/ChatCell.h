//
//  ChatCell.h
//  QQtest
//
//  Created by Tony on 13-8-15.
//  Copyright (c) 2013年 xipj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatItem.h"
@interface ChatCell : UITableViewCell
{

    ChatItem *item;
    ChatItem *item1;
    
    UILabel *_leftLabel;
    UILabel *_rightLabel;
    
    UIImageView *_rightView;
    UIImageView *_leftView;
  
    CacheImageView *_headImgView;
  
    CacheImageView *_rightheadImgView;

    UILabel *leftTimeLabel;
  
    UILabel *rightTimeLabel;

}
@property (nonatomic,retain)NSString *otherUrl;
- (id)initWithDic:(NSDictionary *)dic;
@end
