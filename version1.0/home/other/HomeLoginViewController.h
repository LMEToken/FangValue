//
//  HomeLoginViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-27.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "Reachability.h"
#import "sqlite3.h"


@interface HomeLoginViewController : ParentViewController
<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIView *teleView;
    UIImageView *teleImageView;
    UIView *lineView;
    UIView *passWordView;
    UIImageView *passImageView;
    UIImageView *registerLine;
    UIImageView *passLine;
    UITextField *teleField;
    UITextField *passField;
    UIButton *registerButton;
    UIButton *passButton;
    UIButton *loginButton;
    
    UIScrollView *backScrollerView;
    NSMutableArray *turnButtonArray;
    NSMutableArray *chooseArray;
}
@end
