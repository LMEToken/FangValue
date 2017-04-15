//
//  socketNet.h
//  FangChuang
//
//  Created by chenlihua on 14-7-7.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface socketNet : AsyncSocket
<AsyncSocketDelegate>

+ (id)sharedSocketNet;
+(void)managerDisconnect;

@end
