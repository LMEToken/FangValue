//
//  TongyongViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ToggleView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "APickerView.h"
@interface TongyongViewController : ParentViewController <ToggleViewDelegate,APickerViewDelegate>
{
    ToggleView *toggleViewBaseChange1;
    ToggleView *toggleViewBaseChange2;
    UIImageView *onView;
    UIImageView *offView;
    UIImageView *onView2;
    UIImageView *offView2;
    BOOL isLeft;
    BOOL isLeft2;
    
    //UIPickerView *myPickerView;
    APickerView *myPickerView;
    UILabel *fontLabel;
    NSArray *fontArray;
    
    ToggleView *toggleViewBaseChangeRemind;
    UIImageView *onViewRemind;
    UIImageView *offViewRemind;
    BOOL isNewRemind;
     
}
@end
