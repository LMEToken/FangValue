//
//  xiangmumingxiViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "CacheImageView.h"
@interface xiangmumingxiViewController : ParentViewController<UIScrollViewDelegate>
{
    //    UIScrollView *scrollView;
    NSString *titleid;
    NSString *hangYe;
    NSString *rongZi;
    UILabel *DWlable;
    UILabel *HYlable;
    UILabel *RZElable;
    int intString;
    NSString *textStr;
}
@property (nonatomic ,retain) NSDictionary *myDic;
- (id)initSetTitle:(NSString *)title hangye:(NSString *)hangye rongzi:(NSString *)rongzi;
@end
