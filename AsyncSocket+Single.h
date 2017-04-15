//
//  AsyncSocket+Single.h
//  FangChuang
//
//  Created by chenlihua on 14-7-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "AsyncSocket.h"

@interface AsyncSocket (Single)

+ (id)sharedManager;
+(void)clhSocketInit:(AsyncSocket *)socket;

@end
