//
//  EditTimeViewController.h
//  FangChuang
//
//  Created by 顾 思谨 on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//


#import "ParentViewController.h"

@interface EditTimeViewController : ParentViewController
{
    UILabel *startLabel;
    UILabel *finishLabel;
    UIButton *button;
    NSDictionary *_dic;
}
@property(nonatomic,retain)NSDictionary *dic;
@property(nonatomic,copy)NSString *proid;
@property(nonatomic,copy)NSString *starDate;
@end
