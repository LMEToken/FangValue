//
//  SQLite.m
//  FangChuang
//
//  Created by 朱天超 on 14-1-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//数据库文件
#import "SQLite.h"
/*
 
 为了支持本地搜索，
 将所有的表名存到本地
 
 tableName = {
 
 chatt00149:'0',
 chatt00249:'0'
 
 
 }
 
 本地便利 tableName.allKeys;
 
 */

#define ALLTABLENAME @"ALLTABLENAME"

//当前页数
int currentPage = 0;
int firstPage = 0;
@implementation SQLite
{
    NSString* usrIDStr;
}

+ (NSMutableDictionary*)allTableName
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:ALLTABLENAME]];
    
    NSLog(@"tableName = %@",dic);
    if (dic) {
        return dic;
    }
    
    dic = [[NSMutableDictionary alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return dic;
    
}


//获得表名
NSString* tableName(NSString* userID, NSString* talkID)
{
    return [NSString stringWithFormat:@"chat%@%@",userID,talkID];
}

//创建路径
+ (NSString*)getSqlitePath
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    path = [path stringByAppendingString:SQLITENAME];
    
    //NSLog(@"sqlite path = %@",path);
    return path;
}


+ (NSString*)getTime:(NSString*)time
{
    if (time && time.length) {
        return time;
    }
    
    NSMutableString* timeString = [[NSMutableString alloc] init];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [timeString setString:[df stringFromDate:[NSDate date]]];
    
    
    
    return timeString;
}


#pragma mark - 单聊

#pragma mark - 插入数据
//2014.05.22 chenlihua 解决未发送成功消息，连网重新发送。重写函数。

//+ (BOOL)setSingleChatWithUserId:(NSString*)userId
//                         talkId:(NSString*)talkId
//                    contentType:(NSString*)contentType
//                       talkType:(NSString*)talkType
//                      vedioPath:(NSString*)vedioPath
//                        picPath:(NSString*)picPath
//                        content:(NSString*)content
//                           time:(NSString*)time
//                         isRead:(NSString*)isRead
//                         second:(NSString*)second
//                          MegId:(NSString*)MegId
//                       imageUrl:(NSString*)imageUrl
//                         openBy:(NSString*)openby
//                         isSend:(NSString*)isSend
//
//{
//
//    NSString* timeStr = [self getTime:time];
//
//    sqlite3* database;
//
//    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK ) {
//
//        //创建表
//        NSString* creatString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT,imageUrl TEXT,openby TEXT,isSend TEXT)",tableName(userId, talkId)];
//        char* err;
//
//        if (sqlite3_exec(database, [creatString UTF8String], NULL, NULL, &err) == SQLITE_OK) {
//
//            //            NSLog(@"tableName = %@",tableName(userId, talkId));
//
//
//            //保存当前表的名称
//
//
//            NSDictionary* mainDic =[[NSUserDefaults standardUserDefaults] objectForKey:ALLTABLENAME];
//
//            if (mainDic) {
//                NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:mainDic];
//
//                if (![dic objectForKey:tableName(userId, talkId)]) {
//                    [dic setObject:@"0" forKey:tableName(userId, talkId)];
//                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                }
//
//            }
//            else
//            {
//                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
//
//                [dic setObject:@"0" forKey:tableName(userId, talkId)];
//                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//
//
//            }
//
//            /*
//             NSMutableDictionary* dic =  [[self allTableName] retain];
//
//             //保存表明
//             if (![dic objectForKey:tableName(userId, talkId)]) {
//             [dic setObject:@"0" forKey:tableName(userId, talkId)];
//             [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
//             [[NSUserDefaults standardUserDefaults] synchronize];
//             }
//             */
//            //首先判断是否是重复的消息
//
//            //重复消息不在存储
//            if ([self getCountWithTable:tableName(userId, talkId) key:MESSAGEID value:MegId]) {
//
//                NSLog(@"---------------发送9张图片时，消息重复，参数错误----------");
//                return NO;
//
//            }
//
//            //设置插入语句
//            NSString* insertString = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') ",tableName(userId, talkId),USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE,SECOND,MESSAGEID,IMAGEURL,OPENBY,ISSEND,userId,talkId,contentType,vedioPath,picPath,content,timeStr,isRead,talkType,second,MegId,imageUrl,openby,isSend];
//
//            //执行语句
//            return [self excuteSQliteWithString:insertString database:database tableName:tableName(userId, talkId)];
//
//        }
//
//        NSLog(@"setSingChat err = --%s--",err);
//
//
//    }
//
//    sqlite3_close(database);
//    return NO ;
//
//}

//原来代码

-(NSString *)sqliteEscape:(NSString * )keyWord{

    return keyWord;

}
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
                         openBy:(NSString*)openby

{
    
    NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@",userId,talkId,contentType,talkType,vedioPath,picPath,content,time,isRead,second,MegId,imageUrl,openby);
    sleep(0.1);
    NSString* timeStr = [self getTime:time];
    
    sqlite3* database;
    
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK ) {
        
        //创建表
        NSString* creatString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT,imageUrl TEXT,openby TEXT)",tableName(userId, talkId)];
        char* err;
        
        if (sqlite3_exec(database, [creatString UTF8String], NULL, NULL, &err) == SQLITE_OK) {
            
            //            NSLog(@"tableName = %@",tableName(userId, talkId));
            
            //            creatString	__NSCFString *	@"CREATE TABLE IF NOT EXISTS chatt002765 (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT,imageUrl TEXT,openby TEXT)"	0x0d11efe0
            //保存当前表的名称chatt002393081
            
            [[NSUserDefaults standardUserDefaults] setObject:tableName(userId, talkId) forKey:@"tableName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSDictionary* mainDic =[[NSUserDefaults standardUserDefaults] objectForKey:ALLTABLENAME];
            
            if (mainDic) {
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:mainDic];
                
                if (![dic objectForKey:tableName(userId, talkId)]) {
                    [dic setObject:@"0" forKey:tableName(userId, talkId)];
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
            }
            else
            {
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                [dic setObject:@"0" forKey:tableName(userId, talkId)];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
            
            /*
             NSMutableDictionary* dic =  [[self allTableName] retain];
             
             //保存表明
             if (![dic objectForKey:tableName(userId, talkId)]) {
             [dic setObject:@"0" forKey:tableName(userId, talkId)];
             [[NSUserDefaults standardUserDefaults] setObject:dic forKey:ALLTABLENAME];
             [[NSUserDefaults standardUserDefaults] synchronize];
             }
             */
            //首先判断是否是重复的消息
            
            //重复消息不在存储
            //            //tom0918
            if ([self getCountWithTable:tableName(userId, talkId) key:MESSAGEID value:MegId]) {
                  [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"themsgagehave"];
                NSLog(@"---------------发送9张图片时，消息重复，参数错误----------");
                return NO;
                
            }
         

            NSLog(@"---clh--content-----%@",content);
            content = [content stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
            content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
            NSLog(@"%@",content);
            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
            NSLog(@"---clh-second-content-----%@",content);

            NSString* insertString = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') ",tableName(userId, talkId),USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE,SECOND,MESSAGEID,IMAGEURL,OPENBY,userId,talkId,contentType,vedioPath,picPath,content ,timeStr,isRead,talkType,second,MegId,imageUrl,openby];
            //执行语句
            return [self excuteSQliteWithString:insertString database:database tableName:tableName(userId, talkId)];
        }

        sqlite3_close(database);
        NSLog(@"setSingChat err = --%s--",err);
        
        
    }
    sqlite3_close(database);
    
    
    
    return NO ;
    
}

#pragma mark - 获取单聊历史记录
//2014.05.22 chenlihua 重新函数。解决消息未发送成功时，联网自动发送。

//+ (NSArray*)getSingleChatArrayWithUserId:(NSString*)userId talkId:(NSString*)talkId
//{
//    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
//
//
//    //回话ID为空return
//    if (!talkId) {
//        return chatArray;
//    }
//
//    sqlite3* database;
//
//
//
//    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
//
//
//        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
//
//        //        order by time asc  按时间排序 升序 （desc 降序）
//        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM  (SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@' order by time desc LIMIT %@ OFFSET %@) order by time asc",tableName(userId, talkId),TALKID,talkId,USERID,userId,pageNumber,[NSString stringWithFormat:@"%d",currentPage * 10 + firstPage]];
//
//
//        NSLog(@"selectString = %@",selectString);
//        sqlite3_stmt* statement;
//
//        //设置属性
//        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,ISSEND,nil];
//
//        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
//
//            NSLog(@"currentPage = -------------------------->%d",currentPage);
//
//            //判断是否翻页
//            BOOL isAdd = NO;
//
//            //遍历记录行，取出属性
//            while (sqlite3_step(statement) == SQLITE_ROW) {
//
//                isAdd = YES ;
//                //拼接字典
//                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
//
//                for (int i = 0; i < attributes.count; i ++) {
//
//                    //获取属性
//                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
//
//                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
//
//
//                }
//
//                [chatArray addObject:dic];
//
//
//            }
//
//            if (isAdd) {
//                currentPage ++ ;
//            }
//            else
//            {
//                //没有拿到历史数据
//                /*
//                 [[NSNotificationCenter defaultCenter] postNotificationName:tableName(userId, talkId) object:nil];
//                 */
//            }
//
//        }
//
//    }
//    else
//    {
//        NSLog(@"getSingChat -----> error!");
//    }
//
//
//
//
//    return chatArray;
//}
//20140903 tom 添加一条 数据库查询
+ (NSArray*)getSingleChatArrayWithUserId3:(NSString*)userId talkId3:(NSString*)talkId page3:(NSInteger)page opneby:(NSString *)opneby
{
    
    
    NSLog(@"%@",opneby);
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    
    //回话ID为空return
    if (!talkId) {
        return chatArray;
    }
    
    sqlite3* database;
    
    
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM  (SELECT * FROM %@ WHERE %@ = '%@' AND openby = '%@'  order by time desc LIMIT %@ OFFSET %@) order by time asc ",tableName(userId, talkId),TALKID,talkId,opneby ,[NSString stringWithFormat:@"%d",page],[NSString stringWithFormat:@"%d",0]];
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSLog(@"currentPage = -------------------------->%d",currentPage);
            
            //判断是否翻页
            BOOL isAdd = NO;
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                isAdd = YES ;
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
                sqlite3_close(database);
                
            }
            
            if (isAdd) {
                currentPage ++ ;
            }
            else
            {
                //没有拿到历史数据
                /*
                 [[NSNotificationCenter defaultCenter] postNotificationName:tableName(userId, talkId) object:nil];
                 */
            }
            
        }
        
    }
    else
    {
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}


//20140903 tom 添加了一条 数据库查询语句
+ (NSArray*)getSingleChatArrayWithUserId2:(NSString*)userId talkId2:(NSString*)talkId page2:(NSInteger)page
{
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    
    //回话ID为空return
    if (!talkId) {
        return chatArray;
    }
    
    sqlite3* database;
    
    
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM  (SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@'  order by time asc LIMIT %@ OFFSET %@) order by time asc ",tableName(userId, talkId),@"isRead",@"0",USERID,userId,[NSString stringWithFormat:@"%d",page],[NSString stringWithFormat:@"%d",0]];
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSLog(@"currentPage = -------------------------->%d",currentPage);
            
            //判断是否翻页
            BOOL isAdd = NO;
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                isAdd = YES ;
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
                sqlite3_close(database);
                
            }
            
            if (isAdd) {
                currentPage ++ ;
            }
            else
            {
                //没有拿到历史数据
                /*
                 [[NSNotificationCenter defaultCenter] postNotificationName:tableName(userId, talkId) object:nil];
                 */
            }
            
        }
        
    }
    else
    {
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}

//20140809 Tom 修改了查询语句是得到数据的条数自己孔子

+ (NSArray*)getSingleChatArrayWithUserId:(NSString*)userId talkId:(NSString*)talkId page:(NSInteger)page
{
    NSLog(@"%@",talkId);
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    
    //回话ID为空return
    if (!talkId) {
        return chatArray;
    }
    
    sqlite3* database;
    
    
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        //        order by time asc  按时间排序 升序 （desc 降序）
          NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM  (SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@'  order by time desc LIMIT %@ ) order by time asc ",tableName(userId, talkId),TALKID,talkId,USERID,userId,[NSString stringWithFormat:@"%d",page]];
        
//        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM  (SELECT * FROM %@ WHERE %@ = '%@' AND %@ = '%@'  order by time desc LIMIT %@ OFFSET %@) order by time asc ",tableName(userId, talkId),TALKID,talkId,USERID,userId,[NSString stringWithFormat:@"%d",page],[NSString stringWithFormat:@"%d",0]];
        
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSLog(@"currentPage = -------------------------->%d",currentPage);
            
            //判断是否翻页
            BOOL isAdd = NO;
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                isAdd = YES ;
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            if (isAdd) {
                currentPage ++ ;
            }
            else
            {
                //没有拿到历史数据
                /*
                 [[NSNotificationCenter defaultCenter] postNotificationName:tableName(userId, talkId) object:nil];
                 */
            }
            
        }
        
    }
    else
    {
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}

//获取最新数据,获取后把标记变为已读
+ (NSArray*)getNewSingleChatArrayWithUserId:(NSString*)userId talkId:(NSString*)talkId
{
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    
    //回话ID为空return
    if (!talkId) {
        return chatArray;
    }
    
    sqlite3* database;
    
    
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        //NSLog(@"selectString = %@",selectString);
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '0' order by time asc desc LIMIT %d",tableName(userId, talkId),ISREAD,30];
        
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
                
                
                firstPage = chatArray.count;
                sqlite3_close(database);
                
            }
            
            if ([SQLite setMessageReadWithUserId:userId talkId:talkId]) {
                NSLog(@"更改已读成功");
            }
            else
            {
                NSLog(@"更改已读失败");
            }
            
            
            //读取数据成功 ， 将消息标记为 已读
            
            
            
        }
        
    }
    else
    {
        sqlite3_close(database);
        
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}

#pragma -mark -获取未读消息数目，但是并不更新已读
//2014.05.05 chenlihua 软件外部推送消息与内部保持一致
//获取未读消息数目，但是并不更新已读
+ (NSArray*)getUnReadChatNumberWithUserId:(NSString*)userId talkId:(NSString*)talkId
{
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    
    //回话ID为空return
    if (!talkId) {
        return chatArray;
    }
    
    sqlite3* database;
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        //NSLog(@"selectString = %@",selectString);
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '0' order by time asc",tableName(userId, talkId),ISREAD];
        
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
                
                
                firstPage = chatArray.count;
                sqlite3_close(database);
                
            }
            
            /*
             if ([SQLite setMessageReadWithUserId:userId talkId:talkId]) {
             NSLog(@"更改已读成功");
             }
             else
             {
             NSLog(@"更改已读失败");
             }
             */
            
            //读取数据成功 ， 将消息标记为 已读
            
            
            
        }
        
    }
    else
    {
        sqlite3_close(database);
        
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}

#pragma -mark -获取全部未读数据，根据账号名,软件外部右上角的推送的未读消息的数目
//只由名字获得表名
//2014.05.05 chenlihua 软件外部推送消息与内部保持一致
//获取所有的未读消息数，推送时软件右上角显示的数字
+ (NSArray*)getAllUnReadChatNumberWithUserId:(NSString*)userId
{
    NSMutableArray* chatArray = [[NSMutableArray alloc] init];
    
    sqlite3* database;
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        //NSLog(@"selectString = %@",selectString);
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        // NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '0' order by time asc",tableName(userId, talkId),ISREAD];
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '0' order by time asc",userId,ISREAD];
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                
                [chatArray addObject:dic];
                
                
                firstPage = chatArray.count;
                sqlite3_close(database);
                
            }
            
            /*
             if ([SQLite setMessageReadWithUserId:userId talkId:talkId]) {
             NSLog(@"更改已读成功");
             }
             else
             {
             NSLog(@"更改已读失败");
             }
             */
            
            //读取数据成功 ， 将消息标记为 已读
            
            
            
        }
        
    }
    else
    {
        sqlite3_close(database);
        
        NSLog(@"getSingChat -----> error!");
    }
    
    
    
    
    return chatArray;
}

+ (BOOL)setMessageReadWithUserId:(NSString*)userId talkId:(NSString*)talkId
{
    sqlite3* db;
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &db) == SQLITE_OK) {
        NSString* sql = [NSString stringWithFormat:@"update %@  set %@ = 1 where %@ = 0",tableName(userId, talkId),ISREAD,ISREAD];
        NSLog(@"sql = %@",sql);
        
        
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK ) {
            sqlite3_close(db);
            return YES;
        }
    }
    else
    {
        sqlite3_close(db);
    }
    return NO;
}


+ (BOOL)setReadWithUserId:(NSString*)userId
                   talkId:(NSString*)talkId
                       ID:(NSString*)ID
{
    sqlite3* db;
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &db) == SQLITE_OK) {
        
        char* err;
        
        NSString* select = [NSString stringWithFormat:@"update  %@ set isRead = 2 where ID = %@",tableName(userId, talkId),ID];
        if (sqlite3_exec(db, [select UTF8String], NULL, NULL, &err) == SQLITE_OK) {
            
            return YES ;
        }
        
    }
    
    return NO;
}


+(BOOL)isHaveMsgIdInDataBaseWith:(NSString *)msgId andUserName:(NSString *)userName andTalkId:(NSString *)talkId
{
    sqlite3* database;
    
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        
        //limit pagenumber offset current row;  取当前行之后的pagenumber条数据  等同于 limit row，pagenumber
        
        //        order by time asc  按时间排序 升序 （desc 降序）
        NSString* selectString = [NSString stringWithFormat:@"SELECT * FROM %@ where MegId=%@",tableName(userName, talkId),msgId];
        
        NSLog(@"selectString = %@",selectString);
        sqlite3_stmt* statement;
        
        //设置属性
        NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,@"MegId",nil];
        
        if (sqlite3_prepare_v2(database, [selectString UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            //遍历记录行，取出属性
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //拼接字典
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < attributes.count; i ++) {
                    
                    //获取属性
                    NSString* value = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, i)];
                    
                    [dic setObject:value forKey:[attributes objectAtIndex:i]];
                    
                    
                }
                if([dic objectForKey:@"MegId"]!=nil)
                    return YES;
                
            }
            
        }
        
    }
    else
    {
        NSLog(@"getSingChat -----> error!");
    }
    
    return NO;
}




#pragma mark - 判断条数
//tom0918
+(int)getCountWithTable:(NSString*)table key:(NSString*)key value:(NSString*)value
{
    
    
    sqlite3 *chatDb;
    
    sqlite3_stmt * statement = NULL;
    if (sqlite3_open([[self getSqlitePath] UTF8String], &chatDb)==SQLITE_OK) {
        
        NSString *sql1 = [NSString stringWithFormat:@"SELECT  COUNT(%@)  FROM %@   WHERE  %@ ='%@'  order by messageId  desc  limit  1",key,table,key,value];
        
        if (sqlite3_prepare_v2(chatDb, [sql1 UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            int count = 0;
            if (sqlite3_step(statement))
            {
                count = sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
            sqlite3_close(chatDb);
            return count;
            
            
        }
        else
        {
            
            sqlite3_finalize(statement);
                sqlite3_close(chatDb);
            return 0;
            
            
        }

        
    }else{
        sqlite3_finalize(statement);
        sqlite3_close(chatDb);
        return 0;
    }
    
}

#pragma mark - 设置时间

+ (BOOL)setLastTime:(NSString*)lastTime
{
    
    if (lastTime== nil) {
        return NO;
    }
    
    
    /*
     在这里将时间首先存到本地
     
     */
    
    
    [[NSUserDefaults standardUserDefaults] setObject:lastTime forKey:@"LASTTIME"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
    
    /*
     sqlite3* database;
     
     if (sqlite3_open([[SQLite getSqlitePath] UTF8String], &database) == SQLITE_OK) {
     
     //        @"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT)"
     NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY ,TIME TEXT)",LASTTABLE];
     
     if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK) {
     
     
     NSString* insert = [NSString stringWithFormat:@"insert or replace into '%@' (ID, TEXT) values('1','%@')",LASTTABLE,lastTime];
     
     
     if (sqlite3_exec(database, [insert UTF8String], NULL, NULL, nil) == SQLITE_OK) {
     
     sqlite3_close(database);
     
     return YES;
     
     }
     
     }
     
     }
     
     sqlite3_close(database);
     
     return NO;
     */
}

+ (NSString*)getLastTime
{
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"LASTTIME"];
    
    /*
     sqlite3* database;
     
     if (sqlite3_open([[SQLite getSqlitePath] UTF8String], &database)) {
     
     //        @"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT)"
     NSString* sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE ID = 1",LASTTABLE];
     
     sqlite3_stmt* STMT;
     
     
     if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &STMT, NULL)) {
     
     while (sqlite3_step(STMT) ==  SQLITE_ROW) {
     
     NSString*  str = [NSString stringWithUTF8String:(char*)sqlite3_column_text(STMT, 1)];
     if (str) {
     return str;
     }
     
     }
     
     }
     
     
     }
     
     sqlite3_close(database);
     
     return nil;
     */
}


+ (BOOL)excuteSQliteWithString:(NSString *)sql database:(sqlite3 *)db tableName:(NSString*)name
{
    char* err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        
        
        
        sqlite3_close(db);
        //NSLog(@"数据库操作失败 -> (%s)",err);
        
        return NO;
    }
    else
    {
        /*
         //获取时间
         
         NSString* select = [NSString stringWithFormat:@"select time from %@ order by time desc",name];
         
         sqlite3_stmt* stmt;
         
         if (sqlite3_prepare_v2(db, [select UTF8String], -1, &stmt, nil) == SQLITE_OK) {
         
         while (sqlite3_step(stmt) == SQLITE_ROW) {
         
         
         NSString* time = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)];
         sqlite3_close(db);
         
         [self setLastTime:time];
         
         NSLog(@"lastTime = %@ , time = ",time);
         break ;
         }
         
         
         }
         */
        
        sqlite3_close(db);
        
        return YES;
    }
    
}



#pragma mark - 项目进展

+ (void)setProjectName:(NSString*)name
                 order:(NSString*)order
               is_read:(NSString*)is_read
               plan_id:(NSString*)plan_id
                  date:(NSString*)date
{
    
    sqlite3* database;
    
    NSLog(@"project path ----------> %@",[self getSqlitePath]);
    //打开数据库
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        
        //        @"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT)"
        
        
        NSString* insertString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT , order_id TEXT , is_read TEXT,plan_id TEXT , date TEXT)",[NSString stringWithFormat:@"project%@",[[UserInfo sharedManager] username]]];
        char* err ;
        
        if (sqlite3_exec(database, [insertString UTF8String], NULL, NULL, &err) == SQLITE_OK) {
            
            
            //存在就不插入
            //            if ([self getCountWithTable:[NSString stringWithFormat:@"project%@",[[UserInfo sharedManager]username]] key:@"plan_id" value:plan_id]) {
            //
            //                return;
            //            }
            
            NSString* string = [NSString stringWithFormat:@"INSERT INTO '%@' ('name', 'order_id' , 'is_read' , 'plan_id'  , 'date' ) VALUES ('%@','%@','%@','%@','%@')",[NSString stringWithFormat:@"project%@",[[UserInfo sharedManager]username]] ,name, order , is_read,plan_id  , date ];
            
            
            
            if (sqlite3_exec(database, [string UTF8String], NULL, NULL, &err) == SQLITE_OK) {
                
                sqlite3_close(database);
                
            }
            
            
        }
        
        NSLog(@"err = %s",err);
    }
    else
    {
        sqlite3_close(database);
    }
    
    
}




+ (void)setReadWithPlan_id:(NSString*)plan_id
{
    sqlite3* database;
    
    
    if (sqlite3_open([[self getSqlitePath]UTF8String], &database) == SQLITE_OK  ) {
        
        NSString* string =[NSString stringWithFormat:@"update %@ set is_read = 1 where plan_id = %@",[NSString stringWithFormat:@"project%@",[[UserInfo sharedManager]username]],plan_id];
        
        if (sqlite3_exec(database, [string UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            
        }
        
    }
    
    sqlite3_close(database);
    
    
}

+ (NSArray*)getProject
{
    
    NSMutableArray* projects = [[NSMutableArray alloc] init];
    sqlite3* database;
    
    if (sqlite3_open([[self getSqlitePath]UTF8String], &database) == SQLITE_OK) {
        
        NSString* string = [NSString stringWithFormat:@"SELECT * FROM %@",[NSString stringWithFormat:@"project%@",[[UserInfo sharedManager]username]]];
        
        sqlite3_stmt * stmt;
        if (sqlite3_prepare_v2(database, [string UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            NSArray* array = [NSArray arrayWithObjects:@"name", @"order_id" , @"is_read",@"plan_id"  , @"date"  , nil];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < array.count; i++) {
                    
                    NSString* value = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, i + 1)];
                    [dic setObject:value forKey:[array objectAtIndex:i]];
                    
                }
                
                [projects addObject:dic];
                
                
            }
            
        }
        
    }
    
    sqlite3_close(database);
    
    return projects;
    
}




+ (void)setRenWuName:(NSString*)name
               order:(NSString*)order
             is_read:(NSString*)is_read
             plan_id:(NSString*)plan_id
                date:(NSString*)date
{
    
    sqlite3* database;
    
    NSLog(@"project path ----------> %@",[self getSqlitePath]);
    //打开数据库
    if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
        
        
        //        @"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,userId TEXT,talkId TEXT,contentType TEXT,vedioPath TEXT,picPath TEXT,content TEXT,time TEXT,isRead TEXT ,talkType TEXT,second TEXT,messageId TEXT)"
        
        
        NSString* insertString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT , order_id TEXT , is_check TEXT,plan_id TEXT , date TEXT)",[NSString stringWithFormat:@"RenWu%@",[[UserInfo sharedManager] username]]];
        char* err ;
        
        if (sqlite3_exec(database, [insertString UTF8String], NULL, NULL, &err) == SQLITE_OK) {
            
            
            //存在就不插入
            //            if ([self getCountWithTable:[NSString stringWithFormat:@"RenWu%@",[[UserInfo sharedManager]username]] key:@"plan_id" value:plan_id]) {
            //
            //                return;
            //            }
            
            NSString* string = [NSString stringWithFormat:@"INSERT INTO '%@' ('name', 'order_id' , 'is_check' , 'plan_id'  , 'date' ) VALUES ('%@','%@','%@','%@','%@')",[NSString stringWithFormat:@"RenWu%@",[[UserInfo sharedManager]username]] ,name, order , is_read,plan_id  , date ];
            
            
            
            if (sqlite3_exec(database, [string UTF8String], NULL, NULL, &err) == SQLITE_OK) {
                
                sqlite3_close(database);
                
            }
            
            
        }
        
        NSLog(@"err = %s",err);
    }
    else
    {
        sqlite3_close(database);
    }
    
    
}



+ (void)setCheckWithPlan_id:(NSString*)plan_id
{
    sqlite3* database;
    
    
    if (sqlite3_open([[self getSqlitePath]UTF8String], &database) == SQLITE_OK  ) {
        
        NSString* string =[NSString stringWithFormat:@"update %@ set is_check = 1 where plan_id = %@",[NSString stringWithFormat:@"RenWu%@",[[UserInfo sharedManager]username]],plan_id];
        
        if (sqlite3_exec(database, [string UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            
        }
        
    }
    
    sqlite3_close(database);
    
    
}


+ (NSArray*)getRenWu
{
    
    NSMutableArray* projects = [[NSMutableArray alloc] init];
    sqlite3* database;
    
    if (sqlite3_open([[self getSqlitePath]UTF8String], &database) == SQLITE_OK) {
        
        NSString* string = [NSString stringWithFormat:@"SELECT * FROM %@",[NSString stringWithFormat:@"RenWu%@",[[UserInfo sharedManager]username]]];
        
        sqlite3_stmt * stmt;
        if (sqlite3_prepare_v2(database, [string UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            
            NSArray* array = [NSArray arrayWithObjects:@"name", @"order_id" , @"is_check",@"plan_id"  , @"date"  , nil];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < array.count; i++) {
                    
                    NSString* value = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, i + 1)];
                    [dic setObject:value forKey:[array objectAtIndex:i]];
                    
                }
                
                [projects addObject:dic];
                
                
            }
            
        }
        
    }
    
    sqlite3_close(database);
    
    return projects;
    
}




#pragma mark - 获取模糊查询聊天记录

+ (NSMutableArray*)getLikeChatWithKey:(NSString*)key
{
    NSMutableArray* likeArray = [[NSMutableArray alloc] init];
    
    NSDictionary* allTableDic = [self allTableName];
    
    for (int i = 0; i < allTableDic.allKeys.count; i ++) {
        
        
        sqlite3* database ;
        
        if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
            
            
            NSString* usrIDStr = [NSString stringWithFormat:@"select * from %@ where %@ like ",[allTableDic.allKeys objectAtIndex:i],CONTENT];
            NSMutableString *sql=[[NSMutableString alloc] initWithString:usrIDStr];
            
            [sql appendString:@"'%"];
            [sql appendString:key];
            [sql appendString:@"%'"];
            
            
            const char *err;
            sqlite3_stmt* stmt;
            if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, &err) == SQLITE_OK) {
                
                //设置属性
                NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
                
                while (sqlite3_step(stmt) == SQLITE_ROW) {
                    
                    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                    
                    for (int i = 0; i < attributes.count; i++) {
                        
                        NSString* str = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i)];
                        [dic setObject:str forKey:[attributes objectAtIndex:i]];
                        
                    }
                    
                    [likeArray addObject:dic];
                    
                    
                }
                
            }
            
            NSLog(@"error = %s" , err);
            sqlite3_finalize(stmt);
            
        }
        
        sqlite3_close(database);
    }
    return likeArray;
}
//2014.04.26 chenlihua 将搜索功能做成和微信的一样按照昵称和聊天内容进行查询
#pragma -mark -获取聊天内容和聊天记录的一起查询
+ (NSMutableArray*)getLikeNicNameWithKey:(NSString*)key
{
    NSMutableArray* likeArray = [[NSMutableArray alloc] init];
    
    NSDictionary* allTableDic = [self allTableName];
    
    for (int i = 0; i < allTableDic.allKeys.count; i ++) {
        
        
        sqlite3* database ;
        
        if (sqlite3_open([[self getSqlitePath] UTF8String], &database) == SQLITE_OK) {
            
            //昵称数据库查询
            NSString* usrNickStr = [NSString stringWithFormat:@"select * from %@ where %@ like ",[allTableDic.allKeys objectAtIndex:i],OPENBY];
            
            NSMutableString *sqlNick=[[NSMutableString alloc] initWithString:usrNickStr];
            
            [sqlNick appendString:@"'%"];
            [sqlNick appendString:key];
            [sqlNick appendString:@"%'"];
            
            //聊天记录数据库查询
            NSString* usrChatStr = [NSString stringWithFormat:@"select * from %@ where %@ like ",[allTableDic.allKeys objectAtIndex:i],CONTENT];
            
            NSMutableString *sqlChat=[[NSMutableString alloc] initWithString:usrChatStr];
            
            [sqlChat appendString:@"'%"];
            [sqlChat appendString:key];
            [sqlChat appendString:@"%'"];
            
            
            //将昵称查询和聊天记录查询整合成一条查询语句
            NSString* usrIDStr = [NSString stringWithFormat:@"%@ union %@",sqlNick,sqlChat];
            
            NSMutableString *sql=[[NSMutableString alloc] initWithString:usrIDStr];
            
            NSLog(@"----查询语句--%@-----------",sql);
            
            const char *err;
            sqlite3_stmt* stmt;
            if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, &err) == SQLITE_OK) {
                
                //设置属性
                NSArray* attributes = [NSArray arrayWithObjects:@"ID",USERID,TALKID,CONTENTTYPE,VEDIOPATH,PICPATH,CONTENT,TIME,ISREAD,TALKTYPE, SECOND,MESSAGEID,IMAGEURL,OPENBY,nil];
                
                while (sqlite3_step(stmt) == SQLITE_ROW) {
                    
                    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                    
                    for (int i = 0; i < attributes.count; i++) {
                        
                        NSString* str = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i)];
                        [dic setObject:str forKey:[attributes objectAtIndex:i]];
                        
                    }
                    
                    [likeArray addObject:dic];
                    
                    
                }
                
            }
            
            NSLog(@"error = %s" , err);
            sqlite3_finalize(stmt);
            
        }
        
        sqlite3_close(database);
    }
    return likeArray;
}





@end
