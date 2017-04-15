//
//  HomePersonalInformationViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-28.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomePersonalInformationViewController : ParentViewController
<UITextFieldDelegate,UIScrollViewDelegate>
{
    NSMutableArray *textFieldArray;
    NSMutableArray *imageArray;
    UIImageView *remindImageView;
    UIButton *nextButton;
    UIView *backNameView;
   
    NSString *text0;
    NSString *text1;
    NSString *text2;
    NSString *text3;
    NSString *text4;
    
    UIScrollView *backScrollerView;
    
}
@end
