//
//  socketNet.m
//  FangChuang
//
//  Created by chenlihua on 14-7-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "socketNet.h"
#import "AsyncSocket.h"

static socketNet *_manager;

@implementation socketNet


+ (id)sharedSocketNet{
 
    if (!_manager) {
       _manager=[[socketNet alloc] initWithDelegate:self];
    }
    if (![_manager isConnected]) {
        NSError* error = nil;
        [_manager connectToHost:SOCKETADDRESS onPort:SOCKETPORT error:&error];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstconnet"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return _manager;
}
+(void)managerDisconnect
{
    [_manager setDelegate:nil];
    [_manager disconnect];
    
    
}

@end
