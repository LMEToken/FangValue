//
//  xiangmuViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-31.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface xiangmuViewController : ParentViewController<UIScrollViewDelegate>
{
    //    UIScrollView *scrollView;
    NSString *titleid;
    NSString *hangYe;
    NSString *rongZi;
    UILabel *DWlable;
    UILabel *HYlable;
    UILabel *RZElable;
}
- (id)initSetTitle:(NSString *)title hangye:(NSString *)hangye rongzi:(NSString *)rongzi;
@end
