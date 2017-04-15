//
//  AsyncSocket+Single.m
//  FangChuang
//
//  Created by chenlihua on 14-7-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "AsyncSocket+Single.h"


static AsyncSocket *_manager;

@implementation AsyncSocket (Single)

#pragma mark - 获取单例
+ (id)sharedManager{
    if (!_manager) {
        _manager=[[AsyncSocket alloc]init];
    }
    return _manager;
}
+(void)clhSocketInit:(AsyncSocket *)socket
{
    [socket connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:nil];
}

@end
