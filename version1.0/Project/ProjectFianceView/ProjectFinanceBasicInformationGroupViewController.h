//
//  ProjectFinanceBasicInformationGroupViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-20.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "FangChuangInsiderViewController.h"
@interface ProjectFinanceBasicInformationGroupViewController : ParentViewController
{
    NSMutableArray *turnButtonArray;
    NSMutableArray *buttonDownImages;
    NSMutableArray *buttonUpImages;
    NSMutableArray *chooseArray;
     NSMutableArray *chooseIndex;
    
}
@property (nonatomic,strong) NSString *jumpFlagString;
@property (nonatomic,strong) NSString *jumpStr;
@end
