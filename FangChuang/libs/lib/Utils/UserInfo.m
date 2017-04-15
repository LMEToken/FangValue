//
//  UserInfo.m
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-4.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "UserInfo.h"

static UserInfo * _userInfo;

@implementation UserInfo

//@synthesize usertype;
@synthesize apptoken;
#pragma mark - 获取单例
+ (id)sharedManager{
    if (!_userInfo) {
        _userInfo = [[UserInfo alloc]init];
    }
    return _userInfo;
}



@end
