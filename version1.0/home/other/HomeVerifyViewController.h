//
//  HomeVerifyViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeVerifyViewController : ParentViewController
<UITextFieldDelegate>
{
    UILabel *detailLabel;
    UILabel *numberLabel;
    UIView *backView;
    UIImageView *iconImageView;
    UITextField *vertyView;
    NSTimer* sysTimer;
    BOOL timeStart;
    NSString *verifyService;
}

@end
