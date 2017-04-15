//
//  InformationViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface InformationViewController : ParentViewController<UITextFieldDelegate>
{
    UITextField *telTextField;
    UITextField *yanzTextField;
    UITextField *passwdTextField;
    UITextField *pswdTextField;
}
//验证码
@property(nonatomic , retain)    NSString* verificationcode; 
@end
