//
//  NetTest.m
//  DuiDuiLa
//
//  Created by 潘鸿吉 on 13-7-17.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "NetTest.h"
#import "NetManager.h"
#import "UIDevice+IdentifierAddition.h"
@implementation NetTest

+ (void) netTest
{
    
    // 获取token，每次进入应用必须调用
    [[NetManager sharedManager] getTokenWithdeviceid:[[UIDevice currentDevice] uniqueDeviceIdentifier]
                                              hudDic:nil
                                             success:^(id responseDic) {
                                                 NSLog(@"responseDic = %@",responseDic);
                                                 
                                                 [[UserInfo sharedManager] setApptoken:[Utils checkKey:responseDic key:@"apptoken"]];
                                                 
                                                 
                                                 
                                             }
                                                 fail:^(id errorString) {
                                                     NSLog(@"errorString = %@",errorString);
                                                 }];
}






@end
