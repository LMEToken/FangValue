//
//  HomeRegisterViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeRegisterViewController : ParentViewController
<UITextFieldDelegate,UIScrollViewDelegate>
{
    UIView *teleView;
    UIImageView *teleImageView;
    UIView *lineView;
    UIView *passWordView;
    UIImageView *passImageView;
    UIImageView *accountLine;
    UIImageView *agreenView;
    UIButton *accountButton;
    UIButton *nextButton;
    UITextField *teleField;
    UITextField *passField;
    
    UIScrollView *backScrollerView;
}
@end
