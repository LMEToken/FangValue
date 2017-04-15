//
//  HomeInvestorInstructionViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-11-18.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeInvestorInstructionViewController : ParentViewController
<UIScrollViewDelegate,UITextViewDelegate>
{
    UIScrollView *backScrollerView;
    UITextView *textCompanyView;
}

@end
