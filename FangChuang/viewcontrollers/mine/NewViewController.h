//
//  NewViewController.h
//  FangChuang
//
//  Created by BlueMobi BlueMobi on 13-12-27.
//  Copyright (c) 2013年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "ToggleView.h"
@interface NewViewController : ParentViewController<ToggleViewDelegate>
{
    ToggleView *toggleViewBaseChange;
    UIImageView *onView;
    UIImageView *offView;
    BOOL isNewRemind;
}
@end
