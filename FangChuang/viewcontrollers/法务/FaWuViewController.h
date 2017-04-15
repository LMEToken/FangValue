//
//  FaWuViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-2.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface FaWuViewController : ParentViewController<UITextViewDelegate,UIScrollViewDelegate>
{
    NSDictionary *dataDic;
}
@property (nonatomic,retain) NSString *proid;
@end
