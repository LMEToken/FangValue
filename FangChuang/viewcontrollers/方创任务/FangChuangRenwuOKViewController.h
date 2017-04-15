//
//  FangChuangRenwuOKViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 14-1-6.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface FangChuangRenwuOKViewController : ParentViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UIScrollView *myScrollView;
}
@property (nonatomic, copy) NSString *taskid;
@property (nonatomic, retain) NSDictionary* dataDic;
@end
