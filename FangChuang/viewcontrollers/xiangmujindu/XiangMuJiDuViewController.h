//
//  XiangMuJiDuViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface XiangMuJiDuViewController : ParentViewController
{
    UIView* zhuView;
    NSString *_ProId;
    NSDictionary *dic;
}
@property(nonatomic,copy)NSString *ProId;
@end
