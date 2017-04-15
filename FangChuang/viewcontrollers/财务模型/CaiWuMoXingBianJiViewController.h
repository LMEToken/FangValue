//
//  CaiWuMoXingBianJiViewController.h
//  FangChuang
//
//  Created by 朱天超 on 14-1-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "APickerView.h"
@interface CaiWuMoXingBianJiViewController : ParentViewController<UITextFieldDelegate,APickerViewDelegate>
{
    UIScrollView* mainScrollView;
    UILabel *yearLabel;
    
    APickerView *myPickerView;
    NSArray *yearArray;
}

@end
