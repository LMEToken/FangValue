//
//  HomeTeleNumberViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-11-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeTeleNumberViewController : ParentViewController
<UITextFieldDelegate,UIScrollViewDelegate>
{
    UIScrollView *backScrollerView;
    UIImageView *upImageView;
    UIImageView *downImageView;
    UILabel *teleLabel;
    UITextField *testField;
    UITextField *passField;
    NSTimer* sysTimer;
    BOOL timeStart;
    NSString *verifyService;
    
}
@end
