//
//  SUser.h
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUser : NSObject

@property (nonatomic, copy) NSString * uid;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *conText;

@property (nonatomic, strong) NSString *username;
//创建时间
@property (nonatomic, strong) NSString *contentType;
//状态，是否完成
@property (nonatomic, strong)NSString* msgid;

@property (nonatomic, copy) NSString * description;

@property (nonatomic, copy)NSString *readed;

@end
