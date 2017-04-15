//
//  HomeEntreViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-10-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeEntreViewController : ParentViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    
    //名字所在的数组
    NSMutableArray *searchNameArray;
    //图标所在的数组
    NSMutableArray *searchHeadImageArray;
    //名字和图标，所在的字典
    NSMutableDictionary *searchDic;
    //显示内容的数组
    NSMutableArray *alreadyChooseArr;
    
    UIScrollView *backScrollerView;
    UIView *backGroundView;
    UIImageView *imageView;
    UIButton *nextButton;
}

@property (nonatomic,strong) NSString *whereFromString;

@end
