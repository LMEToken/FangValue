//
//  SUserDB.m
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import "SUserDB.h"

#define kUserTableName @"SUser"

@implementation SUserDB

- (id) init {
    self = [super init];
    if (self) {
        //========== 首先查看有没有建立message的数据库，如果未建立，则建立数据库=========
        _db = [SDBManager defaultDBManager].dataBase;
        
    }
    return self;
}

/**
 * @brief 创建数据库
 */
- (void) createDataBase:(NSString *)basename {
    FMResultSet * set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",basename]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    if (existTable) {
        // TODO:是否更新数据库
    
    } else {
        // TODO: 插入新的数据库
        NSString * sql =[NSString stringWithFormat:@"CREATE TABLE %@ (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, titleName VARCHAR(50),conText VARCHAR(50),username VARCHAR(50),contentType VARCHAR(50), msgid VARCHAR(50),description VARCHAR(100),readed VARCHAR(50) )",basename];
        //@"CREATE TABLE SUser (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, titleName VARCHAR(50),conText VARCHAR(50),username VARCHAR(50),contentType VARCHAR(50), msgid VARCHAR(50),description VARCHAR(100))";
        BOOL res = [_db executeUpdate:sql];
        if (!res) {

        } else {
     
        }
    }
}

/**
 * @brief 保存一条用户记录
 *
 * @param user 需要保存的用户数据
 */
- (void) saveUser:(SUser *) user {
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO SUser"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:5];
    if (user.titleName) {
        [keys appendString:@"titleName,"];
        [values appendString:@"?,"];
        [arguments addObject:user.titleName];
    }
    if (user.conText) {
        [keys appendString:@"conText,"];
        [values appendString:@"?,"];
        [arguments addObject:user.conText];
    }
    if (user.username) {
        [keys appendString:@"username,"];
        [values appendString:@"?,"];
        [arguments addObject:user.username];
    }
    if (user.contentType) {
        [keys appendString:@"contentType,"];
        [values appendString:@"?,"];
        [arguments addObject:user.contentType];
    }
    if (user.msgid) {
        [keys appendString:@"msgid,"];
        [values appendString:@"?,"];
        [arguments addObject:user.msgid];
    }
    if (user.description) {
        [keys appendString:@"description,"];
        [values appendString:@"?,"];
        [arguments addObject:user.description];
    }
    if (user.readed) {
        [keys appendString:@"readed,"];
        [values appendString:@"?,"];
        [arguments addObject:user.readed];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    NSLog(@"%@   %@",query,arguments);
    
    [_db executeUpdate:query withArgumentsInArray:arguments];
}

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void) deleteUserWithId:(NSString *) uid {
    NSString * query = [NSString stringWithFormat:@"DELETE FROM SUser WHERE uid = '%@'",uid];

    [_db executeUpdate:query];
}

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (void) mergeWithUser:(NSString *) user {

    
//    if (!user.uid) {
//        return;
//    }
   NSString * query =[NSString stringWithFormat:@"UPDATE SUser SET Readed ='1'  where titleName = '%@'",user];
    //[NSString stringWithFormat:@"UPDATE SUser SET Readed ='1'  where titleName = '106' "];
//    NSMutableString * temp = [NSMutableString stringWithCapacity:20];
//    // xxx = xxx;
//    if (user.titleName) {
//        [temp appendFormat:@" name = '%@',",user.titleName];
//    }
//    if (user.description) {
//        [temp appendFormat:@" description = '%@',",user.description];
//    }
//    [temp appendString:@")"];
//    query = [query stringByAppendingFormat:@"%@ WHERE uid = '%@'",[temp stringByReplacingOccurrencesOfString:@",)" withString:@""],user.uid];
//    NSLog(@"%@",query);
//      
//  
     [_db executeUpdate:query];
 
}

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid
 * @param limit 每页取多少个
 */
- (NSArray *) findWithUid:(NSString *) uid limit:(int) limit {
    NSString * query = @"SELECT uid,name,description FROM SUser";
//    if (!uid) {
//        query = [query stringByAppendingFormat:@" ORDER BY uid DESC limit %d",limit];
//    } else {
//        query = [query stringByAppendingFormat:@" WHERE uid > %@ ORDER BY uid DESC limit %d",uid,limit];
//    }
 
    FMResultSet * rs = [_db executeQuery:query];
    NSLog(@"%@",rs);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        user.readed = [rs stringForColumn:@"readed"];
       
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,user.readed,nil  ]];
	}
	[rs close];
    return array;
}
- (NSInteger *) findWithUid5 :(NSString *) uid2 limit5:(int) limit {
      NSString * query =[NSString stringWithFormat:@"SELECT *  FROM SUser  where  titleName = '%@' and  readed='0' ",uid2];
    //[NSString stringWithFormat:@"SELECT Count(*)  FROM SUser  where  titleName = '%@' add readed='0' ",uid2];

    
    FMResultSet * rs = [_db executeQuery:query];
    NSLog(@"%@",rs);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        user.readed = [rs stringForColumn:@"readed"];
        
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,user.readed,nil  ]];
	}
	[rs close];
    return array.count;
    
}
- (NSArray *) findWithUid2 :(NSString *) uid2 limit2:(int) limit {
    //    NSString * query = @"SELECT uid,name,description FROM SUser";
    //    if (!uid) {
    //        query = [query stringByAppendingFormat:@" ORDER BY uid DESC limit %d",limit];
    //    } else {
    //        query = [query stringByAppendingFormat:@" WHERE uid > %@ ORDER BY uid DESC limit %d",uid,limit];
    //    }
       NSString * query =[NSString stringWithFormat:@"SELECT *  FROM SUser  where  titleName = '%@' ORDER BY uid DESC limit 1",uid2];
//    @"SELECT *  FROM   SUser   where  titleName";
    
    FMResultSet * rs = [_db executeQuery:query];
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        user.readed = [rs stringForColumn:@"readed"];
        
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,user.readed,nil  ]];
	}
	[rs close];
    return array;
}
- (NSArray *) findWithUiddtype :(NSString *) uiddtype limitdtype:(int) limitdtype {
    //    NSString * query = @"SELECT uid,name,description FROM SUser";
    //    if (!uid) {
    //        query = [query stringByAppendingFormat:@" ORDER BY uid DESC limit %d",limit];
    //    } else {
    //        query = [query stringByAppendingFormat:@" WHERE uid > %@ ORDER BY uid DESC limit %d",uid,limit];
    //    }
    NSString * query =[NSString stringWithFormat:@"SELECT *  FROM SUser  where  msgid = '%@'  and  readed = '0' ",uiddtype];
    //    @"SELECT *  FROM   SUser   where  titleName";
    
    FMResultSet * rs = [_db executeQuery:query];
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        user.readed = [rs stringForColumn:@"readed"];
        
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,user.readed,nil  ]];
	}
	[rs close];
    return array;
}

- (NSArray *) findWithUid3 :(NSString *) uid2 limit3:(int) limit {
    //    NSString * query = @"SELECT uid,name,description FROM SUser";
    //    if (!uid) {
    //        query = [query stringByAppendingFormat:@" ORDER BY uid DESC limit %d",limit];
    //    } else {
    //        query = [query stringByAppendingFormat:@" WHERE uid > %@ ORDER BY uid DESC limit %d",uid,limit];
    //    }query	__NSCFConstantString *	@"SELECT * FROM SUser  ORDER BY uid DESC limit 1"	0x0043aa94
    NSString * query =@"SELECT * FROM SUser  ";
    //    @"SELECT *  FROM   SUser   where  titleName";
    
    NSLog(@"%@",query);
    FMResultSet * rs = [_db executeQuery:query];
    NSLog(@"%@",rs);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,nil  ]];
	}
	[rs close];
 
    return array;
}


- (NSArray *) findWithUid4 :(NSString *) uid2 limit4:(int) limit {
    //    NSString * query = @"SELECT uid,name,description FROM SUser";
    //    if (!uid) {
    //        query = [query stringByAppendingFormat:@" ORDER BY uid DESC limit %d",limit];
    //    } else {
    //        query = [query stringByAppendingFormat:@" WHERE uid > %@ ORDER BY uid DESC limit %d",uid,limit];
    //    }query	__NSCFConstantString *	@"SELECT * FROM SUser  ORDER BY uid DESC limit 1"	0x0043aa94
    NSString * query =@"SELECT * FROM SUser  ORDER BY uid DESC limit 1 ";
    //    @"SELECT *  FROM   SUser   where  titleName";
    
    NSLog(@"%@",query);
    FMResultSet * rs = [_db executeQuery:query];
    NSLog(@"%@",rs);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next]) {
        SUser * user = [SUser new];
        user.uid = [rs stringForColumn:@"uid"];
        user.titleName = [rs stringForColumn:@"titleName"];
        user.conText= [rs stringForColumn:@"conText"];
        user.username= [rs stringForColumn:@"username"];
        user.contentType= [rs stringForColumn:@"contentType"];
        user.msgid = [rs stringForColumn:@"msgid"];
        user.description = [rs stringForColumn:@"description"];
        
        [array addObject:[NSArray arrayWithObjects:user.titleName,user.conText,user.username,user.contentType, user.msgid ,user.description,nil  ]];
	}
	[rs close];
    
    return array;
}
@end
