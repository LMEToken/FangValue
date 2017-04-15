//
//  MyChatCell.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"
#import "TalkLabel.h"

@class MyChatCell;
@protocol  MyChatCellDelegate<NSObject>

@required
- (void)myChatCell:(MyChatCell*)cell userId:(NSString*)userId;

@end
@interface MyChatCell : UITableViewCell
{
    CacheImageView* headImageView; // 用户头像
    TalkLabel* contentLabel; //内容
    UITextField* clockTextField; // 发送时间
  //  NSMutableDictionary* cellDictionary;
    //2014.04.22 chenlihua 将聊天消息内容调整为 头像+昵称+内容+日期时间
    UILabel *nickLabel;
    
    
    NSString *isPlay;
}
@property (nonatomic , retain)  NSMutableDictionary* cellDictionary;

- (id) initWithNSDictionary:(NSDictionary*)dic;

@property (nonatomic,retain) UIButton *headButton;
@property (nonatomic,retain) UIButton *sighButton;

@end
