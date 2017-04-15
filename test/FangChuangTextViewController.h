//
//  FangChuangTextViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-8-12.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestOneViewController.h"
#import "TestTwoViewController.h"
#import "TestThreeViewController.h"
#import "TestFourViewController.h"

@interface FangChuangTextViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *testDataArr;
    
    TestOneViewController *oneViewController;
    TestTwoViewController *twoViewController;
    TestThreeViewController *threeViewController;
    TestFourViewController *fourViewController;
}
@end
