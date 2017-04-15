//
//  HomeEntreMoneryViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-10-11.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeEntreMoneryViewController : ParentViewController
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
