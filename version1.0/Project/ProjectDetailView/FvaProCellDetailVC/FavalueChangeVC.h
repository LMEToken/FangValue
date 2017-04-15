//
//  FavalueChangeVC.h
//  FangChuang
//
//  Created by Tom on 14-11-22.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "ParentViewController.h"

@interface FavalueChangeVC:ParentViewController<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIScrollView  *backScrollerView;
    UITextField *nameTextField;
    UITextField *nameTextField2;
}
@property (nonatomic,strong)NSString* userpwd;
@end
