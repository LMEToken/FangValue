//
//  SearchMoneyViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
@interface SearchMoneyViewController : ParentViewController
{
    NSMutableArray *turnButtonArray;
    NSMutableArray *buttonDownImages;
    NSMutableArray *buttonUpImages;
    NSMutableArray *chooseArray;
    NSMutableArray *chooseIndex;
    NSMutableArray *serverArray;
}
@property(nonatomic,strong) NSString *aleadyString;
@end
