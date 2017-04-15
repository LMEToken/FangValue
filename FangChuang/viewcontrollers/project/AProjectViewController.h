//
//  AProjectViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-30.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "CacheImageView.h"
@interface AProjectViewController : ParentViewController<UIScrollViewDelegate>
{
//    UIScrollView *scrollView;
    NSString *titleid;
    NSString *hangYe;
    NSString *rongZi;
    UILabel *DWlable;
    UILabel *HYlable;
    UILabel *RZElable;
}
@property (nonatomic ,retain) NSDictionary *myDic;
- (id)initSetTitle:(NSString *)title hangye:(NSString *)hangye rongzi:(NSString *)rongzi;

@end
