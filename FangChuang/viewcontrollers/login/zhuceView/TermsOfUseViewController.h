//
//  TermsOfUseViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface TermsOfUseViewController : ParentViewController<UIScrollViewDelegate,UITextViewDelegate>
{
    UIScrollView *inforView;
    UITextView *xiatextView;
}
@end
