//
//  SubordinateFieldVC.h
//  FangChuang
//
//  Created by weiping on 14-10-13.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

#import "EditordieViewController.h"
@interface SubordinateFieldVC : ParentViewController

{
    NSArray *savearr;
    NSMutableArray *typearr;
}
@property (nonatomic,strong)   id passValueDelegate;
@end
