//
//  SQLite.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


#define SQLITENAME      @"/chat.sqlite"
#define SINGLECHATTABLE @"singlechat"
#define GROUPCHATTABLE  @"groupchat"
#define LASTTABLE       @"last"

//数据库属性
#define USERID @"userId"
#define TALKID @"talkId"
#define CONTENTTYPE @"contentType"
#define TALKTYPE @"talkType" // 0 self , 1 other
#define VEDIOPATH @"vedioPath"
#define PICPATH @"picPath"
#define CONTENT @"content"
#define TIME @"time"
#define ISREAD @"isRead"  // 0 未读 ， 1 已读  录音 2是已读
#define SECOND @"second"
#define MESSAGEID @"messageId" //消息的主键
#define IMAGEURL @"imageUrl" // 对方的头像
#define OPENBY @"openby"  //消息发送者

//2014.05.22 chenlihua 解决未发送成功消息，联网自动重发问题。
#define ISSEND @"isSend"//消息是否发送成功



//2014.05.27 chenlihua 把聊天界面的消息条数改成显示50.
//#define pageNumber @"10"
#define pageNumber @"50"

extern  int currentPage;
extern  int firstPage;
@interface SQLite : NSObject



/***********
 方创本地思路：
 
 根据 userID 和 回话ID 建多张表
 历史数据直接从本地拿
 没有历史数据的时候从服务器拿去
 
 *************/
//dgid = 630;
//dname = "\U65b9\U521bIT";
//dtype = 1;
//extension = "<null>";
//localid = 1;
//mcnt = 15;
//msgid = 92598;
//msgpath = "<null>";
//msgtext = HHS;
//msgtype = 0;
//openby = t002;
//opendatetime = "2014-08-10 13:44:34";
//vsec = 0;
+ (BOOL)setunRead:(NSString*)dname dtype:(NSString*)dtype;


/*
 单聊缓存
 
 */
+ (BOOL)setSingleChatWithUserId:(NSString*)userId
                         talkId:(NSString*)talkId
                    contentType:(NSString*)contentType
                       talkType:(NSString*)talkType
                      vedioPath:(NSString*)vedioPath
                        picPath:(NSString*)picPath
                        content:(NSString*)content
                           time:(NSString*)time
                         isRead:(NSString*)isRead
                         second:(NSString*)second
                          MegId:(NSString*)MegId
                       imageUrl:(NSString*)imageUrl
                         openBy:(NSString*)openby;


#pragma mark-消息是否重发
+(BOOL)isHaveMsgIdInDataBaseWith:(NSString *)msgId andUserName:(NSString *)userName andTalkId:(NSString *)talkId;

//设置录音已读
+ (BOOL)setReadWithUserId:(NSString*)userId
                   talkId:(NSString*)talkId
                       ID:(NSString*)ID;

/*
 获取单聊数据
 
 */
//查询 每个 群最后的一条数据
+ (NSArray*)getSingleChatArrayWithUserId3:(NSString*)userId talkId3:(NSString*)talkId page3:(NSInteger)page opneby:(NSString *)opneby;

//查询 isread = 0 的数据
+ (NSArray*)getSingleChatArrayWithUserId2:(NSString*)userId talkId2:(NSString*)talkId page2:(NSInteger)page;
//获取历史数据(NSString*)dname dtype:(NSString*)dtype;
+ (NSArray*)getunRead:(NSString*)dname dtype:(NSString*)dtype;

+ (NSArray*)getSingleChatArrayWithUserId:(NSString*)userId talkId:(NSString*)talkId page:(NSInteger) page;

//获取最新数据
+ (NSArray*)getNewSingleChatArrayWithUserId:(NSString*)userId talkId:(NSString*)talkId;


+ (BOOL)setLastTime:(NSString*)lastTime;

+ (NSString*)getLastTime;




#pragma mark - 项目进展

+ (void)setProjectName:(NSString*)name
                 order:(NSString*)order
               is_read:(NSString*)is_read
               plan_id:(NSString*)plan_id
                  date:(NSString*)date;



+ (void)setReadWithPlan_id:(NSString*)plan_id;


+ (NSArray*)getProject;



#pragma mark - 方创任务

+ (void)setRenWuName:(NSString*)name
               order:(NSString*)order
             is_read:(NSString*)is_read
             plan_id:(NSString*)plan_id
                date:(NSString*)date;



+ (void)setCheckWithPlan_id:(NSString*)plan_id;


+ (NSArray*)getRenWu;





#pragma mark - 获取模糊查询聊天记录

+ (NSMutableArray*)getLikeChatWithKey:(NSString*)key;

//2014.04.26 chenlihua 将搜索功能做成和微信的一样按照昵称和聊天内容进行查询
+ (NSMutableArray*)getLikeNicNameWithKey:(NSString*)key;

//2014.05.05 chenlihua 软件外部推送图标与同部提醒保持一致
//从服务器获取未读消息，但是并不标记为已读
+ (NSArray*)getUnReadChatNumberWithUserId:(NSString*)userId talkId:(NSString*)talkId;

//2014.05.05 chenlihua 软件外部推送消息与内部保持一致
//获取所有的未读消息数，推送时软件右上角显示的数字
+ (NSArray*)getAllUnReadChatNumberWithUserId:(NSString*)userId;
@end
