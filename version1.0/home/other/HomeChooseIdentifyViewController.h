//
//  HomeChooseIdentifyViewController.h
//  FangChuang
//
//  Created by chenlihua on 14-9-29.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface HomeChooseIdentifyViewController : ParentViewController
<UIScrollViewDelegate>
{
    UIImageView *detailView;
    UIImageView *chooseImageView;
    UIButton *nextButton;
    
    UIScrollView *backScrollerView;
}
@property (nonatomic,strong) UILabel *tyrantLabel;
@property (nonatomic,strong) NSString *flagString;

@end
