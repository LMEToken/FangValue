//
//  ProjectBasicInfoViewController.h
//  FangChuang
//
//  Created by omni on 14-4-3.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"
#import "SingleLineEditableModule.h"

@interface ProjectBasicInfoViewController : ParentViewController<UIScrollViewDelegate,HPGrowingTextViewDelegate>
{

}
@property (nonatomic,weak)id<UIScrollViewDelegate> dele;

@end
