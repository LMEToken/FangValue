//
//  FangChuangMainCell.h
//  FangChuang
//
//  Created by chenlihua on 14-5-4.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheImageView.h"
#import "TalkLabel.h"
#import "SendfailButton.h"
#import "FangChuangInsiderViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"

@class FangChuangMainCell;
@protocol  FangChuangMainCellDelegate<NSObject>
@required
- (void)myChatCell:(FangChuangMainCell*)cell userId:(NSString*)userId;
@end


@interface FangChuangMainCell : UITableViewCell
{
    //2014.06.12 chenlihua 修改头像缓存方式，暂时注释掉。
   // CacheImageView* headImageView; // 用户头像
    
    TalkLabel* contentLabel; //内容
   // 发送时间
    //  NSMutableDictionary* cellDictionary;
    
    //2014.04.22 chenlihua 将聊天消息内容调整为 头像+昵称+内容+日期时间
   // UILabel *nickLabel;
    
    //2014.06.12 chenlihua 修改头像缓存方式
    UIImageView *headImageViewNew;
    

}
@property (nonatomic,strong)  UITextField* clockTextField;
@property (nonatomic , retain)  NSMutableDictionary* cellDictionary;

//- (id) initWithNSDictionary:(NSDictionary*)dic;

-(void)updata:(NSDictionary *)dic;
@property (nonatomic,retain) UIButton *headButton;

@property (nonatomic,retain) SendfailButton *sighButton;

@property(nonatomic,retain) UILabel *nickLabel;

@end
