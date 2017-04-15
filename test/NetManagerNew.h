//
//  NetManagerNew.h
//  FangChuang
//
//  Created by chenlihua on 14-8-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetManagerNew : NSObject

+ (id)sharedManagerNew;
- (void)senddiscussionWithusername:(NSString*)username
                               did:(NSString*)did
                           msgtype:(NSString*)msgtype
                           msgtext:(NSString*)msgtext
                      opendatetime:(NSString*)opendatetime
                            openby:(NSString*)openby
                             locaid:(NSString *)locaid
                            hudDic:(NSDictionary*)hudDic
                           success:(void (^)(id responseDic))_success
                              fail:(void (^)(id errorString))_fail;



@end
