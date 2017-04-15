//
//  SUserDB.h
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import "SDBManager.h"
#import "SUser.h"

@interface SUserDB : NSObject {
    FMDatabase * _db;
}


/**
 * @brief 创建数据库
 */
- (void) createDataBase:(NSString *)basename;
/**
 * @brief 保存一条用户记录
 * 
 * @param user 需要保存的用户数据
 */
- (void) saveUser:(SUser *) user;

/**
 * @brief 删除一条用户数据
 *
 * @param uid 需要删除的用户的id
 */
- (void) deleteUserWithId:(NSString *) uid;

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (void) mergeWithUser:(NSString *) user;

/**
 * @brief 模拟分页查找数据。取uid大于某个值以后的limit个数据
 *
 * @param uid 
 * @param limit 每页取多少个
 */
- (NSArray *) findWithUid:(NSString *) uid limit:(int) limit;

- (NSArray *) findWithUid2:(NSString *) uid2 limit2:(int) limit;

- (NSArray *) findWithUid3 :(NSString *) uid2 limit3:(int) limit;

- (NSArray *) findWithUid4 :(NSString *) uid2 limit4:(int) limit;

- (NSInteger *) findWithUid5 :(NSString *) uid2 limit5:(int) limit;

- (NSArray *) findWithUiddtype :(NSString *) uiddtype limitdtype:(int) limitdtype ;
@end
