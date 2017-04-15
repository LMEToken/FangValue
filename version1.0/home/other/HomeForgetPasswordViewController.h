//
//  HomeForgetPasswordViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-11-8.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeForgetPasswordViewController : ParentViewController
<UITextFieldDelegate,UIScrollViewDelegate>
{
    UIScrollView *backScrollerView;
    UIImageView *upImageView;
    UIImageView *downImageView;
    UITextField *teleField;
}

@end
