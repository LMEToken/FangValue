//
//  ZBMessageShareMenuItem.h
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-13.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBMessageShareMenuItem : UIButton

@property (nonatomic, strong) UIImage *normalIconImage;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
                                  title:(NSString *)title;

@end
